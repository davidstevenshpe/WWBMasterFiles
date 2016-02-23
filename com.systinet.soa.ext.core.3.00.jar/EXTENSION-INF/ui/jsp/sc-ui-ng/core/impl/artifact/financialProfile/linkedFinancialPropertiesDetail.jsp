<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="message"/>
<fmt:message var="newFiscalPeriod" key="new.fiscal.period" bundle="${message}"/>

<%-- This page is the same as design of artifactDetail
     But we need to reserve separate one page for easier customization
      --%>
<div id="${prefix}cav" style="margin:15px 0 10px 0;display:inline-block">
	<syswf:control id="${prefix}viewAndEditProps" mode="button" caption="View Details & Edit" targetTask="/catalog/viewArtifact" icon="edit">
        <syswf:param name="uuid" value="${artifact._uuid}"/>
    </syswf:control>
</div>
<div class="customPropertiesContainer">
    <jsp:include page="../../../layout/artifactDetail.jsp"/>	
</div>
<syswf:control id="${prefix}createNew" mode="button" caption="${newFiscalPeriod}" targetTask="/${viewId}/newArtifact" icon="plus-square">
       <syswf:param name="sdmName" value="${artifact._artifactSdmName}"/>
       <syswf:param name="creationListener" value="${creationListener}"/>
       <syswf:param name="parentArtifactName" value="${parentArtifactName}"/>
       <syswf:param name="parentArtifactVersion" value="${parentArtifactVersion}"/>
      <c:if test="${disableFinancialButton}">
		<syswf:attribute name="disabled" value="true"/>
	</c:if>
</syswf:control>
<br>
<br>
 <script>
//<![CDATA[

$(document).ready(function(){
	$('#${contextActionId}').prepend($('#${prefix}cav'));
});
            
//]]>
</script>