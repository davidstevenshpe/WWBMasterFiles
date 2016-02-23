<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:control targetTask="/admin/server/browse" targetDepth="${sessionStack.currentDepth-1}" mode="script" caption="reloadPage">
   <syswf:param name="domainId" value="${domainId}"/>
</syswf:control>

<div id="root.container" style="padding-top:10px">
</div>


<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="registerXI50Domain"/>
  <syswf:param name="code">
    function createXI50Domain(c_managementInterfaceUrl,c_webInterfaceURL,c_domain,username,password,c_environment,c_environmentLabel, domainId)
    {
            var xi50=artifactFactory.newArtifact(R_datapowerXI50Artifact.SDM_NAME);
            xi50.setName(c_managementInterfaceUrl);
            xi50.setR_managementInterfaceUrl(c_managementInterfaceUrl);
            xi50.setR_webInterfaceURL(c_webInterfaceURL);
            xi50.setUsername(username);
            xi50.setPassword(password);
            xi50.setR_xi50Domain(c_domain);
            var cat=new Category();
            cat.setVal(c_environment);
            cat.setName(c_environmentLabel);
            xi50.setEnvironment(cat);
            repositoryService.createArtifact(xi50,null,domainId);
            repositoryService.applyDefaultAcl(xi50.get_uuid(),true);
    }

     function getDomainList(url,username,password,device)
     {
        return Packages.com.hp.systinet.proxy.mgmt.ui.CreateDeviceHandler.getInstance().checkConnection(url,username,password,device);
     }
  </syswf:param>
</syswf:component>


<c:if test="${this.backButtonInvoked}">
<script>
//<![CDATA[
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
                     text: "Enter Datapower connection parameters that will be used by the Systinet Platform to access specific Datapower XI50 domain."+
                           "This will create XI50 Datapower artifact which can be later used to create webservice proxies for services registered within the catalog."+
                            " Note that the default XML management URL is on port 5550, accessible over https and and needs to be explicitly enabled within the device configuration."

            };

            var catalogSpecificLabel={
                     style: 'padding:10px 10px 15px 10px',
                     xtype: 'label',
                     text: "Associate the XI50 domain with an environment. When creating proxies for endpoints assigned to environment appropriate XI50 Datapower domain will be automatically chosen."
            };

            var testConnection=function()
            {
               if (typeof timeoutInProgress!='undefined') clearTimeout(timeoutInProgress);
               timeoutInProgress=setTimeout("checkDeviceConnection();",1000);
            }

            var domainStore = new Ext.data.JsonStore({
                autoDestroy: true,
                root: 'domains',
                idProperty: 'name',
                fields: ['name']
            });

            var domainCombo=new Ext.form.ComboBox({
                 id: 'domainCombo',
                 name : "c_domain",
                 disabled: true,
                 fieldLabel : "XI50 Domain",
                 validator: nullValidator,
                 width: 180,
                 height : 23,
                 store: domainStore,
                 lazyRender:true,
                 mode: 'local',
                 triggerAction:'all',
                 displayField:'name',
                 valueField:'name',
                 hiddenName:'c_domain',
                 forceSelection:true,
                 minChars:0,
                 typeAhead: false,
                 pageSize:10
            });

            var saveButton=new Ext.Button({
                      text     : 'Save',
                      disabled : true
            });

            var cancelButton=new Ext.Button({
                      text     : 'Cancel'
            });

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
                                             /*{
                                                   xtype : "textfield",
                                                   name : "c_webInterfaceURL",
                                                   fieldLabel : "Web Interface URL",
                                                   width: 350,
                                                   height : 23,
                                             },*/
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
                                                   inputType: "password",
                                                   name : "password",
                                                   fieldLabel : "Password",
                                                   validator: nullValidator,
                                                   width: 180,
                                                   height : 23,
                                                   enableKeyEvents: true,
                                                   listeners: { keyup: testConnection }
                                             },
                                             domainCombo
                                          ]
                                       } ]},
                   catalogSpecificLabel,
                   {
                       bodyStyle: 'padding-left:10px;padding-right:10px;',
                       items: {
                           xtype : "fieldset",
                           title : "Catalog specific",
                           items : [
                                 environmentCombo, {xtype:'hidden', name:'c_environment'}, {xtype:'hidden', name:'domainId', value:'${domainId}'}, {xtype:'hidden', name:'device', value:'XI50HTTPProxyPublisher'}
                           ]
                        }
                   }],
                   buttons: [saveButton,cancelButton]

            });


            var domainsLoadedHandler=function(data)
            {
               domainCombo.setDisabled(!data.success);
               connectionSuccess = data.success;
               saveButton.setDisabled(!connectionSuccess || !form.getForm().isValid());
               tip.hide();
               if (data.success)
               {
                  domainStore.loadData(data);
               }
               else
               {
                  tip=new Ext.Tip( { html: data.error});
                  tip.showBy('domainCombo',"c");
               }
            }

            checkDeviceConnection=function()
            {
            	saveButton.setDisabled(true);
                var values=form.getForm().getFieldValues();
                if (values.password==null || values.username==null || values.c_managementInterfaceUrl==null ||
                    values.password=='' || values.username=='' || values.c_managementInterfaceUrl=='') return;
                if (typeof tip!='undefined') tip.hide();
                tip=new Ext.Tip( { html: 'Connecting...'});
                tip.showBy('domainCombo',"c");
                getDomainList(values.c_managementInterfaceUrl,values.username,values.password, 'XI50HTTPProxyPublisher', domainsLoadedHandler);
            }

            environmentCombo.on('select',function(combo,record) { 
            	form.getForm().setValues( {c_environment:record.data.value});
            	saveButton.setDisabled(!connectionSuccess || !form.getForm().isValid());
            	} );

            win = new Ext.Window({
               title       : 'Register Datapower XI50 Domain..',
               layout      : 'fit',
               y:100,
               width       : 700,
               height      : 'auto',
               modal       : true,
               closeAction : 'hide',
               plain       : true,
               bodyStyle   : 'padding:5px 5px 0',
               items       : form
            });

            saveButton.on('click',function() {
                         if(form.getForm().isValid())
                         {
                            var v=form.getForm().getValues();
                            var onCreate=function() {
                              win.hide();
                              reloadPage();
                            };
                            createXI50Domain(v.c_managementInterfaceUrl,v.c_webInterfaceURL,v.c_domain,v.username,v.password,v.c_environment,v.c_environmentLabel, v.domainId,onCreate)
                         }
            });

            cancelButton.on('click',function() {
                            win.hide();
            });

            win.show();
});


//]]>
</script>
</c:if>

<syswf:component name="/admin/server/browseAllServers" prefix="background"/>
