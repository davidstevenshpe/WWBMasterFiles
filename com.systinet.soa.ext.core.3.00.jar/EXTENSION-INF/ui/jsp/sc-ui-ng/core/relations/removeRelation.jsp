<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${hasWritePermission}">

    <c:choose>
        <c:when test="${relationOnly}">
            <c:choose>
                <c:when test="${forceDialog}">
                    <fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
                    <fmt:message var="delete_dialogTitle" key="delete.incoming.title" bundle="${messages}" />
        
                    <syswf:component name="/core/window" prefix="rrw">
                        <syswf:param name="winComponent" value="/core/impl/relations/removeRelationWindow" />
                        <syswf:param name="winOpenFunctionName" value="${controlName}" />
                        <syswf:param name="winTitle" value="${delete_dialogTitle}" />
                        <syswf:param name="winOkAction" value="${prefix}DeleteConfirm" />
        
                        <syswf:param name="settings" value="${settings}" />
                        <syswf:param name="relationOnly" value="${true}" />
                    </syswf:component>
        
                    <syswf:control mode="script" caption="${prefix}DeleteConfirm" action="${controlAction}">
                        <syswf:param name="selectionBag" value="${selectionBag}" />
                        <syswf:param name="useType" value="${useType}" />
                    </syswf:control>
                </c:when>
                <c:otherwise>
                    <syswf:control mode="script" caption="${controlName}" action="${controlAction}">
                        <syswf:param name="selectionBag" value="${selectionBag}" />
                        <syswf:param name="useType" value="${useType}" />
                    </syswf:control>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
            <fmt:message var="delete_dialogTitle" key="delete.${incomingRelation?'incoming.':''}title" bundle="${messages}" />

            <syswf:component name="/core/window" prefix="rrw">
                <syswf:param name="winComponent" value="/core/impl/relations/removeRelationWindow" />
                <syswf:param name="winOpenFunctionName" value="${controlName}" />
                <syswf:param name="winTitle" value="${delete_dialogTitle}" />
                <syswf:param name="winOkAction" value="${prefix}DeleteConfirm" />

                <syswf:param name="settings" value="${settings}" />
                <syswf:param name="relationOnly" value="${incomingRelation}" />
            </syswf:component>

            <syswf:control mode="script" caption="${prefix}DeleteConfirm" action="${controlAction}">
                <syswf:param name="selectionBag" value="${selectionBag}" />
                <syswf:param name="useType" value="${useType}" />
            </syswf:control>
        </c:otherwise>
    </c:choose>

</c:if>