<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />

<div id="${prefix}">
	<c:choose>
		<c:when test="${bean.artifactTypeAccessBean.domainId eq 'topLevelDomain'}">
			<c:forEach items="${bean.accessGranteds}" var="agBean" varStatus="cnt">
				<c:choose>
					<c:when test="${agBean.principalId eq principalId}">
						<syswf:control mode="script" action="changeAccessGranted" caption="${prefix}_changeAccessGranted" 
							id="${prefix}_changeAccessGranted" affects="." />
						<syswf:selectOne id="${prefix}_selectValue" optionValues="${accessGrantedOptions}"
							name="${prefix}_selectValue" optionCaptions="${accessGrantedCaptions}"
							value="${agBean}" property="accessGranted" mode="menu">
							<syswf:attribute name="onChange">${prefix}_changeAccessGranted()</syswf:attribute>
						</syswf:selectOne>				
					</c:when>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<label>
				<fmt:message key="defaultAcl.artifactDomain" bundle="${domain_Messages}" />
			</label>
		</c:otherwise>
	</c:choose>
</div>