<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage"
	var="serverMsg" />
<fmt:message key="edit.save" var="save"
	bundle="${serverMsg}" />
<fmt:message key="edit.cancel" var="cancel"
	bundle="${serverMsg}" />				
<fmt:message key="edit.save.hint" var="savehint"
	bundle="${serverMsg}" />
<fmt:message key="edit.cancel.hint" var="cancelhint"
	bundle="${serverMsg}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
	<syswf:param name="title" value="${this.bean.title}" /> 
</syswf:component>

<syswf:block className="UI Block Common">
	<div class="Content">
	    <c:choose>
	       <c:when test ="${actionMode eq 'new'}">
	           <c:set var ="customizationId" value ="admin.newArtifact.${this.bean.artifact._artifactSdmName}" scope="request"/>
	       </c:when>
	       <c:otherwise>
	           <c:set var ="customizationId" value ="admin.editArtifact.${this.bean.artifact._artifactSdmName}" scope="request"/>
	       </c:otherwise>
	    </c:choose>
	    <syswf:component name="/core/layout/columns" prefix="props" wrap="false">
            <syswf:param name="customizationId" value="${customizationId}" />
            <syswf:param name="artifact" value="${this.bean.artifact}" />
            <syswf:param name="validationReport" value="${this.bean}" />
            <syswf:param name="artifactBean" value="${this.bean}" />
        </syswf:component>
	</div>
</syswf:block>

<syswf:block className="UI Block Green">
	<div class="UI Form Controls">
		<syswf:component name="/integration/${this.bean.artifact._artifactSdmName}/connectionCheckerNew" prefix="${this.bean.artifact._artifactSdmName}connectionCheckerNew" wrap="false">
		    <syswf:param name="artifact" value="${this.bean.artifact}" />
		    <syswf:param name="styleClass" value="btn btn-primary" />
		    <syswf:param name="componentType" value="btn btn-gray" />
		</syswf:component>
		<syswf:control mode="button" caption="${save}" hint="${savehint}" action="save">
			<syswf:attribute name="class" value="btn btn-primary" />
		</syswf:control> 
		<syswf:control mode="button" caption="${cancel}" hint="${cancelhint}"  action="cancel" targetDepth="${sessionStack.currentDepth-this.bean.defautBackPage}">
			<syswf:attribute name="class" value="btn btn-gray" />
		</syswf:control>
	</div>
</syswf:block>
