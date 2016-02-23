/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Cloud Assessment Status.            */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */

Ext4.define('EA.scripts.CloudAssessmentStatus', {
    extend: 'EA.portal.TabsContentPortlet',
    requires: [
        'EA.model.tools.DataSourceStore',
        'Ext4.data.JsonStore'
    ],
    config: {
        name: 'Cloud Assessment Status',
        id: 'cloudAssessmentStatus',
        tabs:{
            assessment: {
                name: 'Assessment',
                description: 'Here you can see the list of applications and their cloud transformation assessment status. \
                The assessment scores 0-100 are calculated based on \
                <a href="' + SERVER_URI + '/../../service-catalog/catalog/homepagecsa#runSurvey" target="_blank">surveys</a>\
                The higher the score the suitability of the application to run in cloud enviroment is higher. \
                The goal here is to assign a transformation decision for each application (click on corresponding cell) \
                based on the score and also on the operational costs of the applications which also assigned in \
                <a href="' + SERVER_URI + '/../../service-catalog/artifact/f3e176dd-3009-470c-a9bd-a579c49a7e7b" target="_blank">technical</a> and <a href="' + SERVER_URI + '/../../service-catalog/artifact/9f94a5a1-d1ec-4d4b-8864-e70db969e4b3" target="_blank">financial</a> surveys.'
            },
            financial: {
                name: 'Financial',
                description: 'Here you can see financial information about the applications: \
                Total cost represents the amount currently spent(yearly) on the application. \
                Transformation cost represents the costs associated with application redesign and migration. \
                These data are collected using the financial survey. When you put in into the context of saving that can be realized by the transformation you can estimate return on investment of the transformation and further after the transformation decision based on that.<br><br>\
                Savings opportunity is an estimate based on the most economic deployment of the application. To have this available you need to \
                <a href="' + SERVER_URI + '/../../service-catalog/catalog/homepagecsa#assessInfrastructure" target="_blank">describe the application deployment model</a>. \
                Quality of this description determines the precision of the saving opportunity and ROI. '
            },
            technical: {
                name: 'Technical',
                description: 'Here you can see the list of application and their status of their transformation from a technical perspective. \
                You can see whether service design for automated deployment is available or not and create one if it is required based on the transformation decision. \
                If you need more guidance on how to create a service design for an application, \
                <a href="' + SERVER_URI + '/../../service-catalog/catalog/homepagecsa#buildServiceDesign" target="_blank">continue here</a>'
            }
        },
        dataSource: '/scripts/CloudAssessmentStatusDS.xml',
        serviceDesigns: ['Create New...', 'Available'],
        recommendations: ['<div style="color: #f76c51;">Re-architect<div>', '<div style="color: #32BF72;">Public Cloud<div>', 'Private Cloud', 'N/A'],
        hwCostTooltip:'This value is an estimate based on simulated deployment into the currently assigned data center.\
                       Quality of the modelling of the application in EM determines the quality of this value.',
        height: 400,
        extraParams: {},
        fields: [
            { name: 'appName'},
            { name: 'appVersion'},
            { name: 'transformationStrategy'},
            { name: 'ownerName'},
            { name: 'owner'},
            { name: 'ownerUuid'},
            { name: 'recommendation'},
            { name: 'ba'},
            { name: 'ta'},
            { name: 'fa'},
            { name: 'oa'},
            { name: 'overallScore'},
            { name: 'serviceDesign', type: 'int' },
            { name: 'hardwareCost'},
            { name: 'minEstimatedHwCost'},
            { name: 'currentHwCost'},
            { name: 'currentHwCostEstimate'},
            { name: 'transformationCost'},
            { name: 'totalCost'},
            { name: 'savingsOpportunity'},
            { name: 'ROI'},
            { name: 'finProfileUUID'},
            { name: 'dataCenterName'},
            { name: 'dataCenterUuid'}
        ]
    },
    bodyStyle: 'padding:0 8px;',
    initComponent: function () {
        /**
         * Number.prototype.format(symbol, n, x)
         *
         * @param boolean symbol: w/o symbol prefix
         * @param integer n: length of decimal
         * @param integer x: length of sections
         */
        Number.prototype.format = function(symbol, n, x) {
            symbol = symbol != false;
            var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
            return (symbol ? EM.currencySymbol : "") + this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
        };

        var self = this;
        this.initConfig();

        this.on('resize', function () {
            if (this.dataTable == null || self.disableResize == true) {
            } else {
                $(this.id + '-table').width(this.width - 40);
                this.dataTable.setHeight(this.height - 50);
            }
        });
        this.callParent(arguments);
    },

    // called by portlet in order to load the data
    loadDataSource: function () {
        var self = this;
        if (!self.extraParams || self.extraParams == null) {
            self.extraParams = {};
        }
        self.extraParams.domainFilterType = 'report';
        this.datasource = Ext4.create('EA.model.tools.DataSourceStore', {
            dataSource: this.config.dataSource,
            idProperty: 'uuid',
            fields: self.fields,
            extraParams: self.extraParams,
            remoteSort: true,
            pageSize: 15
        });
        this.datasource.on('load', function (store) {
            for (var i = 0; i < store.data.items.length; i++) {
                var item = store.data.items[i].data;
                self.setScores(item);
                self.setRecommendation(item);
            }
            self.refreshTable();

            if(!self.renderCallBackFired) {
                self.fireEvent('afterContentRender');
                self.renderCallBackFired = true;
            }
        });
        self.buildDataListingTable(self.datasource);
        self.getTransformationStrategyCategories();
        this.datasource.load();
    },

    setScores: function(item) {
        item.ta = item.ta ? Number(item.ta).toFixed(0) : 'N/A';
        item.ba = item.ba ? Number(item.ba).toFixed(0) : 'N/A';
        item.fa = item.fa ? Number(item.fa).toFixed(0) : 'N/A';
        item.oa = Number(item.oa).toFixed(0);
    },

    setRecommendation: function(item) {
        if ((item.ta <= 25 && item.ta > 0) || (item.ba <= 25 && item.ba > 0)) {// Deeper Analysis
            item.recommendation = this.recommendations[0];
        } else if (item.ta >= 75 && item.ba >= 75) {// Public Cloud
            item.recommendation = this.recommendations[1];
        } else if (item.ta > 0 && item.ba > 0) {// Private Cloud
            item.recommendation = this.recommendations[2];
        } else {// N/A
            item.recommendation = this.recommendations[3];
        }
    },

    buildDataListingTable: function (store) {
        var self = this;
        self.transformationStrategyStore = new Ext4.data.Store({
            fields: ["keyName", "keyValue"],
            data : []
        });
        // Transformation Strategy Combo box Template
        var cmbTransformationStrategyTemplate = {
            editable: false,
            typeAhead: true,
            mode: 'local',
            triggerAction: 'all',
            store: self.transformationStrategyStore,
            valueField: 'keyValue',
            displayField: 'keyName',
            matchFieldWidth: true,
            listeners:{
                select: function(combo, records, eOpts) {
                    combo.triggerBlur();
                    combo.blur();
                }
            }
        };
        // Create 3 combo boxes
        var cmbTransformationStrategyAssessment = new Ext4.form.field.ComboBox(cmbTransformationStrategyTemplate);
        var cmbTransformationStrategyFinancial = new Ext4.form.field.ComboBox(cmbTransformationStrategyTemplate);
        var cmbTransformationStrategyTechnical = new Ext4.form.field.ComboBox(cmbTransformationStrategyTemplate);
        // Columns of grid
        self.columns = {
            'name': {
                header: 'Application Name',
                dataIndex: 'appName',
                width: 200,
                flex: 1,
                sortable: true,
                renderer: function (v, columData) {
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.id + '\',null,\'cloudMigration\')">' + v + '</a>';
                }
            },
            'version': {
                header: 'Version',
                dataIndex: 'appVersion',
                width: 100,
                sortable: true
            },
            'owner': {
                header: 'Owner',
                dataIndex: 'ownerName',
                width: 200,
                flex: 1,
                sortable: true,
                renderer: function (v, columData) {
                    var userType = columData.record.data.owner;
                    var link = '<a href=' + SERVER_URI + '/../../service-catalog/';
                    if (userType.lastIndexOf('_sstntgrp:', 0) === 0) {
                        userType = userType.substr(10);
                        if ((userType === 'system#registered') || (userType === 'system#everyone')) {
                            return '<span class="UI Icon OrganizationUnit">' + userType + '</span>';
                        }
                        link += 'common/group/view?groupName=' + encodeURIComponent(userType) + ' class="UI Icon OrganizationUnit"';
                    } else if (userType.lastIndexOf('_sstntrl:', 0) === 0) {
                        link += 'common/role/view?RoleId=' + encodeURIComponent(userType) + ' class="UI Icon Role"';
                    } else {
                        link += 'artifact/' + columData.record.data.ownerUuid + ' class="UI Icon Contact print-hide"';
                    }
                    link += ' target="_blank">' + columData.record.data.ownerName + '</a><span style="color:#579ddb" class="UI Icon Contact print-show hide-not-print" >' + columData.record.data.ownerName +'</span>';
                    return link;
                }
            },
            'serviceDesign': {
                header: 'Service Design',
                dataIndex: 'serviceDesign',
                width: 150,
                sortable: true,
                renderer: function (v, columData) {
                    if (v == 0) {
                        return '<a href="#" onclick="showArtifact(\'' + columData.record.data.id + '\',null,\'cloudMigration\',\'subTabId=deploymentModels\')">' + self.serviceDesigns[0] + '</a>';
                    } else {
                        return '<div style="color: #32BF72;">' + self.serviceDesigns[1] + '</div>';
                    }
                }
            },
            'businessScore': {
                header: 'Business Score',
                dataIndex: 'ba',
                width: 150,
                align: 'center',
                sortable: true,
                renderer: function (v, columData) {
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.id + '\',null,\'cloudMigration\',\'subTabId=business\')">' + v + '</a>';
                }

            },
            'technicalScore': {
                header: 'Technical Score',
                dataIndex: 'ta',
                width: 150,
                align: 'center',
                sortable: true,
                renderer: function (v, columData) {
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.id + '\',null,\'cloudMigration\',\'subTabId=technical\')">' + v + '</a>';
                }
            },
            'financialScore': {
                header: 'Financial Score',
                dataIndex: 'fa',
                width: 150,
                align: 'center',
                sortable: true,
                renderer: function (v, columData) {
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.id + '\',null,\'cloudMigration\',\'subTabId=financial\')">' + v + '</a>';
                }
            },
            'recommendation': {
                header: 'Recommendation',
                dataIndex: 'recommendation',
                width: 150,
                sortable: false
            },
            'overallScore': {
                header: 'Overall Score',
                dataIndex: 'oa',
                width: 150,
                align: 'center',
                sortable: true,
                renderer: function (v, columData) {
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.id + '\',null,\'cloudMigration\')"><b>' + v + '</b></a>';
                }
            },
            'transformationStrategyAssessment' : {
                header: 'Transfomation Strategy',
                dataIndex: 'transformationStrategy',
                minWidth: 200,
                editor: cmbTransformationStrategyAssessment,
                renderer: function (v, columData) {
                    return self.renderTransformationStrategyColumn(v, columData);
                }
            },
            'transformationStrategyFinancial' : {
                header: 'Transfomation Strategy',
                dataIndex: 'transformationStrategy',
                minWidth: 200,
                editor: cmbTransformationStrategyFinancial,
                renderer: function (v, columData) {
                    return self.renderTransformationStrategyColumn(v, columData);
                }
            },
            'transformationStrategyTechnical' : {
                header: 'Transfomation Strategy',
                dataIndex: 'transformationStrategy',
                minWidth: 200,
                editor: cmbTransformationStrategyTechnical,
                renderer: function (v, columData) {
                    return self.renderTransformationStrategyColumn(v, columData);
                }
            },
            'currentHardwareCost' : {
                header: 'Current Hardware Cost',
                dataIndex: 'hardwareCost',
                minWidth:200,
                align: 'right',
                sortable: true,
                renderer: function (v, columData) {
                    var qtip = '';
                    v = v ? layoutManager.formatCurrency(v) : 'N/A';
                    if((v == 'N/A' || columData.record.data['currentHwCost'] == null) && columData.record.data['currentHwCostEstimate'] != null) {
                        v = 'Est. ' + layoutManager.formatCurrency(columData.record.data['currentHwCostEstimate']);
                        qtip = 'data-qtip="' + self.hwCostTooltip + '"';
                    }
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.finProfileUUID + '\')" ' + qtip + '><b>' + v + '</b></a>';
                }
            },
            'totalCost' : {
                header: 'Total Cost',
                dataIndex: 'totalCost',
                minWidth:200,
                align: 'right',
                renderer: function(v) {
                    return v ? layoutManager.formatCurrency(v) : 'N/A';
                }
            },
            'savingsOpportunity' : {
                header: 'Savings Opportunity (yearly)',
                dataIndex: 'savingsOpportunity',
                minWidth:200,
                align: 'right',
                sortable: true,
                renderer: function (v) {
                    return v > 0 ? layoutManager.formatCurrency(v) : 0;
                }
            },
            'ROI' : {
                header: 'ROI (over 5 years)',
                dataIndex: 'ROI',
                minWidth:200,
                align: 'right',
                sortable: true,
                renderer: function (v) {
                    return Number(v).format(false, 2) + "%";
                }
            },
            'transformationCost' : {
                header: 'Transformation Cost',
                dataIndex: 'transformationCost',
                minWidth:200,
                align: 'right',
                renderer: function (v) {
                    return v ? layoutManager.formatCurrency(v) : 'N/A';
                }
            },
            'recommendedDataCenter' : {
                header: 'Recommended Data Center',
                dataIndex: 'dataCenterName',
                minWidth:200,
                renderer: function (v, columData) {
                    return '<a href="#" onclick="showArtifact(\'' + columData.record.data.dataCenterUuid + '\')" ><b>' + v + '</b></a>';
                }
            },
            'minEstimatedHWCost' : {
                header: 'Minimum Estimated HW Costs',
                dataIndex: 'minEstimatedHwCost',
                minWidth:200,
                align: 'right',
                hidden:true,
                sortable: true,
                renderer: function (v) {
                    return v ? layoutManager.formatCurrency(v) : 'N/A';
                }
            },
            'curHWCostEstimate' : {
                header: 'Current HW Costs Estimate',
                dataIndex: 'currentHwCostEstimate',
                minWidth:200,
                align: 'right',
                hidden:true,
                sortable: true,
                renderer: function (v) {
                    return v ? layoutManager.formatCurrency(v) : 'N/A';
                }
            }

        };
        // Cell editing template
        var cellEditPluginTemplate = {
            pluginId: 'cellplugin',
            clicksToEdit: 1,
            listeners: {
                edit: function(editor, e, eOpts) {
                    self.onCellEdit(editor, e, eOpts);
                }
            }
        };

        var assessmentPlugins = [
            Ext4.create('Ext4.grid.plugin.CellEditing', cellEditPluginTemplate)
        ];

        var assessmentColumns = ['name', 'version', 'owner', 'businessScore', 'financialScore', 'technicalScore', 'overallScore', 'recommendation', 'currentHardwareCost', 'transformationStrategyAssessment', 'minEstimatedHWCost', 'curHWCostEstimate'];
        this.activeTable = this.assessmentTable = Ext4.create('EA.model.table.proposal.ArtifactListingDatasourceTable', {
            store: store,
            columns: self.getColumns(assessmentColumns),
            renderTo: self.id + '-assessment',
            width: '100%',
            pluginsParam: assessmentPlugins
        });

        var financialPlugins = [
            Ext4.create('Ext4.grid.plugin.CellEditing', cellEditPluginTemplate)
        ];

        var financialColumns = ['name', 'version', 'owner', 'totalCost', 'transformationCost', 'savingsOpportunity', 'ROI', 'transformationStrategyFinancial', 'minEstimatedHWCost', 'curHWCostEstimate'];
        this.financialTable = Ext4.create('EA.model.table.proposal.ArtifactListingDatasourceTable', {
            store: store,
            columns: self.getColumns(financialColumns),
            renderTo: self.id + '-financial',
            width: '100%',
            pluginsParam: financialPlugins
        });

        var technicalPlugins = [
            Ext4.create('Ext4.grid.plugin.CellEditing', cellEditPluginTemplate)
        ];

        var technicalColumns = ['name', 'version', 'owner', 'technicalScore', 'recommendation', 'serviceDesign', 'recommendedDataCenter', 'transformationStrategyTechnical', 'minEstimatedHWCost', 'curHWCostEstimate'];
        this.technicalTable = Ext4.create('EA.model.table.proposal.ArtifactListingDatasourceTable', {
            store: store,
            columns: self.getColumns(technicalColumns),
            renderTo: self.id + '-technical',
            width: '100%',
            pluginsParam: technicalPlugins
        });

        $('#link-tab-' + self.id + '-assessment').click(function() {
            self.onTabActive('assessment');
        });
        $('#link-tab-' + self.id + '-financial').click(function() {
            self.onTabActive('financial');
        });
        $('#link-tab-' + self.id + '-technical').click(function() {
            self.onTabActive('technical');
        });
    },

    onTabActive: function(tabId) {
        var self = this;
        self.activeTable = self[tabId + 'Table'];
        setTimeout(function() {
            self.refreshTable();
        }, 500);
    },

    getTransformationStrategyCategories: function() {
        var self = this;
        var scriptLocation = '/scripts/TaxonomyUsage';
        var scriptUrl = SERVER_URI + '/../../../remote/execute' + scriptLocation + '/getTransformationStrategyCategories';
        Ext4.Ajax.request({
            url: scriptUrl,
            dataType: 'json',
            headers: { 'Content-Type': 'application/json' },
            success: function(response, textstatus) {
                var responseResult = eval('(' + response.responseText + ')');
                var categories = eval('(' + responseResult.data + ')');
                self.transformationStrategyStore.proxy.data = categories;
                self.valueNameMapping = {};
                var i;
                for(i = 0; i < categories.length; i++) {
                    self.valueNameMapping[categories[i].keyValue] = categories[i].keyName;
                }
                self.refreshTable();
            },
            failure : function(e) {
                self.refreshTable();
            }
        });
    },

    updateTransformationStrategyValue: function(uuid, newValue) {
        var scriptLocation = '/scripts/TaxonomyUsage';
        var scriptUrl = SERVER_URI + '/../../../remote/execute' + scriptLocation + '/updateTransformationStrategy?uuid=' + uuid + '&value=' + newValue;
        var self = this;
        Ext4.Ajax.request({
            url: scriptUrl,
            dataType: 'json',
            headers: { 'Content-Type': 'application/json' },
            success: function(response, textstatus) {
                var responseResult = eval('(' + response.responseText + ')');
                var responseMsg = responseResult.data;
                if(responseMsg === "success") {
                    console.log("Update: Success");
                } else {
                    console.log("Update: Failure");
                    Ext4.MessageBox.show({
                        title: "",
                        msg: responseMsg,
                        icon: Ext4.MessageBox.WARNING,
                        buttons: Ext4.MessageBox.OK,
                        fn: function(buttonId) {
                            if (buttonId === "ok") {
                                self.refreshTableStore();
                            }
                        }
                    });
                }
            },
            failure : function(e) {
                console.log("Request: Failure");
            }
        });
    },

    refreshTable: function(tabId) {
        if(tabId && this[tabId + 'Table']) {
            this[tabId + 'Table'].grid.getView().refresh();
        } else if(this.activeTable) {
            this.activeTable.grid.getView().refresh();
        }
    },

    refreshTableStore: function(tabId) {
        if(tabId && this[tabId + 'Table']) {
            this[tabId + 'Table'].grid.store.load();
        } else if(this.activeTable) {
            this.activeTable.grid.store.load();
        } else {
            if(this.assessmentTable !== undefined && this.assessmentTable.grid !== undefined) {
                this.assessmentTable.grid.store.load();
            }
        }
    },

    onCellEdit: function(editor, e, eOpts) {
        var self = this;
        if (e.field === "transformationStrategy") {
            var oldValue = e.originalValue;
            var newValue = e.value;
            if(oldValue !== newValue) {
                var recordUuid = e.record.data['id'];
                var confirmationMessage = 'Do you really want to change Transformation Strategy to ' + self.valueNameMapping[newValue] + '?';
                Ext4.MessageBox.show({
                    title: "Confirmation",
                    msg: confirmationMessage,
                    icon: Ext4.MessageBox.QUESTION,
                    buttons: Ext4.MessageBox.YESNO,
                    width: 500,
                    fn: function(buttonId) {
                        if(buttonId === 'yes') {
                            self.updateTransformationStrategyValue(recordUuid, newValue);
                        } else if(buttonId === 'no') {
                            self.refreshTableStore();
                        }
                    }
                });
            }
        }
        e.record.commit();
    },

    renderTransformationStrategyColumn: function(value, columData) {
        var displayName = this.valueNameMapping[value];
        return displayName;
    }
})