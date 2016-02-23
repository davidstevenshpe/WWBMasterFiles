/* global variables

  alternativesProcessingEndpointStore - points to endpointStore in chooseEndpoint.js
  function afterDeploy -
*/

var buildDialog=function(data)
{

    var Alternative = Ext.data.Record.create([
                {
                  name: 'endpointUUID',
                  type: 'string'
                },
                {
                  name: 'endpointName',
                  type: 'string'
                },
                {
                  name: 'endpointURL',
                  type: 'string'
                },
                {
                  name: 'proxyUUID',
                  type: 'string'
                },
                {
                  name: 'proxyName',
                  type: 'string'
                },
                {
                  name: 'proxies'
                }
    ]);

    var alternativesStore = new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: Alternative,  root: 'endpointsReport'  }),
       data: data,
       sortInfo: {field: 'endpointName', direction: 'ASC'}
       //listeners : { load: onEndpointsStoreLoad }
    });


   var Proxy = Ext.data.Record.create([
       {
          name: 'proxyUUID',
          type: 'string'
       },
       {
          name: 'proxyName',
          type: 'string'
       },
       {
          name: 'frontendURL',
          type: 'string'
       }
   ]);

   var proxySelectorStore=new Ext.data.Store({
       reader: new Ext.data.JsonReader({fields: Proxy,  root: 'proxies'  }),
       data: { proxies:[ ] },
       sortInfo: {field: 'proxyName', direction: 'ASC'}
   });

    var proxyTpl = new Ext.XTemplate(
        '<tpl for="."><div class="proxy-search-item"><div style="padding:4px">',
            '<div style="font-weight:bold">{proxyName}</div>',
            '<div>{frontendURL}</div></div>',
        '</div></tpl>'
    );

    // create the combo instance
    var proxySelector = new Ext.form.ComboBox({
       store: proxySelectorStore,
       lazyRender:true,
       mode: 'local',
       listeners: {
          beforequery: function(qe){ qe.forceAll=true; }
       },
       forceSelection:true,
       editable:false,
       minChars:0,
       typeAhead: false,
       pageSize:10,
       tpl:proxyTpl,
       itemSelector: 'div.proxy-search-item',
       valueField: 'proxyName',
       displayField:'proxyName'
    });

    var proxyRenderer=function(value,meta,record)
    {
        if (record.data.proxies.length<2) return record.data.proxyName; else return record.data.proxyName+" <a>("+record.data.proxies.length+" options..)</a>";
    }

    var grid= new Ext.grid.EditorGridPanel({
        flex:80,
        align:'stretchmax',
        layout:'fit',
        store: alternativesStore,
        clicksToEdit: 1,
        width: 'auto',
        region:'center',
        margins: '0 5 5 5',
        autoExpandColumn: 'endpointURL',
        columns: [
                new Ext.grid.RowNumberer(),
                {
                    header: 'Endpoint Name',
                    dataIndex: 'endpointName',
                    width: 200,
                    sortable: true
                },{
                    id: 'endpointURL',
                    header: 'Endpoint URL',
                    dataIndex: 'endpointURL',
                    width: 400,
                    sortable: true
                },{
                    header: 'Proxy',
                    dataIndex: 'proxyName',
                    editor:proxySelector,
                    renderer: proxyRenderer ,
                    width: 400,
                    sortable: true
                }
        ]
    });

    var fillEditCombo=function(event) {
       currentlyEditedRecord=event.record;
       proxySelectorStore.loadData(event.record.data,false);
    };
    grid.on('beforeedit',fillEditCombo);


    var chooseProxy=function(combo,record) {
       currentlyEditedRecord.set('proxyName',record.data.proxyName);
       currentlyEditedRecord.set('proxyUUID',record.data.proxyUUID);
       currentlyEditedRecord.commit();
    }
    proxySelector.on('select',chooseProxy);


    var label=new Ext.Panel( { height:50,bodyStyle:'font-size:14px;margin:10px;',html:'<div>There have been proxies already created for the endpoints used by the chosen contract previously.'+
              ' (When another contract has been deployed). Do you want to use those proxies with this contract as well ?</div>'});

    var closeButton = new Ext.Button({
            text: 'Cancel'
    });

    var reuseButton = new Ext.Button({
            text: 'Reuse existing proxies'
    });

    var createNewButton = new Ext.Button({
            text: 'Create new proxies'
    });

    alternativesWindow = new Ext.Window({
       title       : 'There have been proxies created for the selected endpoints..',
       layout      : 'fit',
       width       : 1020,
       height      : 400,
       modal       : true,
       closeAction : 'destroy',
       plain       : true,
       bodyStyle   : 'padding:0',
       items       : { type:'panel',align:'stretchmax',layout:'vbox',items: [ label,grid] },
       buttons: [reuseButton,createNewButton, closeButton ]
    });

    closeButton.on('click',function() { alternativesWindow.close(); win.destroy(); });
    createNewButton.on('click',function() { alternativesWindow.destroy(); });

    var useExistingProxies=function()
    {
        alternativesWindow.destroy();
        var reusedProxyUUIDs=new Array();
        for(j=0;j<alternativesStore.getCount();j++)
        {
            var alternative=alternativesStore.getAt(j).data;
            reusedProxyUUIDs[j]=alternative.proxyUUID;
            for(i=0;i<alternativesProcessingEndpointStore.getCount();i++)
            {
                var rec=alternativesProcessingEndpointStore.getAt(i).data;
                if (rec.uuid==alternative.endpointUUID) alternativesProcessingEndpointStore.removeAt(i);
            }
        }
        endpointsForm.getForm().setValues({reusedProxies:Ext.encode(reusedProxyUUIDs)});
             Ext.Msg.show({
                    title:'Confirmation',
                    msg: 'Are you sure to reuse existing proxies for the contract being deployed ?',
                    buttons: Ext.Msg.YESNO,
                    icon: Ext.MessageBox.QUESTION,
                    fn:function(buttonId) {
                        if (buttonId=='yes')
                        {
                            var waitMsg=Ext.Msg.progress('Please wait','Deploying contract...');
                            performCompleteReuseProxiesForContract(endpointsForm.getForm().findField('rootUUID').getValue(),Ext.encode(reusedProxyUUIDs),
                            function() {
                              waitMsg.hide();
                              Ext.Msg.show({
                                title:'Confirmation',
                                msg: 'Contract has been deployed.',
                                buttons: Ext.Msg.OK,
                                icon: Ext.MessageBox.INFO,
                                fn: function() {
                                     if (alternativesProcessingEndpointStore.getCount()!=0)
                                     {
                                          endpointsForm.getForm().setValues({reusedProxies:Ext.encode(reusedProxyUUIDs)});
                                          Ext.Msg.show({
                                            title:'Confirmation',
                                            msg: 'There are remaining endpoints which don\'t have proxy yet. Follow the wizard to create those.',
                                            buttons: Ext.Msg.OK,
                                            icon: Ext.MessageBox.INFO
                                          });
                                     }
                                     else
                                     {
                                          win.destroy(); afterDeploy();
                                     }
                                }
                              });
                            });
                        }
                        else
                        {
                           win.destroy();
                        }
                    }
             });
    }

    reuseButton.on('click',useExistingProxies);

    alternativesWindow.show();
}

var waitDialog;

var resolveAlternatives=function(data)
{
   waitDialog.hide();
   if (data.endpointsReport.length!=0)
   {
       buildDialog(data);
   }
}

checkForExistingProxies=function(rootUuid,endpointStore)
{
   alternativesProcessingEndpointStore=endpointStore;
   var endpointList='';
   for(i=0;i<endpointStore.getCount();i++)
   {
      var rec=endpointStore.getAt(i);
      endpointList+=rec.data.uuid+'|';
   }
   waitDialog=Ext.Msg.wait('Please wait..','Checking for existing proxies');
   getEndpointDeploymentAlternativesList(rootUuid,endpointList,resolveAlternatives);
}