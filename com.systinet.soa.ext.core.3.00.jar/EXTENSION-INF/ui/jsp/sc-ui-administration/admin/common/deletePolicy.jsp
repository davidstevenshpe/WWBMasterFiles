<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${permissions.delete and not deleted}">    
    <c:set var="controlName" value="deleteArtifactFunc" />
    <syswf:component name="/admin/policy/bulk/deleteSingle" prefix="deleteSingleTechnicalPolicy">
        <syswf:param name="artifact" value="${artifact}" />
        <syswf:param name="uuid" value="${artifact._uuid}" />
        <syswf:param name="artifactName" value="${artifact.name}" />
        <syswf:param name="controlName" value="${controlName}" />
        <syswf:param name="includeSubArtifacts" value="${includeSubArtifacts}"/>
        <syswf:param name="disableAdvancedOptions" value="${disableAdvancedOptions}"/>
        <syswf:param name="winWidth" value="500" />
        <syswf:param name="singleDelete" value="true" />
    </syswf:component>
    
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="messages"/>
    <fmt:message var="delete_buttonLabel" key="contextAction.deleteTechnicalPolicy" bundle="${messages}"/>    

    <a id="DeleteArtifact" href="javascript:void(0);" class="context-button Remove" title="<syswf:out value="${delete_buttonLabel}" context="HtmlBody"/>"></a>
    <script type="text/javascript">
//<![CDATA[

	    Ext.onReady(function() {
	        attachOn('DeleteArtifact','click',${controlName});
	    });
	
//]]>
</script>
</c:if>