<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/admin/domain/acl/ruleCondition" prefix="ruleConditionDialog">
    <syswf:param name="holder" value="${addConditionsHolder}" />
    <syswf:param name="bean" value="${bean}" />
    <syswf:param name="openDialogFunction" value="${prefix}openDialogFunction" />    
</syswf:component>

<div class="webfw-Window" id="${prefix}-webfw-Window">
	<syswf:component name="/core/table" prefix="conditionsTable" wrap="false">
	    <syswf:param name="bean" value="${bean}"/>
	    <syswf:param name="customizationId" value="admin.domain.acl.tableConditionRule" />
	    <syswf:param name="datasource" value="${conditionsDataSource}"/>
	    <syswf:param name="addConditionsHolder" value="${addConditionsHolder}"/>		  
	    <syswf:param name="openDialogFunction" value="${prefix}openDialogFunction"/>
	    <syswf:param name="kind" value="browse" />  
	</syswf:component>
</div>