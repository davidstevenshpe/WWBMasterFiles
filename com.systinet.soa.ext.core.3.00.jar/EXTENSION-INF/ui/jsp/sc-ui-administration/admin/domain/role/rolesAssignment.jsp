<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />

<div class="flex-container">
    <div style="flex-grow:1;" class="UI Middle">
        <table class="UI Layout">
            <tbody>
                <tr>
                    <td><label class ="UI Icon Info"><fmt:message key="rolesAssignment.note" bundle="${domain_Messages}" /></label></td>
                </tr>
                <tr>
                    <td class="UI Middle">
                        <syswf:block className="UI Block Common">
                            <div class="Content">
                            <table class="UI Table ExpressionBuilder Plain">
                                <col style="width:300px;" />
                                <col />
                                <tr>
                                    <td class="Roles">
                                        <div class="Title">
                                            <h3><span>
                                            <fmt:message key="rolesAssignment.role.header" bundle="${domain_Messages}" />
                                            </span></h3>
                                        </div>                          
                                        <syswf:component name="/admin/domain/role/browseRole" prefix="browseRole">                                                                      
                                            <syswf:param name="raHolder" value="${raHolder}" />
                                            <syswf:param name="rolesSummary" value="${rolesSummary}" />
                                        </syswf:component>
                                    </td>
                                    <td class="Members">
                                        <div class="Title">
                                            <h3><span>
                                                <fmt:message key="rolesAssignment.member.header" bundle="${domain_Messages}" />
                                                <syswf:out value="${raHolder.currentRoleName}" context="HtmlBody"/>
                                            </span></h3>
                                        </div>                          
                                        <syswf:component name="/admin/domain/role/addMembersRole" prefix="addMembersRole">
                                            <syswf:param name="raHolder" value="${raHolder}" />
                                        </syswf:component>
                                    </td>
                                </tr>
                            </table>
                            </div>
                        </syswf:block>              
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
    

