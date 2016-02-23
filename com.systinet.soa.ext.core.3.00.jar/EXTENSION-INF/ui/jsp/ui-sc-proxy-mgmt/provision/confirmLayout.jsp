/** Global variables
 **
 ** confirmationForm
 ** afterDeploy();
 **/
CONFIRM_LAYOUT_HEIGHT=490;

var confirmLayoutHandler=function(layout) {

     var finishButton = new Ext.Button({
            text: 'Finish'
     });

     var backButton = new Ext.Button({
            text: 'Back'
     });

     var closeButton = new Ext.Button({
            text: 'Cancel'
     });

     backButton.on('click',function() {
          win.getLayout().setActiveItem(frontendsForm);
          win.setHeight(calculateWindowHeight(CHOOSE_FRONTEND_HEIGHT));
          win.doLayout();
     });

      var Proxy = Ext.data.Record.create([
                {
                  name: 'proxyName',
                  type: 'string'
                },
                {
                  name: 'deviceName',
                  type: 'string'
                },
                {
                  name: 'deviceUUID',
                  type: 'string'
                },
                {
                  name: 'identityManagement',
                  type: 'string'
                },
                {
                  name: 'loadbalancing',
                  type: 'boolean'
                },
                {
                  name: 'frontendName',
                  type: 'string'
                },
                {
                  name: 'frontendURL',
                  type: 'string'
                },
                {
                  name: 'backendName',
                  type: 'string'
                },
                {
                  name: 'backendURL',
                  type: 'string'
                }
      ]);

      var proxyStore = new Ext.data.GroupingStore({
         autoDestroy: true,
         groupField:'proxyName',
         reader: new Ext.data.JsonReader({fields: Proxy,  root: 'records'  }),
         sortInfo: {field: 'frontendURL', direction: 'ASC'},
         data: { records : layout }
      });

      var parseUri=function (sourceUri) {
        var uriPartNames = ["source","protocol","authority","domain","port","path","directoryPath","fileName","query","anchor"];
        var uriParts = new RegExp("^(?:([^:/?#.]+):)?(?://)?(([^:/?#]*)(?::(\\d*))?)?((/(?:[^?#](?![^?#/]*\\.[^?#/.]+(?:[\\?#]|$)))*/?)?([^?#/]*))?(?:\\?([^#]*))?(?:#(.*))?").exec(sourceUri);
        var uri = {};

        for(var i = 0; i < 10; i++){
            uri[uriPartNames[i]] = (uriParts[i] ? uriParts[i] : "");
        }
        if(uri.directoryPath.length > 0){
            uri.directoryPath = uri.directoryPath.replace(/\/?$/, "/");
        }
        return uri;
      }

      var summaryGrid = new Ext.grid.EditorGridPanel({
                height:350,
                region:'center',
                margins: '0 5 5 5',
                store: proxyStore,
                autoExpandColumn: 'name',
                view: new Ext.grid.GroupingView({
                    markDirty: true
                }),

                columns: [
                new Ext.grid.RowNumberer(),
                {
                    hidden: true,
                    header: 'Proxy Name',
                    dataIndex: 'proxyName',
                    width: 60,
                    sortable: true
                },{
                    id: 'name',
                    width: 310,
                    header: 'Managed endpoint URL',
                    dataIndex: 'frontendURL',
                    editor: {
                        xtype: 'textfield',
                        allowBlank: false
                    },
                    sortable: true
                },{
                    width: 310,
                    header: 'Functional endpoint URL',
                    dataIndex: 'backendURL',
                    sortable: true
                },{
                    xtype: 'booleancolumn',
                    header: 'Load Balancing',
                    hidden: true,
                    dataIndex: 'loadbalancing',
                    align: 'center',
                    width: 20,
                    trueText: 'Yes',
                    falseText: 'No',
                    editor: {
                        xtype: 'checkbox'
                    }
                }]
      });

      var urlChanges=new Array();

      summaryGrid.on('validateedit', function(e) {

        var oldUri=parseUri(e.originalValue);
        var newUri=parseUri(e.value);

        if (oldUri.port != newUri.port || oldUri.protocol != newUri.protocol || oldUri.domain != newUri.domain) {
          Ext.Msg.alert('Error', 'Device frontend URL protocol, host or port cannot be changed in this step');
          e.cancel = true;
        }
        else
        {
           var i=0;
           var previousFrontendURL=e.originalValue;

           for(;i<urlChanges.length;i++) {
               if (urlChanges[i].frontendURL==e.originalValue && urlChanges[i].proxyName==e.record.data.proxyName)
               {
                  previousFrontendURL=urlChanges[i].previousFrontendURL;
                  break;
               }
           }
           e.record.data.frontendName=newUri.path;
           urlChanges[i]={proxyName: e.record.data.proxyName, frontendName: e.record.data.frontendName, frontendURL: e.value, 'previousFrontendURL': previousFrontendURL};
        }
      });


      var handlePublish=function(taskKey)
      {
          monitorProgress(taskKey,
                    function(results) {
                        if(!results.success)
                        {
                          Ext.Msg.show({
                            title: results.messages.length+' Problem(s) found',
                            msg: '<table><tr><td>'+results.messages.join('</td></tr><tr><td>')+'</td></tr><table>',
                            buttons: Ext.MessageBox.CANCEL,
                            minWidth : 600,
                            icon: Ext.MessageBox.WARNING
                          });
                        }
                        else
                        {
                          Ext.Msg.show({
                            title: 'Process complete',
                            msg: 'Publishing completed successfuly',
                            buttons: Ext.MessageBox.OK,
                            fn: function() {
                                     if ((typeof afterDeploy) == 'undefined') window.location.reload(); else afterDeploy();
                                     win.destroy();
                            },
                            minWidth : 600,
                            icon: Ext.MessageBox.INFO
                          });
                        }
                     },
                    'Publishing proxies ..');
      }

      var handleFinish=function(taskKey)
      {
          monitorProgress(taskKey,
                    function(results) {
                        if(!results.success)
                        {
                          Ext.Msg.show({
                            title: results.messages.length+' Problem(s) found',
                            msg: '<table><tr><td>'+results.messages.join('</td></tr><tr><td>')+'</td></tr><table>',
                            buttons: Ext.MessageBox.CANCEL,
                            minWidth : 600,
                            icon: Ext.MessageBox.WARNING
                          });
                        }
                        else
                        {
                            var frontendsFormValues=frontendsForm.getForm().getFieldValues();
                            publishProxyLayout(frontendsFormValues.proxyBaseName,endpointsFormValues.deviceUUID,frontendsFormValues.protocol.getId(),frontendData,
                            frontendsFormValues.identityManagementUUID,frontendsFormValues.layout.getId(),
                            endpointsFormValues.rootUUID,endpointsFormValues.endpointUUIDs, Ext.encode(urlChanges),
                            endpointsFormValues.reusedProxies,
                            handlePublish);
                        }
                     },
                    'Verifying proxy configuration setup ..');
      };

      finishButton.on('click',function() {
             var frontendsFormValues=frontendsForm.getForm().getFieldValues();
             validateProxyLayout(frontendsFormValues.proxyBaseName,endpointsFormValues.deviceUUID,frontendsFormValues.protocol.getId(),frontendData,
                            frontendsFormValues.identityManagementUUID,frontendsFormValues.layout.getId(),
                            endpointsFormValues.rootUUID,endpointsFormValues.endpointUUIDs, Ext.encode(urlChanges),handleFinish);
      });

      var summaryLabel={
            style: 'padding:10px 10px 15px 10px',
            xtype: 'label',
            text: 'This is the summary of the proxy(proxies) to be created. You might want to customize frontend urls directly in the table. Click finish to publish the configuration into repository and corresponding proxy devices.'
      };

      if (typeof confirmationForm!='undefined') win.remove(confirmationForm);
      confirmationForm = new Ext.FormPanel({
        labelWidth: 200,
        layout : 'fit',
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
                items: [summaryLabel, summaryGrid]
            }
        ],buttons: [backButton, finishButton, closeButton]
      });

      closeButton.on('click',function() {win.destroy();});
      win.add(confirmationForm);
      win.getLayout().setActiveItem(confirmationForm);
      win.setHeight(calculateWindowHeight(CONFIRM_LAYOUT_HEIGHT));
      win.doLayout();
}

confirmLayout=function(taskKey)
{
    monitorProgress(taskKey,confirmLayoutHandler,'Initializing proxy configuration process ..');
}