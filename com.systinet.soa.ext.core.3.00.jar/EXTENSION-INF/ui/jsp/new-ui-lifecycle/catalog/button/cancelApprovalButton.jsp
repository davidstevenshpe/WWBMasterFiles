<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.canCancelApproval}">

    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

    <syswf:control mode="script" caption="${prefix}cancel" action="cancel"/>

    <syswf:component name="/core/impl/util/dialog" prefix="dialog">
        <syswf:param name="handler" value="${prefix}cancel" />
        <syswf:param name="heading"><fmt:message key="cnclApp_buttonLabel" bundle="${messages}"/></syswf:param>
        <syswf:param name="content"><fmt:message key="cnclApp_dialogText" bundle="${messages}"/></syswf:param>
    </syswf:component>

	<c:if test="${insideTaskBox eq 'false' }">
		<c:set value="EA-right-panel" var="className"/>
	</c:if>

	<div class="${className}">
	    <a id="CancelApproval" href="javascript:void(0);" class="UI PageAction ApprovalCancel">
	       <span><fmt:message key="cnclApp_buttonLabel" bundle="${messages}"/></span>
	    </a>
	</div>
    <script type="text/javascript">
  //<![CDATA[
<c:if test="${not empty callbackFunction}">
    ${callbackFunction}();
</c:if>
   Ext.onReady(function() {
       Ext.get('CancelApproval').on('click', ${prefix}_dialog_control);
       moveWindow('${prefix}_dialog_window','popupWindows');
   });

//]]>
</script>
</c:if>
