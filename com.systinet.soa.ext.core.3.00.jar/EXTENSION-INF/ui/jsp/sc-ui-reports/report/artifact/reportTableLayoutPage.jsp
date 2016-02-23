<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.report.ui.artifact.ReportMessages"	var="reportMessages" />


<fmt:message var="createReportTitle" key="createReport.title" bundle="${reportMessages}" />
<fmt:message var="editReportTitle" key="editReport.title" bundle="${reportMessages}" />
<fmt:message var="createReportSubTitle" key="createReport.subtitle" bundle="${reportMessages}" />
<fmt:message var="editReportSubTitle" key="editReport.subtitle" bundle="${reportMessages}" />
<fmt:message var="reportNameLabel" key="dqlpage.reportName.label" bundle="${reportMessages}" />
<fmt:message var="reportDQLLabel" key="dqlpage.reportDQL.label" bundle="${reportMessages}" />
<fmt:message var="customizeColumnTitle" key="reportlayoutpage.customize.column.title" bundle="${reportMessages}" />
<fmt:message var="customizeColumnDescription" key="reportlayoutpage.customize.column.description" bundle="${reportMessages}" />
<fmt:message var="saveReportBtnCaption" key="reportlayoutpage.save.report.button.caption" bundle="${reportMessages}" />
<fmt:message var="editReportBtnCaption" key="reportlayoutpage.edit.report.button.caption" bundle="${reportMessages}" />
<fmt:message var="reportTablePreviewTitle" key="reportlayoutpage.report.preview.title" bundle="${reportMessages}" />
<fmt:message var="refreshBtnCaption" key="reportlayoutpage.refresh.table" bundle="${reportMessages}" />
<fmt:message var="refreshBtnHint" key="reportlayoutpage.refresh.table.hint" bundle="${reportMessages}" />

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
			<col class="ShortLabelCol" />
			<col />
			<tr>
				<td width="20%"><label class="UI Label Inline"><c:out value="${reportNameLabel}"></c:out></label></td>
				<c:choose>
					<c:when test="${wizardController.wizardContext.dataSourceBean}">
						<td style="padding-right: 8px;"><syswf:input name="reportName" value="${wizardController.wizardContext}" property="reportName">
							<syswf:attribute name="style" value="width:100%"></syswf:attribute>
							<syswf:attribute name="class" value="x-form-text UI Input x-form-field x-form-focus"></syswf:attribute>
						</syswf:input>								
						</td>
					</c:when>
					<c:otherwise>
						<td><label class="UI Label Inline"><c:out value="${wizardController.wizardContext.reportName}" /></label>							
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
		<br />
		<table class="UI Table Properties">
			<col class="ControlsCol" />
			<col />
			<tr>
				<td><label class="UI Label Inline"><c:out value="${customizeColumnTitle}"></c:out></label>
				</td>
				<td>
					<p class="UI Label Inline" style="font-size:11px; font-style:italic;padding-top:4px;">
					<c:out value="${customizeColumnDescription}"></c:out>
					</p>
					
				</td>
			</tr>
		</table>
		<div class="Offset Group">
			<syswf:component prefix="tableEditor" name="/core/impl/customization/editors/tableCustomizationEditor">
		        <syswf:param name="title" value="Table Columns:"/>
		        <syswf:param name="table" value="${tableEditor}"/>
		        <syswf:param name="showCreateSection" value="true"/>
	        </syswf:component>
		   <div class="OffsetTop">
				<syswf:control mode="button" caption="${refreshBtnCaption}" hint="${refreshBtnHint}" action="refresh" >
					<syswf:attribute name="class" value="btn btn-primary" />
				</syswf:control>
			</div>
		</div>
		
		<div class="Subtitle">
			<h4><c:out value="${reportTablePreviewTitle}"></c:out></h4>
		</div>
		
		<div class="OffsetTop">
			<syswf:component name="/core/table/tableInternal" prefix="artifactReportPreview2" wrap="false">
			    <syswf:param name="table" value="${wizardController.wizardContext.tablePreview}" />
			    <syswf:param name="datasource" value="${datasource}" />
			    <syswf:param name="title" value="${reportTablePreviewTitle}"/>
			    <syswf:param name="wrapCaption" value="${reportTablePreviewTitle}"/>
			</syswf:component>
		</div>
	</div>
</syswf:block>
