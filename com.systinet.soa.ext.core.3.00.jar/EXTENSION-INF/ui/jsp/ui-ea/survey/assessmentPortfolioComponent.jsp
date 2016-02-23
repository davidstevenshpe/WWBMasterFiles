<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<style>
#content DIV.UI.Table{padding:20px 0 0 10px}
</style>
<syswf:component name="/core/layout/columns" prefix="assessmentPortfolio">
    <syswf:param name="customizationId" value="${selectionCustomizationID}" />
    <syswf:param name="title" value=""/>
    <syswf:param name="description" value=""/>
    <syswf:param name="kind" value="browse"/>
    <syswf:param name="dqlCondition" value="${dqlCondition}"/>
	<syswf:param name="assessment" value="true"/>
</syswf:component>