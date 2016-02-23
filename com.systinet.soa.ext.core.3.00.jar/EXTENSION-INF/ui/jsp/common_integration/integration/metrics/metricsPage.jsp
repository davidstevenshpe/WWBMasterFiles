<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>

<syswf:block className="UI Block Common">
    <syswf:component name="/integration/stm/servicestatus" prefix="stmintegration" wrap="false">
        <syswf:param name="artifact" value="${artifact}" />
    </syswf:component>
</syswf:block>

<syswf:component name="/integration/bac/servicestatus" prefix="bacintegration" wrap="false">
    <syswf:param name="artifact" value="${artifact}" />
</syswf:component>

<syswf:component name="/integration/soam/servicestatus" prefix="soamintegration" wrap="false">
    <syswf:param name="artifact" value="${artifact}" />
</syswf:component>
