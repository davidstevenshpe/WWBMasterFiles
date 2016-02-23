<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="${type}_radar_chart" style="margin-top: 35px">
</div>

<script type="text/javascript">
//<![CDATA[
Ext4.onReady(function() {
    radarChart = Ext4.create("EA.portlets.AppCompRadarChart",{
    	<c:if test="${not empty tabId}">
    	id: '${tabId}RadarChartId',
    	</c:if>
        renderTo: '${type}_radar_chart',
        header: false,
        draggable: false,
        height: 305,
        width: 450,
        border: 0,
        legend: {
        	visible: true,
        	position: 'bottom',
        	boxStrokeWidth: 0
        },
        config: '${config}'
    });
    
    radarChart.buildGraph("${artifactUUID}");
    
    <c:if test="${not empty tabId}">
	    $('#${tabId}').click(function(){
	    	setTimeout(function(){
	    		Ext4.getCmp('${tabId}RadarChartId').redraw();
	    	}, 300);
		});
    </c:if>
});
//]]>
</script>