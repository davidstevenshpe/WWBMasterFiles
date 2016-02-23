<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<%--@elvariable id="controlName" type="java.lang.String"--%>
<%--@elvariable id="selectionBag" type="java.lang.String"--%>
<syswf:control mode="script" action="removeArtifacts" caption="${controlName}">
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

