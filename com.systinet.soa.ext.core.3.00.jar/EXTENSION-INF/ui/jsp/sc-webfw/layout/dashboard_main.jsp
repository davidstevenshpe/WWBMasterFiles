<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component prefix="layoutControls" name="/layout/dashboard/layoutControls">
    <syswf:param name="panel" value="${panel}"/>
    <syswf:param name="layout" value="${layout}"/>
    <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
</syswf:component>

<syswf:component prefix="uiMessages" name="/util/uiMessageRenderer" wrap="false" />

<table class="shrDashboard">
	<tr>
	    <c:set var="counter" scope="request" value="${1}"/>
	    <c:forEach var="box" items="${panel.activeLayout.boxList}">
	        <td id="dashboardColumn<c:out value="${counter}"/>" class="shrDashboard">
		        <syswf:component prefix="${box.name}" name="/layout/dashboard/box" wrap="false">
		            <syswf:param name="panel" value="${panel}"/>
		            <syswf:param name="box" value="${box}"/>
		            <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
		        </syswf:component>
		        <c:set var="counter" scope="request" value="${counter + 1}"/>
	        </td>
	    </c:forEach>
	</tr>
</table>

<syswf:localizedFileName fileName="${webResourcePath}/js/dashboard.js" var="jsDashboard"/>
<script src="<c:out value="${jsDashboard}"/>" type="text/javascript"></script>