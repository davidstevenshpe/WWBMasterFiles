<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sync.ui.L10nUIMessages" var="messages" />
<fmt:message key="edit.save" var="save" bundle="${messages}" />
<fmt:message key="edit.cancel" var="cancel"	bundle="${messages}" />				
<fmt:message key="edit.save.hint" var="savehint" bundle="${messages}" />
<fmt:message key="edit.cancel.hint" var="cancelhint" bundle="${messages}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
	<syswf:param name="title" value="${this.bean.title}" /> 
	<syswf:param name="subtitle" value="${this.bean.subtitle}" /> 
</syswf:component>
<syswf:block className="UI Block Common">
	<div class="Content">
	    <c:choose>
	       <c:when test ="${actionMode eq 'new'}">
	           <c:set var ="customizationId" value ="admin.newArtifact.${sdmName}" scope="request"/>
	       </c:when>
	       <c:otherwise>
	           <c:set var ="customizationId" value ="admin.newArtifact.syncRepository" scope="request"/>
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
		<syswf:control mode="button" caption="${save}" hint="${savehint}" action="save">
			<syswf:attribute name="class" value="btn btn-primary" />
		</syswf:control> 
		<syswf:control mode="button" caption="${cancel}" hint="${cancelhint}"  action="cancel" targetDepth="${sessionStack.currentDepth-this.bean.defautBackPage}"/>
	</div>
</syswf:block>
