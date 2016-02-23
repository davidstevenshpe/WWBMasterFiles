<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>

<syswf:block className="UI Block">
    <div class="Content">
        <%-- Edit Action --%>
        <syswf:component name="/newUi/lc/admin/process/action/editProcess" prefix="edit" wrap="false">
        </syswf:component>
        <%-- Publish Action --%>
        <syswf:component name="/newUi/lc/admin/process/action/publishProcess" prefix="publish" wrap="false">
        </syswf:component>
        <%-- Deprecate Action --%>
        <syswf:component name="/newUi/lc/admin/process/action/deprecateProcess" prefix="deprecate" wrap="false">
        </syswf:component>
        <%-- Clone Action --%>
        <syswf:component name="/newUi/lc/admin/process/action/cloneProcess" prefix="clone" wrap="false">
        </syswf:component>
        <%-- Delete Action --%>
        <syswf:component name="/newUi/lc/admin/process/action/deleteProcess" prefix="delete" wrap="false">
        </syswf:component>
        <syswf:component name="/core/export/exportGP" prefix="export" wrap="false">
            <syswf:param name="process" value="${process}" />
        </syswf:component>
        <%-- View Usage action --%>
        <syswf:component name="/newUi/lc/admin/process/action/viewUsage" prefix="viewUsage" wrap="false" />        
    </div>
</syswf:block>
