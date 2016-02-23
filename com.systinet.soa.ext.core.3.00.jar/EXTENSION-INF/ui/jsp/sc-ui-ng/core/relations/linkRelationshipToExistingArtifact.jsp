<%--
Component parameters

artifact - source artifact [Require]
relationshipName - relation name [Require]
class - class name for rendering link
text - text for link
type - ul(default) or pop-up window, create list of artifact types as ul or popup [Require]
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>



<c:set var="artifactName">
	<syswf:out value="${artifact.name}" context="HtmlBody"/>
</c:set>
<c:if test="${empty parentMenuId}">
<a id="${prefix}linkExisting" href="javascript:void(0)" class="${class} underline-link">
	<span>${text}</span>
</a>
</c:if>
	<script type="text/javascript">
	//<![CDATA[
		Ext4.onReady(function(){
			var artifactTypes = ${this.relatedArtifactTypesInJSON};
			var menu = new Ext4.menu.Menu({
				bodyCls: 'context-menu',
				shadow: false
			});
			var fnCallback = null;
			var prefix = "${prefix}";
			var ref = {};
			ref.count = 0;
			ref.wndTitle = {};
			<c:forEach var="contentItem" items="${this.artifactSdmNames}">
				<c:choose>
					<c:when test="${not empty relationWinTitle}">
						<c:set var="selectionWndTitle" value="${relationWinTitle}"/>
					</c:when>
					<c:otherwise>
						<fmt:message var="selectionWndTitle" bundle="${relationshipmessages}" key="select.window.title">
							<fmt:param value="${contentItem.second}"/>
							<fmt:param value="${artifactName}"/>
						</fmt:message>
					</c:otherwise>
				</c:choose>				
				ref.wndTitle['${contentItem.first}'] = '<syswf:out value="${selectionWndTitle}" context="HtmlJSText"/>';
			</c:forEach>
			ref.artifactUuid = '${artifact._uuid}';
			ref.relationshipName = '${relationshipName}';
			ref.useType = '${useType}';
			ref.forceNewOutgoing = '${forceNewOutgoing}';
			ref.relationSurveyId = '${relationSurveyId}';			
            <c:if test="${not empty linkExistingArtifactRelationListener}">
            	fnCallback = ${linkExistingArtifactRelationListener};
            </c:if>
	        buildLinkExistingMenu(menu, artifactTypes, prefix, ref, 
	        					{domainNamesParam: '${domainNamesParam}', domainIdsParam: '${domainIdsParam}', domainTypesParam: '${domainTypesParam}'},
	        					'${customDql}',
	        					fnCallback);
	<c:choose>
		<c:when test="${not empty parentMenuId}">
           	var parentMenu = Ext4.getCmp('${parentMenuId}');
           	if(parentMenu != null) {
   				if (ref.count > 1) {
   					parentMenu.add({cls:'context-menu-item icon LinkToExisting', text:'${text}', menu : menu});
   				} else {
   					var lastItem = ref.lastItem;
   					lastItem.text = '${text}';
   					lastItem.cls += ' icon LinkToExisting';
   					parentMenu.add(lastItem);
   				}
           	}
		</c:when>
		<c:otherwise>
		
	  	if(ref.count > 1) {
	  		Ext4.get('${prefix}linkExisting').on('click', function(e,t,o) {
	  			menu.showAt(e.getXY());
	  		});
	  	}else if(ref.count == 1) {
			Ext4.get('${prefix}linkExisting').on('click', function(e,t,o) {
				<c:choose>
	                <c:when test="${empty linkExistingArtifactRelationListener}">
		                showSelectionArtifact(ref.wndTitle[ref.lastItem.type], ref.artifactUuid, 
	                            ref.relationshipName, ref.useType, [{type: ref.lastItem.type}], null, 
	                            {forceNewOutgoing: ref.forceNewOutgoing, relationSurveyId: ref.relationSurveyId, 
		                		domainNamesParam: '${domainNamesParam}', 
		                		domainIdsParam: '${domainIdsParam}', 
		                		domainTypesParam: '${domainTypesParam}', 
		                		customDql: '${customDql}'});
	                </c:when>
	                <c:otherwise>
	                    var fnCallback = ${linkExistingArtifactRelationListener};
	                    var params = {
                                title: ref.wndTitle[ref.lastItem.type], 
                                uuid: ref.artifactUuid,
                                relationName: ref.relationshipName,
                                useType: ref.useType,
                                artifactTypes: [{type: ref.lastItem.type}],
                                artifactRelationTable: null,
                                extraParams: {forceNewOutgoing: ref.forceNewOutgoing, relationSurveyId: ref.relationSurveyId, 
                               				  domainNamesParam: '${domainNamesParam}', 
                               				  domainIdsParam: '${domainIdsParam}', 
                               				  domainTypesParam: '${domainTypesParam}', 
                               				  customDql: '${customDql}'}
                        };
                        fnCallback(params);
	                </c:otherwise>
	            </c:choose>
				if (true) {
					return;
				}
			});
	  	}
		</c:otherwise>
	</c:choose>

	}); 
//]]>
</script>