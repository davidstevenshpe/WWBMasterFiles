<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not hideComponent}">

    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />

    <%-- action control - fires action after user presses OK --%>
    <syswf:control mode="script" action="addPrincipal" caption="${prefix}addPrincipal" >
        <syswf:param name="selectionBag" value="${selectionBag}" />
    </syswf:control>

    <c:if test="${empty select_title}">
    <fmt:message key="editUsers.setOwnership_title" bundle="${user_Messages}" var="select_title"/>
    </c:if>
    <syswf:component name="/core/principal/selector" prefix="ownerByPricipalSelector">
        <syswf:param name="jsOpenFunction" value="${prefix}open" />
        <syswf:param name="windowTitle" value="${select_title}"/>
        <syswf:param name="holder" value="${holder}" />
        <syswf:param name="selectionBag" value="${selectionBag}" />
        <syswf:param name="wrapCaption" value=""/>
        <syswf:param name="groupsDataSource" value="${groupsDataSource}"/>
        <syswf:param name="overrideselectionModel" value="${selectionMode}" />
        <c:if test="${not empty disableRolesTab}">
            <syswf:param name="disableRolesTab" value="${disableRolesTab}" />
        </c:if>
        <c:if test="${not empty disableGroupsTab}">
            <syswf:param name="disableGroupsTab" value="${disableGroupsTab}" />
        </c:if>
        <c:if test="${not empty disableUsersTab}">
            <syswf:param name="disableUsersTab" value="${disableUsersTab}" />
        </c:if>
        <c:if test="${not empty domainId}">
            <syswf:param name="domainId" value="${domainId}" />
        </c:if>
    </syswf:component>

    <script type="text/javascript">
//<![CDATA[

    var ${controlName} = function() {
        ${prefix}open();
    }
    
//]]>
</script>

</c:if>