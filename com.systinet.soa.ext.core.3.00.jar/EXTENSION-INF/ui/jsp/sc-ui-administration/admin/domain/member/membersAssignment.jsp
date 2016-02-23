<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message var="winTitle" key="membersAssignment.roleselector.label" bundle="${domain_Messages}" />

<syswf:input id="principalName" name="principalName" value="" mode="hidden"/>
<syswf:input id="principalCategory" name="principalCategory" value="" mode="hidden"/>

<syswf:control mode="script" action="changeDomainRoles" caption="${prefix}_changeDomainRoles" id="changeDomainRoles" />

<syswf:component name="/core/window" prefix="addResourceCredential">
    <syswf:param name="winTitle" value="${winTitle}"/>
    <syswf:param name="winComponent" value="/admin/domain/member/memberRolesSelector"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openDomainRolesSelector" />
    <syswf:param name="winWidth" value="530" />
    <syswf:param name="winOkAction" value="${prefix}_changeDomainRoles" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="rolesSelectHolder" value="${rolesSelectHolder}" />
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="winGetParamsFunctionName" value="editDialog_getParams" />
    <syswf:param name="inheritedRolesBag" value="${inheritedRolesBag}"/>
</syswf:component>
<script type="text/javascript">
//<![CDATA[

    function storePrincipalName(name, category) {
        Ext.get('principalName').dom.value = name;
        Ext.get('principalCategory').dom.value = category;
    }
    
    function editDialog_getParams() {
    	return {
            'principalName' : Ext.get('principalName').dom.value,
            'principalCategory' : Ext.get('principalCategory').dom.value
        };
    }
    


//]]>
</script>

<div class="flex-container">
    <div style="flex-grow:1;" class="UI Middle">
        <syswf:block className="UI Block Common">
            <div class="Content">
                <table class="UI Table Layout">
                    <tr>
                        <td>
                            <div class="Title"><h3><fmt:message key="membersAssignment.users.label" bundle="${domain_Messages}" /></h3></div>
                            <syswf:component name="/core/table" prefix="browseUserProfile" wrap="false">
                                <syswf:param name="customizationId" value="admin.domain.member.tableDomainUsers" />
                                <syswf:param name="openDialogFunction" value="${prefix}openDomainRolesSelector"/>
                            </syswf:component>
                            <br>
                            <div class="Title"><h3><fmt:message key="membersAssignment.groups.label" bundle="${domain_Messages}" /></h3></div>
                            <syswf:component name="/core/table" prefix="browseGroup" wrap="true">
                                <syswf:param name="customizationId" value="admin.domain.member.tableDomainGroups" />
                                <syswf:param name="openDialogFunction" value="${prefix}openDomainRolesSelector"/>       
                            </syswf:component>
                        </td>
                    </tr>
                </table>
            </div>
        </syswf:block>
    </div>
</div>

	
   