<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/core/impl/wizard" prefix="${viewId}.contractRequestWizard">
    <syswf:param name="customizationId" value="${viewId}.contract.contractRequestWizard"/>
    <syswf:param name="controller" value="${controller}"/>
</syswf:component>

