<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.catalog.button.PreviousStageButton.Bean"--%>
<c:if test="${bean.enabled}">

    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

    <syswf:control mode="script" caption="toPreviousStagePost" action="moveToPreviousStageAction"/>

    <syswf:component name="/core/impl/util/dialog" prefix="dialog">
        <syswf:param name="handler" value="toPreviousStagePost" />
        <syswf:param name="heading"><fmt:message key="prevStage_buttonLabel" bundle="${messages}"/></syswf:param>
        <syswf:param name="content"><fmt:message key="prevStage_dialogText" bundle="${messages}"/></syswf:param>
    </syswf:component>
	<div class="EA-right-panel">
	    <a id="MoveToPreviousStage" href="javascript:void(0);" class="UI PageAction PreviousStage">
	       <span><fmt:message key="prevStage_buttonLabel" bundle="${messages}"/></span>
	    </a>
	</div>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('MoveToPreviousStage').on('click', ${prefix}_dialog_control);
        });
    
//]]>
</script>

</c:if>
