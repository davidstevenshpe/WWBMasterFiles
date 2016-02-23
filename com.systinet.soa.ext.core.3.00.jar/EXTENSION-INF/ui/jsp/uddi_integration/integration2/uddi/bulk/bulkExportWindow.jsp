<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="anonymousUser" key="uddi.bulk.export.user.anonymous" bundle="${l10n}"/>

<c:choose>
	<c:when test="${empty errorMessage}">
		<script type="text/javascript">
//<![CDATA[

			Ext.getCmp('${winOkCustomButtonId}').enable();
		
//]]>
</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
//<![CDATA[

			Ext.getCmp('${winOkCustomButtonId}').disable();
		
//]]>
</script>
	</c:otherwise>
</c:choose>

<div class="UI Offset">             

	<syswf:control mode="ajax" action="changeRegistry" caption="${prefix}changeUuidregistryUuid"  loadingMask="true" affects="."/>
	
    <table class="UI Table Layout">
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.bulk.export.server" bundle="${l10n}"/></label></td>
            <td>
				<syswf:selectOne id="${prefix}registryUuid" name="registryUuid" value="${exportBean}" property="registryUuid" 
									optionValues="${registryList}" optionValuesProperty="uuid" optionCaptions="${registryList}" 
									optionCaptionsProperty="name" mode="menu">
					<syswf:attribute name="style" value="width:100%"></syswf:attribute>
				</syswf:selectOne>
								
				<script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function(){
                        var cmb = new Ext.form.ComboBox({
	                        id : '${prefix}registryUuid',
	                        transform : '${prefix}registryUuid',
	                        listWidth : 310,
	                        width : 310,
	                        emptyText:'${hint}',
	                        disableKeyFilter : true,
	                        mode : 'local',
	                        autoHeight : true,
	                        resizable : true,
	                        triggerAction : 'all',
	                        editable: false                     
                      	});

                        cmb.on('select', function() {
                        	${prefix}changeUuidregistryUuid();
                        });
                    });		            
		        
//]]>
</script>
			</td>                            
        </tr>
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.bulk.export.authentication" bundle="${l10n}"/></label></td>
            <td>
				<c:if test="${not empty exportBean.username}">
					<label class="UI Label Inline"><c:out value='<${exportBean.username}>'/></label>
				</c:if>
				<c:if test="${empty exportBean.username}">
					<label class="UI Label Inline"><c:out value='<${anonymousUser}>'/></label>
				</c:if>
                <span>
                    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_authentication"><fmt:message key="uddi.bulk.export.changeAuthentication" bundle="${l10n}"/></a>
                </span>
            </td>                           
        </tr>
    </table>                    
</div>  

<syswf:control mode="ajax" action="changeAuthentication" caption="${prefix}changeAuthentication"  loadingMask="true" affects="."/>
                
<syswf:component name="/core/window" prefix="selectAuthentication">
    <syswf:param name="winTitle" value="Select Authentication" />
    <syswf:param name="winComponent" value="/integration2/uddi/import/selectAuthentication"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenAuthentication" />
    <syswf:param name="credentialsBean" value="${credentialsBean}" />
    <syswf:param name="hideSaveCredentialOption" value="${hideSaveCredentialOption}" />
    <syswf:param name="winOkAction" value="${prefix}changeAuthentication" />
	<syswf:param name="winOkLabel" value="OK" />
    <syswf:param name="winWidth" value="400" />
	<syswf:param name="winButtonAlign" value="right" />
</syswf:component>

<syswf:control mode="ajax" action="changeMyEntities" caption="${prefix}changeMyEntities"  loadingMask="true" affects="."/>

<c:if test="${exportBean.requireBusinessEntity}">
	<h4>
		<div class="UI Align">
			<div class="Left">
				<fmt:message key="uddi.bulk.export.destinationBusinessEntity" bundle="${l10n}"/>
				<a href="javascript:void(0)" class="UI Icon Info" id="explain_destination"></a>
			</div>		
			<div class="Right">
				<fmt:message key="uddi.bulk.export.show" bundle="${l10n}"/>
				<syswf:selectOne id="${prefix}myEntities" name="myEntities" value="${showEntity}" 
									property="myEntities" mode="radio" optionValues="${showValues}" optionCaptions="${showCaptions}" 
									displayAsRow="true" />
                <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    attachOn('${prefix}myEntities_0','click',function() {
                    	${prefix}changeMyEntities();
                    });
                    attachOn('${prefix}myEntities_1','click',function() {
                    	${prefix}changeMyEntities();
                    });
                });
                
//]]>
</script>
			</div>		
			<div class="x-clear"></div>	
		</div>
	</h4>
	
	<c:if test="${(empty errorMessage)}" >
		<syswf:component name="/core/table" prefix="bulkExport" >
			<syswf:param name="customizationId" value="integration.uddiexport.bulkExportAction"/>
			<syswf:param name="datasource" value="${SEDataSource}"/>
			<syswf:param name="selectionBag" value="${tableSelectionBag}" />               
		</syswf:component>
	</c:if>
	
	<c:if test="${not empty errorMessage}" >
		<p class="Warning"><c:out value="${errorMessage}"/></p>
	</c:if>

	<div class="UI AdvancedOptions Labeled Closed">
		<div class="OptionsOpener">
			<a href="javascript:void(0);" id="${prefix}opener"><span><fmt:message key="uddi.bulk.export.advancedOptions" bundle="${l10n}"/></span></a>
		</div>            
		<div class="Content">
			<syswf:selectOne id="${prefix}overwrite" name="overwrite" selectClass="UI Form Checkbox Inline" 
								value="${exportBean}" property="overwrite" mode="checkbox" 
								optionValues="true" dataType="boolean" optionCaptions="" > 
			</syswf:selectOne><fmt:message key="uddi.bulk.export.overwrite" bundle="${l10n}"/>     
			<br/>        
			<label class="UI Label Inline" for="${prefix}label_0"><fmt:message key="uddi.bulk.export.overwriteExplain" bundle="${l10n}"/></label>        
		</div>
	</div> 

	<!-- DROPDOWN MENU -->
	<div class="x-hidden flyout-menu UI Dropdown" id="explain_destination_content">
		<div class="DropdownContent">
			<p class="Comment"><fmt:message key="uddi.bulk.export.destinationExplain" bundle="${l10n}"/></p>
		</div>
	</div>
	
	<script type="text/javascript">
//<![CDATA[

		Ext.onReady(function(){
			attachOn('${prefix}opener','click',function() {
				AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
			});
			
			Dropdown.init('explain_destination', 'explain_destination_content',{
				align: 'tl-tr', forceRefresh:true, alignOffset:[0,4]
			});
		});	
	
//]]>
</script>

</c:if>

<c:if test="${not exportBean.requireBusinessEntity}">
	<c:if test="${not empty errorMessage}" >
		<p class="Warning"><c:out value="${errorMessage}"/></p>
	</c:if>
</c:if>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
		attachOn('${prefix}change_authentication','click',function() {
		    ${prefix}jsOpenAuthentication();
	    });	
	});	

//]]>
</script>