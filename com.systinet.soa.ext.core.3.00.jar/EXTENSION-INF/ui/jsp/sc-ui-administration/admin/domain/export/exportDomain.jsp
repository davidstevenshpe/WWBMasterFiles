<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${componentVisible}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages"/>
<fmt:message bundle="${exportmessages}" key="export" var="exportCaption" />

<syswf:control mode="script" caption="exportFn" action="export"/>
<div class="hp-export-dialog">
<syswf:component name="/core/window" prefix="w">
    <syswf:param name="winTitle" value="Export" />
    <syswf:param name="winComponent" value="/admin/domain/export/exportDomainWindow" />
    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
    <syswf:param name="winOkLabel" value="${exportCaption}" />
    <syswf:param name="winOkAction" value="exportFn" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="winRenderContents" value="true" />
    
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="domainId" value="${domainId}" />
</syswf:component>
</div>

<c:out value="${buttonCode}" escapeXml="false" default="<a id=\"ExportArtifact\" href=\"javascript:void(0);\" class=\"context-button Export\" title=\"${exportCaption}\"></a>" />

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
		attachOn('ExportArtifact','click',${prefix}open);
	});

//]]>
</script>

</c:if>