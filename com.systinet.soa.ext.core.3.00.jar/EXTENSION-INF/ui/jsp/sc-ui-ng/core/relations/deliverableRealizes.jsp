<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<fmt:message var="btClose" bundle="${relationshipmessages}" key="bt.close"/>
<fmt:message var="btSelect" bundle="${relationshipmessages}" key="bt.select"/>
<fmt:message var="btCancel" bundle="${relationshipmessages}" key="bt.cancel"/>
<%--
<fmt:message var="linkToNewTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToNew.tip"/>
--%>
<fmt:message var="linkToExistingTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToExisting.tip"/>
<fmt:message var="setTargetStageMenu" bundle="${relationshipmessages}" key="artifact.rel.table.setTargetStage.menu"/>
<fmt:message var="removeTip" bundle="${relationshipmessages}" key="artifact.rel.table.remove.tip"/>
<fmt:message var="emptyText" bundle="${relationshipmessages}" key="artifact.rel.table.emptyText"/>
<fmt:message var="titleConfirm" bundle="${relationshipmessages}" key="confirm.window.title"/>
<fmt:message var="msgConfirm" bundle="${relationshipmessages}" key="confirm.window.message.table"/>
<fmt:message var="btnLink" bundle="${relationshipmessages}" key="confirm.window.btn.link"/>
<fmt:message var="btnCancel" bundle="${relationshipmessages}" key="confirm.window.btn.cancel"/>
<fmt:message var="openInCatalog" bundle="${relationshipmessages}" key="open.in.catalog"/>
<fmt:message var="openInNavigator" bundle="${relationshipmessages}" key="open.in.navigator"/>
<fmt:message var="titleWarning" bundle="${relationshipmessages}" key="warning.window.title"/>
<fmt:message var="status_completed" bundle="${relationshipmessages}" key="completion.status.table.completed"/>
<fmt:message var="status_notCompleted" bundle="${relationshipmessages}" key="completion.status.table.notCompleted"/>
<fmt:message var="status_invalid" bundle="${relationshipmessages}" key="completion.status.table.invalid"/>
<fmt:message var="status_allItems" bundle="${relationshipmessages}" key="completion.status.table.allItems"/>
<fmt:message var="tooltip_invalid_transition" bundle="${relationshipmessages}" key="completion.status.table.tooltip.invalidTransition"/>
<fmt:message var="tooltip_no_lifecycle" bundle="${relationshipmessages}" key="completion.status.table.tooltip.noLifecycle"/>
<c:if test="${not empty finalStage and finalStage == false}"><br /></c:if>
<div class="Title">
<h3><span class="IconAlign">${title}</span></h3>
</div>
<div id="${prefix}_deliverableCont" class="deliverableCont"></div>
<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="DeliverableRelation"/>
  <syswf:param name="code">
	function setTargetStage(uuid, oldTargetStageId, targetStageId, relationName, targetUuid){
		return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().setTargetStage(uuid, oldTargetStageId, targetStageId, relationName, targetUuid);
	}	
    function getAllStages(uuid, currentStage) {
       return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().getAllStages(uuid, currentStage);
    }
    
    function setRelationAttribute(srcUuid, tarUuid, atrributeName, attributeValue) {
       return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().setRelationAttribute(srcUuid, tarUuid, '${relationshipName}', atrributeName, attributeValue);
    }
    
    function setRelationAttributes(srcUuid, atrributeNameValues) {
       return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().setRelationAttributes(srcUuid, '${relationshipName}', atrributeNameValues);
    }
  </syswf:param>
</syswf:component>

<syswf:control mode="script" caption="setTargetStageArtifacts" action="setTargetStageArtifacts"/>
<syswf:input id="${prefix}_targetStageName" name="targetStageName" mode="hidden" value="" />
<syswf:input id="${prefix}_targetStageVal" name="targetStageVal" mode="hidden" value="" />
<syswf:input id="${prefix}_targetArtifactUuids" name="targetArtifactUuids" mode="hidden" value="" />

<fmt:message var="selectionWndTitle" bundle="${relationshipmessages}" key="select.window.title">
	<fmt:param value="artifact"/>
	<fmt:param><syswf:out value="${artifact.name}" context="HtmlJSText"/></fmt:param>
</fmt:message>

<script type="text/javascript">
//<![CDATA[

    var localMsg2 = {linkToNewTip: '${linkToNewTip}', linkToExistingTip: '${linkToExistingTip}', removeTip: '${removeTip}', emptyText: '${emptyText}', 
    				titleConfirm: '${titleConfirm}', msgConfirm: '${msgConfirm}', btnLink: '${btnLink}', btnCancel: '${btnCancel}',
    				openInCatalog: '${openInCatalog}', openInNavigator: '${openInNavigator}', titleWarning: '${titleWarning}', setTargetStageMenu: '${setTargetStageMenu}'};
          
	function buildArtifactLink (uuid,type,name,embedded) {
		var link='href=\"'+ SERVER_URI+'/../../service-catalog/artifact/' + uuid + '\"';
        return link;
    }
	
	function initDeliverableInline(title, artifactSdmName, artifactName, uuid, relationName, inverseRelation, serverUrl, artifactTypes, allGovernanceStages, isDisplayTopBar, containerDiv, finalStage){	
		if (deliverableInlineTables == null){
			deliverableInlineTables = [];
		}
		var extraAttributes = [];
		<c:if test="${not empty extraAttributes}">
		    extraAttributes = ${extraAttributes};
		</c:if>
		
		var deliverableInlineTable = Ext4.create('EA.model.table.deliverable.DeliverableRelationTable',
		{
			localMsg: localMsg2,
			pageSize: ${this.pageSize},
			artifactSdmName: artifactSdmName,
			uuid: uuid,
			relationName: relationName,
			inverseRelation: inverseRelation,
			serverUrl: serverUrl,
			artifactTypes: artifactTypes,
			allGovernanceStages: allGovernanceStages,
			isDisplayTopBar: isDisplayTopBar,
			artifactName: artifactName,
			containerDiv : containerDiv,
			selectionWndTitle: '<syswf:out value="${selectionWndTitle}" context="HtmlJSText"/>',
			finalStage: finalStage,
			deliverableInlineTables: deliverableInlineTables,
			statusFilterData: [['', '${status_allItems}'],['C', '${status_completed}'], ['I', '${status_invalid}'],['N', '${status_notCompleted}']],
			nameRenderer:function (v, m, record)
			{
				var text="<a "+ buildArtifactLink(record.data.uuid,record.data.type,record.data.name)
						+" >" + Ext4.String.htmlEncode(record.data.name) + '</a>';
				return text;
			},
			completionStatusRenderer:function (v, m, record)
			{
				var status = (v == null || v == '') ? 'I': v.split("_")[0];
				var text = "";
                var tooltip = "";
				var color = 'HealthYellow'
				if ( status == 'I'){
					text = "${status_invalid}"
					color = 'HealthRed'
                    if(record.data['currentStageName'] == null || record.data['currentStageName'] == ''){
                        tooltip = 'title="${tooltip_no_lifecycle}"';
                    } else {
                        tooltip = 'title="${tooltip_invalid_transition}"';
                    }
				}else if ( status == 'N'){
					text = "${status_notCompleted}"
					color = 'HealthYellow'
				}else if ( status == 'C'){
					text = "${status_completed}"
					color = 'HealthGreen'
				}
				return '<div ' + tooltip + '><span class="UI Icon ' + color + ' ProjectStatus"></span>&nbsp;'+ text + '</div>';
			},
			extraAttributes: extraAttributes,
			readonly: ${not hasWritePermission},
			prefixComponent: '${prefix}'
		});
		
		deliverableInlineTables.push(deliverableInlineTable);
	}
	var deliverableInlineTables;
	
	function refreshInlineTables(){
		if (deliverableInlineTables!= null){
			for (var i=0; i< deliverableInlineTables.length ;i++){
				deliverableInlineTables[i].reloadData();
			}
		}	
	}
	
    Ext4.onReady(function(){
        Ext4.Loader.setPath('Ext4.app', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.portal', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.model', '${webResourcePath}/../../components/ui-ea/model');
        Ext4.Loader.setPath('EA.portlets', '${webResourcePath}/../../components/ui-ea/portlets');
		var artifactTypes = ${this.relatedArtifactTypesInJSON};
		var allGovernanceStages = ${this.allGovernanceStages};
		initDeliverableInline('A title', '${artifact._artifactSdmName}', '<syswf:out value="${artifact.name}" context="HtmlJSText"/>', 
		'${artifact._uuid}', '${inverseRelation}', '${relationshipName}', '${baseUrl}', artifactTypes , allGovernanceStages, ${hasWritePermission}, '${prefix}_deliverableCont'
		<c:if test="${not empty finalStage}">,${finalStage}</c:if>);
    });	
	
//]]>
</script>