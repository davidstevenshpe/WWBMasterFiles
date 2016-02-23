<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uiScComponent"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.versioning.versioning" var="versionMessages"/>

<table class="UI Layout">
    <tr>
        <td class="UI Middle">
        
            <syswf:component name="/core/layout/header" prefix="header" wrap="false" />

            <syswf:component name="/core/impl/layout/uiMessage" prefix="message">
                <syswf:param name="type">warning</syswf:param>
                <syswf:param name="text"><fmt:message key="iv_warning" bundle="${versionMessages}" /></syswf:param>
            </syswf:component>
                        
            <syswf:block className="UI Block Common Decisions">
                <div class="Title">
                    <h3><fmt:message key="iv_title" bundle="${versionMessages}" /></h3>
                </div>
                <div class="Content">
                    <p class="Comment">
                        <fmt:message key="iv_description" bundle="${versionMessages}" />
                    </p>
                    <ul class="ResolutionCenter">
                        <c:forEach items="${solutions}" var="solution" varStatus="i">
                            <li>
                                <c:set var="caption">
                                    <c:choose>
                                        <c:when test="${solution.ungovern}">
                                            <fmt:message key="iv_stopLifecycle" bundle="${versionMessages}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="key" value="${not empty solution.used ? 'iv_useVersion' : 'iv_useCustomVersion'}" />
                                                <fmt:message key="${key}" bundle="${versionMessages}">
                                                    <fmt:param value="${solution.version}"/>
                                                </fmt:message>
                                        </c:otherwise>
                                    </c:choose>
                                </c:set>                            
                                <syswf:selectOne mode="radio" id="${prefix}_solution_${i.index}" name="selectedSolution" merge="true" optionValues="${i.index}" optionCaptions="${caption}" value="" />
                                <c:choose>
                                    <c:when test="${solution.ungovern}">
                                        <div class="Description">
                                            <c:set var="linkedArtifacts">
                                                <c:forEach items="${solution.unused}" var="usedArt" varStatus="j">
                                                    <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="artifactLink_${i.index}_${j.index}" wrap="false">
                                                        <syswf:param name="uuid" value="${usedArt._uuid}" />
                                                        <syswf:param name="caption" value="${usedArt.name}" />
                                                    </syswf:component>
                                                    <c:out value="${(not j.last) ? ',' : ''}" />
                                                </c:forEach>
                                            </c:set>
                                            <fmt:message key="iv_stopLifecycleDesc" bundle="${versionMessages}">
                                                <fmt:param value="${linkedArtifacts}"/>
                                            </fmt:message>
                                        </div> 
                                    </c:when>
                                    <c:when test="${not empty solution.used and (not (solution.ungovern))}">
                                        <div class="Description">
                                            <c:set var="linkedArtifacts">
                                                <c:forEach items="${solution.used}" var="usedArt" varStatus="j">
                                                    <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="artifactLink_${i.index}_${j.index}" wrap="false">
                                                        <syswf:param name="uuid" value="${usedArt._uuid}" />
                                                        <syswf:param name="caption" value="${usedArt.name}" />
                                                    </syswf:component>
                                                    <c:out value="${(not j.last) ? ',' : ''}" />
                                                </c:forEach>
                                            </c:set>
                                            <c:set var="key" value="${solution.root ? 'iv_versionUsedByThis' : 'iv_versionUsedBy'}" />
                                            <fmt:message key="${key}" bundle="${versionMessages}">
                                                <fmt:param value="${linkedArtifacts}"/>
                                            </fmt:message>
                                            <fmt:message key="iv_artifactsToUpdate" bundle="${versionMessages}">
                                                <fmt:param value="${fn:length(solution.unused)}"/>
                                            </fmt:message>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <syswf:input id="${prefix}_useVersion${i.index}" name="useVersion${i.index}" value="${solution}" property="version" mode="text"/>
                                        <script type='text/javascript'>
                                        //<![CDATA[
                                            Ext.onReady(function() {
                                                new Ext.form.TextField({
                                                    applyTo: '${prefix}_useVersion${i.index}',
                                                    width: 50
                                                });
                                            });
                                        
//]]>
</script>
                                        <div class="Description">
                                            <fmt:message key="iv_artifactsToUpdate" bundle="${versionMessages}">
                                                <fmt:param value="${fn:length(solution.unused)}"/>
                                            </fmt:message>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </syswf:block>
            
            <syswf:block className="UI Block Green">
                <div class="Content">
                    <div class="UI Form Controls">
                        <fmt:message key="iv_continueCaption" var="iv_continueCaption" bundle="${versionMessages}" />
                        <fmt:message key="iv_continueHint" var="iv_continueHint" bundle="${versionMessages}" />
                        <syswf:control mode="button" targetTask="/common/newVersion" action="onContinue" caption="${iv_continueCaption}" hint="${iv_continueHint}" targetDepth="${sessionStack.currentDepth}">
                            <syswf:attribute name="class">btn btn-primary</syswf:attribute>
                            <syswf:taskParam name="uuid" value="${uuid}" />
                        </syswf:control>
                        
                        <fmt:message key="Cancel" var="cancelButton" bundle="${uiScComponent}"/>
                        <fmt:message key="Cancel" var="cancelButtonHint" bundle="${uiScComponent}"/>
                        <syswf:control mode="button" caption="${cancelButton}" hint="${cancelButtonHint}" targetDepth="${sessionStack.currentDepth - 1}">
                            <syswf:attribute name="class">btn btn-gray</syswf:attribute>
                        </syswf:control>
                    </div>
                </div>
            </syswf:block>
        </td>
    </tr>
</table>