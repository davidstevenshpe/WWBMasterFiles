// GLOBAL VARIABLES:
//  currentDomain: domain id being configured

Ext.onReady(function(){
        var saveButton=new Ext.Button({
                  text     : 'Save',
                  disabled : true
        });

        var protocols={ 'HTTP':'HTTP','HTTPS':'HTTPS' };
        var radios=new Array();
        var i=0;
        for(p in protocols)
        {
            radios[i++]= {
              id:p,
              boxLabel: protocols[p],
              name: 'protocol',
              inputValue: p,
              listeners: { change: function() { saveButton.setDisabled(false); } }
              //listeners: { /*check : function(radio,checked) { if (checked) protocolChosen(radio.getId()); } */ }
            };
        }

        var nameValidator=function(value)
        {
            if (value==null || value.trim()=='') return "<div style='padding-left:17px'>This field is required</div>";
          if (value.search(/^\w+$/i)<0) return "<div style='padding-left:17px'>Must contain letters, numbers and '_' only</div>";
          return true;
        }


        var proxyLayoutShootOut=new Ext.form.RadioGroup({
                          columns:1,
                          name: 'layout',
                          disabled:false,
                          vertical: true,
                          id:"layout",
                          items: [
                            {boxLabel: 'Shared proxy layout (recommended)', name: 'layout-id-1', id: 'shared', inputValue:'SHARED', checked:true},
                            {boxLabel: 'Per service proxy layout', name: 'layout-id-1', id: 'per_service', inputValue:'PER_SERVICE'}
                          ],
                          listeners: { change: function() { saveButton.setDisabled(false); } }
        });


        var samplingInterval = new Ext.form.NumberField(
                  {
                     xtype : "textfield",
                     disabled:true,
                     id: "slmSamplingInterval",
                     name : "slmSamplingInterval",
                     fieldLabel : "Sampling Interval",
                     minValue: 3,
                     required:true,
                     allowDecimals:false,
                     allowNegative:false,
                     validator: nameValidator,
                     width: 350,
                     height : 23,
                     listeners: { change: function() { saveButton.setDisabled(false); } }

                  }
        );
        
        var wsdlBufferSize = new Ext.form.NumberField(
                  {
                     xtype : "textfield",
                     id: "wsdlBufferSize",
                     name : "wsdlBufferSize",
                     fieldLabel : "",
                     minValue: 5000,
                     required:true,
                     allowDecimals:false,
                     allowNegative:false,
                     validator: nameValidator,
                     width: 350,
                     height : 23,
                     listeners: { change: function() { saveButton.setDisabled(false); } }

                  }
        );

        var snmpServerPort = new Ext.form.NumberField(
                  {
                     xtype : "textfield",
                     disabled:true,
                     id: "snmpServerPort",
                     name : "snmpServerPort",
                     fieldLabel : "SNMP Port",
                     minValue: 1024,
                     required:true,
                     allowDecimals:false,
                     allowNegative:false,
                     width: 350,
                     height : 23,
                     listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var snmpServerURL=new Ext.form.TextField(
                  {
                           xtype : "textfield",
                           disabled:true,
                           name : "snmpServerURL",
                           fieldLabel : "SNMP Host",
                           //validator: nameValidator,
                           width: 350,
                           height : 23,
                           listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var snmpAggregatorServerURL=new Ext.form.TextField(
                  {
                           xtype : "textfield",
                           disabled:true,
                           name : "snmpAggregatorServerURL",
                           fieldLabel : "Aggregator URL",
                           //validator: nameValidator,
                           width: 350,
                           height : 23,
                           listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var protocolRadios=new Ext.form.RadioGroup(
                  {
                           columns:1,
                           disabled:true,
                           name: 'defaultFrontendProtocol',
                           vertical: true,
                           id:'protocol',
                           items: radios,
                           listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var protocolName=new Ext.form.TextField(
                  {
                           xtype : "textfield",
                           disabled:false,
                           name : "defaultFrontendProtocolName",
                           fieldLabel : "Protocol handler",
                           //validator: nameValidator,
                           width: 350,
                           height : 23,
                           listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var defaultFrontendUrlPathTemplate=new Ext.form.TextField(
                  {
                           xtype : "textfield",
                           disabled:false,
                           name : "defaultFrontendUrlPathTemplate",
                           fieldLabel : "Path Template",
                           //validator: nameValidator,
                           width: 350,
                           height : 23,
                           listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var deleteOrphanProxies=new Ext.form.Checkbox(
                  {
                           xtype : "checkbox",
                           name : "autoDeleteOrphanProxies",
                           boxLabel : "Destroy orphan proxies",
                           disabled: true,
                           width: 350,
                           height : 23,
                           enableKeyEvents: true,
                           listeners: { change: function() { saveButton.setDisabled(false); } }
                  }
        );

        var IdentityManagementInstance = Ext.data.Record.create([
                  {
                    name: 'uuid',
                    type: 'string'
                  },
                  {
                    name: 'name',
                    type: 'string'
                  },
                  {
                    name: 'description',
                    type: 'string'
                  },
                  {
                    name: 'method',
                    type: 'string'
                  }
        ]);

        var identityManagementStore = new Ext.data.Store({
          reader: new Ext.data.JsonReader({fields: IdentityManagementInstance,  root: 'records'  }),
          url: SERVER_URI+'/../../query',
          baseParams : { dql : '<query>select d._uuid as uuid,d.name as name,d.description as description, d.r_identityRetrievalMethod.val as method from r_identityManagementArtifact d where upper(d.name) like :query</query>' },
          sortInfo: {field: 'name', direction: 'ASC'}
        });

        var identityManagementTpl = new Ext.XTemplate(
          '<tpl for="."><div class="search-item">',
              '<h3><span>{method}</span> {name}</h3>',
              '{description}',
          '</div></tpl>'
        );

        var identityManagementCombo=new Ext.form.ComboBox({
                    name: 'identityManagement',
                    store: identityManagementStore,
                    width:400,
                    fieldLabel: 'Identity Retrieval',
                    displayField:'name',
                    valueField:'uuid',
                    hiddenName:'identityManagementUUID',
                    forceSelection:true,
                    editable:false,
                    triggerAction:'all',
                    listeners: {
                        beforequery: function(qe){ qe.forceAll=true; }
                    },
                    minChars:0,
                    typeAhead: false,
                    loadingText: 'Searching...',
                    pageSize:10,
                    tpl:identityManagementTpl,
                    itemSelector: 'div.search-item',
                    listeners: { select: function(combo,value) {saveButton.setDisabled(false);} }
        });
        identityManagementStore.load({params: { query: ''} });
/*
            var automaticContractPromotion=new Ext.form.Checkbox(
                      {
                               xtype : "checkbox",
                               name : "automaticContractPromotion",
                               boxLabel : "Enable automatic contract promotion between environments",
                               disabled: true,
                               width: 350,
                               height : 23,
                               enableKeyEvents: true,
                               listeners: { change: function() {} }
                      }
            );
*/
        var environments = new Ext.data.JsonStore({
           autoDestroy: true,
           url: SERVER_URI+'/../../taxonomy?taxonomy=uddi:systinet.com:soa:model:taxonomies:environments',
           root: 'records',
           idProperty: 'key',
           fields: ['key', 'value' ]
        });
        environments.load();

        var environmentCombo = new Ext.form.ComboBox({
              disabled:true,
              forceSelection: true,
              mode: 'local',
              store: environments,
              valueField: 'value',
              displayField: 'key',
              name : "c_environmentLabel",
              fieldLabel : "Environment",
              listeners: { change: function(combo,value) {saveButton.setDisabled(false);} }
        });

        var form = new Ext.Panel({
            bodyStyle   : 'padding:0 10px 0;background-color:transparent;border:none',
            //autoScroll: true,
            border: false,
            items :
               [{
                        bodyStyle: 'padding-left:10px;padding-right:10px;',
                        items: [
                             {
                                xtype : "fieldset",
                                id : 'slmConfig',
                                bodyStyle: 'margin-left:20px;',
                                title : "SLM Retrieval Configuration ",
                                items : [
                                           {
                                                  xtype: 'label',
                                                  html: "<div>Service level metrics are downloaded from proxy devices on the background. "+
                                                        "You can customize the interval between individual SLM retrievals (specified in minutes). "+
                                                        "These setting are defined for top level domain only and are inherited by other domains.</div>"
                                           },
                                           {
                                                  xtype : "checkbox",
                                                  id : "slmSampling",
                                                  name : "slmSampling",
                                                  boxLabel : "Enable SLM data retrieval",
                                                  width: 350,
                                                  height : 23,
                                                  enableKeyEvents: true,
                                                  listeners: { check: function(checkbox,value) {
                                                            samplingInterval.setDisabled(!value);
                                                            snmpAggregatorServerURL.setDisabled(!value);
                                                            snmpServerURL.setDisabled(!value);
                                                            snmpServerPort.setDisabled(!value);
                                                            saveButton.setDisabled(false); } }
                                           },
                                           samplingInterval,
                                           snmpServerURL,
                                           snmpServerPort,
                                           snmpAggregatorServerURL
                                         ]
                             },
                             {
                                xtype : "fieldset",
                                bodyStyle: 'margin-left:20px;',
                                title : "Deployment settings",
                                items:  [
                                            {
                                                  style: 'padding-bottom:15px',
                                                  xtype: 'label',
                                                  html: "<div>Automatically reuse proxies during contract deployment if possible (recommended)</div>"
                                            },
                                            {
                                                  xtype : "checkbox",
                                                  id : "autoProxyReuse",
                                                  name : "autoProxyReuse",
                                                  boxLabel : "Reuse proxies",
                                                  width: 350,
                                                  height : 23,
                                                  enableKeyEvents: true,
                                                  listeners: { check: function(checkbox,value) { deleteOrphanProxies.setDisabled(!value); saveButton.setDisabled(false); } }
                                            },
                                            {
                                                  style: 'padding-bottom:15px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>During contract/lifecycle based undeployment a proxy which is no longer bound to a contract can be automatically deleted. (recommended)</div>"
                                            },
                                            deleteOrphanProxies,
/*                                            {
                                                  style: 'padding-bottom:15px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Automatically propagate changes of functional endpoints and WSDLs on their reapproval/republishing to devices:</div>"
                                            },
                                            {
                                                  xtype : "checkbox",
                                                  id : "changePropagation",
                                                  name : "changePropagation",
                                                  disabled: false,
                                                  boxLabel : "Propagate service changes",
                                                  width: 350,
                                                  height : 23,
                                                  enableKeyEvents: true,
                                                  listeners: { check: function(button, value) {
                                                                        saveButton.setDisabled(false);
                                                                      }
                                                              }
                                            },*/
                                            {
                                                  style: 'padding-bottom:15px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Hide functional endpoints in the main service catalog page if corresponding managed (proxy) endpoint exists. Works only for users that do not have write access to the implementation holding the endpoints.</div>"
                                            },
                                            {
                                                  xtype : "checkbox",
                                                  id : "hideFunctionalEndpoints",
                                                  name : "hideFunctionalEndpoints",
                                                  disabled: false,
                                                  boxLabel : "Hide functional endpoints",
                                                  width: 350,
                                                  height : 23,
                                                  enableKeyEvents: true,
                                                  listeners: { check: function(button, value) {
                                                                        saveButton.setDisabled(false);
                                                                      }
                                                              }
                                            },
                                            {
                                                  style: 'padding-top:25px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Allow manual / non-governed deployment actions on contract detail ui pages:</div>"
                                            },
                                            {
                                                  xtype : "checkbox",
                                                  id : "manualDeployment",
                                                  name : "manualDeployment",
                                                  disabled: false,
                                                  boxLabel : "Manual deployment ",
                                                  width: 350,
                                                  height : 23,
                                                  enableKeyEvents: true,
                                                  listeners: { check: function(button, value) {
                                                                        saveButton.setDisabled(false);
                                                                      }
                                                              }
                                            },
											{
                                                  style: 'padding-top:25px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Write WSDL buffer size (minimum 5000):</div>"
                                            },
											wsdlBufferSize
                                      ]
                             },
                             {
                                xtype : "fieldset",
                                bodyStyle: 'margin-left:20px;',
                                title : "New proxy parameters",
                                items : [
                                           {
                                                  style: 'padding-bottom:15px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Define a regexp filter for the device protocol handlers associated with newly created proxies. First matching handler will be used for the new proxy:</div>"
                                           },
                                           protocolName,
                                           {
                                                  style: 'padding-bottom:25px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Define a template for the path part of the url of new proxies, use ${path},${environment},${contractID} parameters:</div>"
                                           },
                                           defaultFrontendUrlPathTemplate,
                                           {
                                                  style: 'padding-top:25px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>When the deployed contract is bound to multiple services you need to choose whether to create a proxy for each service or a common proxy for both services will be created.</div>"
                                           },
                                           proxyLayoutShootOut,
                                           {
                                                  style: 'padding-top:25px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>Select default contract identification method:</div>"
                                           },
                                           identityManagementCombo
                                        ]
                            },
                            {
                                xtype : "fieldset",
                                bodyStyle: 'margin-left:20px;',
                                title : "Adapter specific parameters",
                                items : [
                                           {
                                                  style: 'padding-bottom:15px',
                                                  xtype: 'label',
                                                  html: "<div style='padding-top:15px'>You can customize how proxy objects are created on the L7 device or OSB domain  by altering the default template used to build proxy object configuration</div>"
                                           },
                                           {
                                            	xtype: 'panel',
												layout:'table',
                                            	fieldLabel : 'OSB template',
                                                items:[
                                                	{
                                                		xtype: 'button',
		                                                text: 'Import',
		                                                listeners: { click: function() {
																osbUploadShow();									
                                                        	}
                                                  		}
                                                	},
													{
                                                		xtype: 'button',
		                                                text: 'Export',
														cellCls: 'osb-template',
		                                                listeners: { click: function() {
																window.open (osbTemplatesURL,'_self',false)
                                                        	}
                                                  		}
                                                	}
                                                ]
                                           },
                                           {
                                                  xtype: 'button',
                                                  fieldLabel : "L7 proxy template",
                                                  text: "Change",
                                                  listeners: { click: function() {
                                                         textarea=new Ext.form.TextArea({ value:l7ProxyTemplate});
                                                         win = new Ext.Window({
                                                            title       : 'Change proxy object template',
                                                            layout      : 'fit',
                                                            width       : 860,
                                                            height      : 500,
                                                            modal       : true,
                                                            closeAction : 'destroy',
                                                            plain       : true,
                                                            maximizable : true,
                                                            bodyStyle   : 'padding:0',
                                                            items       : [ textarea ],
                                                            buttons     : [  new Ext.Button({ text: 'OK', listeners: {click:function() { saveButton.setDisabled(false);l7ProxyTemplate=textarea.getValue();win.destroy();} } }),
                                                                             new Ext.Button({ text: 'Cancel', listeners: {click:function() {win.destroy();} } }) ]
                                                         });
                                                         win.show();
                                                        }
                                                  }
                                           }
                                        ]
                            }
                         ]
                }],
               buttons: [saveButton]

        });

        form.render('configurationContent');
		
        var onSave=function() {
            Ext.Msg.show({
              title:'Info..',
              msg: 'Configuration has been saved',
              buttons: Ext.Msg.OK,
              icon: Ext.MessageBox.INFO
            });
        }

        saveButton.on('click',function() {
                        var result={
                            domain: currentDomain,
                            slmSampling: form.findById('slmSampling').getValue(),
                            slmSamplingInterval: form.findById('slmSamplingInterval').getValue(),
                            autoDeleteOrphanProxies: deleteOrphanProxies.getValue(),
                            manualDeployment: form.findById('manualDeployment').getValue(),
//                            changePropagation: form.findById('changePropagation').getValue(),
                            changePropagation: false,
                            hideFunctionalEndpoints: form.findById('hideFunctionalEndpoints').getValue(),
                            autoProxyReuse: form.findById('autoProxyReuse').getValue(),
                            defaultIdentityManagement:identityManagementCombo.getValue(),
                            defaultFrontendProtocolName: protocolName.getValue(),
                            snmpAggregatorServerURL: snmpAggregatorServerURL.getValue(),
                            snmpServerURL: snmpServerURL.getValue(),
                            snmpServerPort: snmpServerPort.getValue(),
                            defaultFrontendUrlPathTemplate : defaultFrontendUrlPathTemplate.getValue(),
                            //defaultFrontendProtocol:protocolRadios.getValue().getRawValue(),
                            defaultProxyLayout:proxyLayoutShootOut.getValue().getRawValue(),
                            l7ProxyTemplate:l7ProxyTemplate,
                            //environment: environmentCombo.getValue()
							wsdlBufferSize: wsdlBufferSize.getValue()
                        };
                        updateConfiguration(Ext.encode(result),onSave);
                        saveButton.setDisabled(true);
        });

        form.setDisabled(true);
        getConfiguration('${domainId}', function(config) {
                             // does not work outside window (inside our framework panel) form.getForm().setValues(config);
                             currentDomain=config.domain,
                             form.findById('slmSamplingInterval').setValue(config.slmSamplingInterval);
                             form.findById('wsdlBufferSize').setValue(config.wsdlBufferSize);
                             form.findById('slmSampling').setValue(config.slmSampling);
                             samplingInterval.setDisabled(!config.slmSampling);
                             protocolName.setValue(config.defaultFrontendProtocolName);
                             defaultFrontendUrlPathTemplate.setValue(config.defaultFrontendUrlPathTemplate);
                             identityManagementCombo.setValue(config.defaultIdentityManagement);
                             proxyLayoutShootOut.setValue(config.defaultProxyLayout);
                             snmpAggregatorServerURL.setValue(config.snmpAggregatorServerURL);
                             snmpServerURL.setValue(config.snmpServerURL);
                             snmpServerPort.setValue(config.snmpServerPort);
                             snmpAggregatorServerURL.setDisabled(!config.slmSampling);
                             snmpServerURL.setDisabled(!config.slmSampling);
                             snmpServerPort.setDisabled(!config.slmSampling);
                             deleteOrphanProxies.setValue(config.autoDeleteOrphanProxies);
                             form.findById('autoProxyReuse').setValue(config.autoProxyReuse);
                             form.findById('manualDeployment').setValue(config.manualDeployment);
  //                           form.findById('changePropagation').setValue(config.changePropagation);
                             form.findById('hideFunctionalEndpoints').setValue(config.hideFunctionalEndpoints);
                             l7ProxyTemplate=config.l7ProxyTemplate;
							 osbTemplatesURL=config.osbTemplatesURL;
                             form.setDisabled(false);
                             Ext.ComponentMgr.get('slmConfig').setDisabled(currentDomain!='topLevelDomain');
                             saveButton.setDisabled(true);
                         });});

