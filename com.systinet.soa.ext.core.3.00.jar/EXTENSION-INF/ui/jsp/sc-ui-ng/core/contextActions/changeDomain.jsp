<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages"/>
<fmt:message bundle="${messages}" key="changeDomain.title" var="lable"/>

<c:set var="comCon">
    <syswf:component name="/core/impl/bulk/edit/domain" prefix="d" wrap="false">
        <syswf:param name="controlName" value="${prefix}d" />
        <syswf:param name="artifact" value="${artifact}" />
    </syswf:component>
</c:set>

<c:if test="${fn:length(fn:trim(comCon)) > 0}">
    <c:out value="${comCon}" escapeXml="false" />
	
		<c:choose>
			<c:when test="${ contextMenu == true}">
				<div class="EA-left-panel">
					<a id="${prefix}h" class="UI PageAction Domain" title="${lable}" href="javascript:void(0)"><span>${lable}</span></a>
				</div>
			</c:when>
			<c:otherwise>
				<a href="javascript:void(0)" id="${prefix}h" class="context-button Domain" title="${lable}"></a>
			</c:otherwise>
		</c:choose>
				
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        attachOn('${prefix}h','click',${prefix}d);
    	moveWindow('${prefix}_d_dw','popupWindows');
    });
    
//]]>
</script>
</c:if>