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

<%-- Headers --%>
<div class="UI Offset">             
    <table class="UI Table Layout">
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.taxonomy.import.server" bundle="${l10n}"/></label></td>
            <td>
            	<c:out value="${artifact.name}"/>
			</td>                            
        </tr>
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.taxonomy.import.authentication" bundle="${l10n}"/></label></td>
            <td>
				<c:if test="${not empty importExportBean.username}">
					<label class="UI Label Inline"><c:out value='<${importExportBean.username}>'/></label>
				</c:if>
				<c:if test="${empty importExportBean.username}">
					<label class="UI Label Inline"><c:out value='<${anonymousUser}>'/></label>
				</c:if>
                <span>
                    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_authentication"><fmt:message key="uddi.bulk.export.changeAuthentication" bundle="${l10n}"/></a>
                </span>
            </td>                           
        </tr>
    </table>                    
</div>  

<syswf:control mode="script" action="changeAuthentication" caption="${prefix}changeAuthentication"  loadingMask="true" affects="."/>
                
<syswf:component name="/core/window" prefix="selectAuthentication">
    <syswf:param name="winTitle" value="Select Authentication" />
    <syswf:param name="winComponent" value="/integration2/uddi/import/selectAuthentication"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenAuthentication" />
    <syswf:param name="credentialsBean" value="${changedCredential}" />
    <syswf:param name="hideSaveCredentialOption" value="${hideSaveCredentialOption}" />
    <syswf:param name="winOkAction" value="${prefix}changeAuthentication" />
	<syswf:param name="winOkLabel" value="OK" />
    <syswf:param name="winWidth" value="400" />
	<syswf:param name="winButtonAlign" value="right" />	
</syswf:component>

<%-- Choose options --%>
<syswf:control mode="script" action="changeShowMissing" caption="${prefix}changeShowMissing"  loadingMask="true" affects="."/>

	<h4>
		<div class="UI Align">
		    <c:choose>
		    	<c:when test="${isImporting eq '1'}">
		    	    <div class="Left">
				        <fmt:message key="uddi.taxonomy.import.selectWhatToImport" bundle="${l10n}"/>
			        </div>	
		    	</c:when>
		    	<c:otherwise>
		    	    <div class="Left">
				        <fmt:message key="uddi.taxonomy.export.selectWhatToExport" bundle="${l10n}"/>
			        </div>	
		    	</c:otherwise>
		    </c:choose>	
			<div class="Right">
				<fmt:message key="uddi.taxonomy.import.show" bundle="${l10n}"/>
				<syswf:selectOne id="${prefix}myMissing" name="myMissing" value="${showMissing}" 
						property="myMissing" mode="radio" optionValues="${showValues}" optionCaptions="${showCaptions}" 
						displayAsRow="true" >
				</syswf:selectOne>
				<script type="text/javascript">
//<![CDATA[

	                Ext.onReady(function() {
	                    attachOn('${prefix}myMissing_0','click',function() {
	                    	${prefix}changeShowMissing();
	                    });
	                    attachOn('${prefix}myMissing_1','click',function() {
	                    	${prefix}changeShowMissing();
	                    });
	                });
                
//]]>
</script>     
			</div>		
			<div class="x-clear"></div>	
		</div>
	</h4>
	
	<%-- Taxonomy Table --%>
	<c:if test="${(empty errorMessage)}" >
		<syswf:component name="/core/table" prefix="importTaxonomy" >
			<syswf:param name="customizationId" value="integration.taxonomy.taxonomyImportExport"/>
			<syswf:param name="datasource" value="${eximTaxonomyDataSource}"/>
			<syswf:param name="selectionBag" value="${selectionBag}" />               
		</syswf:component>
	</c:if>
		
	<c:if test="${not empty errorMessage}" >
		<p class="Warning"><c:out value="${errorMessage}"/></p>
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
