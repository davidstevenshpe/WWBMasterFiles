<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<fmt:setBundle	basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />

<%--@elvariable id="sourceType" type="java.lang.String"--%>
<%--@elvariable id="externalViewBean" type="com.hp.systinet.report.ui.impl.policy.ViewSourceSelectorComponent.ExternalViewBean"--%>
<%--@elvariable id="searchViewBean" type="com.hp.systinet.sc.datasource.DataSource"--%>
<syswf:block className="UI Block Common">
    <div class="Title">
	    <h3><c:choose>
	        <c:when test="${sourceType eq 'RSOURCE'}">
	            <fmt:message key="policyreport.definition.search.header"
	                bundle="${pr_Messages}" />
	        </c:when>
	        <c:otherwise>
	            <fmt:message key="policyreport.definition.external.header"
	                bundle="${pr_Messages}" />
	        </c:otherwise>
	    </c:choose></h3>
    </div>
    <div class="Content">
	    <table class="UI Table Properties">
	        <col class="LabelCol">
	        <col>
	        <tbody>
	            <c:choose>
	                <c:when test="${sourceType eq 'RSOURCE'}">
	                    <c:if test="${not empty searchViewBean}">
	                        <tr><td colspan="2">
	                        <syswf:component prefix="search" name="/core/search/util/searchViewer">
	                            <syswf:param name="value" value="${searchViewBean}"/>
	                            <syswf:param name="criteriaCustomizationId"
	                                         value="reports.policy.artifact.search.criteria"/>
	                        </syswf:component>
	                        </td></tr>
	                    </c:if>
	                </c:when>
	                <c:otherwise>
	                    <c:if test="${not empty externalViewBean}">
	                        <tr>
	                            <th>
	                                <label class="UI Label Inline">
	                                    <fmt:message key="policyreport.definition.url.label" bundle="${pr_Messages}" />:
	                                </label>
	                            </th>
	                            <td>
	                                <span class="IconAlign"><c:out value="${externalViewBean.url}"/></span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>
	                                <label class="UI Label Inline">
	                                    <fmt:message key="policyreport.definition.authentication.label" bundle="${pr_Messages}" />:
	                                </label>
	                            </th>
	                            <td>
	                                 <span class="IconAlign">
	                                    <c:choose>
	                                        <c:when test="${externalViewBean.authentication}">
	                                            <fmt:message key="policyreport.definition.authentication.yes.label" bundle="${pr_Messages}" />
	                                        </c:when>
	                                        <c:otherwise>
	                                            <fmt:message key="policyreport.definition.authentication.no.label" bundle="${pr_Messages}" />
	                                        </c:otherwise>
	                                    </c:choose>
	                                 </span> 
	                            </td>
	                        </tr>
	                    </c:if>
	                </c:otherwise>
	            </c:choose>
	        </tbody>
	    </table>
    </div>
</syswf:block>


