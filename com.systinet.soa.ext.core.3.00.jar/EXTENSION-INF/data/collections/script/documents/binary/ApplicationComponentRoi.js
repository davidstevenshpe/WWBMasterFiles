Ext4.define('EA.scripts.ApplicationComponentCost', {
    extend: 'EA.portal.VisualizablePortlet',
    config: {
        id: 'ApplicationComponentCost',
        dataSource: '/scripts/ApplicationComponentRoiData.xml',
        visualizations: [{
            label: 'Application Health',
            items: [{
                type: 'EA.portlets.visualization.BackgroundColorVisualization',
                field: 'entityHealth',
                name: 'not filtered',
                description: '*) Application health',
                styleSchema: {
                    'Green': {
                        style: 'background-color:rgba(0,162,118,0.7)',
                        desc: 'Very Good'
                    },
                    'Yellow': {
                        style: 'background-color:rgba(255,229,84,0.7)',
                        desc: 'Good'
                    },
                    'Red': {
                        style: 'background-color:rgba(247,108,81,0.7)',
                        desc: 'Require Analysis'
                    },
                    'N/A': {
                        style: 'background-color:rgba(204,204,204,0.7)'
                    }
                }

            },{
                type: 'EA.portlets.visualization.SchemaLogicBasedVisualization',
                field: 'entityHealth',
                name: 'Very Good',
                description: '*) Application health',
                styleSchema: {
                    'Very Good': {
                        style: 'background-color:rgba(0,162,118,0.7)',
                        conditions:' == "Green"'
                    },
                    'Other': {
                        style: 'background-color:rgba(255,255,255,0.0)',
                        conditions:' != "Green"'
                    }
                }

            },{
                type: 'EA.portlets.visualization.SchemaLogicBasedVisualization',
                field: 'entityHealth',
                name: 'Good',
                description: '*) Application health',
                styleSchema: {
                    'Good': {
                        style: 'background-color:rgba(255,229,84,0.7)',
                        conditions:' == "Yellow"'
                    },
                    'Other': {
                        style: 'background-color:rgba(255,255,255,0.0)',
                        conditions:' != "Yellow"'
                    }
                }

            },{
                type: 'EA.portlets.visualization.SchemaLogicBasedVisualization',
                field: 'entityHealth',
                name: 'Require Analysis',
                description: '*) Application health',
                styleSchema: {
                    'Require Analysis': {
                        style: 'background-color:rgba(247,108,81,0.7)',
                        conditions:' == "Red"'
                    },
                    'Other': {
                        style: 'background-color:rgba(255,255,255,0.0)',
                        conditions:' != "Red"'
                    }
                }

            }]
        }]
    },

    renderConfig: {
        minRadius: 10,
        maxRadius: 50,
        maxVal:{},
        radiusField: 'returnOnInvestment',
        calculateRadius: function(value,datasource) {
            if(value < 0) return 5; //negativeRadius
            var minValue = 0, maxValue = datasource.max(this.radiusField);
            maxValue = maxValue ? maxValue : datasource.max('annualCostTotal');
            var retVal = Math.sqrt(value*this.maxRadius*this.maxRadius/maxValue);
            if(retVal < this.minRadius)  retVal = this.minRadius;
            return retVal;
        }
    },

    initComponent: function() {
        this.callParent(arguments);
        this.update('<div id="' + this.config.id + '-menu" class="em-smap-menu cell-container"></div>' +
            '<div class = "eam-smap height-scrollable" id="' + this.config.id + '-map"></div>' +
            '<div class="em-smap-legend" id="' + this.config.id + '-legend"></div>');
        this.mapPrepared = false;
        this.config.currencySymbol = layoutManager.currencySymbol;
    },

    orderBy: [{
        field: 'annualCostTotal',
        'value': 'afp.annualCostTotal DESC',
        'name': 'Total Cost'
    },
        {
            field: 'annualCostLabor',
            'value': 'afp.annualCostLaborInt DESC, afp.annualCostLaborExt DESC',
            'name': 'Labor Cost'
        },
        {
            field: 'annualCostHw',
            'value': 'afp.annualCostHw DESC',
            'name': 'Hardware Cost'
        },
        {
            field: 'annualCostSw',
            'value': 'afp.annualCostSw DESC',
            'name': 'Software Cost'
        },
        {
            field: 'annualCostOther',
            'value': 'afp.annualCostOther DESC',
            'name': 'Other Cost'
        },
        {
            field: 'transformationCost',
            'value': 'afp.transformationCost DESC',
            'name': 'Transformation Cost'
        },
        {
            field: 'netPresentValue',
            'value': 'afp.netPresentValue DESC',
            'name': 'NPV'
        },
        {
            field: 'returnOnInvestment',
            'value': 'afp.returnOnInvestment DESC',
            'name': 'ROI'
        }],

    buildMenu: function() {
        var self = this, options = self.orderBy;
        var topSelector = this.buildSelector(this.menuContainer,'Top 50',options,0);

        topSelector.change(function() {
            var index = this.selectedIndex;
            self.buildMap({
                loadData:true,
                extraParams: {
                    sort: options[index].value
                },
                pageSize:50,
                remoteSort:false
            });
        });

        var xAxisSelector = this.buildSelector(this.menuContainer,'X Axis',options,1);
        var yAxisSelector = this.buildSelector(this.menuContainer,'Y Axis',options,2);

        yAxisSelector.change(function() {
            var index = this.selectedIndex;
            var yField = options[index].field;
            self.chart.axes.items[0].fields = [yField];
            self.chart.axes.items[0].title = self.orderBy[index].name;
            self.chart.series.items[0].yField = yField;
            self.chart.refresh();
        });

        xAxisSelector.change(function() {
            var index = this.selectedIndex;
            var xField = options[index].field;
            self.chart.axes.items[1].fields = [xField];
            self.chart.axes.items[1].title = self.orderBy[index].name;
            self.chart.series.items[0].xField = xField;
            self.chart.refresh();
        });

        var sizeSelector = this.buildSelector(this.menuContainer,'Size', options, 7);
        sizeSelector.change(function() {
            self.renderConfig.radiusField = options[this.selectedIndex].field;
            self.datasource.sort({
                property: self.renderConfig.radiusField,
                direction: 'DESC'
            });
            self.chart.refresh();
        });

        this.callParent();
    },

    loadDataSource: function () {
        this.buildMap({
            loadData: true,
            extraParams: {
                sort: 'afp.annualCostTotal DESC',
                domainFilterType:'report'
            },
            buildVisualizationController: true,
            pageSize: 50,
            remoteSort:false
        });
    },

    buildMapContent: function() {
        var self = this;
        var items = self.datasource.data.items;
        for (var i = 0; i < items.length; i++) {
            items[i].data = items[i].raw;
        }
        self.datasource.sort({
            property: self.renderConfig.radiusField,
            direction: 'DESC'
        });

        if (self.chart) {
            self.chart.bindStore(self.datasource);
            self.chart.redraw();
            return;
        }

        var circleRenderer = function(sprite, node, attr, index, store) {
            var value = +node.get(self.renderConfig.radiusField);
            var rgba = self.buildVisualStyle(node).substr(17);
            var rgb = rgba.match(/^rgba\((\d+),\s*(\d+),\s*(\d+),0.(\d+)\)$/);

            var radius = self.renderConfig.calculateRadius(value,self.datasource);
            sprite.on('mouseover', function() {
                legendLabel.setText(node.get('name'));
            });
            sprite.on('mouseout', function() {
                legendLabel.setText(self.renderConfig.legendText);
            });

            return Ext4.apply(attr, {
                radius: radius,
                size: radius,
                fill: rgba,
                stroke: rgb[4] != '0' ? 'rgb(' + Math.round(rgb[1] * 0.8) + ',' + Math.round(rgb[2] * 0.8) + ',' + Math.round(rgb[3] * 0.7) + ')' : 'rgba(0,0,0,0)',
                'stroke-width': 2
            });
        };

        var onClick = {
            itemmousedown: function(v) {
                showArtifact(v.storeItem.data['uuid']);
            }
        };
        var toolTipGridStore = Ext4.create('Ext.data.JsonStore', {
            fields: ['name', 'value']
        });
        var numberRenderer = Ext4.util.Format.numberRenderer('0,0');
        var toolTipGrid = Ext4.create('Ext.grid.Panel', {
            store: toolTipGridStore,
            columns: [{
                text: 'Name',
                dataIndex: 'name',
                width: 150
            },
                {
                    text: 'Value',
                    dataIndex: 'value',
                    width: 95,
                    align: 'right',
                    renderer: function(val,m,record) {
                        if(val == null) return 'N/A';
                        return Ext4.isNumber(val) ? (record.data.name == 'ROI' ? val : layoutManager.formatCurrency(val)) : self.config.currencySymbol + val;
                    }
                }]
        });

        self.chart = Ext4.create('Ext4.chart.Chart', {
            xtype: 'chart',
            renderTo: self.config.id + '-map',
            animate: true,
            width: self.getWidth() - 20,
            height: self.getHeight() - 200,
            shadow: false,
            store: self.datasource,
            axes: [{
                type: 'Numeric',
                position: 'left',
                fields: ['annualCostHw'],
                title: 'Hardware Cost',
                grid: true,
                label: {
                    renderer: Ext4.util.Format.numberRenderer('0,0'),
                    font: 'HPSimplified'
                }
            },
                {
                    type: 'Numeric',
                    minimum: 0,
                    position: 'bottom',
                    fields: ['annualCostLabor'],
                    title: 'Labor Cost',
                    grid: true,
                    label: {
                        renderer: Ext4.util.Format.numberRenderer('0,0'),
                        font: 'HPSimplified'
                    }
                }],
            series: [{
                type: 'scatter',
                axis: false,
                xField: 'annualCostLabor',
                yField: 'annualCostHw',
                color: '#ccc',
                markerConfig: {
                    type: 'circle'
                },
                renderer: circleRenderer,
                tips: {
                    trackMouse: true,
                    width: 270,
                    height: 300,
                    layout: 'fit',
                    items: {
                        xtype: 'container',
                        layout: 'hbox',
                        items: [toolTipGrid]
                    },
                    renderer: function(node) {
                        this.setTitle(node.get('name'));
                        var fields = [];
                        for(var i =0; i < self.orderBy.length; i++) {
                            fields[i] = {
                                name: self.orderBy[i].name,
                                value: node.get(self.orderBy[i].field)
                            }
                        }
                        toolTipGridStore.loadData(fields);
                        toolTipGrid.setSize(250, 240);
                    }
                },
                listeners: onClick
            }]
        });
        var legendLabel = Ext4.create("Ext.form.Label", {
            region: 'south',
            margin: '0 5 5 5',
            text: self.renderConfig.legendText
        });
    }
})