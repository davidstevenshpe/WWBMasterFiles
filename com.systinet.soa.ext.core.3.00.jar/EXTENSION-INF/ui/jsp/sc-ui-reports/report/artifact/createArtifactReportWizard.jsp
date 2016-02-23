<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/impl/wizard" prefix="${viewId}.artifact">
    <syswf:param name="customizationId" value="${wizardCustomization}"/>
    <syswf:param name="controller" value="${wizardController}"/>
    <syswf:param name="mode" value="${mode}"/>
</syswf:component>