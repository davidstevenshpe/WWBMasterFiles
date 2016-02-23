<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="message"/>
	<fmt:message var="historyLabel" key="history.label" bundle="${message}"/>
	<fmt:message var="historyDesc" key="history.description" bundle="${message}"/>
	<fmt:message var="historyTableEmpty" key="history.table.empty" bundle="${message}"/>
	<fmt:message var="historyDupWarning" key="history.duplicate.warning" bundle="${message}"/>
	<fmt:message var="historyNotSet" key="history.not.set" bundle="${message}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
	<fmt:message var="btClose" bundle="${relationshipmessages}" key="bt.close"/>
	<fmt:message var="btCancel" bundle="${relationshipmessages}" key="bt.cancel"/>
	<fmt:message var="btSelect" bundle="${relationshipmessages}" key="bt.select"/>	
	<fmt:message var="linkToExistingTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToExisting.tip"/>
	<fmt:message var="removeTip" bundle="${relationshipmessages}" key="artifact.rel.table.remove.tip"/>	
	<fmt:message var="titleConfirm" bundle="${relationshipmessages}" key="confirm.window.title"/>
	<fmt:message var="msgConfirm" bundle="${relationshipmessages}" key="confirm.window.message.table"/>	
	<fmt:message var="titleWarning" bundle="${relationshipmessages}" key="warning.window.title"/>
	<fmt:message var="btnLink" bundle="${relationshipmessages}" key="confirm.window.btn.link"/>
	<fmt:message var="btnCancel" bundle="${relationshipmessages}" key="confirm.window.btn.cancel"/>
	<fmt:message var="selectWindowTitle" bundle="${relationshipmessages}" key="financial.profile.select.window.title"/>
	<fmt:message var="sameFiscalPeriodWarning" bundle="${relationshipmessages}" key="financial.profile.same.fiscal.period.exist.warning"/>
	
<syswf:component name="/core/relations/selectArtifacts" prefix="${prefix}ArtifactSelection"/>

<div class="Title">
	<h3><span>
		<c:out value="${historyLabel}"/>
	</span></h3>
</div>
<i>
	<c:out value="${historyDesc}"/>
</i>
<br><br>
<div id="${prefix}warningDuplicatedFiscalPeriod" class="Message Warning Duplicate FiscalPeriod"></div>
<div id="tableview_${relationshipName}"></div>

<script>
//<![CDATA[
    Ext4.onReady(function(){
 	            
        var localMsg = {linkToExistingTip: '${linkToExistingTip}', removeTip: '${removeTip}', btnLink: '${btnLink}', btnCancel: '${btnCancel}',
                titleConfirm: '${titleConfirm}', msgConfirm: '${msgConfirm}', btSelect: '${btSelect}', btCancel: '${btCancel}',
                titleWarning: '${titleWarning}', emptyText: '${historyTableEmpty}', selectWindowTitle: '${selectWindowTitle}', 
                sameFiscalPeriodWarning: '${sameFiscalPeriodWarning}', historyDupWarning: '${historyDupWarning}', historyNotSet: '${historyNotSet}'};
        
        var properties = [];
	<c:if test="${not empty properties}">
		properties = ${properties};
        function buildFinancialProfileHistoryTable(uuid, artifactName, artifactSdmName, relationName, artifactType, modifyEnabled, deleteEnabled, autoHeight){
            
        	var historyTable = Ext4.create('EA.model.table.financialProfile.FinancialProfileTable',
                    {
		            	localMsg: localMsg,
		                pageSize: ${this.pageSize},
		                currentFiscalPeriod: '${this.currentFiscalPeriod}',
		                fiscalPeriods: ${this.fiscalPeriods},
		                uuid: uuid,
		                relationName: relationName,
		                artifactName: artifactName,
		                artifactSdmName: artifactSdmName,
		                artifactType: artifactType,
		                deleteEnabled: deleteEnabled,
		                modifyEnabled: modifyEnabled,
		                autoHeight: autoHeight,
		                properties: properties,
		                warningDiv: '${prefix}warningDuplicatedFiscalPeriod'
                    });        	
            return historyTable;
        }
        var tableDiv = document.getElementById ("tableview_${relationshipName}");
        var financialProfileHistoryTable = buildFinancialProfileHistoryTable('${artifact._uuid}', '<syswf:out value="${artifact.name}" context="HtmlJSText"/>', '${artifact._artifactSdmName}', '${relationshipName}', '${artifactType}', true, true, true);
        financialProfileHistoryTable.render(tableDiv);
    </c:if>
        
    });
  //]]>    
</script>