<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />

<syswf:control mode="script" action="changeArtifactType" caption="${prefix}_changeArtifactType"/>

<tr>
	<td>
		<label>
			<fmt:message key="ruleLayout.grants.label" bundle="${domain_Messages}" />
		</label>
	</td>
	<td>
		<syswf:selectOne name="lstRuleType" id="${prefix}_lstRuleType"
			value="${bean}" property="ruleType" mode="radio" size="1"
			optionValues="${bean.typeOptions}" optionCaptions="${bean.typeCaptions}"/>
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
	Ext.TreeCombo = Ext.extend(Ext.form.ComboBox, {
		setValue : function(v){
	        var text = v;
	        if(this.valueField){
	            var r = this.findRecord(this.valueField, v);
	            if(r){
	                text = r.data[this.displayField];
	            }else if(Ext.isDefined(this.valueNotFoundText)){
	                text = this.valueNotFoundText;
	            }
	        }
	        text=text.replace(/&nbsp;/g,'');
	        this.lastSelectionText =text;
	        if(this.hiddenField){
	            this.hiddenField.value = Ext.value(v, ''); 
	        }
	        Ext.form.ComboBox.superclass.setValue.call(this, text);
	        this.value = v;
	        return this;
	    }, 
	});
	Ext.reg('treecombo', Ext.TreeCombo);
    var ${prefix}_cmb_RuleType;
        
    Ext.onReady(function(){
   		${prefix}_cmb_RuleType = new Ext.TreeCombo({
	        id : '${prefix}_lstRuleType',
	        transform : '${prefix}_lstRuleType',
	        listWidth : 180,
	        width : 180,        
	        disableKeyFilter : true,
	        mode : 'local',
	        autoHeight : true,
	        resizable : true,
	        editable: false,	        
	        triggerAction : 'all'
	        //,tpl: '<tpl for="."><div ext:qtip="{ +' this.valueField '+  }" class="x-combo-list-item">{' + this.displayField + '}</div></tpl>'
      	});
    	${prefix}_cmb_RuleType.on('select',function(){
			${prefix}_changeArtifactType();
        });      	
    });     
</script>