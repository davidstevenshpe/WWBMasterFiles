<%--
Component parameters

artifact - source artifact [Require]
relationshipName - relation name [Require]
class - class name for rendering link
text - text for link
type - ul(default) or pop-up window, create list of artifact types as ul or popup [Require]
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach var="contentItem" items="${this.artifactSdmNames}">
	<syswf:control id="${prefix}${contentItem.first}addNew" mode="script" caption="${prefix}${contentItem.first}linkToNewFunc" targetTask="/${viewId}/newArtifact">
        <syswf:param name="sdmName" value="${contentItem.first}"/>
		<syswf:param name="tabId" value="${tabId}"/>
		<syswf:param name="subTabId" value="${subTabId}"/>
		<syswf:param name="infraserviceUuid" value="${infraserviceUuid}"/>
        <c:choose>
            <c:when test="${empty creationArtifactRelationListener}">
                <syswf:param name="creationListener" value="${linkToNewRelationListener}"/>
            </c:when>
            <c:otherwise>
                <syswf:param name="creationListener" value="${creationArtifactRelationListener}"/>
            </c:otherwise>
        </c:choose>
    </syswf:control>
</c:forEach>

<c:if test="${empty parentMenuId}">
<a id="${prefix}linkNew" href="javascript:void(0)" class="${class} underline-link">
	<span>${text}</span>
</a>
</c:if>

<script type="text/javascript">
//<![CDATA[
	Ext4.onReady(function(){
		var artifactTypes = ${this.relatedArtifactTypesInJSON};
		var menu = new Ext4.menu.Menu({
			bodyCls: 'context-menu',
			shadow: false
		});
		var prefix = "${prefix}";
		var ref = {};
		ref.count = 0;
		buildLinkNewMenu(menu, artifactTypes, prefix, ref);
		<c:choose>
		<c:when test="${not empty parentMenuId}">
		var parentMenu = Ext4.getCmp('${parentMenuId}');
		if(parentMenu != null) {
			if (ref.count > 1) {
				parentMenu.add({cls:'context-menu-item icon LinkToNew', text:'${text}', menu : menu});
			} else {
				var lastItem = ref.lastItem;
				lastItem.text = '${text}';
				lastItem.cls += ' icon LinkToNew';
				parentMenu.add(lastItem);
			}
    	}
	  	</c:when>
	  	<c:otherwise>
			if(ref.count > 1) {
				Ext4.get('${prefix}linkNew').on('click', function(e,t,o) {
					menu.showAt(e.getXY());
				});
			}else if(ref.count == 1) {
				Ext4.get('${prefix}linkNew').on('click', function(e,t,o) {
					eval(prefix + ref.lastItem.type + 'linkToNewFunc();');				
				});
			}
	  	</c:otherwise>
	  	</c:choose>
	}); 
//]]>
</script>