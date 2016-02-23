<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<%-- 
Show a table with a bar chart in the first column.
Input parameters:
datasource: 
displayedItemCount: number rows are displayed
table: 
   - (require) a column with property "countColumn", value of this column is displayed as bar chart
   - (optional) column with property "totalCountColumn", use to count percentage for "countColumn".
   - other columns are displayed as in normal table. Accept property widget or custom component to render.

Customization schema: /customization/schema/barsChartTable.xsd
 --%>

 <fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
 
 
<c:set var="height" value="20"/>
<c:set var="currentTotal" value="0"/>
<c:set var="totalOnRows" value="0"/>

<c:if test="${not empty chartHeight}">
    <c:set var="height" value="${chartHeight}"/>
</c:if> 
 
<c:set var="barChartBlock">
	<div class="UI Table Layout Chart Bar">
	<c:if test="${not empty emtyMsg}">
	   <c:out value="${emtyMsg}"/>
	</c:if>
	<c:if test="${noData}">
	   <c:choose>
	       <c:when test="${not empty emptyMsg}">
	           <c:out value="${emptyMsg}"/>
	       </c:when>
	       <c:otherwise>
	           <fmt:message key="report.noData_message" bundle="${report_Message}"/>
	       </c:otherwise>
	   </c:choose>
	</c:if>
	<c:if test="${not noData}">
		<c:forEach var="row" items="${resultContent}" varStatus="rowStatus">
		      <div class="UI Table Row" id="row${prefix}_${rowStatus.index}">
		          <table class="UI Table Properties Chart">
	                  <col>
		              <col class="BarChartNumber">
		              <col class="BarChart">
		              <tbody> 
		                  <tr>
		                      <c:set var="column" value="${flatColumns[0]}"/>
		                      <c:set var="totalOnRows" value="${totalOnRows + row.count}"/>
	                        <td>
	                           <c:choose>
	                                <c:when test="${not empty row.columns[column.id].content[0].componentName}">
	                                	<c:choose>
	                                		<c:when test="${empty row.columns[column.id].content[0].parameters['uuid']}">
	                                			<fmt:message key="report.unspecified" bundle="${report_Message}"/>
	                                		</c:when>
	                                		<c:otherwise>
	                                			<syswf:component name="${row.columns[column.id].content[0].componentName}" prefix="row${rowStatus.index}_${column.id}">
			                                        <syswf:paramSet value="${row.columns[column.id].content[0].parameters}"></syswf:paramSet>
			                                    </syswf:component>
	                                		</c:otherwise>
	                                	</c:choose>
	                                </c:when>
	                                <c:when test="${empty row.columns[column.id].content[0].parameters['value']}">
	                                	<fmt:message key="report.unspecified" bundle="${report_Message}"/>
	                                </c:when>
	                                <c:otherwise>
	                                   <c:out value="${row.columns[column.id].content[0].parameters['value']}"/>
	                                </c:otherwise>
	
	                            </c:choose>
	                           </td>
		                      <td>
	                              <c:if test="${row.showPercent}">
	                                <c:choose>
		                                <c:when test="${row.totalCount==0}">
		                                    <c:set var="percentValue" value="0"/>
		                                </c:when>
		                                <c:when test="${(row.totalCount!=0 && !rowStatus.last) || (rowStatus.last && row.totalCount != totalOnRows)}">
		                                    <fmt:formatNumber var="percentValue" value="${row.count*100/row.totalCount}" pattern="0"/>
		                                    <c:if test="${currentTotal+percentValue >= 100}">
		                                    	<fmt:formatNumber var="percentValue" value="${100-currentTotal}" pattern="0"/>	
		                                    </c:if>
		                                    <c:set var="currentTotal" value="${currentTotal+percentValue}"/>
		                                </c:when>
		                                <c:otherwise>
		                                	<fmt:formatNumber var="percentValue" value="${100-currentTotal}" pattern="0"/>		                                    
		                                </c:otherwise>
	                                </c:choose>
	                                
	                                <div class="ChartNumber"><c:out value="${percentValue}"/>%</div>
	                              </c:if>
	                              <c:if test="${not row.showPercent}">
	                                <c:set var="percentValue" value="${row.chartData}"/>
	                                <div class="ChartNumber"><c:out value="${row.count}"/></div>
	                              </c:if>
	                          </td>
	                          <td>
	                              <div style="height: <c:out value='${height}'/>px;" id="row${prefix}_${rowStatus.index}_barChart"></div>
	                              <script type="text/javascript">
//<![CDATA[

	                                  $(document).ready(function() {                                                                                                                
	                                      setBarChart('row${prefix}_${rowStatus.index}_barChart', {
	                                          width: $('#row${prefix}_${rowStatus.index}_barChart').parent().width(),
	                                          height: $('#row${prefix}_${rowStatus.index}_barChart').parent().height(),
	                                          data: [${percentValue}],
	                                          colors: ${row.chartColors}
	                                      });
	                                  });
	                              
//]]>
</script>
	                          </td>
		                  </tr>
		              </tbody>
		          </table>                                                                                        
		      </div>
		</c:forEach>               
	</c:if> 
	</div>
</c:set>


<c:choose>
    <c:when test="${not empty title}">
    	<table class="UI Layout">
            <tbody>
                <tr>
                    <td class="UI Middle">
                        <syswf:block className="UI Block Common">
	    <div class="Title">
	        <h3><span><c:out escapeXml="true" value="${title}"/></span></h3>
	    </div>
	    <c:out value="${barChartBlock}" escapeXml="false"/>
	    </syswf:block>
                    </td>
                    
                </tr>
            </tbody>
        </table>
	    
    </c:when>
    <c:otherwise>
     	<table class="UI Layout">
            <tbody>
                <tr>
                    <td class="UI Middle">
                        <c:out value="${barChartBlock}" escapeXml="false"/>
                    </td>
                    
                </tr>
            </tbody>
        </table>
        
    </c:otherwise>
</c:choose>
