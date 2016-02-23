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
<fmt:message key="contractrequest.wizard.selectslo.button.changeconsumptiontarget" var="changeConsumptionTarget"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.label.providedby" var="providedby" bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.in" var="in" bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.popup.selectconsumptiontarget" var="selectconsumptiontarget"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.popup.cancel" var="cancel" bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.selectslo.popup.select" var="select" bundle="${tornadoui_Message}"/>


<tr>
    <th>
        <%--TODO REVIEW (Svata, 4/05/2009): Coding:P2 do not use c:out for simple output. use ${} EL directly --%>
        <label class="UI Label Inline"><c:out value="${producerSDMLabel}"/>:</label>
    </th>
    <c:choose>
        <c:when test="${not sameProviderAndOwner}">
            <td>
                <c:choose>
                    <c:when test="${providerIsVisible}">
                        <syswf:component prefix="providerView"
                                         name="/core/impl/util/artifactLinkRenderer" wrap="false">
                            <syswf:param name="caption" value="${providerName}"/>
                            <syswf:param name="uuid" value="${providerUuid}"/>
                        </syswf:component>
                    </c:when>
                    <c:otherwise>
                        <span><c:out value="${providerName}"/></span>
                    </c:otherwise>
                </c:choose>
                <c:out value=" ${in} "/>
                <%-- TODO REVIEW (Svata, 4/05/2009): Error - same prefix is used for more components--%>
                <syswf:component prefix="providerView2"
                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                    <syswf:param name="caption" value="${providerOwnerName}"/>
                    <syswf:param name="uuid" value="${providerOwnerUuid}"/>
                </syswf:component>
            </td>
        </c:when>
        <c:when test="${sameProviderAndOwner}">
            <td>
                <syswf:component prefix="providerView3"
                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                    <syswf:param name="caption" value="${providerOwnerName}"/>
                    <syswf:param name="uuid" value="${providerOwnerUuid}"/>
                </syswf:component>
                <c:if test="${not empty providerServiceType}">
                    <span> (<c:out value="${providerServiceType}"/>)</span>
                </c:if>
            </td>
        </c:when>
    </c:choose>
</tr>
<c:if test="${editProvider}">
    <tr>
        <th/>
        <td>
            <a class="UI Icon Edit" href="javascript:void(0)"
               id="changeConsumptionTargetId">
                <span><c:out value="${changeConsumptionTarget}"/><span/></span>
            </a>

            <div class="x-hidden" id="changeConsumptionTargetWindowId">
                <div class="x-window-header"><c:out value="${selectconsumptiontarget}"/></div>
                <div class="x-window-body">
                    <div class="UI Offset">
                        <syswf:component name="/core/impl/tree/table" prefix="contractRequestProviderTreeTable">
                            <syswf:param name="customizationId"
                                         value="partner.contract.contractRequestProviderTreeTable"/>
                            <syswf:param name="uuid" value="${providerOwnerUuid}"/>
                            <syswf:param name="reportType" value="${reportType}"/>
                            <syswf:param name="availableArtifacts" value="${availableArtifacts}"/>
                            <syswf:param name="datasourceInstance" value="${datasourceInstance}"/>
                            <syswf:param name="selection" value="${selection}"/>
                            <syswf:param name="availableProviderTypes" value="${availableProviderTypes}"/>
                        </syswf:component>
                    </div>
                </div>
            </div>
            <syswf:control caption="reloadPageFunction" mode="script" action="reloadPage" formName="ContentForm" targetDepth="${sessionStack.currentDepth}"/>
            <script type="text/javascript">
//<![CDATA[
                
                var changeConsumptionButtons = [
                {
                    text:'<c:out value="${select}"/>',
                    handler: reloadPageFunction,
                    id: '${prefix}_selectButton'
                },{
                    text:'<c:out value="${cancel}"/>',
                    handler:function() {
                        SPopup.Window.Instance['changeConsumptionTargetId'].hide();
                    },
                    id: '${prefix}_cancelButton'
                }];
                SPopup.Window.init('changeConsumptionTargetId', 'changeConsumptionTargetWindowId', {width:600,autoHeight:true,buttons:changeConsumptionButtons,centerOnScreen:true});
            
//]]>
</script>                           
        </td>
    </tr>
</c:if>
<c:if test="${(not empty showProvidedBy) and (showProvidedBy)}">
    <tr>
        <th><label class="UI Label Inline"><c:out value="${providedby}"/>:</label></th>
        <td>
            <syswf:component prefix="providerView4"
                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                    <syswf:param name="caption" value="${providedByName}"/>
                    <syswf:param name="uuid" value="${providedByUuid}"/>
                </syswf:component>
        </td>
    </tr>
</c:if>