<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<fmt:message var="completionTitle" bundle="${relationshipmessages}" key="completion.status.title"/>
<fmt:message var="status_completed" bundle="${relationshipmessages}" key="completion.status.completed"/>
<fmt:message var="status_notCompleted" bundle="${relationshipmessages}" key="completion.status.notCompleted"/>
<fmt:message var="status_invalid" bundle="${relationshipmessages}" key="completion.status.invalid"/>
<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="DeliverableCompletionStatus"/>
  <syswf:param name="code">
  
	function getPieInfo( uuid,  relationName) {
       return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().getPieInfo( uuid,  relationName);
    }
	
  </syswf:param>
</syswf:component>
<div id="${prefix}_completionStatus" style="display:none;">
    <div class="EA-right-panel" style="padding: 0">
    	<div style="padding-top:10px;padding-right:10px;font-size: 16px;line-height: 20px;"><c:out value="${completionTitle}"/></div>
		<div id="${prefix}completionStatusCont" style="width: 247px;margin-left: -12px;"></div>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
	var colorSetting = ${colorSetting};
	var completed =  colorSetting.completed != null ? colorSetting.completed :'#00882B';
	var notCompleted =  colorSetting.notCompleted != null ? colorSetting.notCompleted :'#E7C300';
	var invalid =  colorSetting.invalid != null ? colorSetting.invalid :'#FF0000';
	
	getPieInfo('${artifact._uuid}', '${relationshipName}', function(result){
		var countLegend = 3;
		if (result!= null && (result[0] > 0 || result[1] > 0 || result[2] > 0)){
			$('#${prefix}_completionStatus').show();
			if (result[0] > 0) countLegend--;
			if (result[1] > 0) countLegend--;
			if (result[2] > 0) countLegend--;
			$('#${prefix}completionStatusCont').height(175 - countLegend*16);
		}else{
			return;
		}
		setPieChart('${prefix}completionStatusCont', 
		   { 
			 data: result,
			 legend: ['<syswf:out value="${status_completed}" context="HtmlJSText"/> (%%)', '<syswf:out value="${status_notCompleted}" context="HtmlJSText"/> (%%)', '<syswf:out value="${status_invalid}" context="HtmlJSText"/> (%%)'],
			 colors: [completed, notCompleted, invalid ],
			 href: [completed, notCompleted, invalid ],
			 legendpos: 'south',
			 posx: 123,
			 posy: 55,
			 r: 45,			 
		   }
		);
	})	
});

//]]>
</script>
