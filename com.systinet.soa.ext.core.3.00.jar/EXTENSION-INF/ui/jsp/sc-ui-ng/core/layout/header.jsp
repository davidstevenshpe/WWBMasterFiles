<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uimessages"/>
<fmt:message bundle="${uimessages}" key="Back" var="Back" />
<fmt:message bundle="${uimessages}" key="revisionNumberPrefix" var="revisionNumberPrefix" />
<fmt:message bundle="${uimessages}" key="currentRevisionLabel" var="currentRevisionLabel" />
<fmt:message bundle="${uimessages}" key="header.title.deleted" var="titleDeleted" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<c:set var="pageIdentityClass">
    <c:choose>
        <c:when test="${artifactDeleted}">Deleted</c:when>
        <c:when test="${not empty artifactRevisionNumber and not (artifactRevisionNumber == -1)}">Revision</c:when>
        <c:when test="${not empty artifactRevisionNumber and artifactRevisionNumber == -1}">Revision Current</c:when>
        <c:when test="${artifactLocked}">Locked</c:when>
    </c:choose>
</c:set>
<c:set var="headerText">
		<c:choose>
			<c:when test="${not empty artifactSdmName}">
				 <h3 class="EA-top-header" onclick="if($('#overview-tab-link a').length > 0) {window.location=$('#overview-tab-link a').attr('href')}"><c:out value="${title}" /></h3>
			</c:when>
			<c:otherwise>
				<h3 class="EA-top-header"><c:out value="${title}"/></h3>
			</c:otherwise>
		</c:choose>
        <c:if test="${not empty subtitle}">
            <c:set var="style">
                <c:if test="${not empty iconType}">
                	background: url(${deploymentUrl}/artifactIcon?type=${iconType}&format=${iconFormat}) no-repeat center left; padding-left:20px;
                </c:if>
            </c:set>
            <c:choose>
            	<c:when test="${not empty lifecycleInformation }">
            		<h5 class="${subtitleClass} EA-sub-type clickable">
            			<span class="artifactType clickable">
	            			<syswf:control mode="anchor" caption="${subtitle}" targetTask="/common/browseArtifact" targetDepth="0">
								<syswf:param name="artifactType" value="${artifactSdmName}"/>
							</syswf:control>
						</span>
            			<span class="LifecycleInformation clickable" onclick="window.location=$('#lifecycle-tab-link a').attr('href')"><c:out value="${lifecycleInformation}"/></span>
            			<c:if test="${artifactDeleted}">
			                <span class="titleDeleted"><c:out value="${titleDeleted}"/></span>
			            </c:if>
            		</h5>
            	</c:when>
            	<c:otherwise>
            		<h5 class="${subtitleClass} EA-sub-type clickable">
				        <c:choose>
							<c:when test="${not empty artifactSdmName}">
							<span class="artifactType">
							<syswf:control mode="anchor" caption="${subtitle}" targetTask="/common/browseArtifact" targetDepth="0">
								<syswf:param name="artifactType" value="${artifactSdmName}"/>
                                <syswf:attribute name="onMouseOver" value="this.style['text-decoration']='underline'"/>
                                <syswf:attribute name="onMouseOut" value="this.style['text-decoration']='none'"/>
							</syswf:control>
							</span>
							</c:when>
							<c:otherwise>
								<c:out value="${subtitle}"/>
							</c:otherwise>
						</c:choose>
	                    <c:if test="${artifactDeleted}">
			                <span class="titleDeleted"><c:out value="${titleDeleted}"/></span>
			            </c:if>
            		</h5>
            	</c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${not empty artifactRevisionNumber}">
             <div class="RevisionInfo">
                <c:choose>
                    <c:when test="${artifactRevisionNumber == -1}">
                        ${currentRevisionLabel}
                    </c:when>
                    <c:otherwise>
                        ${revisionNumberPrefix} <syswf:out context="HtmlBody" value="${artifactRevisionNumber}"/>
                    </c:otherwise>
                </c:choose>
            </div>            
        </c:if>
</c:set>

<c:set var="customizationControls">
    <%-- TODO fix when design is done --%>
    <c:choose>
        <c:when test="${pageType eq 'reportPage'}">
        	<c:if test="${empty disableEditButton}">
	            <fmt:message var="editBtnCaption" key="header.editReport" bundle="${bundle}"/>
	            <syswf:control id="editArtifactReport" mode="anchor" caption="${editBtnCaption}"
	                           wrapper="span" targetTask="/reports/artifact/createArtifactReport">
	                <syswf:param name="reportId" value="${reportId}" />
	                <syswf:param name="reportName">${reportName}</syswf:param>
	                <syswf:param name="mode" value="edit"/>
	                <syswf:attribute name="class" value="EA-button main-action gray"/>
	            </syswf:control>
            </c:if>
        </c:when>
        <c:when test="${not empty pageType}">
	        <fmt:message var="editArtifactType" key="header.editPage" bundle="${bundle}"/>
	        <syswf:control id="editArtifactType" mode="anchor"
	                       targetTask="/${viewId}/addArtifactType"
	                       wrapper="span" caption="${editArtifactType}">
	            <syswf:param name="generate" value="false" />
	            <syswf:param name="artifactType" value="${artifactTypeForCustomization}" />
	            <syswf:param name="pageTypeForCustomization" value="${pageType}" />
	            <syswf:attribute name="class" value="EA-button main-action gray"/>
	        </syswf:control>
        </c:when>
    </c:choose>
</c:set>

<c:set var="pageTitleDeletedClass">
	<c:if test="${artifactDeleted}">
	   pageTitleDeleted
	</c:if>
</c:set>

<div id="pagetitle" class="UI Block Common EA-Blue-Bar ${pageTitleDeletedClass}">
	<div class="EA-Block"><c:out value="${headerText}" escapeXml="false"/></div>
	<div class="EA-Block"><c:out value="${customizationControls}" escapeXml="false"/></div>
	<c:if test="${not empty domainLabel and not showRating and artifactSdmName ne 'reportArtifact'}">
		<div class="EA-Block EA-block-vote">
			<div class="domain-text-page">
				<span>Located in</span><br>
				<span>${domainLabel}</span>
			</div>
		</div>
	</c:if>
	<div class="EA-Block EA-block-vote">
    <c:if test="${showRating && not artifactDeleted}">
        <syswf:component name="/core/rating/rateArtifact" prefix="rating">
            <syswf:param name="uuid" value="${artifactUuid}"/>
			<syswf:param name="domainLabel" value="${domainLabel}"/>
        </syswf:component>
    </c:if>
    </div>
	<c:if test="${showBackButton}">
		<div class="EA-Block" style="float:right">		
			<syswf:control mode="button" targetDepth="${sessionStack.currentDepth-1}" caption="${Back}" />				       
		</div>
	 </c:if>
    <div class="float-clear"></div>
</div>
