<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- action control - fires action after user presses Remove favorites --%>

<syswf:control mode="script" caption="${controlName}" action="${controlAction}" />

<%-- confirmation dialog
<syswf:control mode="script" caption="${prefix}_removeFavorites" action="${controlAction}" />

<syswf:block className="UI Block Green">
    <syswf:component name="/core/util/confirmPopUp" prefix="deletePopUp">
        <syswf:param name="winOpenFunctionName" value="${controlName}" />
        <syswf:param name="winOkAction" value="${prefix}_removeFavorites" />
        <syswf:param name="confirmMessage" value="Really?" />
        <syswf:param name="title" value="Delete from favorites" />
    </syswf:component>
</syswf:block>
--%>