<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tui_Message"/>

<c:if test="${not empty timeout}">

<syswf:control mode="ajax" caption="refreshLogin" />

<script type="text/javascript">
//<![CDATA[


function refreshLoginConfirm() {
	if (confirm('<fmt:message key="sessionAboutToExpire" bundle="${tui_Message}"/>')) {
		refreshLogin();
		window.setTimeout(refreshLoginConfirm,${timeout});
	}
}
window.setTimeout(refreshLoginConfirm,${timeout});


//]]>
</script>

</c:if>