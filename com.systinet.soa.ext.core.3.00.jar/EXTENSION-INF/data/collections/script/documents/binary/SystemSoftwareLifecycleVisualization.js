/**
 * @class EA.scripts.SystemSoftwareLifecycleVisualization
 * @extends EA.portlets.visualization.Visualization
 *
 * Visualizes system software field of a leaf node to carry lifecycle stage.
 * 
 * Example configuration:
 * <pre>
 * {
 *      type: 'EA.portlets.visualization.LeafNodeVisualization',
 *      field: 'sdmName', // optional
 *      leafValue: 'Application Component',
 *      name: 'Type'
 * }
 * </pre>
 */
Ext4.define('EA.scripts.SystemSoftwareLifecycleVisualization', {
    extend: 'EA.portlets.visualization.Visualization',

    // @Override
    getNodeStyle: function(container, node){
        var value = node.data[this.field];
        if (value){
            if (node.data.boxCount == 1){
                // visualize software lifecycle
                var count = value.length;
                var itemNames = ["N/A","Candidate","Production","Deprecated","Unsupported","Denied"];
                var colors = ["white","blue","green","yellow","#bb0000","red"];
                var items = {};
                for(var i=0; i<itemNames.length; i++){
                   items[itemNames[i]] = {count: 0, color: colors[i]};
                }
                for(var i=0; i<value.length; i++){
                   var val = value[i];
                   if (val.lastApprovedStage){
                      var item = items[val.lastApprovedStage];
                      if (item){
                        item.count++;
                      } else{
                        items["N/A"].count++;
                      }
                   } else{
                      items["N/A"].count++;
                   }
                }
                var content = '<div style="border:1px solid black; width:100%; height:16px">';
                var width = 0;
                for(var i=0; i<itemNames.length; i++){
                   var item = items[itemNames[i]];
                   if (item.count>0){
                      item.width = Math.floor(100*item.count/count);
                      width = width + item.width;
                   }
                }
                if (width === 0){
                      content+='<div style="height:14px; width:100%; background-color: '+items["N/A"].color+';" title="System software is not modeled">N/A</div>';
                } else{
                    width = 100-width;
                    for(var i=0; i<itemNames.length; i++){
                       var item = items[itemNames[i]];
                       if (item.width){
                          if (width>0){item.width+=width; width=0;}
                          content+='<div style="display:inline-block; height:100%; width:' + item.width +'%; background-color: '+item.color+';" title="'+itemNames[i]+': '+item.count+'/'+count+'"> </div>';
                       }
                    }
                }
                
                content+= '</div>';
                node.data.headerContent = '<div style="height: 37px;">'+node.data.headerContent+'</div>'
                node.data.nodeContent = content+node.data.nodeContent;
            } else{ // not a leaf 
            } 
        }
        return { style: ''};
    },
    
    // @Override
    renderLegend : function(container) {
        var itemNames = ["N/A","Candidate","Production","Deprecated","Unsupported","Denied"];
        var colors = ["white","blue","green","yellow","#bb0000","red"];
        // no legend intentionally
        var retVal = '<div class="clear">';
        retVal+='<div style="width:auto; height: auto;margin-bottom: 11px;" class="capa-legend-tile" title="Software Lifecycle">';
        retVal+='<div style="display:inline-block; border:1px solid #bbb; width:auto; height:auto;">';
        for (var i = 0; i < itemNames.length; i++) {
            if (colors[i] == "blue" || colors[i] == "#0000ff") {
                retVal+='<div class="cap-portlet-legend-desc" style="width:60px; color: white; background-color: ' + colors[i] + ';" title="' + itemNames[i] + '">' + itemNames[i] + '</div>';
            } else {
                retVal+='<div class="cap-portlet-legend-desc" style="width:60px; background-color: ' + colors[i] + ';" title="' + itemNames[i] + '">' + itemNames[i] + '</div>';
            }
        }
        retVal+='</div>';
        retVal+='<div style="width: auto;" class="desc">Shows the usage of lifecycle status of system software that the application component depends on. Area of each color/status is proportional to the relative frequency of usage of the given status.<br /></div>';
        retVal+='</div>';
        retVal+='</div>';
        container.legendContainer.append(retVal);
    },

    constructor: function(config) {
        this.callParent(arguments);
        if (!this.field){
            this.field = "systemSoftware";
        }
        this.showOnTooltip = false; // do not render the value in a header tooltip
        /*
        this.styleSchema = {
           "N/A": {style: "border:1px solid black; height:16px;background-color: white;", description:"N/A"},
           "Active": {style: "border:1px solid black; height:16px;background-color: green;", description:"Active"},
           "Deprecated": {style: "border:1px solid black; height:16px;background-color: yellow;", description:"Deprecated"},
           "Retired": {style: "border:1px solid black; height:16px;background-color: red;", description:"Retired"},
        }
        */
    }
})