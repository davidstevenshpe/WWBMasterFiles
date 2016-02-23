<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="createDomain.title" var="title" bundle="${domain_Messages}"/>

<fmt:message key="button.save.label" bundle="${domain_Messages}" var="save_Label"/>
<fmt:message key="button.cancel.label" bundle="${domain_Messages}" var="cancel_Label"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:component name="/detail/editArtifactProperties"  prefix="${this.bean.artifact.artifactDescriptor.artifactSdmName}" wrap="false">
				    <syswf:param name="customizationId" value="admin.domain.properties" />
				    <syswf:param name="artifact" value="${this.bean.artifact}" />
				    <syswf:param name="validationReport" value="${this.bean}" />
				</syswf:component>
				
				<syswf:block className="UI Block Green">
				    <div class="Content">
				        <div class="UI Form Controls">
				            <syswf:control mode="postAnchor" action="save" caption="${save_Label}">
				                <syswf:attribute name="class" value="btn btn-primary" />
				            </syswf:control>
				            <syswf:control mode="postAnchor" action="cancel" caption="${cancel_Label}" 
				            	targetDepth="${sessionStack.currentDepth-1}">
				                <syswf:attribute name="class" value="btn btn-gray" />
				            </syswf:control>
				        </div>
				    </div>
				</syswf:block>
				<syswf:component name="/util/stayLoggedIn" prefix="stayLoggedIn" wrap="false" />
			</td>
		</tr>
	</tbody>
</table>				