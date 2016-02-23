CHOOSE_ENDPOINT_STEPS_HEIGHT=670;

chooseFrontendProtocol=function(result)
{
     alert("This is just a placeholder to be overriden");
}

/* note that contract uuid/name/domain might be null */

createProxyWindow=function(domain,contractUUID, contractName) {
    var BaseInstance = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'domain',
                  type: 'string'
                },
                {
                  name: 'owner',
                  type: 'string'
                },
                {
                  name: 'description',
                  type: 'string'
                }
    ]);

    var Device = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string',
                  convert: function(v,record)
                  {
                     return v+' / '+record.environment;
                  }
                },
                {
                  name: 'environment',
                  type: 'string'
                },
                {
                  name: 'description',
                  type: 'string'
                }
    ]);

    var Endpoint = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'access_url',
                  type: 'string'
                }
    ]);

    selectedBasetype='contractArtifact';
    hideProxied=contractUUID==null;

    var buildQuery=function()
    {
        var additionalFilter='';
        if (selectedBasetype=='contractArtifact') additionalFilter="and a.contractState.name='Accepted'";
        if (selectedBasetype=='endpointArtifact') additionalFilter="and (a.r_managementType.val&lt;>'managedEndpoint' or a.r_managementType.val is null)";
        if (hideProxied) additionalFilter+=" and not exists (select u._uuid from "+selectedBasetype+" u join r_proxyArtifact p using r_relatedMessagingProxy where u._uuid=a._uuid)";
        return "<query>select a._uuid as uuid, a._domainId as domain, a.name as name,a._owner as owner, a.description as description from "+selectedBasetype+" a where upper(a.name) like :query "+additionalFilter+" order by a.name</query>";
    }

    endpointSelectionModel=new Ext.grid.CheckboxSelectionModel();

    var onEndpointsStoreLoad=function(store)
    {
       endpointSelectionModel.selectRange(0,store.getTotalCount());
       checkForExistingProxies(store.rootUUID,store);
    };

    var selectedEndpointsStore = new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: Endpoint,  root: 'records'  }),
       url: SERVER_URI+'/../../query',
       sortInfo: {field: 'name', direction: 'ASC'},
       listeners : { load: onEndpointsStoreLoad }
    });

    var selectedEndpointsGrid = new Ext.grid.GridPanel({
        store: selectedEndpointsStore,
        width: 'auto',
        height:80,
        region:'center',
        margins: '0 5 5 5',
        emptyText: 'No results to display',
        autoExpandColumn: 'name',
        selModel: endpointSelectionModel,
        columns: [
                new Ext.grid.RowNumberer(),
                {
                    id: 'name',
                    header: 'Name',
                    dataIndex: 'name',
                    width: 180,
                    sortable: true
                },{
                    header: 'Access URL',
                    dataIndex: 'access_url',
                    width: 320,
                    sortable: true
                },
                endpointSelectionModel
        ]
    });


    var loadSelectedEndpoints=function(rootUUID)
    {
       var query=null;
       var excludeManaged="and (e.r_managementType.val&lt;>'managedEndpoint' or e.r_managementType.val is null)";

       if (selectedBasetype=='endpointArtifact')
       {
           query="<query>select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from endpointArtifact e where e._uuid=:rootUUID "+excludeManaged+"</query>";
       }
       if (selectedBasetype=='businessServiceArtifact')
       {
           query="<query>select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from businessServiceArtifact b join applicationInterfaceArtifact w1 using service, "+
                                                        "applicationInterfaceArtifact w2 join endpointArtifact e using w2.endpoint "+ "where w1._uuid=w2._uuid and b._uuid=:rootUUID "+excludeManaged+"</query>";
       }
       if (selectedBasetype=='applicationInterfaceArtifact')
       {
           query="<query>select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from applicationInterfaceArtifact w join endpointArtifact e using endpoint where w._uuid=:rootUUID "+excludeManaged+"</query>";
       }
       if (selectedBasetype=='applicationComponentArtifact')
       {
           query="<query>select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from applicationComponentArtifact a join businessServiceArtifact b1 using a.r_consistsOf,"+
                                                          "businessServiceArtifact b2 join applicationInterfaceArtifact w1 using b2.service,"+
                                                           "applicationInterfaceArtifact w2 join endpointArtifact e using w2.endpoint "+
                          "where b1._uuid=b2._uuid and w1._uuid=w2._uuid and a._uuid=:rootUUID "+excludeManaged+"</query>";
       }
       if (selectedBasetype=='contractArtifact')
       {
           query="<query>"+
                   "select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from contractArtifact c join applicationComponentArtifact a1 using providerContractor, "+
                                                    "applicationComponentArtifact a2 join businessServiceArtifact b1 using a2.r_consistsOf, "+
                                                    "businessServiceArtifact b2 join applicationInterfaceArtifact w1 using b2.service, "+
                                                    "applicationInterfaceArtifact w2 join endpointArtifact e using w2.endpoint "+
                             "where a1._uuid=a2._uuid and b1._uuid=b2._uuid and w1._uuid=w2._uuid and c._uuid=:rootUUID "+excludeManaged+
                   " UNION "+
                   "select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from contractArtifact c join businessServiceArtifact b1 using providerContractor, "+
                                                    "businessServiceArtifact b2 join applicationInterfaceArtifact w1 using b2.service, applicationInterfaceArtifact w2 join endpointArtifact e using w2.endpoint "+
                             "where b1._uuid=b2._uuid and w1._uuid=w2._uuid and c._uuid=:rootUUID "+excludeManaged+
                   " UNION "+
                   "select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from contractArtifact c join applicationInterfaceArtifact w1 using providerContractor, applicationInterfaceArtifact w2 join endpointArtifact e using w2.endpoint "+
                             "where w1._uuid=w2._uuid and c._uuid=:rootUUID "+excludeManaged+
                   " UNION "+
                   "select e._uuid as uuid, e.name as name,e.accessPoint.url as access_url from contractArtifact c join endpointArtifact e using providerContractor "+
                             "where c._uuid=:rootUUID "+excludeManaged+
                  "</query>";
       }
       selectedEndpointsStore.setBaseParam('dql',query);
       selectedEndpointsStore.setBaseParam('rootUUID',rootUUID);
       selectedEndpointsStore.rootUUID=rootUUID;
       selectedEndpointsStore.load();
    }

    var searchInstanceStore = new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: BaseInstance,  root: 'records'  }),
       url: SERVER_URI+'/../../query',
       baseParams : { dql : buildQuery() },
       sortInfo: {field: 'name', direction: 'ASC'}
    });

    var selectBaseType=function(type) {
         selectedBasetype=type;
         searchInstanceStore.setBaseParam('query','');
         var query=buildQuery();
         searchInstanceStore.setBaseParam('dql',query);
         searchInstanceStore.load();
    };

    var setHideProxied=function(hide) {
         searchInstanceStore.setBaseParam('query','');
         hideProxied=hide;
         searchInstanceStore.setBaseParam('dql',buildQuery());
         searchInstanceStore.load();
    };

    var typeShootOut={
        bodyStyle: 'padding-left:20px;',
        items: [ {
            xtype: 'fieldset',
            collapsible:true,
            title: 'Choose type',
            autoHeight: true,
            width: 'auto',
            defaultType: 'radio',
            items: [
            {
                checked: true,
				id: 'radContract',
                fieldLabel: 'Base type',
                boxLabel: 'Contract (recommended)',
                name: 'baseType',
                inputValue: 'contract',
                listeners: { check : function(checkbox,checked) { if (checked) selectBaseType('contractArtifact'); } }
            }, {
                fieldLabel: '',
                labelSeparator: '',
                boxLabel: 'Application',
                name: 'baseType',
                inputValue: 'application',
                disabled: contractUUID!=null,
                listeners: { check : function(checkbox,checked) { if (checked) selectBaseType('applicationComponentArtifact'); } }
            }, {
                fieldLabel: '',
                labelSeparator: '',
                boxLabel: 'Service',
                name: 'baseType',
                inputValue: 'businessService',
                disabled: contractUUID!=null,
                listeners: { check : function(checkbox,checked) { if (checked) selectBaseType('businessServiceArtifact'); } }
            }, {
                fieldLabel: '',
                labelSeparator: '',
                boxLabel: 'Implementation',
                name: 'baseType',
                inputValue: 'implementation',
                disabled: contractUUID!=null,
                listeners: { check : function(checkbox,checked) { if (checked) selectBaseType('applicationInterfaceArtifact'); } }
            }, {
                fieldLabel: '',
                boxLabel: 'Individual Endpoint',
                labelSeparator: '',
                name: 'baseType',
                inputValue: 'endpoint',
                disabled: contractUUID!=null,
                listeners: { check : function(checkbox,checked) { if (checked) selectBaseType('endpointArtifact'); } }
            }]
        } ]
    };


    var resultTpl = new Ext.XTemplate(
        '<tpl for="."><div class="search-item">',
            '<h3><span>{owner}</span> {name}</h3>',
            '{description}',
            '<div><a onclick="showArtifactInNewWindow(\'{uuid}\')" target="_blank">(more..)</a></div>',
        '</div></tpl>'
    );


    var searchDeviceStore = new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: Device,  root: 'records'  }),
       url: SERVER_URI+'/../../query',
       baseParams : { dql : '<query>select d._uuid as uuid,d.name as name,d.description as description,d.environment.name as environment from r_deviceArtifact d where upper(d.name) like :query and (d._domainId=:domain or d._domainId=\'topLevelDomain\')</query>' },
       sortInfo: {field: 'name', direction: 'ASC'}
    });

    var loadDevices=function(domain) {
       searchDeviceStore.setBaseParam('domain',domain);
       searchDeviceStore.setBaseParam('query');
       searchDeviceStore.load();
    }

    var chooseRootCombo=new Ext.form.ComboBox({
        store: searchInstanceStore,
        name:'root',
        hiddenName:'rootUUID',
        triggerAction:'all',
        xtype:'combo',
        width:400,
        fieldLabel: 'Chosen artifact',
        displayField:'name',
        valueField:'uuid',
        forceSelection:true,
        minChars:0,
        typeAhead: false,
        loadingText: 'Searching...',
        pageSize:10,
        tpl:resultTpl,
        disabled: contractUUID!=null,
        valueNotFoundText:contractName,
        itemSelector: 'div.search-item',
        listeners: { select : function(combo,record) { if (combo.getValue()!=null)  { loadSelectedEndpoints(combo.getValue()); loadDevices(record.data.domain); }}}
       }
    );

    searchInstanceStore.on('load',function() { chooseRootCombo.reset(); });

    if (contractUUID!=null)
    {
       chooseRootCombo.setValue(contractUUID);
       loadSelectedEndpoints(contractUUID);
    }

    loadDevices(domain);

    var instanceShootOut={
        bodyStyle: 'padding-left:20px;',
        items: [ {
            xtype: 'fieldset',
            collapsible:true,
            title: 'Choose Instance',
            autoHeight: true,
            width: 'auto',
            items: [
               {
                fieldLabel: '',
                boxLabel: 'Hide already proxied',
                labelSeparator: '',
                xtype:'checkbox',
                name: 'hideProxied',
                inputValue: 'hideProxied',
                checked: hideProxied,
                disabled: contractUUID!=null,
                listeners: { check : function(checkbox,checked) { setHideProxied(checked); } }
               },
               chooseRootCombo
            ]
        }]
    };

    var summary={
        bodyStyle: 'padding-left:20px;',
        items: [ {
            xtype: 'fieldset',
            collapsible:true,
            title: 'Selected endpoints',
            autoHeight: true,
            layout:'fit',
            width: 'auto',
            items: selectedEndpointsGrid
        }]
    };

    var deviceResultTpl = new Ext.XTemplate(
        '<tpl for="."><div class="search-item">',
            '<h3><span>{environment}</span> {name}</h3>',
            '{description}',
        '</div></tpl>'
    );


    var deviceCombo=new Ext.form.ComboBox(
               {
                  name: 'device',
                  lazyRender:true,
                  triggerAction:'all',
                  store: searchDeviceStore,
                  width:400,
                  fieldLabel: 'Chosen device',
                  displayField:'name',
                  valueField:'uuid',
                  hiddenName:'deviceUUID',
                  forceSelection:true,
                  minChars:0,
                  typeAhead: false,
                  loadingText: 'Searching...',
                  pageSize:10,
                  tpl:deviceResultTpl,
                  itemSelector: 'div.search-item'
               }
    );

    var deviceShootOut={
        bodyStyle: 'padding-left:20px;',
        items: [ {
            xtype: 'fieldset',
            collapsible:true,
            title: 'Choose Proxy Device',
            autoHeight: true,
            width: 'auto',
            items: [
 /*              {
                fieldLabel: '',
                boxLabel: 'List only devices matching endpoint(s) environment',
                labelSeparator: '',
                xtype:'checkbox',
                name: 'matchingEnvironment',
                inputValue: 'true'
               },*/
               deviceCombo
            ]
        }]
    };

    var instanceShootOutLabel={
            style: 'padding:0px 10px 5px 10px',
            xtype: 'label',
            text: 'Choose the particular artifact now:'
    };


    var typeShootOutLabel={
            style: 'padding:5px 10px 5px 10px',
            xtype: 'label',
            text: 'You need to choose a set of endpoints that will be proxied first. You will need to pick an artifact that directly'+
                  ' or indirectly references endpoints. Choose the type of the artifact now:'
    };

    var summaryLabel={
            style: 'padding:0px 10px 5px 10px',
            xtype: 'label',
            text: 'This list contains the list of all selected endpoint that the proxy will be created for:'
    };

    var deviceLabel={
            style: 'padding:0px 10px 5px 10px',
            xtype: 'label',
            text: 'Choose the proxy device to host the newly created proxy:'
    };

    var nextButton = new Ext.Button({
            text: 'Next',
            disabled:true
    });

    var closeButton = new Ext.Button({
            text: 'Cancel'
    });

    endpointsForm = new Ext.FormPanel({
        labelWidth: 200,
        layout : 'fit',
        width: 600,
        bodyStyle: 'padding:0',
        items: [
            {
                layout: 'column',
                bodyStyle: 'padding:0 10px',
                autoScroll: true,
                border: false,
                defaults: {
                    columnWidth: '1',
                    border: false
                },
                items: [typeShootOutLabel, typeShootOut, instanceShootOutLabel,instanceShootOut,summaryLabel,summary, deviceLabel, deviceShootOut,
                        {xtype:'hidden', name:'endpointUUIDs'}, {xtype:'hidden', name:'reusedProxies'} ]
            }
        ],
        buttons: [nextButton, closeButton ]
    });

    nextButton.on('click', function() {
                  if(endpointsForm.getForm().isValid()) {
                        var endpoints=endpointSelectionModel.getSelections();
                        var result="";
                        for(var e=0;e < endpoints.length;e++) result+=endpoints[e].data.uuid+'|';
                        endpointsForm.getForm().setValues({endpointUUIDs:result});
                        getFrontendProtocols(endpointsForm.getForm().getFieldValues().deviceUUID,chooseFrontendProtocol);						
                  }
                });

    var enableNextStep=function() {
        nextButton.setDisabled(endpointSelectionModel.getCount()==0 || endpointsForm.getForm().getFieldValues().deviceUUID=='');
    };

    endpointSelectionModel.on('selectionchange', enableNextStep );
    deviceCombo.on('select', enableNextStep );

    win = new Ext.Window({
       title       : 'Create new proxy..',
       layout      : 'card',
       activeItem  : 0,
       autoScroll: true,
       width       : 730,
       //height      : 785,
       height      : calculateWindowHeight(CHOOSE_ENDPOINT_STEPS_HEIGHT),
       modal       : true,
       closeAction : 'hide',
       plain       : true,
       bodyStyle   : 'padding:0',
       items       : endpointsForm
    });

    closeButton.on('click',function() {win.destroy();});
    win.show();

};

deployContract=function(contractUUID, contractName,contractDomain)
{
   createProxyWindow(contractDomain,contractUUID,contractName);
}
