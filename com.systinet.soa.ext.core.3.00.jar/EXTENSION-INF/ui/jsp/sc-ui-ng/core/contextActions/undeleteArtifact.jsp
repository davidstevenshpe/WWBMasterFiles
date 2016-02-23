<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contextactions.messages" var="messages"/>
<fmt:message bundle="${messages}" key="undelete" var="label"/>

<c:if test="${this.permissions.pureWrite}">

<syswf:component name="/core/impl/recycleBin/restore" prefix="restore">
    <syswf:param name="uuid" value="${artifact._uuid}" />
    <syswf:param name="controlName" value="${prefix}restore" />
    <syswf:param name="controlAction" value="restore" />
</syswf:component>

<a href="javascript:void(0)" id="${prefix}restoreAnchor" class="context-button GoBack" title="${label}"></a>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    attachOn('${prefix}restoreAnchor','click',${prefix}restore);
});

//]]>
</script>

</c:if>