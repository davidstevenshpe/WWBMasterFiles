<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<table class="UI Table Layout">
    <c:forEach items="${artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
		<c:if test="${group.id != 'proxy.mgmt' or proxyMgmtEnabled}">
			<c:if test="${group.hasCreatableTypes}">
				<col />
				<c:if test="${not groupStatus.last}">
					<col class="SpacerCol" />
				</c:if>
			</c:if>
		</c:if>
    </c:forEach>
    <tr>
        <c:forEach items="${artifactsConfiguration.groups}" var="group" varStatus="groupStatus">
        	<c:if test="${group.id != 'proxy.mgmt' or proxyMgmtEnabled}">
	            <c:if test="${group.hasCreatableTypes}">
	                <td>
	                    <h4>${group.label}</h4>
	                    <ul class="UI Hierarchy Plain">
	                        <c:forEach items="${group.artifactTypes}" var="artifactType" varStatus="artifactTypeStatus">
                                <c:if test="${artifactType.allowCreate or artifactType.subArtifactHasCreate}">	
	                                <li>
	                                   	<syswf:component name="${linkRenderer}" prefix="popupCreateLinks_${groupStatus.index}_${artifactTypeStatus.index}" wrap="true">
	                                        <syswf:param name="defaultBasicArtifacts" value="${defaultBasicArtifacts}"/>
	                                        <syswf:param name="showBasicOnly" value="false"/>
	                                        <syswf:param name="artifactSdmType" value="${artifactType}"/>
	                                        <syswf:param name="showIcon" value="true"/>
	                                        <syswf:param name="wrapAsListItem" value="true"/>
	                                        <syswf:param name="renderPin" value="true"/>
	                                        <syswf:param name="renderAbstractArtifactType" value="staticLink"/>
	                                        <syswf:param name="collectionId" value="${collectionId}"/>
	                                        <syswf:param name="mode" value="create"/>
                                            <syswf:param name="indent" value="display: block; background-position: left 3px; line-height:14px;"/>
	                                   	</syswf:component>
	                                </li>
                                </c:if>
	                        </c:forEach>
	                    </ul>
	                </td>
	                <c:if test="${not groupStatus.last}">
	                    <td><!-- SPACER --></td>
	                </c:if>
	            </c:if>        	
        	</c:if>
        </c:forEach>
    </tr>
</table>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        var createLinks = Ext.select('#${prefix} div.UI a.Artifact', true);
        createLinks.each(function(el, self, index) {
            el.on('click', function() {
                SPopup.Window.Instance['${popupId}'].hide();
                return false;
            })
        });
    });

//]]>
</script>