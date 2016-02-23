<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>

<%-- Get Message. --%>
<fmt:message key="contractrequest.wizard.selectslo.header" var="sloHeader" bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.description.${activeTab}" var="sloDescription"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.message.info.${activeTab}" var="infoMessage"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.message.info.no-slo" var="infoMessageNoSLO"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.table.header" var="tableSloHeader" bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.title.consumptiontarget" var="consumptionTarget"
             bundle="${tornadoui_Message}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${sloHeader}"/>
</syswf:component>

<div class="UI Text Description">
    <p>
        <c:out value="${sloDescription}"/>
    </p>
</div>

<div class="Paragraph Tip">
    <p>
        <c:choose>
            <c:when test="${noSLO}">
                <c:out value="${infoMessageNoSLO}"/>
            </c:when>
            <c:otherwise>
                <c:out value="${infoMessage}"/>
            </c:otherwise>
        </c:choose>
    </p>
</div>

<%-- TODO REVIEW (Svata, 4/05/2009): Coding: use syswf:block --%>
<div class="UI Block Common">
    <div class="UI Edge">
        <div class="UI Edge">
            <div class="UI Edge">
                <div class="UI Edge">
                    <div class="UI Canvas">
                        <div class="Title">
                            <h3><span><c:out value="${consumptionTarget}"/></span></h3>
                        </div>
                        <div class="Content">
                            <table class="UI Table Properties">
                                <colgroup>
                                    <col class="LabelCol"/>
                                    <col/>
                                </colgroup>
                                <tbody>
                                <syswf:component name="/core/impl/contract/providerView"
                                                 prefix="providerView" wrap="false">
                                    <syswf:param name="editProvider" value="${editProvider}"/>
                                    <syswf:param name="showProvidedBy" value="${showProvidedBy}"/>
                                    <syswf:param name="reportType" value="${reportType}"/>
                                    <syswf:param name="selectionBag" value="${selectionBag}"/>
                                </syswf:component>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${not noSLO}">
    <div class="UI Block Common">
        <div class="UI Edge">
            <div class="UI Edge">
                <div class="UI Edge">
                    <div class="UI Edge">
                        <div class="UI Canvas">
                            <div class="Title">
                                <h3><span><c:out value="${tableSloHeader}"/></span></h3>
                            </div>
                            <div class="Content" id="ext-gen16">
                                <syswf:component name="/core/table" prefix="contractRequestSloTable">
                                    <syswf:param name="customizationId"
                                                 value="partner.contract.contractRequestSloTable"/>
                                    <syswf:param name="selectionBag" value="${selectionBag}"/>
                                    <syswf:param name="providedByUuid" value="${providedByUuid}"/>
                                    <syswf:param name="providerOwnerUuid" value="${providerOwnerUuid}"/>
                                </syswf:component>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>