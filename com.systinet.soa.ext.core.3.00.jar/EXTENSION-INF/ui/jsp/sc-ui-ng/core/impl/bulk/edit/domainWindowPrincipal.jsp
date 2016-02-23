<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="bulkmessages"/>

<syswf:component name="/core/principal/selector" prefix="ps">
    <syswf:param name="jsOpenFunction" value="${prefix}ps" />
    <syswf:param name="windowTitle"><fmt:message bundle="${bulkmessages}" key="changeDomain.chooseNewOwner" /></syswf:param>
    <syswf:param name="holder" value="${holder}" />
</syswf:component>

<c:choose>
    <c:when test="${not empty holder.newOwner}">
        <syswf:component prefix="owner" name="/core/impl/util/principalLinkRenderer" wrap="false">
            <syswf:param name="principal" value="${holder.newOwner.id}"/>
            <syswf:param name="showIcon" value="${true}"/>
        </syswf:component>
        <a href="javascript:void(0)" class="UI Icon" id="${prefix}nuOpen"><fmt:message bundle="${messages}" key="Change" /></a>
    </c:when>
    <c:otherwise>
        <a href="javascript:void(0)" id="${prefix}nuOpen"><fmt:message bundle="${messages}" key="Select" /></a>
    </c:otherwise>
</c:choose>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
    attachOn('${prefix}nuOpen','click',${prefix}ps);
});

//]]>
</script>