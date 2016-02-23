<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>
<c:if test="${not empty complianceInPercents && complianceInPercents > -1}">
<syswf:block className="EA-right-panel policy-widget">
	<div class="Title">
		<h3><span title="<fmt:message key="validationResult.policycompliance.hint" bundle="${messages}"/>"><fmt:message key="validationResult.policycompliance" bundle="${messages}"/></span></h3>
	         <fmt:message key="validationResult.currentPercentage" bundle="${messages}" var="currentStatus">
	             <fmt:param value="${complianceInPercents}"/>
	         </fmt:message>
	         <%-- <div class="sub-title">${currentStatus}</div>--%>
	         <br/>
    </div>
	<div class="Content">
		<c:forEach items="${policies}" var="policy" varStatus="status">
		<div class="cell-container">
			<div class="name">
            <syswf:control targetTask="/artifact/${policy.id}" caption="${policy.name}" mode="anchor">
				<syswf:param name="validationResultId" value="${policy.detailId}"/>
    			<syswf:param name="artifactTabId">results</syswf:param>
			</syswf:control>
			</div>
			<div class="status">
				<span style="color:${policy.color}">${policy.compliance} %</span>
			</div>
		</div>
		</c:forEach>
		<a href="javascript.void(0)" onclick="this.href=$('#compliance-tab-link a').attr('href')"><fmt:message key="validationResult.showMore" bundle="${messages}"/></a>
	</div>
</syswf:block>
</c:if>
