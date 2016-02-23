<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="ruleCondition.edit.label" var="editLabel" bundle="${domain_Messages}" />

<div class="UI Icon Edit">
<a href="javascript:void(0)" id="${prefix}_editCondition"><span>${editLabel}</span></a>
</div>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    attachOn('${prefix}_editCondition','click', function() {
	    	${openDialogFunction}('${editTaxUri}', '${editOperator}');
		});
	});

//]]>
</script>