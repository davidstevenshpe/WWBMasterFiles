<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:control mode="script" caption="${controlName}" action="${controlAction}">
    <c:if test="${not empty selectionBag}">
        <syswf:param name="selectionBag" value="${selectionBag}"/>
    </c:if>
</syswf:control>
