<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>

<c:set var="reportType" value="DAY_NP,WEEK_NP,MONTH_NP,YEAR_NP,ART_ACCESS,ART_EDIT" />
<fmt:message var="emptyMsg" key="dashboard.activity_report.no_data_msg" bundle="${report_Message}" />
<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span><fmt:message key="dashboard.activity_report.title" bundle="${report_Message}" /></span></h3>
        <div class="UI Text Description">
            <fmt:message key="activity_report.subtitle.${activityType.reportTime}.${activityType.reportAction}" bundle="${report_Message}" />
        </div>
    </div>
    <div class="Content">
        <table class="UI Table Layout">
            <col class ="Meta">
            <tbody>
	            <tr>
	                <td>
	                    <div class="UI Table Layout Chart Bar">
	                        <div class="UI Table Header">
	                            <table class="UI Table Properties Chart">
	                                <col>
	                                <thead>
	                                    <tr>
	                                        <th>
                                                <c:set var="cssClass" value="hp-corner-box void"/>
	                                            <c:forTokens items="${reportType}" delims="," var="type">
													<c:if test="${activityType.reportTime eq type || activityType.reportAction eq type }">
													    <c:set var="cssClass" value="hp-corner-box"/>
													</c:if> 
	                                                <syswf:control mode="ajax" action="report${type}" caption="${prefix}report${type}" loadingMask="true"/>
								                    <div class="${cssClass}">
	                                                    <div>
	                                                        <div> 
	                                                            <div> 
	                                                                <div>
	                                                                    <a href ="javascript:void(0);" id="${prefix}report${type}" ><fmt:message key="dashboard.activity_report.${type}" bundle="${report_Message}" /></a>
	                                                                </div>
	                                                            </div>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <c:set var="cssClass" value="hp-corner-box void"/>
                                                    <script type="text/javascript">
//<![CDATA[

	                                                    attachOn('${prefix}report${type}','click',function() {
	                                                        ${prefix}report${type}();
	                                                    });
                                                    
//]]>
</script>
								                </c:forTokens>
	                                        </th>
	                                    </tr>
	                                </thead>
	                            </table>
	                        </div>
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                 <td>
	                     <syswf:component name="/reports/chart/barsChartTable" prefix="chart">
	                           <syswf:param name="customizationId" value="reports.dashboard.activityReportTable"/>
	                           <syswf:param name="activityType" value ="${activityType}"/>
	                           <syswf:param name="emptyMsg" value ="${emptyMsg}"/>
	                     </syswf:component>
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <div class="UI Table Layout Chart Bar">
		                     <div class="UI Table Footer">
		                        <table class="UI Table Properties Chart">
		                            <col>
		                            <col>
		                            <thead>
		                                <tr>
		                                    <th>
		                                        <c:if test="${not empty updatedDate}">
		                                             <c:out value="${updatedDate}"/>
		                                        </c:if>
		                                    </th>
		                                    <th>
		                                        &nbsp;
		                                    </th>
		                                </tr>
		                            </thead>
		                        </table>
		                     </div>
	                     </div>
                    </td>
                 </tr>
            </tbody>
        </table>
    </div>
</syswf:block>