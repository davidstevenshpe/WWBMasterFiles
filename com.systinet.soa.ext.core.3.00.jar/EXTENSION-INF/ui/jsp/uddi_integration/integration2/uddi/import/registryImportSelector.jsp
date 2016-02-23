<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="anonymousUser" key="uddi.import.user.anonymous" bundle="${l10n}"/>
<fmt:message var="changeTabTitle" key="uddi.import.warning.title" bundle="${l10n}"/>
<fmt:message var="changeTabOkButton" key="uddi.import.warning.okButton" bundle="${l10n}"/>
<fmt:message var="businessEntitiesTabLabel" key="uddi.import.businessEntities" bundle="${l10n}"/>
<fmt:message var="businessServicesTabLabel" key="uddi.import.businessServices" bundle="${l10n}"/>
<fmt:message var="wsPoliciesTabLabel" key="uddi.import.wsPolocies" bundle="${l10n}"/>
<fmt:message var="systinetServicesTabLabel" key="uddi.import.systinetServices" bundle="${l10n}"/>

<c:if test="${empty errorMessage}">
	<script type="text/javascript">
//<![CDATA[
		
		Ext.getCmp('${winOkCustomButtonId}').enable();
	
//]]>
</script>
</c:if>
<c:if test="${not empty errorMessage}">
	<script type="text/javascript">
//<![CDATA[
		
		Ext.getCmp('${winOkCustomButtonId}').disable();
	
//]]>
</script>
</c:if>

<div class="UI Offset">             
    <table class="UI Table Layout">
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.import.serverName" bundle="${l10n}"/></label></td>
            <td>
                <syswf:component name="/integration2/uddi/common/uddiServerLinker" prefix="serverLinker" wrap="false">
                   <syswf:param name="serverName" value="${registryImportBean.registryName}"/>
                   <syswf:param name="serverUUID" value="${registryImportBean.registryUuid}"/>
                </syswf:component>  
            </td>                            
        </tr>
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.import.authentication" bundle="${l10n}"/></label></td>
            <td>
				<c:if test="${not empty registryImportBean.username}">
					<label class="UI Label Inline"><c:out value='<${registryImportBean.username}>'/></label>
				</c:if>
				<c:if test="${empty registryImportBean.username}">
					<label class="UI Label Inline"><c:out value='<${anonymousUser}>'/></label>
				</c:if>
                <span>
                    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_authentication"><fmt:message key="uddi.import.changeAuthentication" bundle="${l10n}"/></a>
                </span>
            </td>                           
        </tr>
    </table>                    
</div>  


<syswf:control mode="script" action="changeAuthentication" caption="${prefix}changeAuthentication"  loadingMask="true" affects="."/>
                
<syswf:component name="/core/window" prefix="selectAuthentication">
    <syswf:param name="winTitle" value="Select Authentication" />
    <syswf:param name="winId" value="${prefix}selectAuthentication" />
    <syswf:param name="winComponent" value="/integration2/uddi/import/selectAuthentication"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenAuthentication" />
    <syswf:param name="credentialsBean" value="${changedCredential}" />
    <syswf:param name="hideSaveCredentialOption" value="${hideSaveCredentialOption}" />
    <syswf:param name="winOkAction" value="${prefix}changeAuthentication" />
	<syswf:param name="winOkLabel" value="OK" />
    <syswf:param name="winWidth" value="400" />
	<syswf:param name="winButtonAlign" value="right" />
</syswf:component>



<div id="${prefix}addressbook_browser" class="TabPanel Simple">
    
    <syswf:control mode="script" action="changeMyEntities" caption="${prefix}myEntities"  loadingMask="true" affects="."/>
	
	<h4>
		<div class="UI Align">
			<div class="Left">
				<fmt:message key="uddi.import.whatToImport" bundle="${l10n}"/>
			</div>	
			<div class="Right">
				<fmt:message key="uddi.import.show" bundle="${l10n}"/>
				<syswf:selectOne id="${prefix}myEntities" name="myEntities" value="${showEntity}" 
								property="myEntities" mode="radio" optionValues="${showValues}" optionCaptions="${showCaptions}" 
								displayAsRow="true" />
                <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    attachOn('${prefix}myEntities_0','click',function() {
                    	${prefix}myEntities();
                    });
                    attachOn('${prefix}myEntities_1','click',function() {
                    	${prefix}myEntities();
                    });
                });
                
//]]>
</script>                    
			</div>			
			<div class="x-clear"></div>
		</div>
	</h4>
</div>	

<hr/>

<div class="com_tabs ui-tabs ui-widget ui-widget-content ui-corner-all">
    <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
	    <li class="ui-corner-top ui-state-default <c:if test="${selectedTabId eq 'BusinessEntity'}">ui-state-active</c:if>"> 
		     <syswf:control mode="anchor" caption="${businessEntitiesTabLabel}" action="tabChange" id="tabChangeBE" icon="UI Icon" loadingMask="true" affects=".">
		         <syswf:param name="tab" value="BusinessEntity" />
		     </syswf:control>
	    </li>
	    <li class="ui-corner-top ui-state-default <c:if test="${selectedTabId eq 'BusinessService'}">ui-state-active</c:if>">
		     <syswf:control mode="anchor" caption="${businessServicesTabLabel}" action="tabChange" id="tabChangeBS" icon="UI Icon" loadingMask="true"  affects=".">
		         <syswf:param name="tab" value="BusinessService" />
		     </syswf:control>
		</li>
	 	<li class="ui-corner-top ui-state-default <c:if test="${selectedTabId eq 'WSPolicy'}">ui-state-active</c:if>">
		     <syswf:control mode="anchor" caption="${wsPoliciesTabLabel}" action="tabChange" id="tabChangeWS" icon="UI Icon" loadingMask="true"  affects=".">
		         <syswf:param name="tab" value="WSPolicy" />
		     </syswf:control>
		</li>
	    <li class="ui-corner-top ui-state-default <c:if test="${selectedTabId eq 'SystinetService'}">ui-state-active</c:if>">
		     <syswf:control mode="anchor" caption="${systinetServicesTabLabel}" action="tabChange" id="tabChangeSS" icon="UI Icon" loadingMask="true"  affects=".">
		         <syswf:param name="tab" value="SystinetService" />
		     </syswf:control>
		</li>
    </ul>
</div>


<c:if test="${selectedTabId eq 'BusinessEntity'}" >
	<c:if test="${empty errorMessage}">
	    <syswf:component name="/core/table" prefix="principal1">
	       <syswf:param name="customizationId" value="integration.uddiimport.properties.registryImportAction"/>                         
	       <syswf:param name="datasource" value="${SEDataSource}"/>
	       <syswf:param name="selectionBag" value="${tableSelectionBag}" />
	    </syswf:component>
	</c:if>
	<c:if test="${not empty errorMessage}" >
	    <p class="Warning"><c:out value="${errorMessage}"/></p>
	</c:if>
</c:if>

<c:if test="${selectedTabId eq 'BusinessService'}" >
	<c:if test="${empty errorMessage}" >
	    <syswf:component name="/core/table" prefix="principal2">
	       <syswf:param name="customizationId" value="integration.uddiimport.properties.registryImportBusinessServiceAction"/>
	       <syswf:param name="datasource" value="${SEDataSource}"/>    
	       <syswf:param name="selectionBag" value="${tableSelectionBag}" />        
	    </syswf:component>
    </c:if>
    <c:if test="${not empty errorMessage}" >
	    <p class="Warning"><c:out value="${errorMessage}"/></p>
	</c:if>
</c:if>

<c:if test="${selectedTabId eq 'WSPolicy'}" >
	<c:if test="${empty errorMessage}" >
	    <syswf:component name="/core/table" prefix="principal3" >
	       <syswf:param name="customizationId" value="integration.uddiimport.properties.registryImportAction"/>
	       <syswf:param name="datasource" value="${SEDataSource}"/>    
	       <syswf:param name="selectionBag" value="${tableSelectionBag}" />            
	    </syswf:component>
    </c:if>
    <c:if test="${not empty errorMessage}" >
	    <p class="Warning"><c:out value="${errorMessage}"/></p>
	</c:if>
</c:if>

<c:if test="${selectedTabId eq 'SystinetService'}" >
	<c:if test="${empty errorMessage}" >
	    <syswf:component name="/core/table" prefix="principal4" >
	       <syswf:param name="customizationId" value="integration.uddiimport.properties.registryImportAction"/>
	       <syswf:param name="datasource" value="${SEDataSource}"/>
	       <syswf:param name="selectionBag" value="${tableSelectionBag}" />               
	    </syswf:component>
    </c:if>
    <c:if test="${not empty errorMessage}" >
	    <p class="Warning"><c:out value="${errorMessage}"/></p>
	</c:if>
</c:if>

<div class="UI AdvancedOptions Labeled Closed">
    <div class="OptionsOpener">
        <a href="javascript:void(0);" id="${prefix}opener"><span><fmt:message key="uddi.import.advancedOptions" bundle="${l10n}"/></span></a>
    </div>    
    <div class="Content">
        <label class="UI Label Inline" for="${prefix}label_0"><fmt:message key="uddi.import.autoSync" bundle="${l10n}"/></label>
        <br/>
        <syswf:selectOne id="${prefix}synOn" name="automaticSync" selectClass="UI Form Checkbox Inline" 
                            value="${registryImportBean}" property="automaticSync" mode="radio" 
                            optionValues="${synValues}" optionCaptions="${synCaptions}" displayAsRow="true" >
        </syswf:selectOne>
    </div>
</div>  

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	   attachOn('${prefix}change_authentication','click',function() {
		   ${prefix}jsOpenAuthentication();
	   });
	   
	   attachOn('${prefix}opener','click',function() {
			AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);			
		});
   });

//]]>
</script>

<c:if test="${showWarningDialog}">
	<syswf:control mode="script" action="tabChange" caption="${prefix}doChangeTab" loadingMask="true" affects=".">
		<syswf:param name="confirm" value="yes" />
		<syswf:param name="tab" value="${tab}" />
	</syswf:control>
	
	<syswf:component name="/core/window" prefix="changeTabConfirmation">
		<syswf:param name="winTitle" value="${changeTabTitle}" />
		<syswf:param name="winComponent" value="/integration2/uddi/import/confirmChangeTab"/>
		<syswf:param name="winOpenFunctionName" value="${prefix}openConfirmationDialog" />
		<syswf:param name="winOkAction" value="${prefix}doChangeTab" />
		<syswf:param name="winOkLabel" value="${changeTabOkButton}" />
		<syswf:param name="winWidth" value="350" />
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[

		${prefix}openConfirmationDialog();
	
//]]>
</script>
</c:if>
