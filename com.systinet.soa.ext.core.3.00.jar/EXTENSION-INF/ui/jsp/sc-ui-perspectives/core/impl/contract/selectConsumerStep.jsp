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
<fmt:message key="contractrequest.wizard.selectconsumer.header" var="selectConsumerHeader"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectconsumer.description" var="selectConsumerDescription"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectconsumer.message.info" var="infoMessage"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectconsumer.consumer" var="consumer"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectconsumer.changeconsumer" var="changeconsumer"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.in" var="in" bundle="${tornadoui_Message}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${selectConsumerHeader}"/>
</syswf:component>

<div class="UI Text Description">
    <p>
        <c:out value="${selectConsumerDescription}"/>
    </p>
</div>

<div class="Paragraph Tip">
    <p>
        <c:out value="${infoMessage}"/>
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
                            <h3><span><c:out value="${consumer}"/></span></h3>
                        </div>
                        <div class="Content">
                            <table class="UI Table Properties">
                                <colgroup>
                                    <col class="LabelCol"/>
                                    <col/>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th>
                                        <label class="UI Label Inline"><c:out value="${consumerSDMLabel}"/>:</label>
                                    </th>
                                    <%-- TODO REVIEW (Svata, 4/05/2009): Coding: This part is copy-pasted from ProviderView component. Refactor and reuse --%>
                                    <c:choose>
                                        <c:when test="${not sameConsumerAndOwner}">
                                            <td>
                                                <c:choose>
                                                    <c:when test="${consumerIsVisible}">
                                                        <syswf:component prefix="providerView1"
                                                                         name="/core/impl/util/artifactLinkRenderer"
                                                                         wrap="false">
                                                            <syswf:param name="caption" value="${consumerName}"/>
                                                            <syswf:param name="uuid" value="${consumerUuid}"/>
                                                        </syswf:component>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span><c:out value="${consumerName}"/></span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:out value=" ${in} "/>
                                                <syswf:component prefix="providerView2"
                                                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                                    <syswf:param name="caption" value="${consumerOwnerName}"/>
                                                    <syswf:param name="uuid" value="${consumerOwnerUuid}"/>
                                                </syswf:component>
                                            </td>
                                        </c:when>
                                        <c:when test="${sameConsumerAndOwner}">
                                            <td>
                                                <syswf:component prefix="providerView3"
                                                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                                    <syswf:param name="caption" value="${consumerOwnerName}"/>
                                                    <syswf:param name="uuid" value="${consumerOwnerUuid}"/>
                                                </syswf:component>
                                                <c:if test="${not empty consumerServiceType}">
                                                    <span> (<c:out value="${consumerServiceType}"/>)</span>
                                                </c:if>
                                            </td>
                                        </c:when>
                                    </c:choose>
                                </tr>
                                <tr>
                                    <th/>
                                    <td>
                                        <div class="x-hidden" id="consumer_change_source">
                                            <%-- TODO REVIEW (Svata, 4/05/2009): Maturity: I18N --%>
                                            <div class="x-window-header">Find Consumer Artifact</div>
                                            <div class="x-window-body">
                                                <div class="UI Offset">
                                                    <%-- TODO REVIEW (Svata, 4/05/2009): Style: use simple prefixes --%>
                                                    <syswf:component name="/core/impl/wizard" ajax="true"
                                                                     prefix="analyst.contractRequestWizard.selectConsumerStep">
                                                        <syswf:param name="customizationId"
                                                                     value="analyst.contract.consumer.contractRequestConsumerWizard"/>
                                                        <syswf:param name="controller" value="${controller}"/>
                                                    </syswf:component>
                                                </div>
                                            </div>
                                        </div>
                                        <a id="consumer_change" class="UI Icon Edit"
                                           href="#"><span><c:out value="${changeconsumer}"/></span></a>
                                        <script type="text/javascript">
//<![CDATA[

                                            var changeConsumptionButtons = [];
                                            SPopup.Window.init('consumer_change', 'consumer_change_source', {width:900,autoHeight:true,buttons:changeConsumptionButtons});
                                        
//]]>
</script>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>