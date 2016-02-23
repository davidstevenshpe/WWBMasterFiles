<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.catalog.catalogmessages" var="catalogMessages"/>
<fmt:message var="removeFromMenuLink" key="removeFromMenuLink" bundle="${catalogMessages}" />
<fmt:message var="addToMenuLink" key="addToMenuLink" bundle="${catalogMessages}" />
<c:if test="${(artifactSdmType.basic or not showBasicOnly) and not hiddenLink}">
    <c:choose>
        <c:when test="${label eq 'single'}">
            <c:set var="caption" value="${artifactSdmType.singleLabel}"/>    
        </c:when>
        <c:otherwise>
            <c:set var="caption" value="${artifactSdmType.multipleLabel}"/>   
        </c:otherwise>
    </c:choose>    
    <c:if test="${renderPin and not hiddenCreateLink and not ((artifactSdmType.id eq 'agreementArtifact') or (artifactSdmType.id eq 'xmlSpecificationsArtifact') or (artifactSdmType.id eq 'modelArtifact'))}">
        <div class="UI Align">
            <div class="Right">
                <c:choose>
                    <c:when test="${artifactSdmType.basic}">
                        <c:set var="functionName" value="${prefix}removeBasic"/>
                        <%-- TODO REVIEW (Svata, Nov 4, 2009): consider to have one 'toggle' function called from both states --%>
                        <syswf:control mode="script" affects="." action="removeBasic" caption="${functionName}" id="removeBasic${functionName}">
                            <syswf:param name="artifactSdmType" value="${artifactSdmType}" />
                            <syswf:param name="collectionId" value="${collectionId}" />
                        </syswf:control>
                        <a href="javascript:void(0)" class="UI Icon Pin" title="${removeFromMenuLink}" id="remove${functionName}"></a>
                        <script type="text/javascript">
//<![CDATA[

                            function resetPin() {
                                var pin_id = $("#remove${functionName}");
								fCatalogMenuPinned = true;
                                pin_id.toggleClass("Pin").toggleClass("Unpin");
                                ${functionName}();
                            };
                        
//]]>
</script>
                        <script type="text/javascript">
//<![CDATA[

                            attachOn('remove${functionName}', 'click', resetPin);
                        
//]]>
</script>
                    </c:when>
                    <c:otherwise>
                        <c:set var="functionName" value="${prefix}addBasic"/>
                        <syswf:control mode="script" affects="." action="addBasic" caption="${functionName}" id="addBasic${functionName}">
                            <syswf:param name="artifactSdmType" value="${artifactSdmType}" />
                            <syswf:param name="collectionId" value="${collectionId}" />
                        </syswf:control>                        
                        <a href="javascript:void(0)" class="UI Icon Unpin" title="${addToMenuLink}" id="add${functionName}"></a>
                        <script type="text/javascript">
//<![CDATA[

                            function resetPin() {
                                var pin_id = $("#add${functionName}");
                                pin_id.toggleClass("Pin").toggleClass("Unpin");
								fCatalogMenuPinned = true;
                                ${functionName}();
                            };
                        
//]]>
</script>
                        <script type="text/javascript">
//<![CDATA[

                            attachOn('add${functionName}', 'click', resetPin);
                        
//]]>
</script>
                    </c:otherwise>                                                    
                </c:choose>
            </div>
    </c:if>
    
    <c:choose>
        <c:when test="${mode eq 'create' and (not artifactSdmType.creatable or artifactSdmType.abstractArtifact or not artifactSdmType.allowCreate)}">        	
            <c:choose>
                <c:when test="${(artifactSdmType.abstractArtifact and renderAbstractArtifactType eq 'none') or hiddenCreateLink}">
                    <%-- do not render the abstract artifact at all - usually used for left menu --%>
                </c:when>
                <c:otherwise>
                    <c:set var="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${artifactSdmType.id}&amp;format=small)"/>
                    <%-- This is intentionally a 'span' instead of an 'a' element - the text must be rendered as non-clickable
                         This particular solution was recommended by designers. --%>
                    <span class="UI Icon Artifact" style="${style}"><span>${caption}</span></span>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${artifactLink}">
                    <syswf:control mode="anchor" caption="${caption}" targetTask="/artifact/${artifactSdmType.id}" id="$${artifactSdmType.id}" wrapper="span" targetDepth="0"/>
                </c:when>
                <c:otherwise>
                	<c:choose>
                		<c:when test="${(artifactSdmType.id eq 'agreementArtifact') or (artifactSdmType.id eq 'xmlSpecificationsArtifact') or (artifactSdmType.id eq 'modelArtifact')}">
                			<c:set var="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${artifactSdmType.id}&amp;format=small)"/>
		                    <%-- This is intentionally a 'span' instead of an 'a' element - the text must be rendered as non-clickable
		                         This particular solution was recommended by designers. --%>
		                    <span class="UI Icon Artifact" style="${style}"><span>${caption}</span></span>
                		</c:when>
                		<c:otherwise>
                			<syswf:control mode="anchor" caption="${caption}" targetTask="${targetTask}" id="${artifactSdmType.id}" wrapper="span" targetDepth="0">
		                        <syswf:param name="${idParamName}" value="${artifactSdmType.id}"/>
		                        <c:if test="${showIcon and not empty artifactSdmType.icon}">
		                            <syswf:attribute name="class" value="UI Icon Artifact"/>
		                            <syswf:attribute name="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${artifactSdmType.icon}&format=small); ${indent}"/>
		                        </c:if>
		                    </syswf:control>	
                		</c:otherwise>
                	</c:choose>
                </c:otherwise>
            </c:choose>
            <c:if test="${appendBreak}">
                <br/>
            </c:if>
        </c:otherwise>
    </c:choose>
        
    <c:if test="${renderPin}">
    	<c:choose>
    		<c:when test="${mode eq 'create'}">
    			<c:if test="${not hiddenCreateLink}">
    				<div/>
    			</c:if>
    		</c:when>
    		<c:otherwise>
    			<div/>
    		</c:otherwise>
    	</c:choose>        
    </c:if>

</c:if>
    
<%-- Recursion to parse the whole tree. Do not render the subtree if the current node is hidden --%>
<c:if test="${not empty artifactSdmType.artifactTypes and not hiddenLink}">
    <c:if test="${wrapAsListItem}">
        <ul class="UI Hierarchy Plain">
    </c:if>
    <c:forEach items="${artifactSdmType.artifactTypes}" var="artifactSubType" varStatus="status">
        <c:if test="${wrapAsListItem}">
            <li>
        </c:if>
        <syswf:component name="${subItemRenderer}" prefix="${artifactSdmType.id}_${status.index}">
            <syswf:param name="defaultBasicArtifacts" value="${defaultBasicArtifacts}"/>
            <syswf:param name="showBasicOnly" value="${showBasicOnly}"/>
            <syswf:param name="targetTask" value="${targetTask}"/>
            <syswf:param name="label" value="${label}"/>
            <syswf:param name="artifactSdmType" value="${artifactSubType}"/>
            <syswf:param name="idParamName" value="${idParamName}"/>
            <syswf:param name="showIcon" value="${showIcon}"/>
            <syswf:param name="wrapAsListItem" value="${wrapAsListItem}"/>
            <syswf:param name="renderPin" value="${renderPin}"/>            
            <syswf:param name="artifactLink" value="${artifactLink}"/>
            <syswf:param name="mode" value="${mode}"/>
            <c:if test="${not empty renderAbstractArtifactType}">
                <syswf:param name="renderAbstractArtifactType" value="${renderAbstractArtifactType}"/>
            </c:if>
        </syswf:component>
        <c:if test="${artifactSdmType.basic or not showBasicOnly}">       
            <c:if test="${wrapAsListItem}">
                </li>
            </c:if>
        </c:if>
    </c:forEach>
    <c:if test="${wrapAsListItem}">
        </ul>
    </c:if>
</c:if>