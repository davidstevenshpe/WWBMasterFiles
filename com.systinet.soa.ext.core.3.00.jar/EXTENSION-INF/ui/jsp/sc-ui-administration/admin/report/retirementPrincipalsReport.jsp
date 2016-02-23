<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>

<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${report}" />
    <syswf:param name="actionComponents" value="${actionComponents}"/>
</syswf:component>

<syswf:block className="UI Block Common">
 <div class="webfw-Window" id="${prefix}-webfw-Window">                
     <syswf:component name="/core/table" prefix="table">
         <syswf:param name="customizationId" value="admin.common.principalRetirementReport"/>
         <syswf:param name="artifact" value="${report}"/>
     </syswf:component>
 </div>
</syswf:block>
