<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="anonymousUser" key="uddi.artifact.import.user.anonymous" bundle="${l10n}"/>

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
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.artifact.import.artifactName" bundle="${l10n}"/></label></td>
            <td><label class="UI Label Inline"><syswf:out value="${artifactName}" context="HtmlBody"/></label></td>                            
        </tr>
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.artifact.import.serverName" bundle="${l10n}"/></label></td>
            <td><label class="UI Label Inline"><syswf:out value="${artifactImportBean.registryName}" context="HtmlBody"/></label></td>                            
        </tr>
        <tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.artifact.import.authentication" bundle="${l10n}"/></label></td>
            <td>
                <c:choose>
                    <c:when test="${not empty artifactImportBean.username}">
                        <label class="UI Label Inline"><c:out value='<${artifactImportBean.username}>'/></label>
                    </c:when>
                    <c:otherwise>
                        <label class="UI Label Inline"><c:out value='<${anonymousUser}>'/></label>
                    </c:otherwise>
                </c:choose>
                <span>
                    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_authentication"><fmt:message key="uddi.artifact.import.changeAuthentication" bundle="${l10n}"/></a>
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

	Ext.onReady(function() {
	   attachOn('${prefix}change_authentication','click',function() {
		   ${prefix}jsOpenAuthentication();
	   });
   });

//]]>
</script>