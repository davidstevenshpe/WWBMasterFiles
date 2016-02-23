<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${visible}">
    <syswf:component name="/core/layout/dropdownsInternal" prefix="t" ajax="true" loadingMask="true">
        <syswf:param name="tabs" value="${tabs}" />
        <syswf:param name="widthDropdown" value="200" /><%-- set width for dropdown menu manually --%>
        <syswf:param name="isAddPrefixText" value="true" /><%-- add "Select from:" text in front of Dropdown --%>
    </syswf:component>
</c:if>
 