<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<syswf:control targetTask="/admin/server/browse" targetDepth="${sessionStack.currentDepth-1}" mode="script" caption="reloadPage">
   <syswf:param name="domainId" value="${domainId}"/>
</syswf:control>

<div id="root.container" style="padding-top:10px">
</div>


<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="registerOSB"/>
  <syswf:param name="code">
    function createGateway(c_managementInterfaceUrl,r_agentURL,domainId,username,password,c_environment,c_environmentLabel,frontends)
    {
            var osb=artifactFactory.newArtifact(R_oracleServiceBusArtifact.SDM_NAME);
            osb.setName(c_managementInterfaceUrl);
            osb.setR_managementInterfaceUrl(c_managementInterfaceUrl);
            osb.setR_agentUrl(r_agentURL);
            osb.setUsername(username);
            osb.setPassword(password);
            var cat=new Category();
            cat.setVal(c_environment);
            cat.setName(c_environmentLabel);
            osb.setEnvironment(cat);
            osb.setR_frontendURLGroup(Packages.com.hp.systinet.proxy.mgmt.impl.l7.L7CreateDeviceHelper.convert(frontends));
            repositoryService.createArtifact(osb,null,domainId);
            repositoryService.applyDefaultAcl(osb.get_uuid(),true);
    }

     function checkConnection(managementUrl,agentUrl,username,password)
     {
        return Packages.com.hp.systinet.proxy.mgmt.impl.osb.OSBProxyPublisher.testConnection(managementUrl,agentUrl,username,password);
     }
  </syswf:param>
</syswf:component>


<c:if test="${this.backButtonInvoked}">
<script>
	var showStack;
    Ext.onReady(function() {

            var environments = new Ext.data.JsonStore({
               autoDestroy: true,
               url: SERVER_URI+'/../../taxonomy?taxonomy=uddi:systinet.com:soa:model:taxonomies:environments',
               root: 'records',
               idProperty: 'key',
               fields: ['key', 'value' ]
            });
            environments.load();


            var environmentCombo = new Ext.form.ComboBox({
                  typeAhead: true,
                  forceSelection: true,
                  triggerAction: 'all',
                  lazyRender:true,
                  mode: 'local',
                  allowBlank: false,
                  editable: false,
                  store: environments,
                  valueField: 'value',
                  displayField: 'key',
                  name : "c_environmentLabel",
                  fieldLabel : "Environment"
            });

            var nullValidator=function(value)
            {
                if (value==null || value.trim()=='') return "<div style='padding-left:17px'>This field is required</div>";
                return true;
            }
			
            var connectionSuccess = false;
            
            var connectionLabel={
                     style: 'padding:10px 10px 15px 10px',
                     xtype: 'label',
                     text: "Enter Oracle Service Bus managment interface url and connection parameters that will be used by the Systinet Agent to access the server."+
                           "This will create Oracle Service Bus  artifact which can be later used to create webservice proxies for services registered within the catalog."+
                            "Sample url: t3://localhost:7001\n"+
                            "Also enter Systinet Oracle Service Bus Agent URL. You need to deploy the agent prior using this server into the Web Logic instance you are about to manage."+
                           "The agent behaves as a proxy for communication between Systinet and Weblogic managment interface."+
                            "Sample device url: http://localhost:7001/systinet-osb-agent/"
            };


            var catalogSpecificLabel={
                     style: 'padding:10px 10px 15px 10px',
                     xtype: 'label',
                     text: "Associate the OSB instance with an environment. When creating proxies for endpoints assigned to environment appropriate OSB instance will be automatically chosen."
            };

            var testConnection=function()
            {
               if (typeof timeoutInProgress!='undefined') clearTimeout(timeoutInProgress);
               timeoutInProgress=setTimeout("checkDeviceConnection();",1000);
            }


            var saveButton=new Ext.Button({
                      text     : 'Save',
                      disabled : true
            });

            var cancelButton=new Ext.Button({
                      text     : 'Cancel'
            });



            var deviceInterfacesLabel={
                     style: 'padding:10px 10px 15px 10px',
                     xtype: 'label',
                     text: "Enumerate available OSB frontend URLs."+
                           "This URLs serve as the base URLs for newly created endpoints on the OSB. This depends on your setup of the Weblogic server. "+
                           "In the default configuration where the OSB is hosted by the admin server enter the url similar to  http://localhost:7001"
            };

////
            var selectionModel=new Ext.grid.CheckboxSelectionModel();

            var cm = new Ext.grid.ColumnModel({
                columns: [{
                    id: 'name',
                    header: 'Name',
                    dataIndex: 'name',
                    width: 100,
                    // use shorthand alias defined above
                    editor: new Ext.form.TextField({
                        allowBlank: false
                    })
                }, {
                    header: 'URL',
                    id: 'url',
                    dataIndex: 'url',
                    width: 130,
                    editor: new Ext.form.TextField({
                        allowBlank: false
                    })
                },
                selectionModel
            ]
            });

            var store = new Ext.data.ArrayStore({
                fields: ['name', 'url'],
                idIndex: 0
            });

            addIfaceRecord=function() {
                        var Iface = store.recordType;
                        var p = new Iface({
                            name: 'HTTP',
                            url:'http://'
                        });
                        frontendGrid.stopEditing();
                        store.insert(0, p);
                        frontendGrid.startEditing(0, 0);
            };

            var myData = [];
            store.loadData(myData);
            // create the editor grid
            var frontendGrid = new Ext.grid.EditorGridPanel({
                store: store,
                selModel: selectionModel,
                cm: cm,
                width: '400',
                height: 100,
                autoExpandColumn: 'url',
                clicksToEdit: 1,
                tbar: [{
                          text: 'Add',
                          handler : addIfaceRecord
                       },
                       {
                          text: 'Remove',
                          handler : function() { store.remove(selectionModel.getSelections()); }
                       }
                ]
            });


////


            var form = new Ext.form.FormPanel({
                autoHeight : true,
                bodyStyle   : 'padding:0 10px 0;background-color:transparent;border:none',
                layout: 'column',
                border: false,
                defaults: {
                    columnWidth: '1',
                    border: false
                },
                items :
                   [connectionLabel,{
                            bodyStyle: 'padding-left:10px;padding-right:10px;',
                            items: [ {
                                 xtype : "fieldset",
                                 bodyStyle: 'margin-left:20px;',
                                 title : "Connection parameters",
                                 items : [
                                             {
                                                   xtype : "textfield",
                                                   name : "c_managementInterfaceUrl",
                                                   fieldLabel : "Management Interface URL",
                                                   validator: nullValidator,
                                                   width: 350,
                                                   height : 23,
                                                   enableKeyEvents: true,
                                                   listeners: { keyup: testConnection }
                                             },
                                             {
                                                   xtype : "textfield",
                                                   name : "r_agentURL",
                                                   fieldLabel : "Systinet Agent URL",
                                                   validator: nullValidator,
                                                   enableKeyEvents: true,
                                                   width: 350,
                                                   height : 23,
                                                   listeners: { keyup: testConnection }
                                             },
                                             {
                                                   xtype : "textfield",
                                                   name : "username",
                                                   fieldLabel : "Username",
                                                   validator: nullValidator,
                                                   width: 180,
                                                   height : 23,
                                                   enableKeyEvents: true,
                                                   listeners: { keyup: testConnection }
                                             },
                                             {
                                                   xtype : "textfield",
                                                   id:'password',
                                                   inputType: "password",
                                                   name : "password",
                                                   fieldLabel : "Password",
                                                   validator: nullValidator,
                                                   width: 180,
                                                   height : 23,
                                                   enableKeyEvents: true,
                                                   listeners: { keyup: testConnection }
                                             }
                                          ]
                                       } ]},
                   deviceInterfacesLabel,
                   {
                       bodyStyle: 'padding-left:10px;padding-right:10px;',
                       items: {
                           xtype : "fieldset",
                           title : "Device interfaces (Listen ports)",
                           items : [
                                frontendGrid, {xtype:'hidden', name:'interfaces'}
                           ]
                        }
                   },
                   catalogSpecificLabel,
                   {
                       bodyStyle: 'padding-left:10px;padding-right:10px;',
                       items: {
                           xtype : "fieldset",
                           title : "Catalog specific",
                           items : [
                                 environmentCombo, {xtype:'hidden', name:'c_environment'}, {xtype:'hidden', name:'domainId', value:'${domainId}'},{xtype:'hidden', name:'frontends'}
                           ]
                        }
                   }
                   ],
                   buttons: [saveButton,cancelButton]
            });


            hideTip=function()
            {
               tip.hide();
            }

            var domainsLoadedHandler=function(data)
            {
               connectionSuccess = data.success;
               saveButton.setDisabled(!connectionSuccess || !form.getForm().isValid());
               tip.hide();
               if (data.success)
               {
                  tip=new Ext.Tip( { html: 'Connection ok'});
                  tip.showBy('password',"c");
                  setTimeout("hideTip();",4000);
               }
               else
               {
				  if  (data.error != null && data.error.length < 300){
					  tip=new Ext.Tip( { html: data.error});
					  tip.showBy('password',"c");
				  }else{
					  showStack = function (){
						  tip.hide();
						  Ext.Msg.show({title:'Stacktrace',
							width:800, 
							multiline: 300,
							value:data.error,
							buttons: Ext.Msg.OK});
					  };
					  tip=new Ext.Tip( { html: 'Connection failed. <a onclick=\"javascript: eval(\'showStack()\');\" style=\"cursor: pointer;\"> (Details..)</a>'});
					  tip.showBy('password',"c");
				  }
               }
            }

            checkDeviceConnection=function()
            {
            	saveButton.setDisabled(true);
                var values=form.getForm().getFieldValues();
                if (values.password==null || values.username==null || values.c_managementInterfaceUrl==null || values.r_agentURL==null ||
                    values.password=='' || values.username=='' || values.c_managementInterfaceUrl==''|| values.r_agentURL=='') return;
                if (typeof tip!='undefined') tip.hide();
                tip=new Ext.Tip( { html: 'Connecting...'});
                tip.showBy('password',"c");
                checkConnection(values.c_managementInterfaceUrl,values.r_agentURL,values.username,values.password, domainsLoadedHandler);
            }

            environmentCombo.on('select',function(combo,record) { 
            	form.getForm().setValues( {c_environment:record.data.value});
            	saveButton.setDisabled(!connectionSuccess || !form.getForm().isValid());
            	} );

            win = new Ext.Window({
               title       : 'Register Oracle Service Bus instance',
               layout      : 'fit',
               y:100,
               width       : 700,
               height      : 'auto',
               modal       : true,
               closeAction : 'hide',
               plain       : true,
               bodyStyle   : 'padding:5px 5px 0',
               listeners   : {'hide': function () { if (typeof tip!='undefined') tip.hide(); } },
               items       : form
            });

            saveButton.on('click',function() {
                         if(form.getForm().isValid())
                         {
                            var res='';
                            for(i=0;i<store.getCount();i++)
                            {
                                if (i>0) res+='|';
                                res+=store.getAt(i).data.name+'|'+store.getAt(i).data.url;
                            }
                            form.getForm().setValues( {frontends:res});

                            var v=form.getForm().getValues();
                            var onCreate=function() {
                              win.hide();
                              reloadPage();
                            };
                            createGateway(v.c_managementInterfaceUrl,v.r_agentURL,v.domainId,v.username,v.password,v.c_environment,v.c_environmentLabel,v.frontends,onCreate)
                         }
            });

            cancelButton.on('click',function() {
                            win.hide();
            });

            win.show();
            addIfaceRecord();

});

</script>
</c:if>

<syswf:component name="/admin/server/browseAllServers" prefix="background"/>

