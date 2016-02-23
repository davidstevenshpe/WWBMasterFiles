<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="messages"/>

<%--@elvariable id="cacheRefreshTime" type="java.lang.String"--%>

<table class="UI Layout">
    <tbody>
    <tr>
        <td class="UI Middle">
            <div class="Paragraph Tip">
                <p>
                    <fmt:message key="formValidation_note" bundle="${messages}">
                        <fmt:param value="${cacheRefreshTime}"/>
                    </fmt:message>
                </p>
            </div>
            <syswf:component name="/pm/formvalidation/formValidationBox" prefix="formValidationBox"/>
        </td>
    </tr>
    </tbody>
</table>