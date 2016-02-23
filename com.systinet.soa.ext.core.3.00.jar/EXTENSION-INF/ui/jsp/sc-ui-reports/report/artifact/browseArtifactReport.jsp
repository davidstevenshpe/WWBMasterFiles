<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%--
REVIEW (Danh, 2010-06-22):
- Do not use inline CSS
- To show delete popup dialog with changed content:
  + reuse component /core/impl/util/dialog for confirmation dialog
  + reference user-interface/ui-lifecycle/src/main/ext/ui/jsp/new-ui-lifecycle/admin/visualization/tasksSection.jsp how to change parameter for 
    popup dialog. 
 --%>
<fmt:setBundle basename="com.hp.systinet.report.ui.artifact.ReportMessages"	var="reportMessages" />

<fmt:message var="browseTitle" key="browse.title" bundle="${reportMessages}" />
<fmt:message var="browseSubTitle" key="browse.subTitle" bundle="${reportMessages}" />


<%-- Actions --%>
<syswf:control id="deleteReport" mode="script" caption="${prefix}deleteReport" action="deleteReport" affects="." loadingMask="true" />
<syswf:control id="cloneReport" mode="script" caption="${prefix}cloneReport" action="cloneReport" affects="." loadingMask="true" />

<syswf:input id="selectedReport" name="selectedReport" value="" mode="hidden"/>


<%-- Delete/Clone confirm dialog --%>
<syswf:component prefix="reportDeleteDialog" name="/core/impl/util/dialog">
    <syswf:param name="handler" value="dummy" />
    <syswf:param name="heading"></syswf:param>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    function storeReportId(reportId) {
        Ext.get('selectedReport').dom.value = reportId;
    }

//]]>
</script>

<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:component name="/core/layout/header" prefix="header"
				    wrap="false">
				    <syswf:param name="title" value="${browseTitle}" />
				    <syswf:param name="subtitle" value="${browseSubTitle}" />
				    <syswf:param name="iconFormat" value="small" />
				</syswf:component>
				<syswf:block className="UI Block Common">
					<div class="Content">
					<table class="UI Layout">
						<tbody>
							<tr>
								<td class="UI Middle">
								<table class="UI Table Properties">
						<col>
						<col>
						<c:forEach var="report" items="${artifactItems}" varStatus="status" >
							<c:choose>
								<c:when test="${status.first}">
									<tr class="x-grid3-row x-grid3-row-first" style="border-color:#EDEDED">
								</c:when>
								<c:when test="${status.last}">
									<tr class="x-grid3-row x-grid3-row-last">
								</c:when>
								<c:otherwise>
									<tr class="x-grid3-row">
								</c:otherwise>
							</c:choose>
								<td>
									<syswf:control id="artifactReport_${status.count}" mode="anchor" caption="${report.singleLabel}" targetTask="/common/viewReport">
										<syswf:param name="reportId" value="${report.id}" />
									</syswf:control>
								</td>
								<td class="x-grid3-hd-row" style="width:90px">
									<a id="report_cln_${report.id}" href="javascript:void(0)" ></a>																
								</td>
								<td style="width:20px">
									<a id="report_del_${report.id}" href="javascript:void(0)" class="UI Icon Delete" >                                        
										&nbsp; <%-- add space so Chrome can display Delete icon. Chrome defect: an empty a.innerHtml can't display icon/background-image --%>
                                    </a>																
								</td>
							</tr>	
						</c:forEach>
					</table>
								</td>
							</tr>
						</tbody>
					</table>
					
					
					</div>
				</syswf:block>
			</td>
		</tr>
	</tbody>
</table> 

<script type="text/javascript">
//<![CDATA[
      
Ext.onReady(function() {
	<c:forEach var="report" items="${artifactItems}">						
        var element = Ext.get('report_del_${report.id}');	 
        var clnElement = Ext.get('report_cln_${report.id}');
           
        element.on('click', function() {
        	${prefix}_reportDeleteDialog_showDialog(element, '<fmt:message key="browse.delete.report.title" bundle="${reportMessages}"/>',
                    '<fmt:message key="browse.delele.report.confirmation" bundle="${reportMessages}"> <fmt:param value="${report.encodedLabel}" /></fmt:message>',
                    null, function(){ storeReportId('${report.id}'); ${prefix}deleteReport(); }, true);
        });
        <c:if test="${report.editable}">
        	clnElement.dom.innerHTML = 'Clone report';
        	clnElement.on('click', function() {
            	${prefix}_reportDeleteDialog_showDialog(clnElement, '<fmt:message key="browse.clone.report.title" bundle="${reportMessages}"/>',
                        '<fmt:message key="browse.clone.report.confirmation" bundle="${reportMessages}"> <fmt:param value="${report.encodedLabel}" /></fmt:message>',
                        null, function(){ storeReportId('${report.id}'); ${prefix}cloneReport(); }, false);
            });
        </c:if>
                     
    </c:forEach>
});     

//]]>
</script>
