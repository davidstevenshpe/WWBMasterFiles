<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:if test="${not empty showIcon}">
    <c:set var="class" value="UI Icon ${class}"/>
</c:if>
<c:if test="${not empty menuItem}">
    <li class>
</c:if>
<c:choose>
	<c:when test="${not accessRead}">
		<span>${caption}</span>
	</c:when>
	<c:otherwise>	
		<c:choose>
			<c:when test="${not empty artifactTaskUri && not empty caption}">
				<syswf:control mode="anchor" caption="${caption}" targetTask="${artifactTaskUri}" targetDepth="${depth}" id="artifact">
					<syswf:param name="view" value="${view}"/>
					<c:if test="${not empty targetArtifactTabId}">
						<syswf:param name="artifactTabId" value="${targetArtifactTabId}"/>
					</c:if>
					<c:if test="${not empty revision}">
						<syswf:param name="revision" value="${revision}"/>
					</c:if>
					<c:if test="${mode == 'data'}">
						<syswf:attribute name="target" value="dataContent"/>
					</c:if>
					<c:if test="${not empty timeSlice}">
						<syswf:param name="timeSlice" value="${timeSlice}"/>
					</c:if>
					<c:if test="${not empty class}">
						<syswf:attribute name="class" value="${class}"/>
					</c:if>
					<c:if test="${not empty target}">
						<syswf:attribute name="target" value="${target}"/>
					</c:if>
					<c:if test="${not empty showIcon && not empty sdmName}">
						<syswf:attribute name="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${sdmName}&format=small);"/>
					</c:if>
					<c:if test="${empty showIcon && not empty style}">
						<syswf:attribute name="style" value="${style}"/>
					</c:if>
					<%-- Shown when mouse cursor hovers over caption --%>
					<c:if test="${not empty title}">
						<syswf:attribute name="title">${title}</syswf:attribute>
					</c:if>
				</syswf:control>${suffix}
				<c:if test="${mode == 'both'}">
					<fmt:message key="artifactLinkWidget.downloadHint" var="downloadHint" bundle="${widgetMessages}"/>
					<syswf:control mode="anchor" targetTask="${artifactTaskUri}" targetDepth="${depth}" caption=" " hint="${downloadHint}" id="data">
						<syswf:param name="view" value="${view}"/>
						<c:if test="${not empty targetArtifactTabId}">
							<syswf:param name="artifactTabId" value="${targetArtifactTabId}"/>
						</c:if>
						<c:if test="${not empty revision}">
							<syswf:param name="revision" value="${revision}"/>
						</c:if>
						<c:choose>
							<c:when test="${not empty target}">
								<syswf:attribute name="target" value="${target}"/>
							</c:when>
							<c:otherwise>
								<syswf:attribute name="target" value="dataContent"/>
							</c:otherwise>
						</c:choose>
						<syswf:attribute name="class" value="UI Icon DownloadDocument"/>
					</syswf:control>${suffix}
				</c:if>
			</c:when>
			<c:when test="${not empty caption}">
				<syswf:out context="HtmlBody" value="${caption}"/>${suffix}
			</c:when>
		</c:choose>
		<c:if test="${not empty menuItem}">
			</li>
		</c:if>
</c:otherwise>
</c:choose>