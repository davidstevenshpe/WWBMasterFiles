<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/core/table" prefix="editAccessTable">
    <syswf:param name="customizationId" value="admin.lifecycle.responsibilities.editAccessTable"/>
    <syswf:param name="datasource" value="${dataSource}" />
    <syswf:param name="process" value="${process}" />
    <syswf:param name="parentComponent" value="${prefix}" />    
</syswf:component>