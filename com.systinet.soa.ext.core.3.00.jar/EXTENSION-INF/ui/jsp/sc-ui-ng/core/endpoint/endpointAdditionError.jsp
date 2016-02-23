<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="componentsmessages"/>

<fmt:message bundle="${componentsmessages}" key="edit" var="edit" />

<div class="UI SystemMessage Error">
    <div class="MessageContainer">
        <div class="Text">
            <c:out value="${msg1}" />
            <syswf:component name="/core/contextActions/editArtifact" prefix="edit" wrap="false">
                <syswf:param name="artifact" value="${artifact}" />
                <syswf:param name="styleClass" value=" " />
                <syswf:param name="label">
                    <c:out value="${label}" />
                </syswf:param>
            </syswf:component>
            <c:out value="${msg2}" />
         </div>
         <div class="x-clear"></div>
    </div>
    </div>
    
</div>


