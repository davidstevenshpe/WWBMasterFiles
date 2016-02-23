<%-- 
Component parameters

artifact - source artifact that have relationship to others
relationshipName - relationship name between source artifact and target artifact(s) e.g: 'realizedBy'
artifactTypes - artifact types of target artifact, e.g: 'applicationComponentArtifact,infrastructureServiceArtifact'
useType - added to attribute useType of relationship

label - custom label when display as one line, 
		e.g: label = Reference Applications 
			Reference Applications: 	Link new , Link existing...

hintText - show help text for relationship editor

tableViewWndTitle - custom window title when click 'Table View'
relationWinTitle - custom window title when click 'Link Existing'

tableViewOnly - true will display as inline table 
	hideLabelOfTable - hide label of table 
	readOnly - true will hide all CRUD operations
	deleteOnly - only show Delete operation 
	isInvalid - if true, all rows will be shown as red color
	
isBidirectional - 

isSurveyPage - true if this relationship editor rendered in any kind of survey page
	relationSurveyId - only are available/used in doSurvey page, it represents the local storage id to persist operated artifacts (linked new/existing) in relationship editor  
	forceGetUuids - only are available/used in doSurvey page, it is boolean 
 

domainIdsParam - filter target artifacts by domain ids, e.g: 'csaServiceDesignsDomain,defaultDomain'
domainTypesParam - filter target artifacts by domain types, e.g: 'Architecture,Reference'
domainNamesParam - filter target artifacts by domain names, e.g: 'Top Level Domain,Default Domain'

onlyLinkLatest - true will remove all current targeted artifact base on relation name and link to newly selected artifact(s)

customDql - custom dql to filter artifacts from 'Link Existing'

customColumns - must be passed as a json array of columns in ExtJs grid/table. Note that 'name' column is always shown firstly
				available value as below
				[{
	               header:'Type',
	               dataIndex:'sdmName',
	               width:150,
	               sortable:true
	           }, {
	               header:'Version',
	               dataIndex:'version',
	               renderer:function (v) {
	                   if (v == null || v == '') return 'N/A'; else return v;
	               },
	               width:100,
	               sortable:true
	           }, {
	               header:'Stage',
	               dataIndex:'currentStage',
	               renderer:function (v) {
	                   if (v == null) return ''; else return v;
	               },
	               width:100,
	               sortable:true
	           }, {
	               header:'Owner',
	               dataIndex:'owner',
	               hidden:true,
	               width:150,
	               sortable:true
	           }, {
	               header:'Domain',
	               dataIndex:'domain',
	               hidden:true,
	               width:150,
	               sortable:true
	           }]
 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="relationshipTypeLinkNew" bundle="${relationshipmessages}" key="relationship.type.link.new"/>
<fmt:message var="relationshipTypeLinkExisting" bundle="${relationshipmessages}" key="relationship.type.link.existing"/>
<fmt:message var="tableView" bundle="${relationshipmessages}" key="table.view.text"/>

<c:set var="uniqueId">
	<%= java.util.UUID.randomUUID().toString() %>
</c:set>

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
        <c:when test="${isInvalid}">${filterArtifactTypes}</c:when>
        <c:otherwise><c:forEach var="item" items="${this.relatedArtifactTypes}" varStatus="status"><c:if test="${empty item.hidden or item.hidden eq 'false'}">${item.type}<c:if test="${not status.last}">,</c:if></c:if></c:forEach></c:otherwise>
    </c:choose>
</c:set>
<c:if test="${not empty descriptor}">
<c:set var="artifactName"><syswf:out value="${artifact.name}" context="HtmlBody"/></c:set>

<fmt:message var="relationWndTitle" bundle="${relationshipmessages}" key="relation.window.title">
    <fmt:param value="${descriptor.label}"/>
    <fmt:param value="${artifactName}"/>
</fmt:message>

<c:choose>
	<c:when test="${not empty relationWinTitle}">
		<c:set var="selectionWndTitle" value="${relationWinTitle}"/>
	</c:when>
	<c:otherwise>
		<fmt:message var="selectionWndTitle" bundle="${relationshipmessages}" key="select.window.title">
		    <fmt:param value="artifact"/>
		    <fmt:param value="${artifactName}"/>
		</fmt:message>
	</c:otherwise>
</c:choose>

<c:if test="${empty customColumns}">
	<c:set var="customColumns" value="null"/>
</c:if>

<c:set var="artifactTypeListForTableView">
    [<c:forEach var="item" items="${this.relatedArtifactTypes}" varStatus="status">
    {
    	type:'${item.type}', 
    	label:'${item.label}', 
   		hidden: ${item.hidden}, 
   		canCreate: ${item.canCreate}, 
   		callback: function(){${prefix}${item.type}${status.index}func()}, 
   		titleWnd: '<syswf:out value="${selectionWndTitle}" context="HtmlJSText"/>'
	}
    <c:if test="${not status.last}">,</c:if>
</c:forEach>]
</c:set>


<c:set var="extraAttributes">
  [<c:forEach var="attr" items="${relationAttrBeans}" varStatus="status">
  {"id":"${attr.mappedTo}", "label":"${attr.label}", "main": "${attr.major}", "defaultValue": "${attr.mappedVal}", "type": "string"}
  <c:if test="${not status.last}">,</c:if>
  </c:forEach>]
</c:set>

<c:forEach var="item" items="${this.relatedArtifactTypes}" varStatus="status">
    <c:if test="${item.type == false and item.abstractType == false}">
        <syswf:control id="${prefix}${item.type}${status.index}id" mode="script" caption="${prefix}${item.type}${status.index}func" targetTask="/${viewId}/newArtifact">
            <syswf:param name="sdmName" value="${item.type}"/>
            <syswf:param name="creationListener" value="${linkToNewRelationListener}"/>
        </syswf:control>
    </c:if>
</c:forEach>

<c:if test="${not empty hintText}">
	<div class="help-text">${hintText}</div>
</c:if>

<c:choose>
    <c:when test="${tableViewOnly}">
    	<c:choose>
    		<c:when test="${not empty hideLabelOfTable and hideLabelOfTable eq true}">
    			<%-- hide label of table --%>
    		</c:when>
    		<c:otherwise>
    			<div class="Title">
		            <h3><span class="IconAlign">
		               <c:choose>
		                   <c:when test="${not empty labelUI}">${labelUI}</c:when>
		                   <c:otherwise>${descriptor.label}</c:otherwise>
		               </c:choose>
		             </span></h3>
		        </div>
    		</c:otherwise>
    	</c:choose>
        <div id="tableview_${descriptor.property.name}_${uniqueId}">

        </div>
        <script>
            Ext4.onReady(function(){
            	showArtifactRelationInline('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', '${artifact.artifactDescriptor.sdmName}', 
            			'${artifactName}', '${artifact._uuid}', '${descriptor.property.name}', '${useType}', '${isValidUseType}', 
            			makeArtifactSelParams('${baseUrl}', ${artifactTypeListForTableView}, '${modifyEnabled}', 
            				                  '${deleteEnabled}','${invalidTableView}', 'false', 'false', '', '${inverseRelationName}', 
            				                  '', '${isInvalid}', ${extraAttributes}, '${relationSurveyId}', null, null, null, ${customColumns}, '${customDql}', false), '${uniqueId}', '${onlyLinkLatest}');
            });
        </script>
        <br/>
    </c:when>
    <c:otherwise>
        <c:set var="hideStyle"><c:if test="${hideIfEmpty}">display:none;</c:if></c:set>
        <div id="lineRelationshipEditor_${prefix}" style="${hideStyle}">
            <c:choose>
                <c:when test="${not empty this.relatedArtifactTypes}">
                    <table class="UI Table Properties">
                        <colgroup>
                            <col class="LabelCol">
                            <col>
                        </colgroup>
                        <tbody>
                        <c:set var="output">
                            <%-- descriptor.component: simpleRelationWidget  --%>
                            <syswf:component name="${descriptor.component}" prefix="${prefix}${descriptor.id}" wrapIfEmpty="false">
                                <syswf:param name="model" value="${descriptor.model}"/>
                                <syswf:param name="mode" value="${descriptor.displayType}"/>
                                <syswf:param name="error" value="${descriptor.model.errorMessage}"/>
                                <syswf:param name="artifact" value="${artifact}"/>
                                <syswf:param name="relationshipLabel" value="${descriptor.label}"/>
                                <syswf:param name="hasWritePermission" value="${hasWritePermission}"/>
                                <syswf:param name="readOnly" value="${readOnly}"/>
                                <syswf:param name="deleteOnly" value="${deleteOnly}"/>
                                <syswf:param name="isInvalid" value="${isInvalid}"/>
                                <syswf:param name="invalidTableView" value="${invalidTableView}"/>
                                <syswf:param name="artifactTypeListForTableView" value="${artifactTypeListForTableView}"/>
                                <syswf:param name="tableViewOnly" value="${tableViewOnly}"/>
                                <syswf:paramSet value="${descriptor.params}"/>
                                <syswf:param name="artifactTypes" value="${artifactTypes}"/>
                                <syswf:param name="inverseRelationName" value="${inverseRelationName}"/>
                                <syswf:param name="moreLinkId" value="${prefix}_leftClickMenu_${descriptor.property.name}"/>
                                <syswf:param name="customRelationship" value="${customRelationship}"/>
                                <syswf:param name="forceNewOutgoing" value="${forceNewOutgoing}"/>
                                <syswf:param name="hideIfEmpty" value="${hideIfEmpty}"/>
                                <syswf:param name="editorBlockID" value="lineRelationshipEditor_${prefix}"/>
                                <syswf:param name="relationAttrBeans" value="${relationAttrBeans}"/>
                                <syswf:param name="hasMajorAttr" value="${hasMajorAttr}"/>
                                <syswf:param name="useType" value="${useType}"/>
                                <syswf:param name="isValidUseType" value="${isValidUseType}"/>
                                <syswf:param name="relationSurveyId" value="${relationSurveyId}"/>
                                <syswf:param name="notShowLinkNew" value="${notShowLinkNew}"/>
                                <syswf:param name="domainIdsParam" value="${domainIdsParam}"/>
	            				<syswf:param name="domainNamesParam" value="${domainNamesParam}"/>
	            				<syswf:param name="domainTypesParam" value="${domainTypesParam}"/>
	            				<syswf:param name="customColumns" value="${customColumns}"/>	            				
	            				<syswf:param name="customDql" value="${customDql}"/>
	            				<syswf:param name="relationWinTitle" value="${relationWinTitle}"/>
                            </syswf:component>
                        </c:set>
                        <tr id="${descriptor.property.name}">
                            <th>
                                <c:set var="propertyLabel">
                                    <c:choose>
                                        <c:when test="${not empty labelUI}">${labelUI}</c:when>
                                        <c:otherwise>${descriptor.label}</c:otherwise>
                                    </c:choose>
                                </c:set>
                                <label class="UI Label Inline" id="${prefix}_label_${descriptor.property.name}">
                                    <c:out value="${propertyLabel}"/>:
                                </label>
                            </th>
                            <td>
				                <span class="IconAlign" id="relationship_${descriptor.property.name}_${uniqueId}">
				                    <c:out value="${output}" escapeXml="false" />
				                </span>

                                <c:if test="${not empty descriptor.model.errorMessage}">
                                    <em class="x-form-invalid-msg UI Invalid">
                                        <span><c:out value="${descriptor.model.errorMessage}"/></span>
                                    </em>
                                </c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <c:if test = "${hasHiddenArtifact or isInvalid}" >
                        <table class="UI Table Properties">
                            <colgroup>
                                <col class="LabelCol">
                                <col>
                            </colgroup>
                            <tbody>
                            <c:set var="output">
                                <%-- descriptor.component: simpleRelationWidget  --%>
                                <syswf:component name="${descriptor.component}" prefix="${prefix}${descriptor.id}" wrapIfEmpty="false">
                                    <syswf:param name="model" value="${descriptor.model}"/>
                                    <syswf:param name="mode" value="${descriptor.displayType}"/>
                                    <syswf:param name="error" value="${descriptor.model.errorMessage}"/>
                                    <syswf:param name="artifact" value="${artifact}"/>
                                    <syswf:param name="relationshipLabel" value="${descriptor.label}"/>
                                    <syswf:param name="hasWritePermission" value="${hasWritePermission}"/>
                                    <syswf:param name="readOnly" value="${readOnly}"/>
                                    <syswf:param name="deleteOnly" value="${deleteOnly}"/>
                                    <syswf:param name="isInvalid" value="${isInvalid}"/>
                                    <syswf:param name="artifactTypeListForTableView" value="${artifactTypeListForTableView}"/>
                                    <syswf:param name="tableViewOnly" value="${tableViewOnly}"/>
                                    <syswf:paramSet value="${descriptor.params}"/>
                                    <syswf:param name="artifactTypes" value="${invalidTableView}"/>
                                    <syswf:param name="showDropMenu" value="true"/>
                                    <syswf:param name="moreLinkId" value="${prefix}_leftClickMenu_${descriptor.property.name}"/>
                                    <syswf:param name="customRelationship" value="${customRelationship}"/>
                                    <syswf:param name="forceNewOutgoing" value="${forceNewOutgoing}"/>
                                    <syswf:param name="relationAttrBeans" value="${relationAttrBeans}"/>
                                    <syswf:param name="hasMajorAttr" value="${hasMajorAttr}"/>
                                    <syswf:param name="useType" value="${useType}"/>
                                    <syswf:param name="isValidUseType" value="${isValidUseType}"/>
                                    <syswf:param name="notShowLinkNew" value="${notShowLinkNew}"/>
                                </syswf:component>
                            </c:set>
                            <tr >
                                <th>
                                    <c:set var="propertyLabel">
                                        <c:choose>
                                            <c:when test="${not empty labelUI}">${labelUI}</c:when>
                                            <c:otherwise>${descriptor.label}</c:otherwise>
                                        </c:choose>
                                    </c:set>
                                    <label class="UI Label Inline">
                                        <c:out value="${propertyLabel}"/>:
                                    </label>
                                </th>
                                <td>
					                <span class="IconAlign" id="relationship_${descriptor.property.name}_${uniqueId}">
					                    <c:out value="${output}" escapeXml="false" />
					                </span>

                                    <c:if test="${not empty descriptor.model.errorMessage}">
                                        <em class="x-form-invalid-msg UI Invalid">
                                            <span><c:out value="${descriptor.model.errorMessage}"/></span>
                                        </em>
                                    </c:if>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>

    </c:otherwise>
</c:choose>


<div id="tableview_${descriptor.property.name}_${uniqueId}">

</div>
<c:set var="tableViewListener">
	var artSelParams = makeArtifactSelParams('${baseUrl}', ${artifactTypeListForTableView}, '${modifyEnabled}', '${deleteEnabled}', 
                                               '${invalidTableView}', 'false', 'false', '', '${inverseRelationName}', '', 
                                               '${isInvalid}', ${extraAttributes}, '${relationSurveyId}', 
                                               '${domainIdsParam}', '${domainTypesParam}', '${domainNamesParam}', 
                                                ${customColumns},
                                               '${customDql}',
                                               '${onlyLinkLatest}');
	<c:choose>
		<c:when test="${not tableViewOnly}">
		<c:if test="${not empty tableViewWndTitle}">
			<c:set var="relationWndTitle" value="${tableViewWndTitle}"/>
		</c:if>
	    showArtifactRelation('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', '${artifact.artifactDescriptor.sdmName}', 
	                         '<syswf:out value="${artifactName}" context="HtmlJSText"/>', '${artifact._uuid}', '${descriptor.property.name}', '${useType}', '${isValidUseType}',
	                         artSelParams, '${uniqueId}', '${notShowLinkNew}');
		</c:when>
		<c:otherwise>
	    showArtifactRelationInline('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', '${artifact.artifactDescriptor.sdmName}', 
	                               '${artifactName}', '${artifact._uuid}', '${descriptor.property.name}', '${useType}', '${isValidUseType}',
	                               artSelParams, '${uniqueId}', '${notShowLinkNew}');
		</c:otherwise>
	</c:choose>
</c:set>
<script type="text/javascript">
    //<![CDATA[
    Ext4.onReady(function(){
    	<c:if test="${isSurveyPage}">
	    	// to store relation artifact uuids in local storage
	    	try {
	    		setSurveyArtifactUuidsStorage('${relationSurveyId}', '${relationArtifactUuids}');
	    	} catch (e) {
	    		console.log(e);
	    	}
    	</c:if>
    	
        var contextMenuLink = Ext4.get('${prefix}_leftClickMenu_${descriptor.property.name}');
        if(contextMenuLink != null) {
            var menu = new Ext4.menu.Menu({
                bodyCls: 'context-menu',
    			shadow: false,
                id: '${prefix}_leftClickMenu_${descriptor.property.name}_menu'
                <c:if test="${isSurveyPage eq true}">
                <%--Relationship Editor in doSurvey page: menu component should be pre-rendered to static component to avoid layout issue--%>
                ,renderTo: Ext4.getBody()
                </c:if>
            });
            
            contextMenuLink.on('click', function(e){
            <c:choose>
            	<%-- If readOnly is true, no need to show 'Table View' menu item anymore --%>
            	<c:when test="${readOnly eq true}">
            		${tableViewListener}
            	</c:when>
            	<c:otherwise>
	            	if(!menu.isVisible()) {
	                    menu.showAt(e.getXY());
	                }
            	</c:otherwise>
            </c:choose>
                
            });
        }
    });
    //]]>
</script>
<c:if test="${modifyEnabled}">
    <c:if test="${empty notShowLinkNew or (notShowLinkNew eq 'false')}">
        <syswf:component name="/core/relations/linkRelationshipToNewArtifact" prefix="${prefix}linkRelationshipToNewArtifact">
            <syswf:param name="parentMenuId" value="${prefix}_leftClickMenu_${descriptor.property.name}_menu"/>
            <syswf:param name="artifact" value="${artifact}"/>
            <syswf:param name="relationshipName" value="${relationshipName}"/>
            <syswf:param name="class" value="UI PageAction LinkToNew"/>
            <syswf:param name="text" value="${relationshipTypeLinkNew}"/>
            <syswf:param name="type" value="ul"/>
            <syswf:param name="artifactTypes" value="${artifactTypes}"/>
            <syswf:param name="customRelationship" value="${customRelationship}"/>
            <syswf:param name="forceNewOutgoing" value="${forceNewOutgoing}"/>
            <syswf:param name="useType" value="${useType}"/>
        </syswf:component>
    </c:if>
    <syswf:component name="/core/relations/linkRelationshipToExistingArtifact" prefix="${prefix}linkRelationshipToExistingArtifact">
        <syswf:param name="parentMenuId" value="${prefix}_leftClickMenu_${descriptor.property.name}_menu"/>
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="relationshipName" value="${relationshipName}"/>
        <syswf:param name="class" value="UI PageAction LinkToExisting"/>
        <syswf:param name="text" value="${relationshipTypeLinkExisting}"/>
        <syswf:param name="type" value="ul"/>
        <syswf:param name="artifactTypes" value="${artifactTypes}"/>
        <syswf:param name="customRelationship" value="${customRelationship}"/>
        <syswf:param name="useType" value="${useType}"/>
    </syswf:component>
</c:if>
</c:if>
<script type="text/javascript">
    //<![CDATA[
    Ext4.onReady(function(){
    	<c:if test="${not notShowTableViewMenu}" >
			var menu = Ext4.getCmp('${prefix}_leftClickMenu_${descriptor.property.name}_menu');
			if(menu != null) {
				menu.add({
					cls: 'context-menu-item icon TableView',
					text:'${tableView}',
					listeners: { 
						'click': function() {
							${tableViewListener}
						}
					}
				});
			}
		</c:if>
    });
	
    //]]>
</script>
