<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="responsibilities.copy.from" var="from" bundle="${messages}"/>
<fmt:message key="responsibilities.copy.to" var="to" bundle="${messages}"/>
<fmt:message key="responsibilities.copy.copy" var="copy" bundle="${messages}"/>

<table class="UI Table Properties">
    <col class="LabelCol" />
    <col />    
  <tr>
    <td><label class="UI Label Inline" for="fromStage">${from}</label></td>
    <td>
    	<c:if test="${copyBean.oneStageSelected}">
    		<span>${copyBean.oneStage}</span>
    		<c:set target="${copyBean}" property="copyFromStageId" value="${copyBean.oneStageId}" />
		</c:if>
    	<c:if test="${not copyBean.oneStageSelected}">
			<syswf:selectOne id="${prefix}_fromStage" name="fromStage" mode="menu" optionValues="${copyBean.selectedStages}"  
			optionCaptions="${copyBean.selectedStagesNames}" property="copyFromStageId"  
			value="${copyBean}" size="1" />            
            
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function(){
                    new Ext.form.ComboBox({
                    id : '${prefix}_fromStage',
                    transform : '${prefix}_fromStage',
                    listWidth : 140,
                    width : 140,        
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    triggerAction : 'all',
                    editable: false                    
                  });                               
                });                     
            
//]]>
</script>            
            
		</c:if>
    </td>
  </tr>
  <tr>
    <td><label class="UI Label Inline" for="toStages">${to}</label></td>
    <td>
		<syswf:selectMany name="toStages" mode="checkbox" optionValues="${responsibilitiesBean.stagesIds}"  
		optionCaptions="${responsibilitiesBean.stages}" property="copyToStagesIds" optionClasses="${responsibilitiesBean.styleClassesForStages}"         
		value="${copyBean}" size="1" >
            <syswf:attribute name="class" value="UI Checkbox Inline" />
        </syswf:selectMany>
    </td>
  </tr>
  <tr>
    <td><label class="UI Label Inline" for="check">${copy}</label></td>
    <td>
		<syswf:selectMany name="check" mode="checkbox" optionValues="${copyBean.options}" optionValuesProperty="key"  
        optionClasses="${responsibilitiesBean.styleClassesForResponsibilities}" optionCaptions="${copyBean.options}" 
        optionCaptionsProperty="value" property="checked"  
		value="${copyBean}" size="1" >
            <syswf:attribute name="class" value="UI Checkbox Inline" />
        </syswf:selectMany>
    </td>
  </tr>
  
</table>
