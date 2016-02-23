<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.catalog.button.UndoLastApprovalButton.Bean"--%>
<c:if test="${bean.enabled}">

    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

    <syswf:control mode="script" caption="undoLastApprovalPost" action="undoLastApprovalAction"/>

    <syswf:component name="/core/impl/util/dialog" prefix="dialog">
        <syswf:param name="handler" value="undoLastApprovalPost" />
        <syswf:param name="heading"><fmt:message key="undoApp_buttonLabel" bundle="${messages}"/></syswf:param>
        <syswf:param name="content"><fmt:message key="undoApp_dialogText" bundle="${messages}"/></syswf:param>
    </syswf:component>
	<div class="EA-right-panel">
	    <a id="UndoLastApproval" href="javascript:void(0);" class="UI PageAction Undo">
	       <span><fmt:message key="undoApp_buttonLabel" bundle="${messages}"/></span>
	    </a>
	</div>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('UndoLastApproval').on('click', ${prefix}_dialog_control);
        });
    
//]]>
</script>

</c:if>
