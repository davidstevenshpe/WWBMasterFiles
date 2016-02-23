<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.artifact.ArtifactMessages" var="messages" />

<fmt:message var="title" key="artifactNotAvailable.title" bundle="${messages}">
    <fmt:param><syswf:out value="${aneBean.currentTabLabel}" context="HtmlBody"/></fmt:param>
</fmt:message>
<fmt:message var="description" key="artifactNotAvailable.description" bundle="${messages}">
    <fmt:param><syswf:out value="${aneBean.currentTabLabel}" context="HtmlBody"/></fmt:param>
</fmt:message>
<fmt:message var="descriptionRedir" key="artifactNotAvailable.descriptionRedir" bundle="${messages}">
    <fmt:param><syswf:out value="${aneBean.currentTabLabel}" context="HtmlBody"/></fmt:param>
</fmt:message>
<fmt:message var="artifactName" key="artifactNotAvailable.artifactName" bundle="${messages}" />
<fmt:message var="artifactType" key="artifactNotAvailable.artifactType" bundle="${messages}" />
<fmt:message var="lastKnownLocation" key="artifactNotAvailable.lastKnownLocation" bundle="${messages}" />

<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
                <!-- Title and description -->
                <div class="UI PageIdentity">
                    <h1>${title}</h1>
                </div>
    
                <div class="UI Text Description">
                    <c:choose>
                        <c:when test="${empty aneBean.links}">
                            ${description}
                        </c:when>
                        <c:otherwise>
                            ${descriptionRedir}
                        </c:otherwise>
                    </c:choose>
                </div>
                    
                <!-- Details properties -->
                <syswf:block className="UI Block Common">
                    <div class="Content">
                    <table class="UI Table Properties">
                        <col class="LabelCol">
                        <col>
                        <tbody>
                            <tr>
                                <th><label class="UI Label Inline">${artifactName}:</label></th>
                                <td><syswf:out value="${aneBean.artifactName}" context="HtmlBody"/></td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">${artifactType}:</label></th>
                                <td><syswf:out value="${aneBean.artifactType}" context="HtmlBody"/></td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">${lastKnownLocation}:</label></th>
                                <td><syswf:component name="lastKnownLocation" prefix="lastKnownLocation" wrap="false" /></td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                    </div>
                </syswf:block>
            </td>

            <td class="UI Right">
                <!-- Right side links -->
                <syswf:block className="UI Block Green">
                    <div class="Content">
                        <c:forEach items="${aneBean.links}" var="linkHolder">
                            <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="${status.count}" wrap="false">
                                <syswf:param name="uuid" value="${linkHolder.uuid}" />
                                <syswf:param name="caption" value="${linkHolder.name}" />
                                <syswf:param name="class" value="UI PageAction ChangeView" />
                                <syswf:param name="view" value="${linkHolder.view}"/>
                                <syswf:param name="depth" value="${linkHolder.depth}"/>
                            </syswf:component>
                        </c:forEach>
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
