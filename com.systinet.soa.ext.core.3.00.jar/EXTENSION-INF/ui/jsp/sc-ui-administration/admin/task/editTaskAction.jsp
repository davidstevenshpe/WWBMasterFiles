<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="canDisplayButton" type="boolean"--%>
<c:if test="${canDisplayButton}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="messages"/>
    <fmt:message var="edit_buttonLabel" key="CONTEXT_ACTION_EDIT_LABEL" bundle="${messages}"/>
    <syswf:control mode="anchor" targetTask="/${this.activeView}/task/editTaskArtifact" caption="">
        <syswf:attribute name="class">context-button Edit</syswf:attribute>
        <syswf:attribute name="title">${edit_buttonLabel}</syswf:attribute>
        <syswf:taskParam name="uuid">${this.artifact._uuid}</syswf:taskParam>
    </syswf:control>
</c:if>