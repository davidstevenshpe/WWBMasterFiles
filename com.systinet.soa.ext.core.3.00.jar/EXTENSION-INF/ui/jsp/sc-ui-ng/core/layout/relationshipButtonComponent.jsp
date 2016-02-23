<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${type eq 'linkNew'}">
	<syswf:control id="${prefix}addNew" mode="script" caption="${prefix}_linkToNewFunc" targetTask="/${viewId}/newArtifact">
	    <syswf:param name="sdmName" value="${artifactTypes}"/>
		<syswf:param name="creationListener" value="${linkToNewRelationListener}"/>
	</syswf:control>
</c:if>

<div style="margin: 15px 10px 10px 0; display: inline-block;">
	<div class="btn btn-gray btn-labeled em fa ${icon}" onclick="${prefix}_${type}_click();">
		<span><c:out value="${label}"/></span>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
    
    function ${prefix}_${type}_click(){
    	var type = '${type}';
   		if (type == 'linkNew'){
   			${prefix}_linkToNewFunc();
   		}else if(type == 'linkExisting') {
			if ('true' === '${multipleRels}') {
				showSelectionArtifact('<syswf:out value="${relationWinTitle}" context="HtmlJSText"/>', 
					'${artifact._uuid}', 
 					'${relationshipName}', 
   					null, 
   					[{type: '${artifactTypes}'}], 
   					null, 
   					{
						domainNamesParam: '${domainNamesParam}', 
						domainIdsParam: '${domainIdsParam}', 
 						domainTypesParam: '${domainTypesParam}', 
 						customDql: '${customDql}',
 						callbackFn: null/*extra param*/,
						multipleRels: '${multipleRels}',
						relationshipNames: '${relationshipNames}',
						sourceArtifactUuids: '${sourceArtifactUuids}'
					}
				);
			} else {
				showSelectionArtifact('<syswf:out value="${relationWinTitle}" context="HtmlJSText"/>', 
					'${artifact._uuid}', 
 					'${relationshipName}', 
   					null, 
   					[{type: '${artifactTypes}'}], 
   					null, 
   					{
						domainNamesParam: '${domainNamesParam}', 
						domainIdsParam: '${domainIdsParam}', 
 						domainTypesParam: '${domainTypesParam}', 
 						customDql: '${customDql}',
 						callbackFn: null/*extra param*/
					}
				);
			}

   		}
   	}

//]]>

</script>