<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${isAccessGranted}">

	<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="common_Messages" />
	<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
	<fmt:message var="dialogTitle" key="browseDomain.operations.delete.dialog.header" bundle="${domain_Messages}"/>
	
	<c:choose>
		<c:when test="${empty singlePrincipal}">
			<fmt:message var="warningMessage" key="browseDomain.operations.delete.confirm_msg" bundle="${domain_Messages}"/>
		</c:when>
		<c:otherwise>
			<fmt:message var="warningMessage" key="viewDomain.actions.delete.confirm_msg" bundle="${domain_Messages}">
				<fmt:param><syswf:out value="${domainName}" context="HtmlBody"/></fmt:param>
			</fmt:message>
		</c:otherwise>
	</c:choose>
		
	<syswf:component name="/core/impl/util/dialog" prefix="deleteDomains">
		<syswf:param name="handler" value="${prefix}deleteDomains" />
		<syswf:param name="heading">${dialogTitle}</syswf:param>
		<syswf:param name="content">${warningMessage}</syswf:param>
		<syswf:param name="noUndo" value="true" />
		<syswf:param name="controlName" value="${prefix}_openDeleteDomainConfirmPopUp"/>
	</syswf:component>
	
	<c:choose>
		<c:when test="${empty singlePrincipal}">
			<syswf:control mode="script" action="deleteDomains" caption="${prefix}deleteDomains">			
				<syswf:param name="selectionBag" value="${selectionBag}" />
			</syswf:control>				
		</c:when>
		<c:otherwise>
			<syswf:control mode="script" action="deleteDomains" caption="${prefix}deleteDomains">				
			</syswf:control>														
		</c:otherwise>
	</c:choose>
		
	<script type="text/javascript">
	//<![CDATA[

		var ${controlName} = function() {
			${prefix}_openDeleteDomainConfirmPopUp();
		}
	
	//]]>
	</script>
</c:if>