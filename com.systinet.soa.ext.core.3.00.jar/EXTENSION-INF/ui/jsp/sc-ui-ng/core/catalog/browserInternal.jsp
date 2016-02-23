<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.catalog.catalogmessages" var="catalogMessages"/>

<c:if test="${not empty customizeLinks}">
<li>
    <c:out value="${customizeLinks}" escapeXml="false"/>
</li>
</c:if>
<li>
    <c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
       	<c:if test="${group.id != 'proxy.mgmt' or proxyMgmtEnabled}">
	        <c:forEach items="${group.artifactTypes}" var="artifactType" varStatus="artifactTypeStatus">
	            <syswf:component name="${browseLinkRenderer}" prefix="menuBrowseLinks_${groupStatus.index}_${artifactTypeStatus.index}">
	                <syswf:param name="showBasicOnly" value="true"/>
	                <syswf:param name="artifactSdmType" value="${artifactType}"/>
	                <syswf:param name="showIcon" value="false"/>  
	                <syswf:param name="wrapAsListItem" value="false"/>
	                <syswf:param name="renderPin" value="false"/>
	                <syswf:param name="collectionId" value="${collectionId}"/>
	                <syswf:param name="mode" value="browse"/>
	            </syswf:component>
	        </c:forEach>
       	</c:if>
    </c:forEach>
    <%-- 
    <a href="javascript:void(0);" id="BrowseArtifact"><span><fmt:message key="moreLink" bundle="${catalogMessages}"/></span></a>
    --%>
    <c:if test="${not hideMoreLink}">
        <a href="javascript:void(0);" id="${prefix}browseArtifactHandler"><span><fmt:message key="moreLink" bundle="${catalogMessages}"/></span></a>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                attachOn('${prefix}browseArtifactHandler','click',function() {
                    ${prefix}openBrowseArtifact();
                });
                moveWindow('${prefix}browsePopup','popupWindows');
            });
        
//]]>
</script>
    </c:if>
</li>

<c:if test="${not empty createLinkRenderer}">
    <li class="systinet-horizontal-menu-separator"><span></span></li>

    <!-- BEGIN: 'CREATE' DROPDOWN MENU -->
    <div class="x-hidden flyout-menu UI Dropdown" id="${prefix}artifacts_list_content">
        <div class="DropdownContent">
            <c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
            	<c:if test="${group.id != 'proxy.mgmt' or proxyMgmtEnabled}">
	                <c:if test="${group.hasCreatableTypes}">
	                    <c:forEach items="${group.artifactTypes}" var="artifactType" varStatus="artifactTypeStatus">
	                      <c:if test="${artifactType.allowCreate}">
	                        <syswf:component name="${createLinkRenderer}" prefix="menuCreateLinks_${groupStatus.index}_${artifactTypeStatus.index}">
	                            <syswf:param name="showBasicOnly" value="true"/>
	                            <syswf:param name="artifactSdmType" value="${artifactType}"/>
	                            <syswf:param name="showIcon" value="true"/>
	                            <syswf:param name="wrapAsListItem" value="false"/>
	                            <syswf:param name="appendBreak" value="${not (groupStatus.last and artifactTypeStatus.last)}"/>
	                            <syswf:param name="renderPin" value="false"/>
	                            <syswf:param name="renderAbstractArtifactType" value="none"/>
	                            <syswf:param name="collectionId" value="${collectionId}"/>
	                            <syswf:param name="mode" value="create"/>
	                        </syswf:component>
	                      </c:if>
	                    </c:forEach>
	                </c:if>            	
            	</c:if>
            </c:forEach>
            <%--
            <a href="javascript:void(0);" class="UI Icon Artifact" id="CreateArtifact"><span><fmt:message key="moreLink" bundle="${catalogMessages}" /></span></a>
            --%>

            <c:if test="${not hideMoreLink}">
                <a href="javascript:void(0);" class="UI Icon Artifact" id="${prefix}createArtifactHandler"><span><fmt:message key="moreLink" bundle="${catalogMessages}"/></span></a>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        attachOn('${prefix}createArtifactHandler','click',function() {
                            ${prefix}openCreateArtifact();
                        });
                        moveWindow('${prefix}createPopup','popupWindows');
                    });
                
//]]>
</script>
            </c:if>
        </div>
    </div>

    <li>
        <a href="javascript:void(0);" onclick="return false;" class="UI Dropdown Right" id="${prefix}artifacts_list"><span><fmt:message key="createDropdownLink" bundle="${catalogMessages}"/></span></a>
    </li>
    
    <!-- DROPDOWN INIT -->
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){ Dropdown.init('${prefix}artifacts_list','${prefix}artifacts_list_content',{align:'tl-tr',forceRefresh:true}); });
    
//]]>
</script>
    <!-- END: 'CREATE' DROPDOWN MENU -->
</c:if>

<c:set var="functionNameRestoreDefaults" value="${prefix}_restoreDefaults" />
<syswf:control mode="script" action="restoreDefaults" caption="${functionNameRestoreDefaults}"/>

<c:set var="functionNameClose" value="${prefix}_close" />
<syswf:control mode="script" action="close" caption="${functionNameClose}"/>

<c:choose>
    <c:when test="${not empty windowTitle}">
        <c:set var="title" value="${windowTitle}"/>
    </c:when>
    <c:otherwise>
        <c:set var="title"><fmt:message key="catalogBrowserPopupHeader" bundle="${catalogMessages}"/></c:set>
    </c:otherwise>
</c:choose>

<c:if test="${empty browseWindowWidth}">
    <c:set var="browseWindowWidth" value="${170*this.artifactsConfiguration.count + 100}"/>
</c:if>

<c:if test="${empty createWindowWidth}">

    <c:set var="emptyGroupsCount" value="0"/>
    <c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
        <c:if test="${not group.hasCreatableTypes}">
            <c:set var="emptyGroupsCount" value="${emptyGroupsCount + 1}"/>
        </c:if>
    </c:forEach>

    <c:set var="createWindowWidth" value="${170 * (this.artifactsConfiguration.count - emptyGroupsCount) + 100}"/>
</c:if>

<syswf:component name="/core/window" prefix="browsePopup">
    <syswf:param name="winTitle">${title}</syswf:param>
    <syswf:param name="winComponent" value="/core/catalog/browsePopup"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openBrowseArtifact"/>    
    <syswf:param name="winOkLabel"><fmt:message key="restoreDefaultsButton" bundle="${catalogMessages}"/></syswf:param>
    <syswf:param name="winOkAction" value="${functionNameRestoreDefaults}"/>
    <syswf:param name="winCancelLabel"><fmt:message key="closeButton" bundle="${catalogMessages}"/></syswf:param>     
    <syswf:param name="winCancelAction" value="${functionNameClose}"/>
    <syswf:param name="winWidth" value="${browseWindowWidth}"/>
    <syswf:param name="winButtonAlign" value="right"/>
    <syswf:param name="winForceRefresh" value="true"/>    
    <syswf:param name="artifactsConfiguration" value="${this.artifactsConfiguration}"/>
    <syswf:param name="defaultBasicArtifacts" value="${this.defaultBasicArtifacts}"/>
    <syswf:param name="proxyMgmtEnabled" value="${this.proxyMgmtEnabled}"/>
    <syswf:param name="linkRenderer" value="${browseLinkRenderer}"/>
    <syswf:param name="collectionId" value="${collectionId}"/>
    <syswf:param name="winId" value="${prefix}browsePopup"/>
    <syswf:param name="popupId" value="${prefix}browsePopup"/>
    <syswf:param name="mode" value="browse"/>
</syswf:component>

<c:if test="${not empty createLinkRenderer}">
    <syswf:component name="/core/window" prefix="createPopup">
        <syswf:param name="winTitle"><fmt:message key="createArtifactPopupHeader" bundle="${catalogMessages}"/></syswf:param>
        <syswf:param name="winComponent" value="/core/catalog/createPopup"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}openCreateArtifact"/>
        <syswf:param name="winOkLabel"><fmt:message key="restoreDefaultsButton" bundle="${catalogMessages}"/></syswf:param>
        <syswf:param name="winOkAction" value="${functionNameRestoreDefaults}"/>
        <syswf:param name="winCancelLabel"><fmt:message key="closeButton" bundle="${catalogMessages}"/></syswf:param>
        <syswf:param name="winCancelAction" value="${functionNameClose}"/>
        <syswf:param name="winWidth" value="${createWindowWidth}"/>
        <syswf:param name="winButtonAlign" value="right"/>
        <syswf:param name="winForceRefresh" value="true"/>
        <syswf:param name="artifactsConfiguration" value="${this.artifactsConfiguration}"/>
        <syswf:param name="defaultBasicArtifacts" value="${this.defaultBasicArtifacts}"/>
        <syswf:param name="proxyMgmtEnabled" value="${this.proxyMgmtEnabled}"/>
        <syswf:param name="linkRenderer" value="${createLinkRenderer}"/>
        <syswf:param name="collectionId" value="${collectionId}"/>
        <syswf:param name="winId" value="${prefix}createPopup"/>
        <syswf:param name="popupId" value="${prefix}createPopup"/>
        <syswf:param name="mode" value="create"/>
    </syswf:component>
</c:if>