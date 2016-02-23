var buildProxyView=function(proxyData) {

    var Proxy = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'synchronizationStatus',
                  type: 'string'
                },
                {
                  name: 'synchronizationStatusDescription',
                  type: 'string'
                },
                {
                  name: 'deviceName',
                  convert: function(v,record)
                  {
                            var tpl=new Ext.XTemplate('<a onclick="showArtifact(\'{deviceUUID}\')">{deviceName}</a><tpl if="xcount!=xindex">, </tpl>',
                                                     {compiled:true});
                            return tpl.applyTemplate(record);
                   }
                },
                {
                  name: 'environment',
                  type: 'string'
                },
                {
                  name: 'deviceUUID',
                  type: 'string'
                },
                {
                  name: 'createdFor'
                },
                {
                  name: 'createdForAsString',
                  convert: function(v,record)
                  {
                            var tpl=new Ext.XTemplate('<tpl for="createdFor">',
                                                         '<a onclick="showArtifact(\'{uuid}\')">{name}</a><tpl if="xcount!=xindex">, </tpl>',
                                                      '</tpl>',
                                                     {compiled:true});
                            return tpl.applyTemplate(record);
                   }
                },
                {
                  name: 'frontend'
                },
                {
                  name: 'frontendAsString',
                  convert: function(v,record)
                  {
                            var tpl=new Ext.XTemplate('<tpl for="frontend">',
                                                         '{.}<tpl if="xcount!=xindex">, </tpl>',
                                                      '</tpl>',
                                                     {compiled:true});
                            return tpl.applyTemplate(record);
                   }
                },
                {
                  name: 'backend'
                },
                {
                  name: 'backendAsString',
                  convert: function(v,record)
                  {
                            var tpl=new Ext.XTemplate('<tpl for="backend">',
                                                         '{.}<tpl if="xcount!=xindex">, </tpl>',
                                                      '</tpl>',
                                                     {compiled:true});
                            return tpl.applyTemplate(record);
                   }
                },
                {
                  name: 'owner',
                  type: 'string'
                },
                {
                  name: 'description',
                  type: 'string'
                },
                {
                  name: 'identityManagement',
                  type: 'string'
                },
                {
                  name: 'identityManagementLocation',
                  type: 'string'
                }
    ]);

    var expander = new Ext.ux.grid.RowExpander2({
                    tpl : new Ext.XTemplate(
                        '<div style="margin-left:4px;">',
                            '<span style="font-size:12px">{synchronizationStatusDescription}</span>',
                            '<div style="margin:4px;">Created for: {createdForAsString}</div>',
                            '<div style="margin:4px;">Contract identity management: {identityManagement}</div>',
                            '<div style="margin:4px;">Contract identity management token location: {identityManagementLocation} <tpl if="identityManagementLocation==\'\'">Not defined</tpl></div>',
                            '<table style="margin:8px" border="1">',
                                 '<tr><th style="padding:3px">Frontend URLs</th><th style="padding:3px">Backend URLs</th></tr>',
                                 '<tr><td style="padding:3px;overflow:auto;">',
                                     '<tpl for="frontend">',
                                         '{.}<tpl if="xcount!=xindex"><br/></tpl>',
                                     '</tpl>',
                                 '</td>',
                                 '<td style="padding:3px;overflow:auto;">',
                                     '<tpl for="backend">',
                                         '{.}<tpl if="xcount!=xindex"><br/></tpl>',
                                     '</tpl>',
                                 '</td></tr>',
                            '</table>',
                        '</div>'
                    )
    });


    var proxySelectionModel=new Ext.grid.CheckboxSelectionModel();

    var proxyStore = new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: Proxy,  root: 'records'  }),
       url: SERVER_URI+'/../../query'
,
       sortInfo: {field: 'name', direction: 'ASC'}
    });

    var proxyStore = new Ext.data.GroupingStore({
         autoDestroy: true,
         groupField:'deviceName',
         reader: new Ext.data.JsonReader({fields: Proxy,  root: 'records'  }),
         sortInfo: {field: 'name', direction: 'ASC'},
         data: { records : proxyData.results }
    });

    var proxyGrid = new Ext.grid.GridPanel({
        store: proxyStore,
        width: 'auto',
        autoHeight:true,
        height:'auto',
        region:'center',
        margins: '0 5 5 5',
        emptyText: 'No results to display',
        autoExpandColumn: 'name',
        selModel: proxySelectionModel,
        plugins: [expander],
        view: new Ext.grid.GroupingViewWithRowExpander({
                    markDirty: true
        }),
        columns: [
                expander,
                {
                    id: 'name',
                    header: 'Name',
                    dataIndex: 'name',
                    width: 150,
                    sortable: true
                },{
                    header: 'Synchronization Status',
                    dataIndex: 'synchronizationStatus',
                    width: 150,
                    sortable: true,
                    renderer: function(v)
                             {
                                  if (v=='Unsynchronized') return '<span style="color:red">Unsynchronized</span>';
                                      else return '<span style="color:green">Synchronized</span>';
                             }
                },{
                    header: 'Status Comments',
                    dataIndex: 'synchronizationStatusDescription',
                    hidden: true,
                    sortable: true
                },{
                    header: 'Device',
                    dataIndex: 'deviceName',
                    hidden: true,
                    width: 150,
                    sortable: true
                },{
                    header: 'Environment',
                    dataIndex: 'environment',
                    sortable: true
                },{
                    header: 'Created for',
                    dataIndex: 'createdForAsString',
                    width: 250,
                    sortable: true
                },{
                    header: 'Frontend',
                    dataIndex: 'frontendAsString',
                    hidden: true,
                    sortable: true
                },{
                    header: 'Backend',
                    dataIndex: 'backendAsString',
                    hidden: true,
                    sortable: true
                },{
                    header: 'Identity Management',
                    dataIndex: 'identityManagement',
                    hidden: true,
                    sortable: true
                },{
                    header: 'Identity Token Location',
                    dataIndex: 'identityManagementLocation',
                    hidden: true,
                    sortable: true
                },
                proxySelectionModel
        ]
    });


    var confirmDestroyCompletion=function(result)
    {
            Ext.Msg.show({
              title:'Info..',
              msg: 'Proxy removal complete',
              minWidth:800,
              multiline: true,
              value:result.results.join('\n'),
              fn:function() {
                 var records=proxySelectionModel.getSelections();
                 for(i=0;i<records.length;i++) proxyStore.remove(records[i]);
              },
              buttons: Ext.Msg.OK,
              icon: Ext.MessageBox.INFO
            });
    }

    var destroyProxiesHandler=function(taskKey)
    {
        monitorProgress(taskKey,confirmDestroyCompletion,'Removing proxies ..');
    };


    var onDeleteProxiesClick=function()
    {
	    Ext.Msg.show({
          title:'Confirmation..',
          msg: 'Selected proxies for deleting may be in use on device. Are you sure you want to delete?',
          buttons: Ext.Msg.YESNO,
          fn: function(buttonId) {
                if (buttonId=='yes')
                {
				   var records=proxySelectionModel.getSelections();
				   var toDelete=new Array();
				   for(i=0;i<records.length;i++)
				   {
					  toDelete[i]={ name:records[i].data.name, uuid:records[i].data.uuid, deviceUUID:records[i].data.deviceUUID};
				   }
				   deleteProxies(Ext.encode(toDelete),destroyProxiesHandler);
                }
          },
          icon: Ext.MessageBox.QUESTION
        });
    }

    var deleteSelectedProxiesButton = new Ext.Button({
            text: 'Delete Selected',
            iconCls: 'UI ExtButton Remove',
            listeners: { click: onDeleteProxiesClick },
            disabled:true
    });

    proxySelectionModel.on('selectionchange',function(model) { deleteSelectedProxiesButton.setDisabled(model.getCount()==0); } );


    new Ext.Panel({
       layout      : 'fit',
       renderTo    : 'reportContainer',
       modal       : true,
       plain       : true,
       maximizable : true,
       bodyStyle   : 'padding:0',
       items       : proxyGrid,
       tbar:[deleteSelectedProxiesButton]
    });

    Datagrid.Utils.KeepSize(proxyGrid);
};

var dataLoadedHandler=function(taskKey)
{
    monitorProgress(taskKey,buildProxyView,'Loading proxies ..');
};

