<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${this.permissions.pureWrite}">

<syswf:component name="/core/impl/recycleBin/deletePermanently" prefix="dp">
    <syswf:param name="uuid" value="${artifact._uuid}" />
    <syswf:param name="controlName" value="${prefix}purge" />
    <syswf:param name="controlAction" value="deletePermanently" />
</syswf:component>

</c:if>