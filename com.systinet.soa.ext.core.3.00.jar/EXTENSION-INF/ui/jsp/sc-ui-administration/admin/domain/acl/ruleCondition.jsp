<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="ruleCondition.title" var="titleLabel" bundle="${domain_Messages}" />
<fmt:message key="ruleCondition.button.ok.label" var="okLabel" bundle="${domain_Messages}" />

<syswf:input id="editingTaxUri" name="editingTaxUri" value="" mode="hidden"/>
<syswf:input id="editingOperator" name="editingOperator" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

    function storeEditingProperties(taxUri, operator) {
        Ext.get('editingTaxUri').dom.value = taxUri;
        Ext.get('editingOperator').dom.value = operator;
    }
    function editDialog_getParams() {
        return {
            'editingTaxUri' : Ext.get('editingTaxUri').dom.value,
            'editingOperator' : Ext.get('editingOperator').dom.value
        };
    }
    function ${openDialogFunction}(taxUri, operator) {
        storeEditingProperties(taxUri, operator);
        ${prefix}openRuleCondition();
    }
    

//]]>
</script>

<syswf:control mode="script" caption="${prefix}changeConditions" action="changeConditions"/>

<syswf:component name="/core/window" prefix="w">
    <syswf:param name="winTitle" value="${titleLabel}" />
    <syswf:param name="winComponent" value="/admin/domain/acl/ruleConditionWindow" />
    <syswf:param name="winOpenFunctionName" value="${prefix}openRuleCondition" />
    <syswf:param name="winOkLabel" value="${okLabel}" />
    <syswf:param name="winOkAction" value="${prefix}changeConditions" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="holder" value="${holder}" />    
    <syswf:param name="bean" value="${bean}" />
    <syswf:param name="winGetParamsFunctionName" value="editDialog_getParams" />
</syswf:component>
