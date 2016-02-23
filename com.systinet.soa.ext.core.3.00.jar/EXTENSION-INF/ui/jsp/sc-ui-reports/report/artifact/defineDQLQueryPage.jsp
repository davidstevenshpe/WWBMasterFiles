<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.report.ui.artifact.ReportMessages"	var="reportMessages" />


<fmt:message var="createReportTitle" key="createReport.title" bundle="${reportMessages}" />
<fmt:message var="editReportTitle" key="editReport.title" bundle="${reportMessages}" />
<fmt:message var="createReportSubTitle" key="createReport.subtitle" bundle="${reportMessages}" />
<fmt:message var="editReportSubTitle" key="editReport.subtitle" bundle="${reportMessages}" />
<fmt:message var="reportNameLabel" key="dqlpage.reportName.label" bundle="${reportMessages}" />
<fmt:message var="reportNameHint" key="dqlpage.reportName.hint" bundle="${reportMessages}" />
<fmt:message var="reportDescriptionLabel" key="dqlpage.reportDescription.label" bundle="${reportMessages}" />
<fmt:message var="reportDescriptionHint" key="dqlpage.reportDescription.hint" bundle="${reportMessages}" />
<fmt:message var="reportDQLLabel" key="dqlpage.reportDQL.label" bundle="${reportMessages}" />
<fmt:message var="reportDQLEmptyDescription" key="dqlpage.reportDQL.empty.description" bundle="${reportMessages}" />
<fmt:message var="reportDQLEmptyHint" key="dqlpage.reportDQL.empty.hint" bundle="${reportMessages}" />
<fmt:message var="reportDQLTestBtnCaption" key="dqlpage.testDQL.button.caption" bundle="${reportMessages}" />
<fmt:message var="reportDQLTestDescription" key="dqlpage.reportDQL.test.description" bundle="${reportMessages}" />
<fmt:message var="reportDQLErrorDescription" key="dqlpage.reportDQL.error.description" bundle="${reportMessages}" />
<fmt:message var="reportDQLValidDescription" key="dqlpage.reportDQL.valid.description" bundle="${reportMessages}" />
<fmt:message var="reportDQLPreviewTitle" key="dqlpage.report.preview.title" bundle="${reportMessages}" />
<fmt:message var="requiredCaption" key="required" bundle="${reportMessages}" />
<fmt:message var="requiredTitle" key="required.title" bundle="${reportMessages}" />

<c:if test="${wizardController.wizardContext.createMode}">
	<syswf:component name="/core/layout/header" prefix="header" wrap="false">
	    <syswf:param name="title" value="${createReportTitle}" />
	    <syswf:param name="subTitle" value="${createReportSubTitle}" />
	    <syswf:param name="subtitleClass" value="UI Text Description" />
	</syswf:component>
</c:if>
<c:if test="${not wizardController.wizardContext.createMode}">
	<syswf:component name="/core/layout/header" prefix="header" wrap="false">
	    <syswf:param name="title" value="${editReportTitle}" />
	    <syswf:param name="subTitle" value="${editReportSubTitle}" />
	    <syswf:param name="subtitleClass" value="UI Text Description" />
	</syswf:component>
</c:if>


<%-- wizard context implements SelectOne interface for artecat selection --%>
<syswf:block className="UI Block Common">
    <div class="Content">
		<table class="UI Table Properties">
			<col class="LabelCol" />
            <col/>
			<tr>
				<th><label class="UI Label Required Full" title="${reportNameHint}"><c:out value="${reportNameLabel}"></c:out></label>
				<sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
				</th>
				<td style="padding-right: 8px;"><syswf:input name="reportName" value="${wizardController.wizardContext}" property="reportName" hint="">
					<syswf:attribute name="style" value="width:100%"></syswf:attribute>
					<syswf:attribute name="class" value="x-form-text UI Input x-form-field x-form-focus"></syswf:attribute>
				</syswf:input>								
				</td>
			</tr>
			<tr>
				<th><label class="UI Label Inline" title="${reportDescriptionHint}"><c:out value="${reportDescriptionLabel}"></c:out></label></th>
				<td>
					<syswf:textArea id="${prefix}_richTextArea" name="description" value="${wizardController.wizardContext}" property="reportDescription" escapeXml="true">
						<syswf:attribute name="style" value="width:100%"></syswf:attribute>
						<syswf:attribute name="rows" value="3"></syswf:attribute>
					</syswf:textArea>
				</td>
			</tr>
		</table>
		<div class="Subtitle">
			<h4><c:out value="${reportDQLLabel}"></c:out></h4>
		</div>
		<div class="Offset Group">
			<c:choose>				
			
				<c:when test="${empty wizardController.wizardContext.dqlQuery}">
					<div class="Paragraph StatusWarning">
						<p><c:out value="${reportDQLEmptyDescription}" escapeXml="false"></c:out></p>			            
					</div>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${wizardController.wizardContext.validQuery}">
							<div class="Paragraph StatusValid">
								<p><c:out value="${reportDQLValidDescription}" escapeXml="false"></c:out> </p>
							</div>
						</c:when>
						<c:otherwise>
							<div class="Paragraph StatusFailed">
								<p><c:out value="${reportDQLErrorDescription} ${wizardController.wizardContext.invalidQueryMessage}" escapeXml="false"></c:out> </p>
							</div>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			
			<div class="OffsetTop">
				<syswf:textArea name="dqlQuery" value="${wizardController.wizardContext}" property="dqlQuery">
					<syswf:attribute name="style" value="width:100%;overflow:auto"></syswf:attribute>																	
					<syswf:attribute name="rows" value="10"></syswf:attribute>
				</syswf:textArea>
			</div>
			
			<div class="OffsetTop">
				<syswf:control mode="button" caption="${reportDQLTestBtnCaption}" hint="${reportDQLTestBtnCaption}" action="validateDQLQuery" >
					<syswf:attribute name="class" value="btn btn-primary" />
				</syswf:control>
			</div>
			
		</div>
		
		<div class="Subtitle">
			<h4><c:out value="${reportDQLPreviewTitle}"></c:out></h4>
		</div>
		
		<c:if test="${wizardController.wizardContext.validQuery}">
			<div class="OffsetTop">
				<syswf:component name="/core/table/tableInternal" prefix="artifactReportPreview" wrap="false">
				    <syswf:param name="table" value="${wizardController.wizardContext.tablePreview}" />
				    <syswf:param name="datasource" value="${datasource}" />
				    <syswf:param name="title" value="${reportDQLPreviewTitle}"/>
				    <syswf:param name="wrapCaption" value="${reportDQLPreviewTitle}"/>
				</syswf:component>
			</div>
		</c:if>
	</div>
</syswf:block>