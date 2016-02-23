<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.survey-filter>div{border:none}.survey-filter select{height:31px;border-color:#bbb}.survey-header{padding-top:40px;font-size: 28px}
.survey-header .EA-top-header{ font-family:'Open Sans','Helvetica Neue',Helvetica,Arial,sans-serif;font-weight: normal;font-size:28px}.survey-header .EA-sub-type.clickable{padding-top:20px;cursor:default}
</style>
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="scComponents"/>

<fmt:message var="show_1" key="browse.import_sources.link.show_1" bundle="${scComponents}"/>
<fmt:message var="show_2" key="browse.import_sources.link.show_2" bundle="${scComponents}"/>
<fmt:message var="hide" key="browse.import_sources.link.hide" bundle="${scComponents}"/>

<fmt:message var="ppm_title" key="preCheck.ppm.title" bundle="${messages}"/>
<fmt:message var="ppm_msg" key="preCheck.ppm.msg" bundle="${messages}"/>
<fmt:message var="excel_title" key="preCheck.excel.title" bundle="${messages}"/>
<fmt:message var="excel_msg" key="preCheck.excel.msg" bundle="${messages}"/>
<fmt:message var="ucmdb_title" key="preCheck.ucmdb.title" bundle="${messages}"/>
<fmt:message var="ucmdb_msg" key="preCheck.ucmdb.msg" bundle="${messages}"/>
<fmt:message var="csa_title" key="preCheck.csa.title" bundle="${messages}"/>
<fmt:message var="csa_msg" key="preCheck.csa.msg" bundle="${messages}"/>
<fmt:message var="btStartLabel" key="preCheck.startBt" bundle="${messages}"/>
<fmt:message var="notAdminMsg" key="preCheck.notAdmin" bundle="${messages}"/>
<fmt:message var="multipleMsg" key="preCheck.multipleApplicableType" bundle="${messages}"/>

<c:if test="${not empty this.artifactTypeDescription}">
     <fmt:message var="import_sources_guide" key="preCheck.import_sources.guide_P1" bundle="${messages}">
	  <fmt:param value="${applicableNames}"/>
	</fmt:message>
	<c:set var="extraFunc">
		<c:if test="${not empty tableId}">
			<%-- call doLayout for gridPanel to avoid it's  trimmed from the right --%>
			Ext.getCmp('${tableId}').doLayout();
		</c:if>
	</c:set>
	<div id ="artifact-type-description-selector" class="UI Text Description" style="margin-bottom:0px">
		<p>
			<c:out value="${this.artifactTypeDescription}"/>
			<span class="survey-import-artifact-toggler">
				<%--${applicableNames}--%> ${show_1}
				<a href="javascript:void(0)" onclick="$('.survey-import-artifact-toggler').toggle(); ${extraFunc}">${show_2}</a>
			</span>
			<span class="survey-import-artifact-toggler" onclick="$('.survey-import-artifact-toggler').toggle(); ${extraFunc}" style="display:none">
				<a href="javascript:void(0)" >${hide}</a>
			</span>
		</p> 
	</div>
	
	<div class="pad-btm survey-import-artifact-toggler" style="display:none;padding: 10px 25px 0 25px">
		<div class="import-info" class="pad-btm">${import_sources_guide}</div>
		<div class="survey-imp-box-cont">
            <div class="import-box">
                <div class="import-cont ms-excel">
                    <div class="import-title">${excel_title}</div>
                    <div class="pad-ver"><span><i class="fa fa-table fa-4x"></i></span></div>
                    <div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
                    <div class="import-inner">${excel_msg}</div>
                    <div><a target="_blank" class="btn btn-lg btn-labeled fa fa-arrow-right btn-danger" href="${webdataPath}/../../service-catalog/common/imports/csvImport?artifactType=${applicableType}">${btStartLabel}</a></div>
                </div>
            </div>
            <div class="import-box">
                <div class="import-cont csa">
                    <div class="import-title">${csa_title}</div>
                    <div class="pad-ver"><span><i class="fa fa-cloud fa-4x"></i></span></div>
                    <div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
                    <div class="import-inner">${csa_msg}</div>
                    <div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-primary" href="#" onclick="javascript:boxClick('csa');">${btStartLabel}</a></div>
                </div>
            </div>
			<div class="import-box">
				<div class="import-cont ppm">
					<div class="import-title">${ppm_title}</div>
					<div class="pad-ver"><span><i class="fa fa-users fa-4x"></i></span></div>
					<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
					<div class="import-inner">${ppm_msg}</div>
					<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-dark" href="#" onclick="javascript:boxClick('ppm');">${btStartLabel}</a></div>
				</div>
			</div>
			<div class="import-box">
				<div class="import-cont ucmdb">
					<div class="import-title">${ucmdb_title}</div>
					<div class="pad-ver"><span><i class="fa fa-server fa-4x"></i></span></div>
					<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
					<div class="import-inner">${ucmdb_msg}</div>
					<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-mint" href="#" onclick="javascript:boxClick('ucmdb');">${btStartLabel}</a></div>
				</div>
			</div>
		</div>
	</div>
	<syswf:component name="/newui/nifty" prefix="nifty_angular">
		<syswf:param name="styles" value="['/skinem/bootstrap/css/survey.css']"/>
	</syswf:component>
	<script type="text/javascript">
	//<![CDATA[
	
	function boxClick(type){// dup startSurveyArtifactSelection.jsp
		<c:choose>
			<c:when test="${notAdmin}">
				Ext4.MessageBox.alert('Warning', '${notAdminMsg}')
			</c:when>
			<c:otherwise>
            var targetUrl = '${webResourcePath}/../../../../service-catalog/artifact/';
            if (type == "ppm") {
                targetUrl = targetUrl + '${ppmUrl}';
            } else if (type == "csa") { 
                targetUrl = targetUrl + '${csaUrl}';
            } else {//ucmdb
                targetUrl = targetUrl + '${ucmdbUrl}';
            }
            // prefer admin tab
            targetUrl += (targetUrl.indexOf('?') > -1)? '&view=admin' : '?view=admin';
            window.open(targetUrl); // open in new window/tab
			</c:otherwise>
		</c:choose>
		
	}
	//]]>
	</script>
</c:if>