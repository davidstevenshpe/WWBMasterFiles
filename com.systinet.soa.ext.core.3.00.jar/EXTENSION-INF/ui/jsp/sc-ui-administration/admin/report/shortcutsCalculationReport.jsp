<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${artifact}" />
</syswf:component>

<syswf:block className="UI Block Common">
    <syswf:component name="/core/table" prefix="table">
        <syswf:param name="customizationId" value="admin.shortcut.shortcutsCalculationReport"/>
        <syswf:param name="artifact" value="${report}"/>
    </syswf:component>
</syswf:block>