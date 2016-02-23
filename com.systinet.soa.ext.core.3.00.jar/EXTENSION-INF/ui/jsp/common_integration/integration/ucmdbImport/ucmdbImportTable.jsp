<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="overrideSelectionModel" type="java.lang.String"--%>
<syswf:block className="UI Block Common">
    <div class="webfw-Window" id="${prefix}-webfw-Window">
        <syswf:component name="/core/table" prefix="ucmdbImportTable">
            <syswf:param name="customizationId" value="integration.ucmdbImport.ucmdbImportTable"/>
            <syswf:param name="datasource" value="${dataSource}"/>
            <syswf:param name="tableId" value="ucmdbImportTable"/>
            <%-- "none" and "multiple" are used overrideSelectionModel values --%>
            <syswf:param name="overrideselectionModel" value="${overrideSelectionModel}"/>
        </syswf:component>
    </div>
</syswf:block>