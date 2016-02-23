<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="title" value="${this.bean.artifact.name}"/>


<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${artifactLabel}" />
    <syswf:param name="subtitle" value="Create new..." />
    <syswf:param name="domainLabel" value="${domainLabel}" />
</syswf:component>

<%-- For consistency, keep prefix in sync in view/new/edit pages --%>
<syswf:component name="/core/layout/columns" prefix="props" wrap="false">
    <syswf:param name="customizationId" value="${this.bean.customizationId}" />
    <syswf:param name="artifact" value="${this.bean.artifact}" />
    <syswf:param name="validationReport" value="${this.bean}" />
    <syswf:param name="artifactBean" value="${this.bean}" />
</syswf:component>

<hr />

<syswf:block className="UI Block Green Last">
    <div class="Content">
        <div class="UI Form Controls">
            <%-- TODO REVIEW (Svata, 3/04/2009): HTML mockups use buttons --%>
                    <%-- TODO REVIEW (Svata, 3/04/2009): I18N --%>
            <syswf:control mode="postAnchor" action="save" caption="Save">
                <syswf:attribute name="class" value="btn btn-primary" />
            </syswf:control>
            <%-- TODO REVIEW (Svata, 3/04/2009): I18N --%>
            <syswf:control mode="postAnchor" action="cancel" caption="Cancel" targetDepth="${sessionStack.currentDepth-1}">
                <syswf:attribute name="class" value="btn btn-gray" />
            </syswf:control>
        </div>
    </div>
</syswf:block>
<syswf:component name="/util/stayLoggedIn" prefix="stayLoggedIn" wrap="false" />