var buildPolicyView=function(policyData) {

    var Policy = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'guid',
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
                  type: 'string'
                },
                {
                  name: 'version',
                  type: 'string',
                  convert: function(v,record)
                  {
                     if (v<0) return 'Not versioned'; else return v;
                  }
                },
                {
                  name: 'deviceUUID',
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

    function onLoadpolicyDependencies(deps) {
      var table;
      var devUUID='';
      if (typeof deps.deviceUUID !='undefined') devUUID=deps.deviceUUID;
      if ((typeof deps.data =='undefined') || deps.data.length==0)
      {
        table='None detected.';
      }
      else
      {
        table='<table style="margin:8px" border="1"><tr><th class="PolicyDependencyTableHeader">Name</th><th class="PolicyDependencyTableHeader">Type</th><th class="PolicyDependencyTableHeader">Object Id</th></tr>'
        for(i=0;i<deps.data.length;i++)
        {
           table+='<tr>';
           table+='<td><div class="PolicyDependencyTableCell">';
           table+=deps.data[i].name;
           table+='</div></td>';
           table+='<td><div class="PolicyDependencyTableCell">';
           table+=deps.data[i].type;
           table+='</div></td>';
           table+='<td><div class="PolicyDependencyTableCell">';
           table+=deps.data[i].id;
           table+='</div></td>';
           table+='</tr>';
        }
        table+='</table>';
      }
      Ext.get(devUUID+deps.guid+'Dependencies').dom.innerHTML=table;
    };

    var expander = new Ext.ux.grid.RowExpander2({
                    tpl : new Ext.XTemplate(
                        '<div style="margin-left:4px;">Dependencies:',
                            '<span style="font-size:12px">{synchronizationStatusDescription}</span>',
                            '<span style="font-size:12px">{description}</span>',
                            '<div id="{deviceUUID}{guid}Dependencies"></div>',
                        '</div>'
                    ),
                    listeners: { expand:  function(ex, record, body, rowIndex) {
                                             getPolicyDepencies(record.data.deviceUUID,record.data.guid,record.data.version,onLoadpolicyDependencies);
                                          }
                    }
    });


    var policySelectionModel=new Ext.grid.CheckboxSelectionModel();

    var policyStore = new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: Policy,  root: 'records'  }),
       url: SERVER_URI+'/../../query'
,
       sortInfo: {field: 'name', direction: 'ASC'}
    });

    var policyStore = new Ext.data.GroupingStore({
         autoDestroy: true,
         groupField:'deviceName',
         reader: new Ext.data.JsonReader({fields: Policy,  root: 'records'  }),
         sortInfo: {field: 'name', direction: 'ASC'},
         data: { records : policyData.results }
    });

    var policyGrid = new Ext.grid.GridPanel({
        store: policyStore,
        width: 'auto',
        height: 'auto',
        autoHeight: true,
        region:'center',
        margins: '0 5 5 5',
        emptyText: 'No results to display',
        autoExpandColumn: 'name',
        selModel: policySelectionModel,
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
                    header: 'Version',
                    dataIndex: 'version',
                    hidden: false,
                    width: 150,
                    sortable: true
                },{
                    header: 'Device Native ID',
                    dataIndex: 'guid',
                    hidden: false,
                    width: 200,
                    sortable: true
                },{
                    header: 'Synchronization Status',
                    dataIndex: 'synchronizationStatus',
                    width: 150,
                    sortable: true,
                    renderer: function(v)
                             {
                                  if (v=='Unsynchronized') return '<span style="color:red">Unsynchronized</span>';
                                      else if (v=='Synchronized') return '<span style="color:green">'+v+'</span>'; else return '<span style="color:darkgray">'+v+'</span>';
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
                },
                policySelectionModel
        ]
    });


    var confirmSyncCompletion=function(result)
    {
            Ext.Msg.show({
              title:'Info..',
              msg: 'Policy synchronization complete',
              minWidth:800,
              multiline: true,
              value:result.results.join('\n'),
              fn:function() {
                window.location.reload();
              },
              buttons: Ext.Msg.OK,
              icon: Ext.MessageBox.INFO
            });
    }

    var synchronizePoliciesHandler=function(taskKey)
    {
        monitorProgress(taskKey,confirmSyncCompletion,'Synchronizing policies ..');
    };

    var deletePoliciesHandler=function(taskKey)
    {
        monitorProgress(taskKey,confirmSyncCompletion,'Deleting policies ..');
    };

    var buildPolicyListForProcessing=function(records)
    {
       var toSynchronize=new Array();
       for(i=0;i<records.length;i++)
       {
          toSynchronize[i]={ name:records[i].data.name, guid:records[i].data.guid, uuid:records[i].data.uuid, deviceUUID:records[i].data.deviceUUID,version:records[i].data.version};
       }
       return toSynchronize;
    }

    var onSynchronizePoliciesClick=function()
    {
       var records=policySelectionModel.getSelections();
       var toSynchronize=buildPolicyListForProcessing(records);
       synchronizePolicies(Ext.encode(toSynchronize),synchronizePoliciesHandler);
    }

    var onDeletePoliciesClick=function()
    {
       var records=policySelectionModel.getSelections();
       var toSynchronize=buildPolicyListForProcessing(records);
       deletePolicies(Ext.encode(toSynchronize),deletePoliciesHandler);
    }

    var synchronizeSelectedPoliciesButton = new Ext.Button({
            text: 'Synchronize Into Repository',
            iconCls: 'UI ExtButton Import',
            listeners: { click: onSynchronizePoliciesClick },
            disabled:true
    });

    var deleteSelectedPoliciesButton = new Ext.Button({
            text: 'Delete From Repository',
            iconCls: 'UI ExtButton Remove',
            listeners: { click: onDeletePoliciesClick },
            disabled:true
    });

    policySelectionModel.on('selectionchange',function(model) { synchronizeSelectedPoliciesButton.setDisabled(model.getCount()==0); deleteSelectedPoliciesButton.setDisabled(model.getCount()==0);} );
    /*
    win = new Ext.Window({
       title       : 'Policy Synchronization Report',
       layout      : 'fit',
       width       : 860,
       height      : calculateWindowHeight(785),
       modal       : true,
       closeAction : 'destroy',
       plain       : true,
       maximizable : true,
       bodyStyle   : 'padding:0',
       items       : policyGrid,
       buttons     : [ synchronizeSelectedPoliciesButton, deleteSelectedPoliciesButton, new Ext.Button({ text: 'Close', listeners: {click:function() {win.destroy();} } }) ]
    });
    */

    new Ext.Panel({
       layout      : 'fit',
       renderTo    : 'reportContainer',
       modal       : true,
       plain       : true,
       maximizable : true,
       bodyStyle   : 'padding:0',
       items       : policyGrid,
       tbar:[synchronizeSelectedPoliciesButton, deleteSelectedPoliciesButton]
    });

    Datagrid.Utils.KeepSize(policyGrid);
};

var dataLoadedHandler=function(taskKey)
{
    monitorProgress(taskKey,buildPolicyView,'Loading policies ..');
};

Ext.onReady(function() {
  policyReport(dataLoadedHandler);
});
