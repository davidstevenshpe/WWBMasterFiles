<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="linkToNewTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToNew.tip"/>
<fmt:message var="linkToExistingTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToExisting.tip"/>
<fmt:message var="removeTip" bundle="${relationshipmessages}" key="artifact.rel.table.remove.tip"/>
<fmt:message var="emptyText" bundle="${relationshipmessages}" key="artifact.rel.table.emptyText"/>
<fmt:message var="titleConfirm" bundle="${relationshipmessages}" key="confirm.window.title"/>
<fmt:message var="msgConfirm" bundle="${relationshipmessages}" key="confirm.window.message.table"/>
<fmt:message var="btnLink" bundle="${relationshipmessages}" key="confirm.window.btn.link"/>
<fmt:message var="btnCancel" bundle="${relationshipmessages}" key="confirm.window.btn.cancel"/>
<fmt:message var="openInCatalog" bundle="${relationshipmessages}" key="open.in.catalog"/>
<fmt:message var="openInNavigator" bundle="${relationshipmessages}" key="open.in.navigator"/>
<fmt:message var="titleWarning" bundle="${relationshipmessages}" key="warning.window.title"/>
<div id="${prefix}-policyReportComponent">
</div>
<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
    var localMsg = {linkToNewTip: '${linkToNewTip}', linkToExistingTip: '${linkToExistingTip}', removeTip: '${removeTip}', emptyText: '${emptyText}',
            titleConfirm: '${titleConfirm}', msgConfirm: '${msgConfirm}', btnLink: '${btnLink}', btnCancel: '${btnCancel}',
            openInCatalog: '${openInCatalog}', openInNavigator: '${openInNavigator}', titleWarning: '${titleWarning}'};
	
	Ext4.create('EA.model.table.report.ReportRelationTable',
            {
				renderTo:'${prefix}-policyReportComponent',
                artifactSdmName: '${artifact._artifactSdmName}',
                localMsg:localMsg,
                uuid: '${artifact._uuid}',
                relationName: 'associatedPolicyReports',
                serverUrl: SERVER_URI,
                artifactTypes: [{type:'hpsoaPolicyReportArtifact', canCreate: false, titleWnd : 'Policy Reports'}],
                modifyEnabled: true,
                deleteEnabled: true,
                artifactName: '<syswf:out value="${artifact.name}" context="HtmlJSText"/>',
                artifactTypesListString: null,
                autoHeight: true,
                shortcutEnabled: false,
                outGoing: true,
                inverseRelationName: null
            });
});

//]]>
</script>