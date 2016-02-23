<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />

<fmt:message var="technicalPolicyTitle" key="technicalPolicyReferences.technicalPolicyTitle" bundle="${tpMessages}" />
<fmt:message var="assertionTitle" key="technicalPolicyReferences.assertionTitle" bundle="${tpMessages}" />
<fmt:message var="addAssertionWindowTitle" key="addAssertion.windowTitle" bundle="${tpMessages}" />
<fmt:message var="selectAssertionDialogTitle" key="technicalPolicyReferences.dialog.selectAssertion.windowTitle" bundle="${tpMessages}" />
<fmt:message var="addParameterWindowTitle" key="addParameter.windowTitle" bundle="${tpMessages}" />
<fmt:message var="addParameterOkButtonLabel" key="addParameter.okButtonLabel" bundle="${tpMessages}" />

<fmt:message var="selectArtifactWindowTitle" key="selectArtifact.windowTitle" bundle="${tpMessages}" />
<fmt:message var="selectArtifactOkButtonLabel" key="selectArtifact.okButtonLabel" bundle="${tpMessages}" />

<fmt:message var="editAssertionOkButtonLabel" key="editAssertion.okButtonLabel" bundle="${tpMessages}" />

<fmt:message var="addTechnicalPolicyHref" key="technicalPolicyReferences.addTechnicalPolicyHref" bundle="${tpMessages}" />
<fmt:message var="addAssertionHref" key="technicalPolicyReferences.addAssertionHref" bundle="${tpMessages}" />

<div class="Title">
	<h3><syswf:out value="${technicalPolicyTitle}" context="HtmlBody"/></h3>
</div>

<c:if test="${emptyReferencedTPs and isAccessGranted and (not isDeleted) }">
	
	<span>
		<a href="javascript:void(0);" class="UI Icon Add" id="${prefix}TechnicalPolicy_Add" title="Add an existing Technical">${addTechnicalPolicyHref}</a>							                    
    </span>
    
	<script type="text/javascript">
	//<![CDATA[

		Ext.onReady(function(){
			attachOn('${prefix}TechnicalPolicy_Add','click',function() {		
				${prefix}openSelectTechnicalPolicyDialog();    
		    });	
		});	
	
	//]]>
	</script>
	
</c:if>

<c:if test="${not emptyReferencedTPs}">
	<syswf:component name="/core/table" prefix="referenceTechnicalPolicy"  wrap="false">
		<syswf:param name="customizationId" value="${technicalPolicyCustomizationId}"/>	
		<syswf:param name="datasource" value="${technicalPolicyDataSource}"/>        
		<syswf:param name="artifact" value="${artifact}"/>
		<syswf:param name="openPolicySelectorFunction" value="${prefix}openSelectTechnicalPolicyDialog"/>
		<syswf:param name="mode" value="${mode}"/>
		<syswf:param name="isAccessGranted" value="${isAccessGranted}"/>
		<syswf:param name="isDeleted" value="${isDeleted}"/>
	</syswf:component>	
</c:if>

<syswf:control mode="script" action="selectTechnicalPolicies" caption="${prefix}selectTechnicalPolicy">
	<syswf:param name="tpSelectionBag" value="${tpSelectionBag}"/>
</syswf:control>
<syswf:component name="/core/window" prefix="selectTechnicalPolicyArtifact">
    <syswf:param name="winTitle" value="${selectArtifactWindowTitle}" />
    <syswf:param name="winComponent" value="/core/impl/util/artifactSelectorWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openSelectTechnicalPolicyDialog" />
    <syswf:param name="resultTableId" value="${prefix}selectPolicy_asTableId"/>
    <syswf:param name="popupWindowId" value="${prefix}selectPolicy_asWindowId"/>
    <syswf:param name="artifactType" value="hpsoaTechnicalPolicyArtifact"/>
    <syswf:param name="selectionBag" value="${tpSelectionBag}" />
    <syswf:param name="selectorCustomizationId" value="shared.artifactSelector.hpsoaTechnicalPolicyArtifact" />
    <syswf:param name="showDataBeforeSearch" value="true" />
    <syswf:param name="overrideselectionModel" value="multiple" />
    <syswf:param name="winOkAction" value="${prefix}selectTechnicalPolicy" />
	<syswf:param name="winOkLabel" value="${selectArtifactOkButtonLabel}" />
    <syswf:param name="winWidth" value="650" />
	<syswf:param name="winButtonAlign" value="right" />
</syswf:component>
	
<br/>

<div class="Title">
	<h3><syswf:out value="${assertionTitle}" context="HtmlBody"/></h3>
</div>

<c:if test="${emptyReferencedAssertions and isAccessGranted and (not isDeleted)}">
	<span>
		<a href="javascript:void(0);" class="UI Icon Add" id="${prefix}Assertion_Add" title ="Add an existing Assertion">${addAssertionHref}</a>							                    
    </span>
	
	<script type="text/javascript">
	//<![CDATA[

		Ext.onReady(function(){
			attachOn('${prefix}Assertion_Add','click',function() {		
				${prefix}openAssertionsDialog();    
		    });	
		});	
	
	//]]>
	</script>
<table><tbody><tr><td>&nbsp;</td></tr></tbody></table>
</c:if>

<c:if test="${not emptyReferencedAssertions}">
	<syswf:component name="/core/table" prefix="referenceAssertion"  wrap="false">
		<syswf:param name="customizationId" value="${assertionCustomizationId}"/>
		<syswf:param name="datasource" value="${assertionPolicyDataSource}"/>
		<syswf:param name="artifact" value="${artifact}"/>        
		<!--syswf:param name="assertionBean" value="${assertionBean}"/-->
		<syswf:param name="openAddParametersDialog" value="${prefix}openParamsDialog"/>
		<syswf:param name="openAssertionsSelectorFunction" value="${prefix}openAssertionsDialog"/>
		<syswf:param name="mode" value="${mode}"/>
		<syswf:param name="isAccessGranted" value="${isAccessGranted}"/>		
		<syswf:param name="isDeleted" value="${isDeleted}"/>
	</syswf:component>
</c:if>

<syswf:input id="assertionBeanId" name="assertionBeanId" value="" mode="hidden"/>
<syswf:input id="editParamMode" name="editParamMode" value="" mode="hidden"/>

<syswf:control mode="ajax" action="editAssertion" caption="${prefix}editAssertion" />
<script type="text/javascript">
//<![CDATA[

	function ${prefix}storeEditingProperties(value1, value2) {
	    Ext.get('assertionBeanId').dom.value = value1;
	    Ext.get('editParamMode').dom.value = value2;
	}
	function ${prefix}openParamsDialog(assertionBeanId, editParamMode) {
		${prefix}storeEditingProperties(assertionBeanId, editParamMode);
		${prefix}editAssertion();
	}

//]]>
</script>
	
<syswf:control mode="ajax" action="selectAssertions" caption="${prefix}selectAssertions" >
	<syswf:param name="tableSelectionBag" value="${tableSelectionBag}"/>
	<syswf:param name="referenceDataSource" value="${referenceDataSource}"/>
</syswf:control>
<syswf:component name="/core/window" prefix="selectArtifact">
    <syswf:param name="winTitle" value="${selectAssertionDialogTitle}" />
    <syswf:param name="winComponent" value="/core/impl/util/artifactSelectorWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openAssertionsDialog" />
    <syswf:param name="resultTableId" value="${prefix}selectAssertion_asTableId"/>
    <syswf:param name="popupWindowId" value="${prefix}selectAssertion_asWindowId"/>
    <syswf:param name="artifactType" value="assertionArtifact"/>
    <syswf:param name="selectionBag" value="${tableSelectionBag}" />
    <syswf:param name="selectorCustomizationId" value="shared.artifactSelector.assertionArtifact" />
    <syswf:param name="showDataBeforeSearch" value="true" />    
    <syswf:param name="overrideselectionModel" value="multiple" />
    <syswf:param name="winOkAction" value="${prefix}selectAssertions" />
	<syswf:param name="winOkLabel" value="OK" />
    <syswf:param name="winWidth" value="750" />
	<syswf:param name="winButtonAlign" value="right" />
</syswf:component>
	 
<c:if test="${selectedAssertions}">	
	<syswf:control mode="ajax" action="addParameters" caption="${prefix}addParameters">
		<!--syswf:param name="assertionBean" value="${assertionBean}"/-->
	</syswf:control>	
	<syswf:control mode="ajax" action="cancelAction" caption="${prefix}cancelAction">
	</syswf:control>
	<syswf:component name="/core/window" prefix="addParameter">
	    <syswf:param name="winTitle" value="${addParameterWindowTitle}" />
	    <syswf:param name="winComponent" value="/admin/policy/technical/addAssertionParameters"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openAddParameters" />
	    <syswf:param name="winOkAction" value="${prefix}addParameters" />
	    <syswf:param name="assertionBeanList" value="${assertionBeanList}" />
	    <syswf:param name="paramsError" value="${paramsError}" />
		<syswf:param name="winOkLabel" value="${addParameterOkButtonLabel}" />
		<syswf:param name="winCancelAction" value="${prefix}cancelAction"/>
	    <syswf:param name="winWidth" value="700" />
		<syswf:param name="winButtonAlign" value="right" />
		<syswf:param name="winWrapperClass" value="UI"/>
	</syswf:component>		
	<script type="text/javascript">
	//<![CDATA[

		Ext.onReady(function() {
			${prefix}openAddParameters();
		})
	
	//]]>
	</script>
</c:if>

<c:if test="${editAssertions}">
	<syswf:control mode="ajax" action="editParameters" caption="${prefix}editParameters">
		<!--syswf:param name="assertionBean" value="${assertionBean}"/-->
		<syswf:param name="editParamMode" value="${editParamMode}"/>
		<syswf:param name="beanId" value="${beanId}"/>
	</syswf:control>	
	<syswf:component name="/core/window" prefix="editParameter">
	    <syswf:param name="winTitle" value="Edit Assertion" />
	    <syswf:param name="winComponent" value="/admin/policy/technical/addAssertionParameters"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openEditParameters" />
	    <syswf:param name="winOkAction" value="${prefix}editParameters" />
	    <syswf:param name="assertionBeanList" value="${assertionBeanList}" />
		<syswf:param name="winWrapperClass" value="UI"/>
	    <syswf:param name="paramsError" value="${paramsError}" />
		<syswf:param name="winOkLabel" value="${editAssertionOkButtonLabel}" />
	    <syswf:param name="winWidth" value="630" />
		<syswf:param name="winButtonAlign" value="right" />
	</syswf:component>		
	<script type="text/javascript">
	//<![CDATA[

		Ext.onReady(function() {
			${prefix}openEditParameters();
		})
	
	//]]>
	</script> 
</c:if>
 
<syswf:control id="actionSelectArtifact" mode="script" caption="${prefix}actionSelectArtifact" action="select" affects="." loadingMask="true" />
<c:set var="jsSelectFunction" value="${prefix}_onSelect"/>
<script type="text/javascript">
//<![CDATA[

     ${jsSelectFunction} = function(name, uuid) {
         ${prefix}actionSelectArtifact();
     }

//]]>
</script>
