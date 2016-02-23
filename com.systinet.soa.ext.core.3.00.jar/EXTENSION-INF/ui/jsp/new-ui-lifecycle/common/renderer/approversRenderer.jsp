<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="${emptyColumnKey}" var="emptyColumnKeyMessage" bundle="${messages}"/>
<fmt:message key="principalRenderer.showMore" var="showMore" bundle="${messages}"/>
<fmt:message key="principalRenderer.showLess" var="showLess" bundle="${messages}"/>
<fmt:message key="principalRenderer.clickToEdit" var="clickToEdit" bundle="${messages}"/>
<fmt:message key="principalRenderer.edit" var="edit" bundle="${messages}"/>
<fmt:message key="approverRenderer.automaticApprove1" var="automaticApprove1" bundle="${messages}" />
<fmt:message key="approverRenderer.automaticApprove2" var="automaticApprove2" bundle="${messages}"/>


<c:set var="editorId" value="inlinedit_${editorIdPrefix}_${recordId}" />

<div class="DatagridEditableCell" id="${editorId}" onmouseover="Datagrid.Handler.InlineEditbox('${editorId}');" onmouseout="Datagrid.Handler.InlineEditbox('${editorId}');">
<c:if test="${empty approversRendererBean.approvers}">
	${emptyColumnKeyMessage}
</c:if>

<c:if test="${not empty approversRendererBean.approvers}">
	<c:forEach var="approver" varStatus="status" end="${approversRendererBean.defaultShow-1}" items="${approversRendererBean.approvers}" >	
		<c:choose>
			<c:when test="${approver.passive}">
				<c:set var="spanAttribs" value="class=\"UI Icon AutoApprove\" title=\"${automaticApprove1} ${approver.passiveTimeout} ${automaticApprove2}\"" />
			</c:when>
			<c:otherwise>
				<c:set var="spanAttribs" value="" />
			</c:otherwise>
		</c:choose>
		<span ${spanAttribs}>	
            <syswf:component prefix="${prefix}${editorId}${status.index}v" name="/core/impl/util/principalLinkRenderer" wrap="false">
                <syswf:param name="principal" value="${approver.principal}"/>
                <syswf:param name="showIcon" value="${false}"/>
            </syswf:component>
        </span><c:if test="${not status.last}">,</c:if>
	</c:forEach>
	<c:if test="${approversRendererBean.showMore}">
		<span class="HiddenOptions">,
			<c:forEach var="approver" varStatus="status" begin="${approversRendererBean.defaultShow}" items="${approversRendererBean.approvers}" >
				<c:choose>
					<c:when test="${approver.passive}">
        				<c:set var="spanAttribs" value="class=\"UI Icon AutoApprove\" title=\"${automaticApprove1} ${approver.passiveTimeout} ${automaticApprove2}\"" />
					</c:when>
					<c:otherwise>
						<c:set var="spanAttribs" value="" />
					</c:otherwise>
				</c:choose>
				<span ${spanAttribs}>	
		            <syswf:component prefix="${prefix}${editorId}${status.index}h" name="/core/impl/util/principalLinkRenderer" wrap="false">
		                <syswf:param name="principal" value="${approver.principal}"/>
		                <syswf:param name="showIcon" value="${false}"/>
		            </syswf:component>
	            </span><c:if test="${not status.last}">,</c:if>
			</c:forEach>
		</span>
    	<span class="ControlShowMore"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${editorId}');">${approversRendererBean.moreCount} ${showMore}</a>)</span>
    	<span class="ControlShowLess"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${editorId}');">${showLess}</a>)</span>
	</c:if>	
	

</c:if>
<c:if test="${editFunctionName ne null}">
	<a href="javascript:${editFunctionName}('${recordId}')" class="DatagridEditableLink" title="${clickToEdit}"><span>${edit}</span></a>		
</c:if>
</div>

