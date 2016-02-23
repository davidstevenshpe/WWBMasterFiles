<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
    function maximizeDiagram() {
    	$('.UI.Right').hide();
    	$('#leftcolumn').hide();
    }
    
    function normalizeDiagram() {
    	$('.UI.Right').show();
    	$('#leftcolumn').show();
    }
    
    Ext4.onReady(function() {
    	var diagramContainer = $('#leftcolumn');
    	var height = 600;
    	if(diagramContainer.length > 0) {
    		height = diagramContainer.height() - 50;
    	}
    	var config  = {
    			diagramUuid: '${artifactUuid}',
    			highlightElement: layoutManager.getURLParameter('highlightElement'),
    			keepTrack: false,
    			hideControls: false
    		};
    	Ext4.create("EA.portlets.ArchimateDiagram",{
    		id: '${prefix}-diagram-portlet',
  			renderTo: '${prefix}-diagram',
  			header:false,
  			draggable: false,
  			border:0,
  		  	config: config,
  		  	height: height
  		});
    });
//]]>
</script>
<div id="${prefix}-diagram">
</div>
