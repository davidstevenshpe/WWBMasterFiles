<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />

<syswf:control mode="script" action="changeArtifactType" caption="${prefix}_changeArtifactType">
	<syswf:param name="holder" value="holder" />
</syswf:control>

<tr>
	<td>
		<label>
			<fmt:message key="ruleLayout.grants.label" bundle="${domain_Messages}" />
		</label>
	</td>
	<td>
		<span class="UI Icon Completed">
			<fmt:message key="ruleLayout.grants.action.create.label" bundle="${domain_Messages}" />
		</span>	
	</td>
</tr>
<tr>
	<td>
		<label>
			<fmt:message key="ruleLayout.artifactType.label" bundle="${domain_Messages}" />
		</label>
	</td>
	<td>
		<syswf:selectOne name="lstSdmName" id="${prefix}_lstRuleType"
			value="${bean}" property="artifactType" mode="menu"
			optionValues="${bean.options}" optionCaptions="${bean.captions}" />	 	
	</td>
</tr>

<script type="text/javascript">
//<![CDATA[

    var ${prefix}_cmb_RuleType;
        
    Ext.onReady(function(){
   		${prefix}_cmb_RuleType = new Ext.form.ComboBox({
	        id : '${prefix}_lstRuleType',
	        transform : '${prefix}_lstRuleType',
	        listWidth : 180,
	        width : 180,        
	        disableKeyFilter : false,
	        mode : 'local',
	        autoHeight : true,
	        resizable : true,
	        editable: true,
            forceSelection: true,
            typeAhead: false,
	        triggerAction : 'all',
			listeners:{
				scope: this,
				afterRender: function (comp) {
					var item = comp.getStore().data.items[0];
					comp.emptyText = item.data.text;
				},
				change: function (comp, value) {
					if (comp.getRawValue() == null || comp.getRawValue() == '') {
						var item0 = comp.getStore().data.items[0];
						comp.setValue(item0.data.value);
					}
				}
			}
      	});
    });     

//]]>
</script>