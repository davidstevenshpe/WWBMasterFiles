<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="editMode" type="java.lang.Boolean"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="${emptyColumnKey}" var="emptyColumnKeyMessage" bundle="${messages}"/>
<fmt:message key="principalRenderer.showMore" var="showMore" bundle="${messages}"/>
<fmt:message key="principalRenderer.showLess" var="showLess" bundle="${messages}"/>
<fmt:message key="principalRenderer.clickToEdit" var="clickToEdit" bundle="${messages}"/>
<fmt:message key="principalRenderer.edit" var="edit" bundle="${messages}"/>


<c:set var="editorId" value="inlinedit_${editorIdPrefix}_${recordId}" />

<div id="${editorId}" class="DatagridEditableCell"
    <c:if test="${not empty editMode and editMode}">
         onmouseover="Datagrid.Handler.InlineEditbox('${editorId}');" onmouseout="Datagrid.Handler.InlineEditbox('${editorId}');"
    </c:if>>
<c:if test="${empty principals}">
	${emptyColumnKeyMessage}
</c:if>
<c:if test="${not empty principals}">

	<c:forEach var="principal" varStatus="status" end="${principalsRendererBean.defaultShow-1}" items="${principalsRendererBean.principals}" >	
         <syswf:component prefix="${prefix}${editorId}${status.index}v" name="/core/impl/util/principalLinkRenderer" wrap="false">
             <syswf:param name="principal" value="${principal}"/>
             <syswf:param name="showIcon" value="${showIcon}"/>
         </syswf:component>
		<c:if test="${not status.last}">,</c:if>
	</c:forEach>

	<c:if test="${principalsRendererBean.showMore}">
		<span class="HiddenOptions">
			<c:forEach var="principal" varStatus="status" begin="${principalsRendererBean.defaultShow}" items="${principalsRendererBean.principals}" >
				<c:out value=","/><syswf:component prefix="${prefix}${editorId}${status.index}h" name="/core/impl/util/principalLinkRenderer" wrap="false">
				<syswf:param name="principal" value="${principal}"/>
                <syswf:param name="showIcon" value="${showIcon}"/>
         	</syswf:component>
			</c:forEach>
		</span>
	<span class="ControlShowMore"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${editorId}');">${principalsRendererBean.moreCount} ${showMore}</a>)</span>
	<span class="ControlShowLess"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${editorId}');">${showLess}</a>)</span>
	</c:if>
		
</c:if>
<c:if test="${editFunctionName ne null}">
	<a href="javascript:${editFunctionName}('${recordId}')" class="DatagridEditableLink" title="${clickToEdit}"><span>${edit}</span></a>			
</c:if>
</div>


