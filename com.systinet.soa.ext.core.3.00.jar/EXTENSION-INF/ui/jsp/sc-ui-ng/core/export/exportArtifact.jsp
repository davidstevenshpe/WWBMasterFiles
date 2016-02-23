<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages"/>
<fmt:message bundle="${exportmessages}" key="export" var="exportCaption" />

<syswf:control mode="script" caption="exportFn" action="export"/>
<div class="hp-export-dialog">
<syswf:component name="/core/window" prefix="w">
    <syswf:param name="winTitle" value="Export" />
    <syswf:param name="winComponent" value="/core/export/exportArtifactWindow" />
    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
    <syswf:param name="winOkLabel" value="${exportCaption}" />
    <syswf:param name="winOkAction" value="exportFn" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="winRenderContents" value="true" />
    <syswf:param name="winId" value="${prefix}exportWin"/>
    <syswf:param name="type" value="${type}" />
    <syswf:param name="holder" value="${holder}" />
</syswf:component>
</div>

<c:choose>
<c:when test="${ contextMenu == true}">
<div class="EA-left-panel">
	<a id="ExportArtifact" class="UI PageAction Export" title="${exportCaption}" href="javascript:void(0);"><span>${exportCaption}</span></a>
</div>
</c:when>
<c:otherwise>
<c:out value="${buttonCode}" escapeXml="false" default="<a id=\"ExportArtifact\" href=\"javascript:void(0);\" class=\"context-button Export\" title=\"${exportCaption}\"></a>" />
</c:otherwise>
</c:choose>
<script type="text/javascript">
//<![CDATA[
    Ext.onReady(function() {
	attachOn('ExportArtifact','click',${prefix}open);
    moveWindow('${prefix}exportWin','popupWindows');
});
//]]>
</script>