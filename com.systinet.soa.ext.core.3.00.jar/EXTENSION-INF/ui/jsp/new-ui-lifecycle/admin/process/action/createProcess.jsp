<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canCreate" type="java.lang.Boolean"--%>

<c:if test="${canCreate}">
    <syswf:control mode="script" caption="${controlName}" targetTask="/admin/lifecycle/process/newProcess"/>
</c:if>
