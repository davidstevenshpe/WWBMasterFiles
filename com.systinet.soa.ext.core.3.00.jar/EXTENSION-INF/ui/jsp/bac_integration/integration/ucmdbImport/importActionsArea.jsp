<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%--This component only encapsulates ucmdb import actions into one "UI Block Green" syswf:block--%>
<syswf:block className="UI Block Green">
    <syswf:component prefix="startImportButton" name="/integration/ucmdbImport/startImportButton"/>
    <syswf:component prefix="importScheduleAction" name="/integration/ucmdbImport/importScheduleAction"/>
</syswf:block>