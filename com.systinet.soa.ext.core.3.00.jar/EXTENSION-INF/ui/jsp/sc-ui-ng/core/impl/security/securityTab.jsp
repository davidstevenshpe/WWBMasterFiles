<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/customization/customizableComponent" prefix="columnLayout" wrap="false">
    <syswf:param name="customizationId" value="shared.security"/>
    <syswf:param name="customizedComponent" value="/core/layout/columnsInternal"/>
    <syswf:param name="dontCustomize" value="true"/>
    <syswf:param name="artifact" value="${artifact}"/>
</syswf:component>