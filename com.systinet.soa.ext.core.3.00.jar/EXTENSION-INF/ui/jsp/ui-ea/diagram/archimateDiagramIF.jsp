<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty archimateDiagramBean}">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link href="<c:out value='${webResourcePath}'/>/../../js/diagram/skin/diagram.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/skin/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../components/paper/paper-core.min.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/DiagramHelper.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/Viewport.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/Diagram.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/LayerManager.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/ConnectorFactory.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/ArchimateShapeFactory.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/ArchimateConnectorFactory.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/diagram/DiagramManager.js"></script>
<body>

	<div id="diagram-container">
		<canvas class="digram-canvas" id="diagramCanvas" resize></canvas>
		<div id="diagram-controller">
			<div class="direction-controller">
			    <div>
			    </div>
			    <div class="arrow up">
			    </div>
			    <div>
			    </div>
			    <div  class="arrow left">
			    </div>
			    <div>
			    </div>
			    <div  class="arrow right">
			    </div>
			    <div>
			    </div>
			    <div   class="arrow down">
			    </div>
			    <div class="clear">
			    </div>
			</div>
			<div class="zoom-controller">
				<div class="zoom-in">&nbsp;</div>
				<input id="zoom-bar" type="range" min="-6" max="5" step="1" orient="vertical" class="vertical" value="0"/>
				<div class="zoom-out">&nbsp;<div>
			</div>
		</div>
	</div>
	</div>
		<div id="diagram-viewmode">
			<a class="view-full" href="javascript:void(0)">&nbsp;</a>
		</div>
	</div>
	<div id="diagram-menu">
		<ul>
			<li id="artifact-open-catalog" name="aritfact-menu-item">Open in Catalog</li>
			<li id="artifact-open-diagram"  name="aritfact-menu-item">Open in other diagrams</li>
			<li id="artifact-highlight"  name="aritfact-menu-item" class="uncheck">Highlight</li>
			<li id="diagram-show-relationName"  name="diagram-menu-item" class="uncheck">Show relationship name</li>
			<li id="diagram-show-artifactType"  name="diagram-menu-item" class="uncheck">Show artifact type</li>
		</ul>
	</div>
	<div style="display:none" id="svg-container"></div>
	<div  style="visibility:hidden;position:absolute;left:0;top:0" id="text-container"></div>
	<script type="text/javascript">
//<![CDATA[

           
var logInfo;
$(document).ready(function(){
	var frameId = window.frameElement.id;
	var diagramExtId = frameId.substring(0,frameId.length-6); //remove subfix -frame
	
	if($.browser.msie) {
		$('body').addClass('msie');
	} else if($.browser.firefox) {
		$('body').addClass('firefox');
	}
	
	if(self == top) {
		$('#diagram-container').append('<div id="diagram-viewmode"><a class="view-original" href="javascript:void(0)" onclick="">&nbsp;</a></div>');
	} else if(parent == top){
		
	}
	var diagramContent = eval('(${archimateDiagramBean.content})');

	$('body').on('contextmenu', function(e){
		e.preventDefault();
	});

	var canvas = document.getElementById('diagramCanvas');
	paper.setup(canvas);
	
	var diagram = new DiagramManager({
		context: paper,
		content: diagramContent,
		diagramExtId: diagramExtId,
		controller: {
			id:	'diagram-controller'
		},
		viewport: {
			id: 'diagram-container',
			setting: getURLParameter('viewport')
		}
	});
	paper.view.draw();
	paper.view.onFrame = function() {
		diagram.onFrame();
	}
	paper.view.onResize = function(event) {
		if(diagram.diagram != null) {
			diagram.diagram.centralPoint = diagram.diagram.centralPoint.add(event.delta.width/2,event.delta.height/2);
		}
	}
	
	$('#diagram-viewmode a').click(function(){
		if($(this).attr('class') == 'view-full') {
			window.top.maximizeDiagram();
			$(this).attr('class', 'view-original');
		} else {
			window.top.normalizeDiagram();
			$(this).attr('class', 'view-full');
		}
	});

	
	$('#artifact-open-catalog').click(function(){
		window.top.open("${webContext}/service-catalog/artifact/" + ViewportMenu.artifact.uuid, "_blank");
		ViewportMenu.hide();
	});
	
	$('#artifact-open-diagram').click(function(){
		window.top.Ext4.getCmp(diagramExtId).showArtifactLinkedDiagrams({
			artifactUuid: ViewportMenu.artifact.uuid,
			artifactType: ViewportMenu.artifact.localName,
			width:600
		});
		ViewportMenu.hide();
	});
	
	var showRelationName = false;
	
	$('#diagram-show-relationName').click(function(){
		showRelationName = !showRelationName;
		if(showRelationName) {
			$(this).addClass('checked');
			$(this).removeClass('uncheck');
		} else {
			$(this).removeClass('checked');
			$(this).addClass('uncheck');
		}
		diagram.toggleRelationLabel(showRelationName);
		ViewportMenu.hide();
	});
	
	var showArtifactType = false;
	
	$('#diagram-show-artifactType').click(function(){
		showArtifactType = !showArtifactType;
		if(showArtifactType) {
			$(this).addClass('checked');
			$(this).removeClass('uncheck');
		} else {
			$(this).removeClass('checked');
			$(this).addClass('uncheck');
		}
		diagram.toggleArtifactTypeLabel(showArtifactType);
		ViewportMenu.hide();
	});
	
	$('#artifact-highlight').click(function(){
		diagram.toggleArtifactHighlight(ViewportMenu.artifact.uuid);
		ViewportMenu.hide();
	});
	
	if('${archimateDiagramBean.highlightElement}' != null && '${archimateDiagramBean.highlightElement}'.length > 0) {
		ViewportMenu.artifact = {
				uuid: '${archimateDiagramBean.highlightElement}'
		}
		diagram.focusArtifact(ViewportMenu.artifact.uuid);
	}
	if(getURLParameter('hideControls') == 'true') {
		$('#diagram-controller').hide();
		$('#diagram-viewmode').hide();
	}
	
});

//]]>
</script>
</body>
</html>
</c:if>

