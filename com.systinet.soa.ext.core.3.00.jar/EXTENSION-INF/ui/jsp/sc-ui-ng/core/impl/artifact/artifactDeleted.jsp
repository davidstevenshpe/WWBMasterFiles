<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.artifact.ArtifactMessages" var="messages" />

<fmt:message var="title" key="artifactDeleted.title" bundle="${messages}" />
<fmt:message var="description" key="artifactDeleted.description" bundle="${messages}" />
<fmt:message var="artifactName" key="artifactDeleted.artifactName" bundle="${messages}" />
<fmt:message var="artifactType" key="artifactDeleted.artifactType" bundle="${messages}" />
<fmt:message var="artifactId" key="artifactDeleted.artifactId" bundle="${messages}" />
<fmt:message var="lastKnownLocation" key="artifactDeleted.lastKnownLocation" bundle="${messages}" />

<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
                <!-- Title and description -->
                <div class="UI PageIdentity">
                    <h1><syswf:out value="${title}" context="HtmlBody"/></h1>
                </div>

                <div class="UI Text Description">${description}</div>

                <!-- Details properties -->
                <syswf:block className="UI Block Common">
                    <div class="Content">
                    <table class="UI Table Properties">
                        <col class="LabelCol">
                        <col>
                        <tbody>
                            <tr>
                                <th><label class="UI Label Inline">${artifactName}:</label></th>
                                <td><syswf:out value="${bean.artifactName}" context="HtmlBody"/></td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">${artifactType}:</label></th>
                                <td><syswf:out value="${bean.artifactType}" context="HtmlBody"/></td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">${artifactId}:</label></th>
                                <td><syswf:out value="${bean.artifactIdentifier}" context="HtmlBody"/></td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">${lastKnownLocation}:</label></th>
                                <td><syswf:component name="lastKnownLocation" prefix="lastKnownLocation" wrap="false" /></td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                </syswf:block>
            </td>

            <td class="UI Right">
                <!-- Right side links -->
                <syswf:block className="UI Block Green">
                    <div class="Content">
                        <syswf:component name="lastKnownLocation" prefix="lastKnownLocationRight" wrap="false">
                            <syswf:param name="id">lastKnownLocationRight</syswf:param>
                            <syswf:param name="class">UI PageAction GoBack</syswf:param>
                            <syswf:param name="caption">${lastKnownLocation}</syswf:param>
                        </syswf:component>
                    </div>
                </syswf:block>
            </td>
        </tr>
    </tbody>
</table>