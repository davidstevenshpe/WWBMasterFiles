<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:if test="${not empty reportHtmlLink }">
	<label class="UI Label Inline">
	   <span class="UI Comment">
	       <c:out value="${generatedReport}"/>
	       <c:choose>
	           <c:when test="${not empty reportOwner}">
	               <syswf:control mode="anchor" caption="${reportOwner.name}" targetTask="/common/viewArtifact">
                       <syswf:param name="uuid" value="${reportOwner._uuid}"/>
                   </syswf:control>
	           </c:when>
	           <c:otherwise>
	               <c:out value="${reportOwnerName}" />
	           </c:otherwise>
	       </c:choose>
	   </span>
	</label>
	<iframe src ="${reportHtmlLink}" frameborder="0" scrolling ="auto" width="100%" height ="900">
	</iframe>
</c:if>

