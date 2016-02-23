<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>

<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:block className="UI Block Common">
    <div class="webfw-Window" id="${prefix}-webfw-Window">
        <syswf:component name="/core/table" prefix="ucmdbIgnoredTable">
            <syswf:param name="customizationId" value="integration.ucmdbImport.ucmdbIgnoredTable"/>
            <syswf:param name="datasource" value="${dataSource}"/>
            <syswf:param name="tableId" value="ucmdbIgnoredTable"/>
        </syswf:component>
    </div>
</syswf:block>