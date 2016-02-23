<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />

<div>
    <a href="javascript:void(0);" class="UI Icon" id="${prefix}select_default"><span><fmt:message key="editUsers.select" bundle="${user_Messages}"/></span></a>
</div>

<syswf:control mode="script" caption="${prefix}saveState" action="saveState" />

<fmt:message key="editUsers.setUserDefaultDomain_title" bundle="${user_Messages}" var="select_title"/>
<syswf:component name="/admin/common/domainSelector" prefix="setUserDefaultDomain">
    <syswf:param name="jsOpenFunction" value="${prefix}open" />
    <syswf:param name="windowTitle" value="${select_title}"/>    
    <syswf:param name="selectionBag" value="${selectionBag}" />
    <syswf:param name="holder" value="${holder}"/>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    attachOn('${prefix}select_default','click',function() {
        ${prefix}open();
        ${prefix}saveState();
    });
    
});

//]]>
</script>
