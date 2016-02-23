<%--

Component:      wizardIterator
--------------------------------
Description:
This component enables a wizard scenario and handles the navigation between
the wizard steps. It renders the wizard navigation buttons as Next, Previous,
Cancel and Finish. It is also able to render the complete list of the steps
names with an active step name highlighted.

Parameters:
--------------------------------
steps : com.hp.systinet.sc.ui.wizard.struct.Steps
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
<fmt:setBundle basename="com.systinet.platform.ui.util.UtilMessages" var="util_Message"/>

<%-- Get Message. --%>
<fmt:message key="cancel" var="cancel" bundle="${tornadoui_Message}"/>
<fmt:message key="next" var="next" bundle="${tornadoui_Message}"/>
<fmt:message key="back" var="back" bundle="${tornadoui_Message}"/>
<fmt:message key="finish" var="finish" bundle="${tornadoui_Message}"/>
<fmt:message key="wizardIterator_cancelWizard" var="cancelWizard" bundle="${util_Message}"/>
<fmt:message key="wizardIterator_finishWizard" var="finishWizard" bundle="${util_Message}"/>

<table class="UI Layout">
<tbody>
<tr>
<td class="UI Middle">

<div class="WizardContent">
    <syswf:component name="${controller.currentStep.component}" prefix="step${controller.cursorPosition}" wrap="false">
        <syswf:param name="context" value="${controller.wizardContext}"/>
    </syswf:component>
</div>


<%-- Start of buttons --%>
<div class="UI Block Green">
<div class="UI Edge">
<div class="UI Edge">
<div class="UI Edge">
<div class="UI Edge">
    <div class="UI Canvas">
        <div class="UI Form Controls">

            <%-- Back button --%>
            <c:if test="${controller.steps.showDisabledButtons or controller.previousAllowed}">
                <syswf:control caption="${back}" mode="button" action="previousStep" hint="${controller.previousStep.label}" disabled="${not controller.previousAllowed}">
                        <syswf:attribute name="class" value="btn btn-gray"/>
                </syswf:control>
            </c:if>

            <%-- Next button --%>
            <c:if test="${controller.steps.showDisabledButtons or controller.nextAllowed}">
                <syswf:control caption="${next}" mode="button" action="nextStep" hint="${controller.previousStep.label}" disabled="${not controller.nextAllowed}">
                        <syswf:attribute name="class" value="btn btn-primary"/>
                </syswf:control>
            </c:if>

            <%-- Finish button --%>
            <c:if test="${controller.steps.showDisabledButtons or controller.finishAllowed}">
                <syswf:control caption="${finish}" mode="button" action="${prefix}$commit" hint="${finishWizard}" disabled="${not controller.finishAllowed}"
                      targetDepth="${sessionStack.currentDepth+controller.finishTargetDepth}">
                        <syswf:attribute name="class" value="btn btn-primary"/>
                </syswf:control>
            </c:if>

            <%-- Cancel button --%>
            <c:if test="${controller.steps.showDisabledButtons or controller.cancelAllowed}">
                <syswf:control caption="${cancel}" mode="button" action="${prefix}$rollback" hint="${cancelWizard}" disabled="${not controller.cancelAllowed}"
                        targetDepth="${sessionStack.currentDepth+controller.cancelTargetDepth}">
                        <syswf:attribute name="class" value="btn btn-gray"/>
                </syswf:control>
            </c:if>

        </div>
    </div>
</div>
</div>
</div>
<%-- End of buttons --%>

</td>

<c:if test="${controller.steps.showProgress}">
<td class="UI Right">
    <div class="UI Block Green">
        <div class="UI Edge">
            <div class="UI Edge">
                <div class="UI Edge">
                    <div class="UI Canvas">
                        <div class="Title">
                            <h3><span>${controller.steps.label}</span></h3>
                        </div>
                        <div class="Content">
                            <ul class="UI WizardGuide">
                                <c:set var="counter" scope="request" value="${0}"/>
                                <c:forEach var="step" items="${controller.steps.steps}">
                                    <c:choose>
                                        <c:when test="${counter == controller.cursorPosition}">
                                            <li class="Active">
                                        </c:when>
                                        <c:otherwise>
                                            <li class="WizardStep">
                                        </c:otherwise>
                                    </c:choose>
                                    <span>
                                      <c:out value="${step.label}"/>
                                    </span>
                                    </li>
                                    <c:set var="counter" scope="request" value="${counter + 1}"/>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</td>
</c:if>
</tr>
</tbody>
</table>
<%-- wizardIterator.jsp end --%>