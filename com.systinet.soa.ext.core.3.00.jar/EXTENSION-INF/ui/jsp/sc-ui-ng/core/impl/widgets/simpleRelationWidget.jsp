<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
Component parameters
 
asLine - if true, renders all links on one line separated by '
defaultDisplayed - number of items, which have to be shown immediately (rest will be shown after clicking on link), if null, all items are shown
   
 --%>

<c:set var="modifyEnabled">
    <c:choose>
        <c:when test="${(not readOnly) and (not deleteOnly) and hasWritePermission}">${true}</c:when>
        <c:otherwise>${false}</c:otherwise>
    </c:choose>
</c:set>

<c:set var="deleteEnabled">
    <c:choose>
        <c:when test="${(not readOnly) and hasWritePermission}">${true}</c:when>
        <c:otherwise>${false}</c:otherwise>
    </c:choose>
</c:set>

<c:set var="invalidTableView">
    <c:choose>
        <c:when test="${isInvalid}">${invalidTableView}</c:when>
        <c:otherwise>${artifactTypes}</c:otherwise>
    </c:choose>
</c:set>
<c:set var="artifactName"><syswf:out value="${artifact.name}" context="HtmlBody"/></c:set>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<fmt:message var="relationshipTypeNew" bundle="${relationshipmessages}" key="relationship.type.new"/>
<fmt:message var="relationshipTypeAdd" bundle="${relationshipmessages}" key="relationship.type.add"/>

<fmt:message var="relationWndTitle" bundle="${relationshipmessages}" key="relation.window.title">
    <fmt:param value="${relationshipLabel}"/>
    <fmt:param value="${artifactName}"/>
</fmt:message>

<c:choose>
    <c:when test="${asLine}">
        <c:set var="wrap" value="false" />
    </c:when>
    <c:otherwise>
        <c:set var="wrap" value="true" />
    </c:otherwise>
</c:choose>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<c:if test="${empty multipleRelation}">
    <c:set var="multipleRelation" value="true" />
</c:if>

<c:choose>
	<c:when test="${empty this.artifactLinkHolders and readOnly}">
		N/A
	</c:when>
	<c:when test="${not empty this.artifactLinkHolders}">
	    <script>
	        Ext4.get('${editorBlockID}').setVisible(true);
	    </script>
	
	    <c:forEach items="${this.artifactLinkHolders}" var="linkHolder" varStatus="status">
	        <c:choose>
	            <c:when test="${linkHolder.deleted}">
	                <fmt:message var="deleted" key="relation.target.deleted" bundle="${widgetMessages}" />
	                <span class="UI Icon Deleted" title="${deleted}"><c:out value="${linkHolder.name}"/></span>
	                <c:if test="${asLine and not status.last}">, </c:if>
	            </c:when>
	            <c:otherwise>
	                <c:choose>
	                    <c:when test="${asLine and not status.last}">
	                        <c:set var="suffix" value=", "/>
	                    </c:when>
	                    <c:otherwise>
	                        <c:set var="suffix" value=""/>
	                    </c:otherwise>
	                </c:choose>
	                <c:choose>
	                    <c:when test="${not empty relationshipName}">
	                        <syswf:component name="/core/impl/util/relationshipLinkRenderer" prefix="${status.count}" wrap="${wrap}">
	                            <syswf:param name="uuid" value="${linkHolder.uuid}" />
	                            <syswf:param name="caption" value="${linkHolder.name}" />
	                            <syswf:param name="timeSlice" value="${linkHolder.timeSlice}" />
	                            <syswf:param name="suffix" value="${suffix}" />
	                            <syswf:param name="relationshipName" value="${relationshipName}" />
	                            <syswf:param name="relationshipLabel" value="${relationshipLabel}"/>
	                            <syswf:param name="hasWritePermission" value="${hasWritePermission}"/>
	                            <syswf:param name="readOnly" value="${readOnly}"/>
	                            <syswf:param name="deleteOnly" value="${deleteOnly}"/>
	                            <syswf:param name="isInvalid" value="${isInvalid}"/>
	                            <syswf:param name="artifactTypeListForTableView" value="${artifactTypeListForTable}"/>
	                            <syswf:param name="compliant" value="${linkHolder.compliant}"/>
	                            <syswf:param name="hint" value="${linkHolder.hint}"/>
	                            <syswf:param name="invalidTableView" value="${invalidTableView}"/>
	                            <syswf:param name="tableViewOnly" value="${tableViewOnly}"/>
	                            <syswf:param name="shortcutArtifact" value="${artifact.name}"/>
	                            <syswf:param name="outGoing" value="${outGoing}"/>
	                            <syswf:param name="paths" value="${paths}"/>
	                            <syswf:param name="customRelationship" value="${customRelationship}"/>
	                            <syswf:param name="inverseRelationName" value="${inverseRelationName}"/>
	                            <syswf:param name="multipleRelation" value="${multipleRelation}"/>
	                            <syswf:param name="unresolved" value="${linkHolder.unresolved}"/>
	                            <syswf:param name="shortcutDefinition" value="${shortcutDefinition}"/>
	                            <syswf:param name="parentPrefix" value="${parentPrefix}"/>
	                            <syswf:param name="relationAttrBeans" value="${relationAttrBeans}"/>
	                            <syswf:param name="hasMajorAttr" value="${hasMajorAttr}"/>
								<syswf:param name="relationBean" value="${linkHolder.relation}" />
								<syswf:param name="shortcutContext" value="${shortcutContext}"/>
	                        </syswf:component>
	                    </c:when>
	                    <c:otherwise>
	                        <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="${status.count}" wrap="${wrap}">
	                            <syswf:param name="uuid" value="${linkHolder.uuid}" />
	                            <syswf:param name="caption" value="${linkHolder.name}" />
	                            <syswf:param name="timeSlice" value="${linkHolder.timeSlice}" />
	                            <syswf:param name="suffix" value="${suffix}" />
	                            <syswf:param name="customRelationship" value="${customRelationship}"/>
	                            <syswf:param name="relationAttrBeans" value="${relationAttrBeans}"/>
	                            <syswf:param name="hasMajorAttr" value="${hasMajorAttr}"/>
								<syswf:param name="relation" value="${linkHolder.relation}" />
	                        </syswf:component>
	                    </c:otherwise>
	                </c:choose>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <c:if test="${hiddenItems > 0}">
	        <fmt:message var="andMore" bundle="${relationshipmessages}" key="andMore">
	            <fmt:param value="${hiddenItems}"/>
	        </fmt:message>
	
	                <c:choose>
	                    <c:when test="${not tableViewOnly}">
	                        <a id="${prefix}moreOnTableView" href="javascript:void(0)" class="underline-link"
	                           onclick="javascript:showArtifactRelation('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', '${artifact.artifactDescriptor.sdmName}', '<syswf:out value="${artifactName}" context="HtmlJSText"/>', '${artifact._uuid}', '${relationshipName}', '${useType}', '${isValidUseType}', makeArtifactSelParams('${baseUrl}', ${artifactTypeListForTableView}, '${modifyEnabled}', '${deleteEnabled}','${invalidTableView}', '${not empty paths ? true : false}', '${outGoing}', '${impliedArtifactIdList}', '${inverseRelationName}', '${prefix}', '', '', '${relationSurveyId}', null, null, null, ${customColumns}, '${customDql}', '${onlyLinkLatest}'">
	                            <span>${andMore}</span>
	                        </a>
	                    </c:when>
	                    <c:otherwise>
	                        <a id="${prefix}moreOnTableView" href="javascript:void(0)" class="underline-link"
	                           onclick="javascript:showArtifactRelationInline('${relationWndTitle}', '${artifact.artifactDescriptor.sdmName}', '${artifactName}', '${artifact._uuid}', '${relationshipName}', '${useType}', '${isValidUseType}', makeArtifactSelParams('${baseUrl}', ${artifactTypeListForTableView}, '${modifyEnabled}', '${deleteEnabled}','${invalidTableView}', '${not empty paths ? true : false}', '${outGoing}', '${impliedArtifactIdList}', '${inverseRelationName}', '', '', '', '${relationSurveyId}', null, null, null, ${customColumns}, '${customDql}', '${onlyLinkLatest}'))">
	                            <span>${andMore}</span>
	                        </a>
	                    </c:otherwise>
	                </c:choose>
	
	    </c:if>
	   	<img id="${moreLinkId}" style="padding-left:4px;width:16px;height:13px;vertical-align:middle" src="<c:out value="${baseUrl}"/>/../design/base/skin410/img/viewArtifact/menu_launcher_small.png"/>
	</c:when>	
</c:choose>



<c:if test="${empty showDropMenu || not showDropMenu}" >
	<c:choose>
	    <c:when test="${(not empty relationshipName) and (empty this.artifactLinkHolders) and (modifyEnabled)}">
	        <ul class="rel-new-and-add-link">
                <c:if test="${empty notShowLinkNew or (notShowLinkNew eq 'false')}">
                    <li>
                        <syswf:component name="/core/relations/linkRelationshipToNewArtifact" prefix="${prefix}linkRelationshipToNewArtifact" wrap="false">
                            <syswf:param name="artifact" value="${artifact}"/>
                            <syswf:param name="relationshipName" value="${relationshipName}"/>
                            <syswf:param name="useType" value="${useType}"/>
                            <syswf:param name="text" value="${relationshipTypeNew}"/>
                            <syswf:param name="type" value="popup"/>
                            <syswf:param name="readOnly" value="${readOnly}"/>
                            <syswf:param name="deleteOnly" value="${deleteOnly}"/>
                            <syswf:param name="artifactTypes" value="${artifactTypes}"/>
                            <syswf:param name="customRelationship" value="${customRelationship}"/>
                            <syswf:param name="forceNewOutgoing" value="${forceNewOutgoing}"/>
                            <syswf:param name="relationSurveyId" value="${relationSurveyId}"/>
                            <syswf:param name="creationArtifactRelationListener" value="${creationArtifactRelationListener}"/>
                        </syswf:component>
                    </li>
                    <li class="comma">,</li>
                </c:if>
	            <li>
	                <syswf:component name="/core/relations/linkRelationshipToExistingArtifact" prefix="${prefix}linkRelationshipToExistingArtifact" wrap="false">
	                    <syswf:param name="artifact" value="${artifact}"/>
	                    <syswf:param name="relationshipName" value="${relationshipName}"/>
	                    <syswf:param name="useType" value="${useType}"/>
	                    <syswf:param name="text" value="${relationshipTypeAdd}"/>
	                    <syswf:param name="type" value="popup"/>
	                    <syswf:param name="readOnly" value="${readOnly}"/>
	                    <syswf:param name="deleteOnly" value="${deleteOnly}"/>
	                    <syswf:param name="artifactTypes" value="${artifactTypes}"/>
	                    <syswf:param name="customRelationship" value="${customRelationship}"/>
	                    <syswf:param name="forceNewOutgoing" value="${forceNewOutgoing}"/>
	                    <syswf:param name="relationSurveyId" value="${relationSurveyId}"/>
	                    <syswf:param name="linkExistingArtifactRelationListener" value="${linkExistingArtifactRelationListener}"/>
	                    <syswf:param name="domainIdsParam" value="${domainIdsParam}"/>
           				<syswf:param name="domainNamesParam" value="${domainNamesParam}"/>
           				<syswf:param name="domainTypesParam" value="${domainTypesParam}"/>
           				<syswf:param name="customDql" value="${customDql}"/>
           				<syswf:param name="relationWinTitle" value="${relationWinTitle}"/>
	                </syswf:component>
	            </li>
	        </ul>
	        <c:if test="${hideIfEmpty}">
	            <script>
	                if(typeof(HIDDEN_EDITORS)=='undefined') HIDDEN_EDITORS=new Array();
	                HIDDEN_EDITORS[HIDDEN_EDITORS.length]='${editorBlockID}';
	            </script>
	        </c:if>
	    </c:when>
	    <c:otherwise>&nbsp;</c:otherwise>
	</c:choose>
</c:if>