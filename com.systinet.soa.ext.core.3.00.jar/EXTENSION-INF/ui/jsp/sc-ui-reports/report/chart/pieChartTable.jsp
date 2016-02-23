<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 
Show a table with a pie chart in the first column. The pie chart show percentage of columns in the active row.
Input parameters:
datasource: 
table: 
   - (require) columns with property "includeInGraph".
     value of these columns are displayed as percentage (of all "includeInGraph" columns) in pie chart.
   - (optional) columns with property "countColumn", which is rendered in different style.
   - other columns are displayed as in normal table. Accept property widget or custom component to render.

Customization schema: /customization/schema/table.xsd
--%>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>

<c:set var="width" value="150"/>
<c:set var="height" value="150"/>

<c:if test="${not empty chartWidth}">
    <c:set var="width" value="${chartWidth}"/>
</c:if> 

<c:if test="${not empty chartHeight}">
    <c:set var="height" value="${chartHeight}"/>
</c:if> 

 
<syswf:block className="UI Block Common">
	<c:if test="${not empty title}">
	    <div class="Title">
	        <h3><span><c:out escapeXml="true" value="${title}"/></span></h3>
	    </div>
	</c:if>

	<c:if test="${noData}">
	   <fmt:message key="report.noData_message" bundle="${report_Message}"/>
	</c:if>
	<c:if test="${not noData}">
		<table class ="UI Table Layout">
		    <col class="PieChart">
		    <col class="Meta">
		    <tbody>
			    <tr>
			        <td> 
			            <div id="${prefix}_piechart" style="height: <c:out value='${height}'/>px; width: <c:out value='${width}'/>px;">
			            </div>
			        </td>
			        <td>
			            <div class="UI Table Layout Chart">
			                <div class="UI Table Header">
			                    <table class="UI Table Properties Chart">
			                         <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
			                             <c:choose>
					                         <c:when test="${column.propertiesAsMap['includeInGraph'] eq 'true'}">
					                             <col class="Percent">
					                         </c:when>
					                         <c:when test="${column.propertiesAsMap['numberColumn'] eq 'true'}">
				                                 <col class="Count">
				                             </c:when>
					                         <c:otherwise>
					                             <col>
					                         </c:otherwise>
					                      </c:choose>    
			                         </c:forEach>
			                         <thead>
				                          <tr>
				                                <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
				                                    <td><c:out value="${column.label}"/></td>
				                                </c:forEach>                                
				                          </tr>
			                        </thead>
			                    </table>
			                </div>
			                <c:forEach var="row" items="${resultContent}" varStatus="rowStatus">
				                <c:set var="currentTotal" value="0"/>
				                <c:set var="itemCount" value="0"/>
				                <c:choose>
					                  <c:when test="${not rowStatus.last}">
					                      <c:set var="rowClass" value="Row"/>
					                  </c:when>
					                  <c:otherwise>
					                      <c:set var="rowClass" value="Footer"/>
					                  </c:otherwise>
					            </c:choose>    
				                <div id="${prefix}rowId_${rowStatus.index}" class="UI Table <c:out value='${rowClass}'/>">
				                    <table class="UI Table Properties Chart">
				                        <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
				                         <c:choose>
				                             <c:when test="${column.propertiesAsMap['includeInGraph'] eq 'true'}">
				                                 <col class="Percent">
				                             </c:when>
				                             <c:when test="${column.propertiesAsMap['numberColumn'] eq 'true'}">
				                                 <col class="Count">
				                             </c:when>
				                             <c:otherwise>
				                                 <col>
				                             </c:otherwise>
				                         </c:choose>    
				                        </c:forEach>
				                        <tbody>
				                            <tr>
				                                <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
				                                    <td>
				                                        <c:choose>
				                                            <c:when test="${not empty row.columns[column.id].content[0].componentName}">
				                                                <syswf:component name="${row.columns[column.id].content[0].componentName}" prefix="row${rowStatus.index}_${column.id}">
				                                                    <syswf:paramSet value="${row.columns[column.id].content[0].parameters}"></syswf:paramSet>
				                                                </syswf:component>
				                                            </c:when>
				                                           
				                                            <c:when test="${column.propertiesAsMap['includeInGraph'] eq 'true'}">
				                                                <c:set var="itemCount" value="${itemCount + row.columns[column.id].content[0].parameters['numberValue']}"/>
				                                                
				                                                <c:if test="${row.totalCount==0}">
			                                                        <c:set var="percentValue" value="0"/>
			                                                    </c:if>
			                                                    <c:if test="${row.totalCount!=0 and itemCount < row.totalCount}">
			                                                        <fmt:formatNumber var="percentValue" value="${row.columns[column.id].content[0].parameters['numberValue']*100/row.totalCount}" pattern="0"/>
			                                                        <c:set var="currentTotal" value="${currentTotal+percentValue}"/>
			                                                    </c:if>
			                                                    <c:if test="${row.totalCount!=0 and itemCount > row.totalCount}">
			                                                        <fmt:formatNumber var="percentValue" value="${row.columns[column.id].content[0].parameters['numberValue']*100/row.totalCount}" pattern="0"/>
			                                                    </c:if>
			                                                    <c:if test="${row.totalCount!=0 and itemCount == row.totalCount}">
			                                                        <fmt:formatNumber var="percentValue" value="${100-currentTotal}" pattern="0"/>
			                                                        <c:set var="itemCount" value="${row.totalCount + 1}"/>
			                                                    </c:if>
				                                                <span class="ChartLegend">
				                                                    <span class="Bullet" style="background-color:${row.columns[column.id].content[0].parameters['color']}"></span>
				                                                    <span class="Label"><c:out value="${percentValue}"/>%</span>
				                                                </span>
				                                            </c:when>
				                                            <c:otherwise>
				                                                <c:out value="${row.columns[column.id].content[0].parameters['value']}"/>    
				                                            </c:otherwise>
				                                        
				                                        </c:choose>                                                                                
				                                    </td>
				                                </c:forEach>
				                            </tr>
				                        </tbody>
				                    </table>   
				                    <script type="text/javascript">
//<![CDATA[

				                        Ext.onReady(function() {
				                            var rowControl = $('#${prefix}rowId_${rowStatus.index}');
				                            rowControl.click(function() {
				                            	rowControl.parent(".Chart").find(".Row, .Footer").each(function() {
				                                    $(this).removeClass('Active');
				                                });
				                                $(this).addClass('Active');
				
				                                setPieChart('${prefix}_piechart', 
				                                        { data: ${row.chartData},
				                                          labels: ${row.chartLabels},
				                                          colors: ${row.chartColors}
				                                        }
				                                     );
				                            });
				
				                            rowControl.mouseenter(function() {
				                                $(this).addClass('Hover')
				                            });
				                            rowControl.mouseleave(function() {
				                                $(this).removeClass('Hover');
				                            });
				                            // active total row
				                            <c:if test="${rowStatus.last}">
					                            rowControl.addClass('Active');
					                            setPieChart('${prefix}_piechart', 
				                                        { data: ${row.chartData},
				                                          labels: ${row.chartLabels},
				                                          colors: ${row.chartColors}
				                                        }
				                                     );
			                                </c:if>
				                        });
				                    
//]]>
</script>                  
				                </div>
			                </c:forEach>
			            </div>
			        </td>
			    </tr>
			</tbody>
		</table>
	</c:if>
</syswf:block>
