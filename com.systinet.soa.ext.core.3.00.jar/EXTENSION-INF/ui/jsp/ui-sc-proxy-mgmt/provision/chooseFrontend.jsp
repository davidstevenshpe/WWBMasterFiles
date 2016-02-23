/** Global variables
 **
 ** confirmationForm
 ** frontendsForm
 **/
CHOOSE_FRONTEND_HEIGHT=555;

chooseFrontendProtocol=function(protocols)
{

     var closeButton = new Ext.Button({
            text: 'Cancel'
     });

     var nextButton = new Ext.Button({
            text: 'Next',
            disabled:true
     });

     var backButton = new Ext.Button({
            text: 'Back'
     });

     backButton.on('click',function() {
          win.getLayout().setActiveItem(endpointsForm);
          win.setHeight(calculateWindowHeight(CHOOSE_ENDPOINT_STEPS_HEIGHT));
          win.doLayout();
     });

     var protocolShootOutLabel={
            style: 'padding:10px 10px 15px 10px',
            xtype: 'label',
            text: 'Now the access point to the proxy will be configured. Choose the front side protocol handler (it must be already created on the device) for the newly created proxy:'
     };


     var frontendStore = new Ext.data.JsonStore({
         autoDestroy: true,
         root: 'rows',
         idProperty: 'id',
         fields: ['frontendName','hostname','port','ip','id']
     });


      var frontendTpl = new Ext.XTemplate(
        '<tpl for="."><div class="search-item">',
            '<h3><span>{ip}</span> {hostname}:{port}</h3>',
            '{frontendName}',
        '</div></tpl>'
      );


     var frontendCombo=new Ext.form.ComboBox({
                  name: 'frontend',
                  store: frontendStore,
                  width:400,
                  lazyRender:true,
                  mode: 'local',
                  triggerAction:'all',
                  fieldLabel: 'Front Side Handler',
                  displayField:'frontendName',
                  valueField:'id',
                  hiddenName:'frontendID',
                  forceSelection:true,
                  minChars:0,
                  typeAhead: false,
                  pageSize:10,
                  tpl:frontendTpl,
                  disabled:true,
                  itemSelector: 'div.search-item'
     });

     var frontendProgressWindow;

     var frontendNamesLoaded=function(frontends)
     {
         frontendProgressWindow.hide();
         frontendCombo.setDisabled(false);
         frontendStore.loadData({ rows: frontends.handlers });
         currentFrontendList=frontends.handlers;
     };


     var protocolChosen=function(protocol) {

         frontendCombo.reset();
         enableNextButton();
         frontendProgressWindow=Ext.MessageBox.progress('Please wait..','Loading frontend configuration from the device..','');
         getFrontsideHandlers(endpointsFormValues.deviceUUID,protocol,frontendNamesLoaded);
     };

     var radios=new Array();
     var i=0;
     for(p in protocols)
     {
        radios[i++]= {
          id:p,
          boxLabel: protocols[p],
          name: 'protocol',
          inputValue: p,
          listeners: { check : function(radio,checked) { if (checked) protocolChosen(radio.getId()); } }
        };
     }

     var protocolShootOut={
        bodyStyle: 'padding-left:20px;',
        items: [{
            xtype: 'fieldset',
            collapsible:true,
            title: 'Frontend Protocol',
            fieldLabel: 'Front Side Handler',
            autoHeight: true,
            width: 'auto',
            defaultType: 'radio',
            items: [ new Ext.form.RadioGroup({
                        columns:1,
                        name: 'protocol',
                        vertical: true,
                        id:'protocol',
                        items: radios })
                   ,frontendCombo]
        }]
      };

      var layoutText='Enter the name for the proxy created in the proxy device:'
      if (endpointSelectionModel.getCount()!=1) layoutText='A single web service proxy may be able to accept multiple web services. '+
                                                          'This way multiple web services may share proxy (processing) configuration. Now choose whether '+
                                                           'to create a separate web service proxy for each service endpoint chosen in the previous step'+
                                                          ' or to create a single proxy object for all the endpoints. '+layoutText;
      var proxyLayoutShootOutLabel={
            style: 'padding:10px 10px 15px 10px',
            xtype: 'label',
            text: layoutText
      };


      var nameValidator=function(value)
      {
         if (value==null || value.trim()=='') return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This field is required";
         if (value.search(/^\w+$/i)<0) return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Must contain letters, numbers and '_' only";
         return true;
      }

      var proxyBaseName=new Ext.form.TextField({
                  xtype : "textfield",
                  name : "proxyBaseName",
                  fieldLabel : "Proxy name",
                  validator: nameValidator,
                  width: 350,
                  height : 23
      });

      var proxyLayoutShootOut={
        bodyStyle: 'padding-left:20px;',
        items: [ {
            xtype: 'fieldset',
            collapsible:true,
            title: 'Device Proxy Layout',
            autoHeight: true,
            width: 'auto',
            items: [
               new Ext.form.RadioGroup({
                      columns:1,
                      name: 'layout',
                      hidden: endpointSelectionModel.getCount()==1,
                      fieldLabel: 'Device Proxy Layout',
                      vertical: true,
                      id:"layout",
                      items: [
                        {boxLabel: 'Shared proxy layout (recommended)', name: 'layout-id-1', id: 'shared', checked:true},
                        {boxLabel: 'Per endpoint proxy layout', name: 'layout-id-1', id: 'per_service'}
                      ]
               }),
               proxyBaseName
               ]
        } ]
      };


      var identityManagementShootOutLabel={
            style: 'padding:10px 10px 15px 10px',
            xtype: 'label',
            text: 'Various message processing policies depend on the proxy caller contract idenity. Now choose the way the device will identify the contract of the caller of the service:'
      };

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
        url: SERVER_URI+'/../../query'
,
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
				  disabled: true,
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
                  itemSelector: 'div.search-item'
      });

      var identityManagementShootOut={
        bodyStyle: 'padding-left:20px;',
        items: [ {
            xtype: 'fieldset',
            collapsible:true,
            title: 'Contract Identity Retrieval',
            autoHeight: true,
            width: 'auto',
            items: [
               identityManagementCombo
            ]
        }]
      };

      if (typeof frontendsForm!='undefined') win.remove(frontendsForm);

      frontendsForm = new Ext.FormPanel({
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
                items: [protocolShootOutLabel, protocolShootOut, proxyLayoutShootOutLabel, proxyLayoutShootOut, identityManagementShootOutLabel,identityManagementShootOut ]
            }
        ],
        buttons: [backButton,nextButton,closeButton ]
      });

	  var deployContract = Ext.getCmp('radContract').getValue();
	  
      var enableNextButton=function()
      {
          var values=frontendsForm.getForm().getFieldValues();
          nextButton.setDisabled((values.identityManagementUUID=='' && deployContract) || values.layout=='' || (typeof (values.frontendID)=='undefined')|| values.frontendID==''|| !frontendsForm.getForm().isValid());
      };

      identityManagementCombo.on('select',enableNextButton);
      frontendCombo.on('select',enableNextButton);
      proxyBaseName.on('change',enableNextButton);
	  if (deployContract){
		identityManagementCombo.disabled = false;
	  }

      var afterProxyNameValidated=function(result)
      {
             if (result)
             {
                var values=frontendsForm.getForm().getFieldValues();
                var frontendID=values.frontendID;

                // global variable frontendData is built here
                for(i=0;i<currentFrontendList.length;i++)
                {
                    if (currentFrontendList[i].id==frontendID) { frontendData=Ext.encode(currentFrontendList[i]); break;}
                }

                getProxyLayout(values.proxyBaseName,endpointsFormValues.deviceUUID,values.protocol.getId(),frontendData,values.identityManagementUUID,values.layout.getId(),
                  endpointsFormValues.rootUUID,endpointsFormValues.endpointUUIDs, confirmLayout);
             }
             else
             {
                Ext.Msg.show({
                  title: 'Problem found',
                  msg: 'Proxy name is already taken by an existing proxy on the device. Choose a different proxy name to proceed',
                  buttons: Ext.MessageBox.CANCEL,
                  minWidth : 400,
                  icon: Ext.MessageBox.WARNING
                });
             }
      }

      nextButton.on('click',function() {
             var values=frontendsForm.getForm().getFieldValues();
             isValidNewProxyName(endpointsFormValues.deviceUUID,values.proxyBaseName, afterProxyNameValidated);
      });

      closeButton.on('click',function() {win.destroy();});

      endpointsFormValues=endpointsForm.getForm().getFieldValues();
      // Since ext 3.4 disabled field are not returned through getFieldValues()
      endpointsFormValues.rootUUID=endpointsForm.getForm().findField('rootUUID').getValue();

      // calculate proxy name default
      suggestProxyName(endpointsFormValues.rootUUID, function (result) {proxyBaseName.setValue(result); } );
      win.add(frontendsForm);
      win.getLayout().setActiveItem(frontendsForm);
      win.setHeight(calculateWindowHeight(CHOOSE_FRONTEND_HEIGHT));
      win.doLayout();
}