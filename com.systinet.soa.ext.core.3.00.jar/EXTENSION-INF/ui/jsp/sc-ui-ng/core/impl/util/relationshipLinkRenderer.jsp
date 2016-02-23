<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<c:if test="${empty hint}">
   <c:choose>
        <c:when test="${isInvalid}"><fmt:message var="hint" key="artifact.uncompliant.hint" bundle="${widgetMessages}" /></c:when>
        <c:otherwise><fmt:message var="hint" key="relationship.artifact.hint" bundle="${widgetMessages}" /></c:otherwise>
   </c:choose>
</c:if>
<c:set var="artifactName"><syswf:out value="${model.artifact.name}" context="HtmlBody"/></c:set>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="openInCatalog" bundle="${relationshipmessages}" key="open.in.catalog"/>
<fmt:message var="openInNavigator" bundle="${relationshipmessages}" key="open.in.navigator"/>
<fmt:message var="tableView" bundle="${relationshipmessages}" key="table.view.text"/>
<fmt:message var="relationWndTitle" bundle="${relationshipmessages}" key="relation.window.title">
	<fmt:param value="${relationshipLabel}"/>
	<fmt:param value="${artifactName}"/>
</fmt:message>
<fmt:message var="relAttrHeaderContent" bundle="${relationshipmessages}" key="relationship.attribute.header.content"/>

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

<%-- relation attributes: relationshipItemComponent -> simpleRelationWidget -> relationshipLinkRenderer --%>
<c:if test="${not empty relationAttrBeans && fn:length(relationAttrBeans) gt 0}">
 <c:if test="${not attributesInline}">
  <c:if test="${not hasMajorAttr}">
   <c:set var="relationAttrInlineContent"><%--Workaround to avoid extra space 
--%><c:forEach var="attr" items="${relationAttrBeans}" varStatus="status"><%--Workaround to avoid extra space 
    --%><c:if test="${not empty attr.mappedVal}"><c:if test="${not status.first}">, </c:if><span class="relation-attr-inline"><syswf:out context="HtmlBody" value="${attr.label}: ${attr.mappedVal}"/></span></c:if><%--Workaround to avoid extra space
--%></c:forEach>
   </c:set>
   <c:if test="${fn:startsWith(relationAttrInlineContent, ', ')}"><c:set var="relationAttrInlineContent">${fn:trim(fn:substring(relationAttrInlineContent, 2, fn:length(relationAttrInlineContent)))}</c:set></c:if>
   <c:if test="${not empty relationAttrInlineContent}"><c:set var="suffix">&nbsp;(${relationAttrInlineContent})${suffix}</c:set></c:if>
  </c:if>
  <c:if test="${hasMajorAttr}">
    <c:set var="relationAttrContent">
      <c:forEach var="attr" items="${relationAttrBeans}" varStatus="status"><%--
      --%><c:if test="${not empty attr.mappedVal}">${attr.label}: ${attr.mappedVal}<br/></c:if><%--
  --%></c:forEach>
    </c:set>
    <c:if test="${not empty relationAttrContent}"><c:set var="suffix"><span class="text-inline-info" data-qtip="<b>${relAttrHeaderContent}<span style='visibility: hidden;'>.</span></b><br/><br/>${relationAttrContent}<span style='visibility: hidden;'>.</span>" id="relAttrIconInfo_${uuid}" onclick="showRelAttrInfo('<syswf:out value="${relationAttrContent}" context="HtmlJSText"/>');"> </span>${suffix}</c:set></c:if>
  </c:if>
 </c:if>

 <c:if test="${attributesInline}">
   <c:set var="relationAttrInlineContent"><%--Workaround to avoid extra space 
--%><c:forEach var="attr" items="${relationAttrBeans}" varStatus="status"><%--Workaround to avoid extra space 
    --%><c:if test="${not empty attr.mappedVal}"><c:if test="${not status.first}">, </c:if><span class="relation-attr-inline"><syswf:out context="HtmlBody" value="${attr.label}: ${attr.mappedVal}"/></span></c:if><%--Workaround to avoid extra space
--%></c:forEach>
   </c:set>
   <c:if test="${fn:startsWith(relationAttrInlineContent, ', ')}"><c:set var="relationAttrInlineContent">${fn:trim(fn:substring(relationAttrInlineContent, 2, fn:length(relationAttrInlineContent)))}</c:set></c:if>
   <c:if test="${not empty relationAttrInlineContent}"><c:set var="suffix">&nbsp;(${relationAttrInlineContent})${suffix}</c:set></c:if>
 </c:if>
</c:if>

<c:choose>
    <c:when test="${not empty artifactTaskUri && not empty caption}">
        <c:set var="pathContentTip">
          <c:if test="${not empty paths}">
                <c:forEach var="path" items="${paths}">
                     <c:set var="isFirst" value="false"/>
                     <c:set var="isLast" value="false"/>
                     <c:set var="tooltipContent">
                         <c:forEach var="node" items="${path.nodes}" varStatus="status">
                             <a style="color: #0096d6;" href="${webdataPath}/../../service-catalog/artifact/${node.uuid}" class="underline-link" target="_blank"><c:out value="${node.name}"/></a><c:if test="${not status.last}"> &gt; </c:if>
                             <c:if test="${status.first && node.name eq (outGoing ? shortcutArtifact : caption)}">
                                 <c:set var="isFirst" value="true"/>
                             </c:if> 
                             <c:if test="${status.last && node.name eq (outGoing ? caption : shortcutArtifact)}">
                                 <c:set var="isLast" value="true"/>
                             </c:if> 
                         </c:forEach>
                     </c:set>
                     <c:if test="${isFirst && isLast}">
                         ${tooltipContent}<br/>
                     </c:if>
                     <c:set var="hasPath" value="${hasPath || (isFirst && isLast)}"/>
                 </c:forEach>
            </c:if>
        </c:set>
		<syswf:control mode="anchor" caption="${caption}" targetTask="${artifactTaskUri}" targetDepth="${depth}" id="artifact">
            <syswf:param name="view" value="${view}"/>
            <syswf:attribute name="id" value="${prefix}_relationLink"/>
            <c:if test="${not empty targetArtifactTabId}">
                <syswf:param name="artifactTabId" value="${targetArtifactTabId}"/>
            </c:if>
            <c:if test="${not empty revision}">
                <syswf:param name="revision" value="${revision}"/>
            </c:if>
            <c:if test="${not empty timeSlice}">
                <syswf:param name="timeSlice" value="${timeSlice}"/>
            </c:if>
            <%-- Shown when mouse cursor hovers over caption --%>
			<c:if test="${empty paths || !hasPath}">
				<syswf:attribute name="title">${hint}</syswf:attribute>
			</c:if>
            <c:choose>
                <c:when test="${not compliant}">
                    <syswf:attribute name="class" value="invalid-link"/>
                </c:when>
                <c:otherwise>
                    <syswf:attribute name="class" value="underline-link"/>
                </c:otherwise>         
            </c:choose>			
        </syswf:control><%--Workaround to avoid extra space between elements.

    --%><c:if test="${unresolved}">
            <a id="${prefix}_shortcutUnresolvedLink" class="shortcutUnresolvedLink" href="javascript:void(0);"></a>
            <span id="${parentPrefix}_shortcut-resolution" style="display:none"></span>
        </c:if><%--Workaround to avoid extra space between elements.
    --%>${suffix}
    
		
        <div class="x-hidden flyout-menu UI Dropdown" id="${prefix}_relationLink_content">
			<div class="DropdownContent">
				<div class="rel-dropdown-menu-item">
					<syswf:control mode="anchor" caption="${openInCatalog}" targetTask="${artifactTaskUri}" targetDepth="${depth}" id="${prefix}openInCatalog">
						<syswf:attribute name="target" value="_blank"/>
			            <syswf:param name="view" value="${view}"/>
			            <c:if test="${not empty targetArtifactTabId}">
			                <syswf:param name="artifactTabId" value="${targetArtifactTabId}"/>
			            </c:if>
			            <c:if test="${not empty revision}">
			                <syswf:param name="revision" value="${revision}"/>
			            </c:if>
			            <c:if test="${not empty timeSlice}">
			                <syswf:param name="timeSlice" value="${timeSlice}"/>
			            </c:if>
			            <syswf:attribute name="class" value="UI PageAction Create"/>
			        </syswf:control>
				</div>
				<div class="rel-dropdown-menu-item">
					<syswf:control mode="anchor" caption="${openInNavigator}" targetTask="/common/navigator" targetDepth="0" id="${prefix}openInNavigator">
						<syswf:attribute name="target" value="_blank"/>
						<syswf:param name="uuid" value="${uuid}"/>
						<syswf:param name="viewId" value="navigator"/>
						<syswf:attribute name="class" value="UI PageAction Navigator"/>
					</syswf:control>
				</div>
				<c:if test="${deleteEnabled}">
					<div class="rel-dropdown-menu-item">
						<syswf:component name="/core/relations/unlinkRelationship" prefix="${prefix}unlinkRelation">
							<syswf:param name="artifact" value="${artifact}" />
							<syswf:param name="relation" value="${relation}" />
                            <syswf:param name="inverseRelationName" value="${inverseRelationName}" />
							<syswf:param name="tabId" value="${tabId}"/>
							<syswf:param name="subTabId" value="${subTabId}"/>
							<syswf:param name="shortcutContext" value="${shortcutContext}"/>
	                    </syswf:component>
					</div>
				</c:if>
				<%--
				<c:if test="${artifactTypeListForTableView ne '[]' or isInvalid}">
				<c:if test="${multipleRelation}">
				<div class="rel-dropdown-menu-item">
					<c:choose>
						<c:when test="${not tableViewOnly}">
							<a id="${prefix}tableView" class="UI PageAction TableView" href="javascript:void(0)" onclick="javascript:showArtifactRelation('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', '${model.artifact.artifactDescriptor.sdmName}', '<syswf:out value="${artifactName}" context="HtmlJSText"/>', '${model.artifact._uuid}', '${relation}', '${baseUrl}', ${artifactTypeListForTableView}, '${modifyEnabled}', '${deleteEnabled}', '${invalidTableView}', '${not empty paths ? true : false}', '${outGoing}', '${impliedArtifactIdList}', '${inverseRelationName}', '${parentPrefix}')"><span>${tableView}</span></a>
						</c:when>
						<c:otherwise>
							<a id="${prefix}tableView" class="UI PageAction TableView" href="javascript:void(0)" onclick="javascript:showArtifactRelationInline('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', '${model.artifact.artifactDescriptor.sdmName}', '<syswf:out value="${artifactName}" context="HtmlJSText"/>', '${model.artifact._uuid}', '${relation}', '${baseUrl}', ${artifactTypeListForTableView}, '${modifyEnabled}', '${deleteEnabled}', '${invalidTableView}', '${not empty paths ? true : false}', '${outGoing}', '${impliedArtifactIdList}', '${inverseRelationName}', '${parentPrefix}')"><span>${tableView}</span></a>
						</c:otherwise>
					</c:choose>	
					
				</div>
				</c:if>
				</c:if>
				--%>
			</div>
		</div>
		<c:if test="${not empty paths}">
			<span class="x-hidden">&nbsp;
				<div id="${prefix}_relationLink_tooltip_content">
					${pathContentTip}
				</div>			
			</span>				
		</c:if>		
	    <script type="text/javascript">
		//<![CDATA[
			Ext4.require([
				'Ext4.tip.*'
			]);
			Ext4.onReady(function(){ 
			   Dropdown.init('${prefix}_relationLink', '${prefix}_relationLink_content', {align:'tl-bl',forceRefresh:true,behaviour:'contextmenu',defer:10,shadow:false});
			   <c:if test="${not empty paths && hasPath}">
				  Ext4.create('Ext4.tip.ToolTip',{
				    id: '${prefix}_relationLink_tooltip',
					target: '${prefix}_relationLink',
					cls:'contentbox-tooltip',
					maxWidth:800,
					autoHide : false,														
					html: null,																																		
					contentEl:'${prefix}_relationLink_tooltip_content',
					listeners:{
						mouseleave:{element:'el',fn: function(){Ext4.getCmp('${prefix}_relationLink_tooltip').hide();}}
					}														
				});
			   </c:if>
				Ext4.get('${prefix}_relationLink').on('mouseover', function(e){
					var els = Ext4.ComponentQuery.query('panel[cls=contentbox-tooltip]');
					for(i=0;i<els.length;i++){
						if(els[i].getId() != "${prefix}_relationLink_tooltip"){
							 Ext4.getCmp(els[i].getId()).hide();
						}
					}
				});
				Ext4.QuickTips.init();
				
				<c:if test="${unresolved}">
					Ext4.get('${prefix}_shortcutUnresolvedLink').on('click', function(e){
					    openUnresolvedDialog('${uuid}', '<syswf:out value="${caption}" context="HtmlJSText"/>', '${parentPrefix}', '${artifact.artifactDescriptor.sdmName}');
	                });
				</c:if>
		   });
            function showRelAttrInfo(relationAttributeInfo) {
                var itemTip = jQuery("#ext-quicktips-tip");
                if (itemTip != null) { 
                    itemTip.show();
                    itemTip.mousemove(function(kmouse){
                        itemTip.fadeOut(300);
                    });
                }
            };
		//]]>
		</script>
    </c:when>
</c:choose>
