<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:if test="${permissions.write && visible}">
<c:choose>
    <c:when test="${notifyMe}">
        <a href="javascript:void(0)" class="IconButton" id="DontNotifyMe"><span><span><span class="Subscribe"><fmt:message bundle="${messages}" key="report.dontNotifyMy" /></span></span></span></a>
        <syswf:control mode="script" action="removeNotifiaction" caption="dontNotifyMe" />
        <script type="text/javascript">
//<![CDATA[

        attachOn('DontNotifyMe','click',dontNotifyMe);
        
//]]>
</script>
    </c:when>
    <c:otherwise>
        <a href="javascript:void(0)" class="IconButton" id="NotifyMe"><span><span><span class="Subscribe"><fmt:message bundle="${messages}" key="report.notifyMe" /></span></span></span></a>
        <syswf:control mode="script" action="addNotifiaction" caption="notifyMe" />
        <script type="text/javascript">
//<![CDATA[

        attachOn('NotifyMe','click',notifyMe);
        
//]]>
</script>
    </c:otherwise>
</c:choose>
</c:if>