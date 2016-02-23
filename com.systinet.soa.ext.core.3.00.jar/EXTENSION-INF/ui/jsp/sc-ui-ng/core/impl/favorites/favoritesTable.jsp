<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<div class="Content">
  	<syswf:component name="/core/table" prefix="header" wrap="false">
       <syswf:param name="customizationId" value="shared.favorites.table" />
       <syswf:param name="datasource" value="${datasource}" />
   </syswf:component>
</div>
