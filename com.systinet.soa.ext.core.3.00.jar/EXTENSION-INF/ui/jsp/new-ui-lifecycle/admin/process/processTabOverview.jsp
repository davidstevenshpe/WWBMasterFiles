<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="viewGPBean" type="com.hp.systinet.lifecycle.ui.admin.process.ProcessTabOverview.ViewGPBean"--%>
<%--@elvariable id="inCategoriesWidgetModel" type="com.hp.systinet.lifecycle.ui.common.CategoryBagWidgetModel"--%>
<%--@elvariable id="notInCategoriesWidgetModel" type="com.hp.systinet.lifecycle.ui.common.CategoryBagWidgetModel"--%>
<%--@elvariable id="inDomainsModel" type="com.hp.systinet.lifecycle.ui.common.DomainBagWidgetModel"--%>
<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="processTabOverview.rootArtifactType" var="rootArtifactType" bundle="${messages}"/>
<fmt:message key="processTabOverview.goalLifecycleStage" var="goalLifecycleStage" bundle="${messages}"/>
<fmt:message key="processEditor.traverseArchimateRelationships" var="traverseArchimateRelationships" bundle="${messages}"/>
<fmt:message key="processEditor.traverseComposeOfonly" var="traverseComposeOfonly" bundle="${messages}"/>
            <div class="UI Block Container">
				<syswf:component name="/newUi/lc/admin/process/rightPanel" prefix="contextButton"/>
				<c:if test="${empty viewGPBean.process.states}">
                    <div class="Paragraph Tip">
                         <p><fmt:message key="processTabOverview.emptyProcessMessage" bundle="${messages}"/></p>
                     </div>
                </c:if>
                <c:choose>
                    <c:when test="${viewGPBean.isAssociated}">
                        <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                            <syswf:param name="message"><fmt:message key="processTabOverview.cannotEditProcessLayout.processIsUsed" bundle="${messages}"/></syswf:param>
                        </syswf:component><br/>
                    </c:when>
                    <c:when test="${viewGPBean.process.available}">
                        <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                            <syswf:param name="message"><fmt:message key="processTabOverview.cannotEditProcessLayout.processIsPublished" bundle="${messages}"/></syswf:param>
                        </syswf:component><br/>
                    </c:when>
                </c:choose>
                <syswf:component prefix="processVisualisation" name="/newUi/lc/common/visualization/visualizer">
                    <syswf:param name="flashFileNameWoSuffix" value="process-visualization"/>
                    <syswf:param name="processUuid" value="${process.baseUuid}"/>
                    <c:choose>
                        <c:when test="${(not viewGPBean.isAssociated) and (not viewGPBean.process.available)}">
                            <syswf:param name="editMode" value="true"/>
                        </c:when>
                        <c:otherwise>
                            <syswf:param name="interactive" value="false"/>
                        </c:otherwise>
                    </c:choose>
                    <syswf:param name="showRule" value="false"/>
                </syswf:component>

                <syswf:component prefix="transitionDialog" name="/newUi/lc/admin/visualization/editTransitionDialog">
                    <syswf:param name="processId" value="${process.id}"/>
                    <syswf:param name="flashObjectId" value="process-visualization"/>
                </syswf:component>

                <div class="UI Text Description"><c:out value="${process.description}" escapeXml="false"/></div>

                <syswf:block className="UI Block Common">
                		<c:if test="${not empty viewGPBean.defaultProcessState}">
                		<table class="UI Table Properties">
                            <col class="LabelCol"/>
                            <col/>
                            <tbody>
                             <tr>
                                <td>${goalLifecycleStage}</td>
                                <td><c:out value="${viewGPBean.defaultProcessState}"/></td>
                            </tr>
                            </tbody>
                    	</table>
                    	</c:if>
                    <div class="Title">
                        <h3>
                            <span><fmt:message key="processTabOverview.applicableToTitle" bundle="${messages}"/></span>
                        </h3>
                    </div>
                    <div class="Content">
                        <table class="UI Table Properties">
                            <col class="LabelCol"/>
                            <col/>
                            <tbody>
                            <tr>
                                <td>${rootArtifactType}</td>
                                <td><c:out value="${viewGPBean.primaryATLabel}"/></td>
                            </tr>
                            <c:if test="${not empty viewGPBean.applicableToLabel}">
                                <tr>
                                    <fmt:message key="processTabOverview.subArtifactTypes" var="subArtifactTypes" bundle="${messages}"/>
                                    <td>${subArtifactTypes}</td>
                                    <td><c:out value="${viewGPBean.applicableToLabel}"/></td>
                                </tr>
                            </c:if>
                            <tr>
                                <td>${traverseArchimateRelationships}</td>
                                <c:choose>
                                    <c:when test="${viewGPBean.process.traverseArchimateRels}">
                                        <td><fmt:message key="processTabOverview.yesLabel" bundle="${messages}"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><fmt:message key="processTabOverview.noLabel" bundle="${messages}"/></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <td>${traverseComposeOfonly}</td>
                                <c:choose>
                                    <c:when test="${viewGPBean.process.traverseComposeOfRel}">
                                        <td><fmt:message key="processTabOverview.yesLabel" bundle="${messages}"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><fmt:message key="processTabOverview.noLabel" bundle="${messages}"/></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <fmt:message key="processTabOverview.automaticallyAssigned" var="newGP_automaticallyAssigned" bundle="${messages}"/>
                                <td>${newGP_automaticallyAssigned}</td>
                                <c:choose>
                                    <c:when test="${viewGPBean.process.defaultProcess}">
                                        <td><fmt:message key="processTabOverview.yesLabel" bundle="${messages}"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><fmt:message key="processTabOverview.noLabel" bundle="${messages}"/></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${not empty inCategoriesWidgetModel.value.categories}">
                        <fmt:message key="processTabOverview.positiveCategoriesLabel" var="positiveCategoriesLabel" bundle="${messages}"/>
                        <syswf:component prefix="inCategories" name="/core/impl/widget/categoryBagWidget">
                            <syswf:param name="model" value="${inCategoriesWidgetModel}"/>
                            <syswf:param name="mode" value="view"/>
                            <syswf:param name="title" value="${positiveCategoriesLabel}"/>
                        </syswf:component>
                    </c:if>

                    <c:if test="${not empty notInCategoriesWidgetModel.value.categories}">
                        <fmt:message key="processTabOverview.negativeCategoriesLabel" var="negativeCategoriesLabel" bundle="${messages}"/>
                        <syswf:component prefix="notInCategories" name="/core/impl/widget/categoryBagWidget">
                            <syswf:param name="model" value="${notInCategoriesWidgetModel}"/>
                            <syswf:param name="mode" value="view"/>
                            <syswf:param name="title" value="${negativeCategoriesLabel}"/>
                        </syswf:component>
                    </c:if>

                    <c:if test="${not empty inDomainsModel.value}">
                        <fmt:message key="processTabOverview.inDomainsLabel" var="inDomainsLabel" bundle="${messages}"/>
                        <syswf:component prefix="inDomains" name="/core/category/domainBag" ajax="true">
                            <syswf:param name="model" value="${inDomainsModel}"/>
                            <syswf:param name="mode" value="view"/>
                            <syswf:param name="title" value="${inDomainsLabel}"/>
                        </syswf:component>
                    </c:if>

                </syswf:block>
            </div>

