<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.integration.stm.StmIntegrationL10n" var="integrationMessages"/>

<%-- TODO REVIEW (simon, 2010-06-16): unnecessarily complicated check, use 'if' instead --%>
<c:choose>
	<c:when test="${almServiceStatusContextInfo != null}">
    	<div id='<c:out value="${prefix}_stmstatus"/>'>
			<syswf:component name="/integration/stm/servicestatus/cell" wrap="false" prefix="stmstatus">
			  	 <syswf:param name="documentDescription" value="${documentDescription}"/>
			  	 <syswf:param name="almServiceStatusContextInfo" value="${almServiceStatusContextInfo}"/>
			</syswf:component>
     	</div>
	</c:when>     
	<%-- c:otherwise>
		do not show the section at all
	</c:otherwise --%>
</c:choose>