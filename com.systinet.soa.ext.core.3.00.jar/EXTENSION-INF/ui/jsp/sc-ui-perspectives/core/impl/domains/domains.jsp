<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3>Domains</h3>
    </div>
    <div class="Content">
        <table cellspacing="10">
            <tr>
                <th>Domain ID</th>
                <th>Parent Domain ID</th>
                <th>Name</th>
                <th>&nbsp;</th>
            </tr>
            <c:forEach var="domain" items="${domains}" varStatus="status">
                <tr>
                    <td>${domain.domainId}</td>
                    <td>${domain.parentDomainId}</td>
                    <td><syswf:out value="${domain.name}" context="HtmlBody"/></td>
                    <td>
                        <c:if test="${domain.domainId != 'topLevelDomain' and domain.domainId != 'defaultDomain'}">
                            <syswf:control mode="postAnchor" action="removeDomain"  caption="Remove" id="domain${status.index}">
                                <syswf:param name="domainId" value="${domain.domainId}"/>
                            </syswf:control>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td>
                    <syswf:input name="newDomainId" value="${newDomain}" property="domainId"/>
                </td>
                <td>&nbsp;</td>
                <td>
                    <syswf:input name="newDomainName" value="${newDomain}" property="name"/>
                </td>
                <td>
                    <syswf:control mode="postAnchor" action="addDomain" caption="Add"/>
                </td>
            </tr>
        </table>
    </div>
</syswf:block>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3>Roles</h3>
    </div>
    <div class="Content">
        <table cellspacing="10">
            <tr>
                <th>Role ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>License Feature</th>
                <th>Subroles</th>
                <th>&nbsp;</th>
            </tr>
            <c:forEach var="role" items="${roles}" varStatus="status">
                <tr>
                    <td>${role.roleId}</td>
                    <td><syswf:out value="${role.name}" context="HtmlBody"/></td>
                    <td><syswf:out value="${role.description}" context="HtmlBody"/></td>
                    <td><syswf:out value="${role.licenseFeature}" context="HtmlBody"/></td>
                    <td>
                        <c:forEach var="subRole" items="${role.subRoles}">
                            <syswf:out value="${subRole.child}" context="HtmlBody"/><br/>
                        </c:forEach>
                    </td>
                    <td>
                        <syswf:selectOne mode="menu" name="newSubRole_${role.roleId}" value=""
                            optionValues="${roles}" optionValuesProperty="roleId"/>

                        <syswf:control mode="postAnchor" action="addSubRole"  caption="Add Subrole" id="subRole${status.index}">
                            <syswf:param name="roleId" value="${role.roleId}"/>
                        </syswf:control>
                        <br>

                        <syswf:control mode="postAnchor" action="removeRole"  caption="Remove" id="role${status.index}">
                            <syswf:param name="roleId" value="${role.roleId}"/>
                        </syswf:control>

                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td>
                    <syswf:input name="newRoleId" value="${newRole}" property="roleId"/>
                </td>
                <td>
                    <syswf:input name="newRoleName" value="${newRole}" property="name"/>
                </td>
                <td>
                    <syswf:input name="newRoleDescription" value="${newRole}" property="description"/>
                </td>
                <td>
                    <syswf:input name="newRoleLicnese" value="${newRole}" property="licenseFeature"/>
                </td>
                <td>&nbsp;</td>
                <td>
                    <syswf:control mode="postAnchor" action="addRole" caption="Add"/>
                </td>
            </tr>
        </table>
    </div>
</syswf:block>


<syswf:block className="UI Block Common">
    <div class="Title">
        <h3>Role Assignments</h3>
    </div>
    <div class="Content">
        <table cellspacing="10">
            <tr>
                <th>Domain ID</th>
                <th>Role ID</th>
                <th>Principal Name</th>
                <th>Principal Type</th>
                <th>&nbsp;</th>
            </tr>
            <c:forEach var="roleAssignment" items="${roleAssignments}" varStatus="status">
                <tr>
                    <td>${roleAssignment.domainId}</td>
                    <td>${roleAssignment.roleId}</td>
                    <td><syswf:out value="${roleAssignment.principal.principalName}" context="HtmlBody"/></td>
                    <td><syswf:out value="${roleAssignment.principal.principalCategory}" context="HtmlBody"/></td>
                    <td>
                        <syswf:control mode="postAnchor" action="removeRoleAssignment" caption="Remove" id="roleAssign${status.index}">
                            <syswf:param name="roleId" value="${roleAssignment.roleId}"/>
                            <syswf:param name="domainId" value="${roleAssignment.domainId}"/>
                            <syswf:param name="principal" value="${roleAssignment.principal}"/>
                        </syswf:control>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td>
                    <syswf:selectOne mode="menu" name="newRoleAssignDomainId" value="${newRoleAssignment}" property="domainId"
                            optionValues="${domains}" optionValuesProperty="domainId"/>
                </td>
                <td>
                    <syswf:selectOne mode="menu" name="newRoleAssignId" value="${newRoleAssignment}" property="roleId"
                            optionValues="${roles}" optionValuesProperty="roleId"/>
                </td>
                <td colspan="2">
                    <syswf:input name="newRoleAssignPrincipalName" value="${newRoleAssignment.principal}" property="principalName"/>
                </td>
                <td>
                    <syswf:control mode="postAnchor" action="addRoleAssignment" caption="Add"/>
                </td>
            </tr>
        </table>
    </div>
</syswf:block>
