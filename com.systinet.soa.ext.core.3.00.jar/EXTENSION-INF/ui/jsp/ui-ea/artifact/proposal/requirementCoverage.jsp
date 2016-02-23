<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="${prefix}-scriptComponent">
</div>
<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
	var datasourceScriptLocation = '${scriptLocation}';
	datasource=Ext4.create('EA.model.tools.DataSourceTreeStore', {
		dataSource: datasourceScriptLocation,
		extraParams: {
			seed: '${artifact._uuid}'
		}
	});

	var artifactTreeTable = Ext4.create('EA.model.table.ArtifactTreeListingTable', {
		header:false,
		layout:'fit',
		bodyCls: 'stripe-row-table',
        renderTo: '${prefix}-scriptComponent',
        useArrows: true,
        store: datasource,
        rootVisible: false,
        columns: [{
            text: 'Requires Coverage',
            width: 150,
            align: 'center',
            dataIndex: 'coverageNotRequired',
            sortable: false,
            renderer: function(coverageNotRequired, node) {
            	return coverageNotRequired != 'true'? 'Yes' : 'No';
            }
        }, {
        	 text: 'Covered by',
             flex: 1,
        	 tdCls: 'multiline-cell',
        	 dataIndex: 'coverageNotRequired',
             sortable: false,
        	 renderer: function(functional, node) {
        		 var content = '';
        		 if(node.record.raw.coveredByElement != null && node.record.raw.coveredByElement.length > 0) {
        			 var components = node.record.raw.coveredByElement;
        			 for(var i = 0; i < components.length; i++) {
        				 if(i > 0) {
        					 content += '<br/>';
        				 }
        				 content += artifactTreeTable.renderArtifactLink(components[i]._uuid, components[i].name, components[i]._artifactTypeName, components[i]._sdmName);
        			 }
        		 }
        		 return content;
        	 }
        }, {
        	text: 'Description',
            flex: 1,
       	 	dataIndex: 'description',
            sortable: false,
       	 	renderer: function(description, node) {
       	 		node.tdAttr = 'title="' + description + '"';
       	 		return description;
       	 	}
        }, {
            text: 'Status',
            width: 120,
            tdCls: 'mid-cell',
            dataIndex: 'coverageNotRequired',
            sortable: false,
            renderer: function(coverageNotRequired, node) {
            	var styleClass = 'EA-icon status ';
            	var caption = '';
            	if(node.record.raw.coveredByElement != null && node.record.raw.coveredByElement.length > 0) {
            		styleClass += 'green';
            		caption = 'Covered';
            	} else if(coverageNotRequired == 'true') {
            		styleClass += 'yellow';
            		caption = 'Not Required';
            	} else {
            		styleClass += 'red';
            		caption = 'Not Covered';
            	}
            	return '<span class="' + styleClass + '" style="display:inline-block;margin-right:6px">&nbsp;</span>' + caption;
            }
        }]
    });	
});

//]]>
</script>