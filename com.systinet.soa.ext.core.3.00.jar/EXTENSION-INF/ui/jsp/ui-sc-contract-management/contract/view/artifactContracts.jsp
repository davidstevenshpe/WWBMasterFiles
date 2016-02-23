<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>



<syswf:component name="/core/layout/header" prefix="header"
    wrap="false">
    <syswf:param name="title" value="${this.title}" />
    <syswf:param name="subtitle" value="${this.subtitle}" />
    <syswf:param name="subtitleClass" value="Artifact" />
    <syswf:param name="iconType" value="${this.artifact._artifactSdmName}" />
    <syswf:param name="iconFormat" value="small" />
    <syswf:param name="showRating" value="${false}" />
    <syswf:param name="artifactUuid" value="${this.artifact._uuid}" />
    <syswf:param name="artifactDeleted" value="${false}" />
    <syswf:param name="artifactLocked" value="${false}" />
</syswf:component>

<syswf:component name="/contract/impl/view/contractTab" prefix="ct">
    <syswf:param name="artifact" value="${this.artifact}"/>
</syswf:component>
