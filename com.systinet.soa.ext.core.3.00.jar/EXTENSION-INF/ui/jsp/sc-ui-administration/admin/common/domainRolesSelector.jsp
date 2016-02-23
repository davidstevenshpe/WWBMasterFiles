<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="viewProfile_Messages" />
<fmt:message var ="winTitle" key="viewProfile.selectRole.caption" bundle="${viewProfile_Messages}" />
<fmt:message var ="setActionLabel" key="viewProfile.selectRole.set_action" bundle="${viewProfile_Messages}" />
<fmt:message var ="confirmationHeader" key="viewProfile.selectRole.set_action.confirmation" bundle="${viewProfile_Messages}" />
<fmt:message var ="confirmationMsg" key="viewProfile.selectRole.set_action.confirmation_msg" bundle="${viewProfile_Messages}" />

<syswf:input id="domainIdParam" name="domainIdParam" value="" mode="hidden"/>

<c:choose>
    <c:when test="${not empty affectOnComponent}">
        <syswf:control mode="script" action="changeDomainRoles" caption="${prefix}_changeDomainRoles" id="changeDomainRoles" affects="${affectOnComponent}" loadingMask="true"/>
    </c:when>
    <c:otherwise>
        <syswf:control mode="script" action="changeDomainRoles" caption="${prefix}_changeDomainRoles" id="changeDomainRoles" />
    </c:otherwise>
</c:choose>

<syswf:component name="/core/window" prefix="addResourceCredential">
    <syswf:param name="winTitle" value="${winTitle}" />
    <syswf:param name="winComponent" value="/admin/common/domainRolesSelectorWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openDomainRoleWindow" />
    <syswf:param name="winWidth" value="500" />
    <syswf:param name="winOkAction" value="${prefix}_changeDomainRoles" />
    <syswf:param name="winOkLabel" value="${setActionLabel}" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="principalDomainHolder" value="${principalDomainHolder}" />
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="winGetParamsFunctionName" value="editDialog_getParams" />
    <syswf:param name="inheritedRolesBag" value="${inheritedRolesBag}"/>
</syswf:component>
<script type="text/javascript">
//<![CDATA[

    function storeEditingProperties(domainId) {
        Ext.get('domainIdParam').dom.value = domainId;
    }
    
    function editDialog_getParams() {
        return {
            'domainIdParam' : Ext.get('domainIdParam').dom.value
        };
    }
    
    function ${openDialogFunction}(domainId) {
        storeEditingProperties(domainId);
        ${prefix}openDomainRoleWindow();
    }

//]]>
</script>
