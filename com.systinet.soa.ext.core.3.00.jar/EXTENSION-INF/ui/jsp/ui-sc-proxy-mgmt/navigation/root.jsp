<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<div id="root.container">
</div>

<syswf:control mode="script" id="contractsTask" caption="contractsTask" targetTask="/operations/contracts/browse" targetDepth="1"/>
<syswf:control mode="script" id="monitoringTask" caption="monitoringTask" targetTask="/operations/monitoring/browse" targetDepth="1"/>
<syswf:control mode="script" id="proxiesTask" caption="proxiesTask" targetTask="/operations/proxies/browse" targetDepth="1"/>
<syswf:control mode="script" id="confTask" caption="confTask" targetTask="/operations/configuration/configuration" targetDepth="1"/>
<syswf:control mode="script" id="devicesTask" caption="devicesTask" targetTask="/operations/browseArtifact" targetDepth="1">
  <syswf:param name="artifactType" value="c_deviceArtifact"/>
</syswf:control>

<script>
//<![CDATA[
    systemConfiguration=function()
    {
       confTask();
    };

    contracts=function()
    {
       contractsTask();
    };

    devices=function()
    {
       devicesTask();
    };

    proxies=function()
    {
       proxiesTask();
    };

    monitoring=function()
    {
       monitoringTask();
    };

    documentation=function()
    {
       alert('documentation');
    };

    Ext.onReady(function() {


        var myData = [
                ['1:Contracts','contracts.jpg','contracts'],
                ['2:Devices','devices.jpg','devices'],
                ['3:Proxies','networks.jpg','proxies'],
                ['4:Monitoring','runtime-metrics.jpg','monitoring'],
                ['5:Configuration','wrench.jpg','systemConfiguration'],
                ['6:Documentation','documentation.jpg','documentation']
            ];

        var store = new Ext.data.ArrayStore({
                fields: [
                   'title',
                   'image',
                   'link',
                ]
            });

        // manually load local data
        store.loadData(myData);

        var tpl = new Ext.XTemplate(
            '<tpl for=".">',
                '<div class="thumb-wrap" id="{name}" onclick="{link}();">',
                '<div class="thumb"><img src="${webResourcePath}/skin/operations/root/{image}" title="Browse \'{title}\'"></div>',
                '<span style="margin-left:8px;font-size:15px;text-align:left;text-decoration: underline;">{title}</span></div>',
            '</tpl>',
            '<div class="x-clear"></div>'
        );

        var panel = new Ext.Panel({
            id:'images-view',
            frame:false,
            width:'auto',
            autoHeight:true,
            collapsible:false,
            layout:'fit',

            items: new Ext.DataView({
                store: store,
                tpl: tpl,
                autoHeight:true,
                multiSelect: true,
                overClass:'x-view-over',
                itemSelector:'div.thumb-wrap',
                emptyText: 'Nothing to display',
                listeners: {
                    selectionchange: {
                        fn: function(dv,nodes){
                        }
                    }
                }
            })
        });
        panel.render('root.container');

    });


//]]>
</script>