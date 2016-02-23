<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[

<c:if test="${not empty lifecycleColors}">
function getLifecycleColor() {
	return ${lifecycleColors};
}
</c:if>
<c:if test="${not empty recalculeDelayTime}">
var recalculeDelayTime = ${recalculeDelayTime};
</c:if>

$(document).on('uiReady', function() {
	var config = {};
<c:choose>
	<c:when test="${not empty configuration}">
	config = ${configuration};
	</c:when>
	<c:otherwise>
	<c:if test="${not empty scriptLocation}">
	$.ajax({
		url:SERVER_URI + '/../../../platform/rest/location${scriptLocation}',
		dataType:'text',
		success: function(data) {
		config = eval('(' + data + ')');
	<c:choose>
		<c:when test="${not empty height}">
			config.defaultHeight = ${height};
		</c:when>
		<c:otherwise>
			config.defaultHeight = Math.max(layoutManager.getContentHeight() - 50, 300);
		</c:otherwise>
	</c:choose>
	if (!config.dataSourceExtraParams) config.dataSourceExtraParams = {};
		<c:if test="${not empty toBeArtifactUuid}">
		config.dataSourceExtraParams.plateauArtifactUuid = '${toBeArtifactUuid}';
		</c:if>
		<c:if test="${not empty artifactUuid}">
		config.dataSourceExtraParams.seed = '${artifactUuid}';
		</c:if>
	</c:if>
	</c:otherwise>
</c:choose>
<c:if test="${not empty showHeader and showHeader}">
	$('#pagetitle .EA-top-header').html('${taskLabel}');
</c:if>
  		var visualizedPortlet = Ext4.create("${portletClass}",{
  			renderTo: '${prefix}-visualized-map',
  			<c:choose>
	  			<c:when test="${empty showPortletHeader or showPortletHeader eq 'false'}">
					header:false,
				</c:when>
				<c:when test="${not empty taskLabel}">
				title:'${taskLabel}',
				</c:when>
			</c:choose>
  			draggable: false,
  			border:0,
  		  	<c:if test="${not empty config}">
  		  	${config},
  		  	</c:if>
  		  	<c:if test="${not empty callback}">
  		  	listeners: {
  		  		afterContentRender: function() {
  		  			<c:if test="${not empty linkTabId}">
  		  			visualizedPortlet.doLayout();
  		  			</c:if>
			  		var callback = ${callback};
			  		callback(visualizedPortlet);
  		  		}
  		  	},
  		  	</c:if>
			config: config
  		});

		if($('#${prefix}-visualized-map').is(':visible')) {
			visualizedPortlet.loadDataSource();
		} else {
			<c:if test="${not empty linkTabId}">
			$('#${linkTabId}').one('click', function(){
				function load() {
					visualizedPortlet.doLayout();
					visualizedPortlet.loadDataSource();
				}
				setTimeout(load,500);
			});
			</c:if>
		}
  		<c:if test="${empty configuration && not empty scriptLocation}">
		}});
		</c:if>
});

//]]>
</script>
<c:if test="${not empty showHeader && showHeader}">
<div id="pagetitle" class="UI Block Common EA-Blue-Bar">
	<div class="EA-Block">
		<h3 class="EA-top-header"></h3>
	</div>
</div>
</c:if>
<div class="eam-capa-container" id="${prefix}-visualized-map">
</div>
