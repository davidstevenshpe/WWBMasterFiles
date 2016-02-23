<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="anonymousUser" key="uddi.artifact.export.user.anonymous" bundle="${l10n}"/>
<fmt:message var="emptyBusinessEntity" key="uddi.artifact.export.user.emptyBusinessEntity" bundle="${l10n}"/>

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

    <table class="UI Table Layout">
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.artifact.export.server" bundle="${l10n}"/></label></td>
            <td><label class="UI Label Inline"><c:out value='${artifactExportBean.registryName}'/></label></td>                            
        </tr>
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.artifact.export.authentication" bundle="${l10n}"/></label></td>
            <td>
				<c:if test="${not empty artifactExportBean.username}">
					<label class="UI Label Inline"><c:out value='<${artifactExportBean.username}>'/></label>
				</c:if>
				<c:if test="${empty artifactExportBean.username}">
					<label class="UI Label Inline"><c:out value='<${anonymousUser}>'/></label>
				</c:if>
                <span>
                    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_authentication"><fmt:message key="uddi.artifact.export.changeAuthentication" bundle="${l10n}"/></a>
                </span>
            </td>                           
        </tr>
        
        <c:if test="${artifactExportBean.requireBusinessEntity and empty errorMessage}">
        	<tr>
        		<td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.artifact.export.parentBusinessEntity" bundle="${l10n}"/></label></td>
	            <td>
                    <c:choose>
                        <c:when test="${not empty artifactExportBean.businessEntityName}">
                            <label class="UI Label Inline"><syswf:out value="${artifactExportBean.businessEntityName}" context="HtmlBody"/></label>
                        </c:when>
                        <c:otherwise>
                            <span class="Comment"><syswf:out value="${emptyBusinessEntity}" context="HtmlBody"/></span>
                        </c:otherwise>
                    </c:choose>    

	            	<c:if test="${artifactExportBean.changeBusinessEntity}">
			            <span>
		                    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_businessEntity"><fmt:message key="uddi.artifact.export.changeBusinessEntity" bundle="${l10n}"/></a>
		                </span>
		                <syswf:control mode="script" action="changeBusinessEntity" caption="${prefix}changeBusinessEntity"  affects="." loadingMask="true">
                            <syswf:param name="tableSelectionBag" value="${tableSelectionBag}"/>
                        </syswf:control>
    
						<syswf:component name="/core/window" prefix="selectBusinessEntity">
						    <syswf:param name="winTitle" value="Select Parent Business Entity" />
						    <syswf:param name="winComponent" value="/integration2/uddi/artifact/actions/selectBusinessEntity"/>
						    <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenSelectionBusinessEntity" />
						    <syswf:param name="artifactExportBean" value="${artifactExportBean}" />
						    <syswf:param name="selectionBag" value="${tableSelectionBag}" />
						    <syswf:param name="winOkAction" value="${prefix}changeBusinessEntity" />
						    <syswf:param name="winOkLabel" value="OK" />
						    <syswf:param name="winWidth" value="680" />
						    <syswf:param name="winButtonAlign" value="right" />
                        </syswf:component>

						<script type="text/javascript">
//<![CDATA[

						    Ext.onReady(function(){
						        attachOn('${prefix}change_businessEntity','click',function() {
						            ${prefix}jsOpenSelectionBusinessEntity();
						        }); 
						    }); 
						
//]]>
</script>
	                </c:if>
	            </td>        		
        	</tr>
        </c:if>        
    </table>                    
</div>  

<syswf:control mode="script" action="changeAuthentication" caption="${prefix}changeAuthentication" affects="." loadingMask="true"/>                
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