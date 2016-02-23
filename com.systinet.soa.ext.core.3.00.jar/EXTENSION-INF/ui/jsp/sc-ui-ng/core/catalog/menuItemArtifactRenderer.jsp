<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}"
		scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.catalog.catalogmessages" var="catalogMessages" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="menuBundle"/>
<fmt:message var="menu_bullet" key="menu.bullet" bundle="${menuBundle}"/>

<c:set var="hasItem" value="false"/>
<c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
	<c:if test="${fn:length(group.artifactTypes) gt 0}">
		<c:set var="hasItem" value="true"/>
	</c:if>
</c:forEach>

<c:set var="functionNameRestoreDefaults" value="${prefix}_restoreDefaults" />
<syswf:control mode="script" action="restoreDefaults" caption="${functionNameRestoreDefaults}"/>

<c:set var="functionNameClose" value="${prefix}_close" />
<syswf:control mode="script" action="close" caption="${functionNameClose}"/>

    <script type="text/javascript">
//<![CDATA[
	var fCatalogMenuPinned = false;
	function catalogBrowseClose(){
		
		if (fCatalogMenuPinned){
			${functionNameClose}();
		}	
	}        
    
//]]>
</script>

<c:choose>
    <c:when test="${not empty windowTitle}">
        <c:set var="title" value="${windowTitle}"/>
    </c:when>
    <c:otherwise>
        <c:set var="title"><fmt:message key="catalogBrowserPopupHeader" bundle="${catalogMessages}"/></c:set>
    </c:otherwise>
</c:choose>

<c:set var="emptyGroupsCount" value="0"/>
<c:set var="ipepHide" value="0"/>
<c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
	<c:if test="${not group.hasCreatableTypes}">
		<c:set var="emptyGroupsCount" value="${emptyGroupsCount + 1}"/>
	</c:if>
	<c:if test="${group.id == 'proxy.mgmt' and not proxyMgmtEnabled}">
		<c:set var="ipepHide" value="1"/>
	</c:if>
</c:forEach>

<c:if test="${empty browseWindowWidth}">
    <c:set var="browseWindowWidth" value="${190*(this.artifactsConfiguration.count - ipepHide) + 100}"/>
</c:if>

<c:if test="${browseWindowWidth>1280}">
    <c:set var="browseWindowWidth" value="1280"/>
</c:if>

<c:if test="${empty createWindowWidth}">
    <c:set var="createWindowWidth" value="${190 * (this.artifactsConfiguration.count - emptyGroupsCount - ipepHide) + 100}"/>
</c:if>

<c:if test="${createWindowWidth>1280}">
    <c:set var="createWindowWidth" value="1280"/>
</c:if>

<c:if test="${(browseArtifact eq 'true') and (hasItem eq 'true')}">	
		
		<!-- Customization -->
		<!-- Policy and Custom report don't need customization link  -->
		<c:if test="${(not empty customizeLinks) and (empty notPolicyAndCustomReportMenu)}">
			<li>				
	           <c:out value="${customizeLinks}" escapeXml="false"/>
			</li>
		</c:if>

		<c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
			<c:forEach items="${group.artifactTypes}" var="artifactType" varStatus="artifactTypeStatus">
				<c:if test="${artifactType.basic}">
		            <c:set var="caption" value="${artifactType.multipleLabel}"/>
					<li>
						<c:choose>
							<c:when test="${artifactLink eq 'true'}">
								<syswf:control mode="anchor" caption="${caption}" targetTask="/artifact/${artifactType.id}" id="$${artifactType.id}" targetDepth="0"/>
							</c:when>
							<c:when test="${collectionId eq 'artifactReports'}">
								<syswf:control id="artifactReport_${artifactTypeStatus.count}" mode="anchor" caption="${artifactType.singleLabel}" targetTask="/common/viewReport">
									<syswf:param name="reportId" value="${artifactType.id}" />
								</syswf:control>
							</c:when>
							<c:otherwise>											
								<syswf:control mode="anchor" caption="${caption}" targetTask="/common/browseArtifact" id="${artifactType.id}" targetDepth="0">
									<syswf:param name="artifactType" value="${artifactType.id}"/>
								</syswf:control>
							</c:otherwise>
						</c:choose>
					</li>	
				</c:if>
				
				<c:if test="${not empty artifactType.artifactTypes and not hiddenLink}">
					<c:forEach items="${artifactType.artifactTypes}" var="artifactSubType" varStatus="status">
						<c:if test="${artifactSubType.basic}">
							<c:set var="caption" value="${artifactSubType.multipleLabel}"/>
							<li>	
								<c:choose>
									<c:when test="${artifactLink eq 'true'}">
										<syswf:control mode="anchor" caption="${caption}" targetTask="/artifact/${artifactSubType.id}" id="$${artifactSubType.id}" targetDepth="0"/>
									</c:when>
									<c:otherwise>
										<syswf:control mode="anchor" caption="${caption}" targetTask="/common/browseArtifact" id="${artifactSubType.id}" targetDepth="0">
											<syswf:param name="artifactType" value="${artifactSubType.id}"/>
										</syswf:control>
									</c:otherwise>
								</c:choose>
							</li>	
						</c:if>
                        <c:if test="${not empty artifactSubType.artifactTypes}">
                          <c:forEach items="${artifactSubType.artifactTypes}" var="artifactSubTypeLv2" varStatus="status">
                            <c:if test="${artifactSubTypeLv2.basic}">
                              <c:set var="caption" value="${artifactSubTypeLv2.multipleLabel}"/>
                              <li>
                                <c:choose>
                                    <c:when test="${artifactLink eq 'true'}">
                                        <syswf:control mode="anchor" caption="${caption}" targetTask="/artifact/${artifactSubTypeLv2.id}" id="$${artifactSubTypeLv2.id}" targetDepth="0"/>
                                    </c:when>
                                    <c:otherwise>
                                        <syswf:control mode="anchor" caption="${caption}" targetTask="/common/browseArtifact" id="${artifactSubTypeLv2.id}" targetDepth="0">
                                            <syswf:param name="artifactType" value="${artifactSubTypeLv2.id}"/>
                                        </syswf:control>
                                    </c:otherwise>
                                </c:choose>
                              </li>
                            </c:if>
                          </c:forEach>
                        </c:if>
					</c:forEach>
				</c:if>
				
			</c:forEach>
		</c:forEach>
		
		<c:if test="${not hideMoreLink}">
			<li class="systinet-horizontal-menu-separator">
				<a href="javascript:void(0);" id="${prefix}showMoreArtifactHandler">
					<span>
						<fmt:message key="moreLink" bundle="${catalogMessages}" />
					</span>
				</a>
			</li>
			<script type="text/javascript">
//<![CDATA[

				Ext.onReady(function() {
		            attachOn('${prefix}showMoreArtifactHandler','click',function() {
						fCatalogMenuPinned = false;
		                ${prefix}openBrowseArtifact();
		            });
		            moveWindow('${prefix}browsePopup','popupWindows');
		        });
				function repositionBrowse(){
					SPopup.Window.reposition('${prefix}browsePopup');
				}
//]]>
			</script>
		</c:if>
		
	<syswf:component name="/core/window" prefix="browsePopup">
	    <syswf:param name="winTitle">${title}</syswf:param>
	    <syswf:param name="winComponent" value="/core/catalog/browsePopup"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openBrowseArtifact"/>    
	    <syswf:param name="winOkLabel"><fmt:message key="restoreDefaultsButton" bundle="${catalogMessages}"/></syswf:param>
	    <syswf:param name="winOkAction" value="${functionNameRestoreDefaults}"/>
	    <syswf:param name="winCancelLabel"><fmt:message key="closeButton" bundle="${catalogMessages}"/></syswf:param>     
	    <syswf:param name="winCancelAction" value="catalogBrowseClose"/>
	    <syswf:param name="winWidth" value="${browseWindowWidth}"/>
	    <syswf:param name="winButtonAlign" value="right"/>
	    <syswf:param name="winForceRefresh" value="false"/>    
	    <syswf:param name="artifactsConfiguration" value="${this.artifactsConfiguration}"/>
	    <syswf:param name="defaultBasicArtifacts" value="${this.defaultBasicArtifacts}"/>
	    <syswf:param name="linkRenderer" value="${browseLinkRenderer}"/>
	    <syswf:param name="collectionId" value="${collectionId}"/>
	    <syswf:param name="winId" value="${prefix}browsePopup"/>
	    <syswf:param name="popupId" value="${prefix}browsePopup"/>
	    <syswf:param name="mode" value="browse"/>
		<syswf:param name="proxyMgmtEnabled" value="${proxyMgmtEnabled}"/>
		<syswf:param name="winOnRenderCallback" value="repositionBrowse" />
</syswf:component>
	
</c:if>


<c:if test="${(createArtifact eq 'true') and (hasItem eq 'true')}">
	   	<c:forEach items="${this.artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
	        <c:if test="${group.hasCreatableTypes}">
	            <c:forEach items="${group.artifactTypes}" var="artifactType" varStatus="artifactTypeStatus">
	              <c:if test="${artifactType.allowCreate and (not artifactType.abstractArtifact) and (artifactType.creatable) and (artifactType.basic)}">
	              	<c:set var="caption" value="${artifactType.singleLabel}"/>
	              	<li>	
						<syswf:component name="/core/impl/catalog/artifactNewLinkRenderer" prefix="menuNewLinks_${groupStatus.index}_${artifactTypeStatus.index}">
							<syswf:param name="caption" value="${caption}"/>
							<syswf:param name="artifactSdmType" value="${artifactType}"/>
						</syswf:component>			
					</li>
	              </c:if>
	              
	              <c:if test="${not empty artifactType.artifactTypes and not hiddenLink}">
					<c:forEach items="${artifactType.artifactTypes}" var="artifactSubType" varStatus="statusArtifactSubType">
						<c:if test="${artifactSubType.allowCreate and (not artifactSubType.abstractArtifact) and (artifactSubType.creatable) and (artifactSubType.basic)}">
							<c:set var="caption" value="${artifactSubType.singleLabel}"/>
								<li>	
									<syswf:component name="/core/impl/catalog/artifactNewLinkRenderer" prefix="menuNewSubLinks_${groupStatus.index}_${artifactTypeStatus.index}_${statusArtifactSubType.index}">
										<syswf:param name="caption" value="${caption}"/>
										<syswf:param name="artifactSdmType" value="${artifactSubType}"/>
									</syswf:component>
								</li>	
						</c:if>
                        <c:if test="${not empty artifactSubType.artifactTypes}">
                          <c:forEach items="${artifactSubType.artifactTypes}" var="artifactSubTypeLv2" varStatus="statusSubLv2">
                            <c:if test="${artifactSubTypeLv2.allowCreate and (not artifactSubTypeLv2.abstractArtifact) and (artifactSubTypeLv2.creatable) and (artifactSubTypeLv2.basic)}">
                              <c:set var="caption" value="${artifactSubTypeLv2.singleLabel}"/>
                                <li>
                                    <syswf:component name="/core/impl/catalog/artifactNewLinkRenderer" prefix="menuNewSubLinks_${groupStatus.index}_${artifactTypeStatus.index}_${statusArtifactSubType.index}_${statusSubLv2.index}">
                                        <syswf:param name="caption" value="${caption}"/>
                                        <syswf:param name="artifactSdmType" value="${artifactSubTypeLv2}"/>
                                    </syswf:component>
                                </li>
                            </c:if>
                          </c:forEach>
                        </c:if>
					</c:forEach>
				</c:if>
	              
	            </c:forEach>
	        </c:if>
	    </c:forEach>
	            
	    <c:if test="${not hideMoreLink}">
	    	<li class="systinet-horizontal-menu-separator">
		        <a href="javascript:void(0);" id="${prefix}createArtifactHandler">
		        	<span>
		        		<fmt:message key="moreLink" bundle="${catalogMessages}"/>
		       		</span>
		 		</a>
	 		</li>
	        <script type="text/javascript">
//<![CDATA[
	            Ext.onReady(function() {
	                attachOn('${prefix}createArtifactHandler','click',function() {
						fCatalogMenuPinned = false;
	                    ${prefix}openCreateArtifact();
	                });
	                moveWindow('${prefix}createPopup','popupWindows');
	            });
				function repositionCreate(){
					SPopup.Window.reposition('${prefix}createPopup');
				}
//]]>
			</script>
	    </c:if>
	    
    
    <syswf:component name="/core/window" prefix="createPopup">
	    <syswf:param name="winTitle"><fmt:message key="createArtifactPopupHeader" bundle="${catalogMessages}"/></syswf:param>
	    <syswf:param name="winComponent" value="/core/catalog/createPopup"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openCreateArtifact"/>
	    <syswf:param name="winOkLabel"><fmt:message key="restoreDefaultsButton" bundle="${catalogMessages}"/></syswf:param>
	    <syswf:param name="winOkAction" value="${functionNameRestoreDefaults}"/>
	    <syswf:param name="winCancelLabel"><fmt:message key="closeButton" bundle="${catalogMessages}"/></syswf:param>
	    <syswf:param name="winCancelAction" value="catalogBrowseClose"/>
	    <syswf:param name="winWidth" value="${createWindowWidth}"/>
	    <syswf:param name="winButtonAlign" value="right"/>
	    <syswf:param name="winForceRefresh" value="false"/>
	    <syswf:param name="artifactsConfiguration" value="${this.artifactsConfiguration}"/>
	    <syswf:param name="defaultBasicArtifacts" value="${this.defaultBasicArtifacts}"/>
	    <syswf:param name="linkRenderer" value="${createLinkRenderer}"/>
	    <syswf:param name="collectionId" value="${collectionId}"/>
	    <syswf:param name="winId" value="${prefix}createPopup"/>
	    <syswf:param name="popupId" value="${prefix}createPopup"/>
	    <syswf:param name="mode" value="create"/>
		<syswf:param name="proxyMgmtEnabled" value="${proxyMgmtEnabled}"/>
		<syswf:param name="winOnRenderCallback" value="repositionCreate" />
	</syswf:component>
</c:if>
