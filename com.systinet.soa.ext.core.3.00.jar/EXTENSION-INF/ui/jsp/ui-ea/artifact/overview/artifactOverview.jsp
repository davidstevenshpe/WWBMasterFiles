<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<syswf:component name="/core/relations/selectArtifacts" prefix="${prefix}ArtifactSelection"/>
<c:forEach var="linkToNewRelationListener" items="${this.linkToNewRelationListeners}" varStatus="status">
	<syswf:control id="${prefix}$-overview-linkNew-${status.index}" mode="script" caption="${prefix}linkToNewFunc${linkToNewRelationListener.relationshipName}${linkToNewRelationListener.outgoingSdmName}" targetTask="/${viewId}/newArtifact">
       <syswf:param name="sdmName" value="${linkToNewRelationListener.outgoingSdmName}"/>
       <syswf:param name="creationListener" value="${linkToNewRelationListener}"/>
       </syswf:control>
</c:forEach>
<c:set var="artifactName">
   <syswf:out value="${artifact.name}" context="HtmlJSText"/>
</c:set>
<div id="${prefix}-overview">
</div>
<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
	var contentGroups = '${content}';
	Ext4.create('EA.model.ArtifactOverview', {
		dataSource: '${scriptLocation}',
		dql: "${dql}",
      	seed: '${artifact._uuid}',
      	coreSdmList: '' + toString(getSdmNames(${coreArtifactSdmList}, [])),
		contentGroups: contentGroups,
		renderTo: '${prefix}-overview',
		linkNewPrefix: '${prefix}linkToNewFunc',
		artifact: {
			uuid: '${artifact._uuid}',
			sdmName: '${artifact._artifactSdmName}',
			name: '<syswf:out value="${artifactName}" context="HtmlJSText"/>'		
		},
		artifactSdmLabels: ${artifactSdmLabels}
	});
	function toString(sdmNames) {
    	var result = "";
    	for (idx = 0; idx < sdmNames.length ; idx++) {
    		result += sdmNames[idx] + ",";
    	}
    	return result;
    }
    
    function getSdmNames(subTypes, sdmNames){
        for (var i=0; i< subTypes.length; i++){
            var subType = subTypes[i];
            if (subType.subs.length > 0){
                getSdmNames(subType.subs, sdmNames);
            }
            if (!subType.abstractType){
                sdmNames.push(subType.type);
            }
        }
        return sdmNames;
    }
});

//]]>
</script>