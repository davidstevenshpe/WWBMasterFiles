<script>
/* Global variables
 * contractStore .. used in checkForExistingProxies.js to reload it after publishing
 *
 */

function afterUndeploy()
{
    contractStore.reload();
}

function afterDeploy()
{
    contractStore.reload();
}

function afterUndeployAndProxyRemoval()
{
    contractStore.reload();
}


function openContractIDChangeWindow(contractUUID,contractID)
{
            var saveButton=new Ext.Button({
                      text     : 'Ok'
                      //disabled : true
            });

            var cancelButton=new Ext.Button({
                      text     : 'Cancel'
            });


            var nullValidator=function(value)
            {
                if (value==null || value.trim()=='') return "&nbsp;&nbsp;This field is required";
                return true;
            }


            var idEditor=new Ext.form.TextField({
                  name : "contractID",
                  id : "contractID",
                  fieldLabel : "Contract ID",
                  validator: nullValidator,
                  value: contractID,
                  width: 330,
                  height : 23
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
                   [
                   {
                     style: 'padding:10px 10px 15px 10px',
                     xtype: 'label',
                     text:  'Contract ID is used for identification of contracts on proxy devices. It is part of managed endpoint url or is sent with each message as HTTP header for instance.'+
                            ' Choose a string that conforms to the rules of the particular identity management you intend to use.'
                   },
                   {
                       items: {
                           xtype : "fieldset",
                           title : "New contract ID",
                           items : [
                                 idEditor ]
                        }
                   }]

            });

            var win = new Ext.Window({
               title       : 'Change contract ID',
               layout      : 'fit',
               y:100,
               width       : 550,
               height      : 'auto',
               modal       : true,
               closeAction : 'hide',
               plain       : true,
               bodyStyle   : 'padding:5px 5px 0',
               items       : form,
               buttons: [saveButton,cancelButton]

            });

            saveButton.on('click',function() {
                         if(form.getForm().isValid())
                         {
                            setContractID(contractUUID,form.getForm().getValues().contractID,function(result) {
                                     if (result.status)
                                     {
                                        win.hide();
                                        window.location.reload();
                                     }
                                     else
                                     {
                                        Ext.Msg.show({
                                            title: 'Problem found',
                                            msg: result.error,
                                            buttons: Ext.MessageBox.OK,
                                            minWidth : 400,
                                            icon: Ext.MessageBox.WARNING,
                                            fn: function() { win.destroy(); }
                                        });
                                     }
                            } );
                            win.disable();
                         }
            });

            cancelButton.on('click',function() {
                            win.destroy();
            });

            win.show();
}



var buildContractView=function(domain) {

    var convertProxiesTemplate=new Ext.XTemplate(
                                  '<tpl for="proxies">',
                                          '<a onclick="showArtifact(\'{uuid}\')">{name}</a><tpl if="xcount!=xindex">, </tpl>',
                                  '</tpl>',
                                 {compiled:true});

    var Contract = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'contract_id',
                  type: 'string'
                },
                {
                  name: 'contractID',
                  convert: function(v,record) {  if (record.contract_id==null || record.contract_id=='') return record.uuid; else return record.contract_id; }
                },
                {
                  name: 'provider_name',
                  type: 'string'
                },
                {
                  name: 'provider_uuid',
                  type: 'string'
                },
                {
                  name: 'consumer_name',
                  type: 'string'
                },
                {
                  name: 'consumer_uuid',
                  type: 'string'
                },
                {
                  name: 'environment',
                  convert: function(v,record) {  if (record.environment==null) return "Undefined"; else return record.environment; },
                  type: 'string'
                },
                {
                  name: 'proxies'
                },
                {
                  name: 'proxiesAsString',
                  convert: function(v,record) { return convertProxiesTemplate.applyTemplate(record); }
                },
                {
                  name: 'status',
                  convert: function(v,record) {  if (record.proxies==null || record.proxies.length==0) return "Not deployed"; else return "Deployed"; }
                },
                {
                  name: 'description',
                  type: 'string'
                }
    ]);

    var expander = new Ext.ux.grid.RowExpander2({

      tpl : new Ext.XTemplate(
                        '<div style="margin-left:4px;">',
                           '{description}',
                        '</div>',
                        '<div style="margin-left:4px;">',
                            '<table style="margin:8px" border="0">',
                                 '<tr><td style="padding:3px">Service:</td><td style="padding:3px">',
                                     '{provider_name}',
                                 '</td></tr>',
                                 '<tr><td style="padding:3px">Consumer:</td><td style="padding:3px">',
                                     '{consumer_name}',
                                 '</td></tr>',
                                 '<tr><td style="padding:3px">Wsdl definitions:</td><td style="padding:3px">',
                                     '<div id="{uuid}Wsdls">Loading...</div>',
                                 '</td></tr>',
                                 '<tr><td style="padding:3px">Used Proxies:</td><td style="padding:3px">',
                                     '<tpl for="proxies">',
                                         '{name}<tpl if="xcount!=xindex">,</tpl>',
                                     '</tpl>',
                                 '</td></tr>',
                            '</table>',
                        '</div>',
                        '<span style="float:right;margin:4px;font-size:14px">',
                           '<tpl if="status==\'Deployed\'">',
                             '<input name="Undeploy" value="Undeploy" type="button" onclick="undeployContract(\'{uuid}\',\'{name}\')"/>',
                           '</tpl>',
                           '<tpl if="status==\'Not deployed\'">',
                             '<input name="Change Contract ID" value="Change Contract ID" type="button" onclick="openContractIDChangeWindow(\'{uuid}\',\'{[escape(values.contractID)]}\')"/>',
                              '<input name="Deploy" value="Deploy" type="button" onclick="deployContract(\'{uuid}\',\'{name}\',\''+domain+'\')"/>',
                           '</tpl>',
                        '</span>'
                    )
    });

    var onWSDLsLoaded=function(data)
    {
        var wsdls=Ext.get(data.contractUUID+'Wsdls');
        var text='';
        for(i=0;i< data.wsdls.length;i++)
        {
           text+='<a target="_blank" href="'+data.wsdls[i]+'">';
           text+=data.wsdls[i];
           text+='</a>';
           text+='<br/>';
        }
        wsdls.dom.innerHTML=text;
    }

    var onExpand=function(expander,record)
    {
         getWSDLsForContract(record.data.uuid,onWSDLsLoaded);
    }
    expander.on('expand',onExpand);

    var contractSelectionModel=new Ext.grid.CheckboxSelectionModel();

    var query="<query>"+
                 "select "+
                      "c1._uuid as uuid, c1.r_contractID as contract_id, c1.name as name, c1.description as description, c1.environment.name as environment ,p.name || ' (' || p._artifactTypeName || ')' as provider_name, p._uuid as provider_uuid, co.name || ' (' || co._artifactTypeName || ')' as consumer_name, co._uuid as consumer_uuid"+
                 " from "+
                      "contractArtifact c1 join artifactBase p using c1.providerContractor, contractArtifact c2 join artifactBase co using c2.consumerContractor "+
                 " where "+
                       "c1.contractState.val='uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:accepted' and c1._uuid=c2._uuid and upper(c1.name) like :query"+
                "<query name='proxies'>"+
                    "select proxy.name as name, proxy._uuid as uuid from contractArtifact c3 join r_proxyArtifact proxy using c3.r_relatedMessagingProxy where c3._uuid=:parent"+
                "</query>"+
              "</query>";



    contractStore = new Ext.data.GroupingStore({
       reader: new Ext.data.JsonReader({fields: Contract,  root: 'records'  }),
       url: SERVER_URI+'/../../query',
       baseParams : { dql : query, query:'' },
       groupField: 'environment',
       remoteSort: true,
       sortInfo: {field: 'c1.name', direction: 'DESC'}
    });

    contractStore.load({params:{start:0, limit:20}});


    var contractIDEditor = new Ext.form.TextField();

    var filters = new Ext.ux.grid.GridFilters({
        encode: true, // json encode the filter query
        local: false,   // defaults to false (remote filtering)
        filters: [
        {
            type: 'string',
            dataIndex: 'name'
        }]
    });

    var contractGrid = new Ext.grid.EditorGridPanel({
        store: contractStore,
        renderTo    : 'reportContainer',
        width: 'auto',
        autoHeight:true,
        height:'auto',
        clicksToEdit: 1,
        region:'center',
        emptyText: 'No results to display',
        disableSelection:true,
        autoExpandColumn: 'name',
//        selModel: contractSelectionModel,
        plugins: [expander,filters],/*
        view: new Ext.grid.GroupingViewWithRowExpander({
            markDirty: true,
            emptyGroupText: 'Undefined'
        }),*/
        columns: [
                expander,
                {
                    id: 'name',
                    header: 'Name',
                    dataIndex: 'name',
                    width: 150,
                    sortable: false,
                    filter: {
                      type: 'string'
                    },
                    renderer: function(v,m,record)
                    {
                       return '<a onclick="showArtifact(\''+record.data.uuid+'\')">'+record.data.name+'</a>';
                    }
                },{
                    header: 'Status',
                    width: 80,
                    dataIndex: 'status',
                    sortable: false,
                    renderer: function(v)
                             {
                                  if (v=='Deployed') return '<span style="color:green">Deployed</span>';
                                      else return '<span style="color:gray">Not deployed</span>';
                             }
                },{
                    header: 'Environment',
                    dataIndex: 'environment',
                    hidden: false,
                    sortable: false
                },{
                    header: 'Contract ID',
                    width: 210,
                    dataIndex: 'contractID',
                    editor:contractIDEditor,
                    sortable: false
                },{
                    header: 'Service',
                    dataIndex: 'provider_name',
                    width: 160,
                    sortable: false,
                    renderer: function(v,m,record)
                    {
                       return '<a onclick="showArtifact(\''+record.data.provider_uuid+'\')">'+record.data.provider_name+'</a>';
                    }
                },{
                    header: 'Consumer',
                    width: 160,
                    dataIndex: 'consumer_name',
                    sortable: false,
                    renderer: function(v,m,record)
                    {
                       return '<a onclick="showArtifact(\''+record.data.consumer_uuid+'\')">'+record.data.consumer_name+'</a>';
                    }
                },{
                    header: 'Environment',
                    dataIndex: 'environment',
                    hidden: false,
                    sortable: false
                },{
                    header: 'Proxies',
                    dataIndex: 'proxiesAsString',
                    hidden: true,
                    width: 150,
                    sortable: false
                }/*,
                contractSelectionModel*/
        ],
        bbar: new Ext.PagingToolbar({
            pageSize: 20,
            store: contractStore,
            displayInfo: true,
            displayMsg: 'Displaying {0} - {1} of {2}',
            emptyMsg: "No contracts to display"
        })

    });

    contractGrid.on('validateedit',function(e) { e.cancel=true; });


    var undeploySelectedContractsButton = new Ext.Button({
            text: 'Undeploy Selected',
            disabled:true
    });


    Datagrid.Utils.KeepSize(contractGrid);

};


</script>