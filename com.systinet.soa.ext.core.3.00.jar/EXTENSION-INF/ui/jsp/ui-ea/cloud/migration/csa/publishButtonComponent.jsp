<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>
<fmt:message var="label" key="cloud.migration.csa.overview.publish" bundle="${uisccomponentsmessages}"/>



<div style="margin: 15px 0 10px 0;">
	<button id="${prefix}publishToCSAButton" class="btn btn-gray btn-labeled em fa fa-cloud">
		<span><c:out value="${label}"/></span>
	</button>
</div>
<syswf:control mode="script" caption="publish" action="publish"/>


<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
	var message = "${warningMessage}";
	if(message==""){
		$('#${prefix}publishToCSAButton').click(function() {
			publish();
			return false;
		});
	}else{
		$('#${prefix}publishToCSAButton').click(function() {
			layoutManager.showUiMessage(message, "Warning");
			return false;
		});		
	}
});

//]]>
</script>
