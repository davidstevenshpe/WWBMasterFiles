<%--

Params:

jsOpenFunction = name of a function that opens the window, has to be bound to an element onClick method. 
                Method should be prefixed correctly, but otherwise its name is not limited.
windowTitle = title of the opened window
holder - implementation of PrincipalSelectorListener

overrideselectionModel - overrides default "one" selection mode on table. Send "multiple" to have checkboxes

disableRolesTab - disables roles tab (at least one tab must be enabled)
disableUsersTab - disables users tab (at least one tab must be enabled)
disableGroupsTab - disables groups tab (at least one tab must be enabled)
enablePersonsTab - adds tab Persons (works on DQL and returns UUID as selection!)
enableOrgUnitsTab - adds tab Persons (works on DQL and returns UUID as selection!)

rolesDataSource - custom datasource
usersDataSource - custom datasource
groupsDataSource - custom datasource
personsDataSource - custom datasource
orgUnitsDataSource - custom datasource

domainId - param for rolesDataSource - lists only roles assignable to the domain

winCancelAction - sent to /core/window component - see its documentation

availableArtifactTypes - list of artifact types to search in (for suggested search)
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:if test="${empty windowTitle}">
    <fmt:message bundle="${messages}" var="windowTitle" key="principalSelector.defaultTitle"/>
</c:if>

<c:if test="${empty selectorWidth}">
    <c:set var="selectorWidth" value="550" />
</c:if>

<syswf:component name="/core/window" prefix="selector">
    <syswf:param name="winId" value="${prefix}window" />
    <syswf:param name="winTitle" value="${windowTitle}" />
    <syswf:param name="winComponent" value="/core/impl/principal/selectorWindow" />
    <syswf:param name="winOpenFunctionName" value="${jsOpenFunction}" />
    <syswf:param name="winOkLabel"><fmt:message bundle="${messages}" key="Select" /></syswf:param>
    <syswf:param name="winOkAction" value="${prefix}principalSelected" />
    
    <syswf:param name="winWidth" value="${selectorWidth}" />
    <syswf:param name="selectorWidth" value="${selectorWidth}" />
    
    <syswf:param name="winCancelAction" value="${winCancelAction}" />
    
    <syswf:param name="winRenderAlways" value="true" />
    
    <syswf:param name="searchExpressionWrapper" value="${searchExpressionWrapper}"/>
    <syswf:param name="listener" value="${holder}"/>
    <syswf:param name="myWindowId" value="${prefix}window" />
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="tableSelectionBag" value="${this.tableSelectionBag}" />
    <syswf:param name="overrideselectionModel" value="${overrideselectionModel}" />
    <syswf:param name="allowBlockedAccounts" value="${allowBlockedAccounts}" />
    
    <syswf:param name="disableRolesTab" value="${disableRolesTab}" />
    <syswf:param name="disableUsersTab" value="${disableUsersTab}" />
    <syswf:param name="disableGroupsTab" value="${disableGroupsTab}" />
    
    <syswf:param name="enablePersonsTab" value="${enablePersonsTab}" />
    <syswf:param name="enableOrgUnitsTab" value="${enableOrgUnitsTab}" />
    <syswf:param name="enableContactsTab" value="${enableContactsTab}" />

    <syswf:param name="rolesDataSource" value="${rolesDataSource}" />
    <syswf:param name="usersDataSource" value="${usersDataSource}" />
    <syswf:param name="groupsDataSource" value="${groupsDataSource}" />
    
    <syswf:param name="personsDataSource" value="${personsDataSource}" />
    <syswf:param name="orgUnitsDataSource" value="${orgUnitsDataSource}" />
    
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}" />
    
    <syswf:param name="domainId" value="${domainId}" />
</syswf:component>

<syswf:control mode="ajax" caption="${prefix}principalSelected" action="principalSelected" />