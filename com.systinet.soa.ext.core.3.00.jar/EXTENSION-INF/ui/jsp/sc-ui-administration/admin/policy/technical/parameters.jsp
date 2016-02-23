<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />

<fmt:message var="requiredParameterEmptyValue" key="parameters.errors.requiredParameterEmptyValue" bundle="${tpMessages}"/>

<c:if test="${not empty assertionBean.params}">
	<div class="Content">	
		<c:forEach var="item" items="${assertionBean.params}" varStatus="status">
			<c:if test="${not item.optional or not empty item.value}">			
				<c:choose>
					<c:when test="${not empty item.taxonomy}">
						<c:choose>
							<c:when test="${item.error}">
								<fmt:message var="categoryNotFound" key="parameters.errors.categoryNotFound" bundle="${tpMessages}">
									<fmt:param><c:out value="'${item.value}'"/></fmt:param>
									<fmt:param><c:out value="'${item.taxonomy}'"/></fmt:param>
								</fmt:message>
								<span title="${categoryNotFound}" class="error"><c:out value="${item.name}=${item.value}"/></span>
							</c:when>
							<c:otherwise>
								<c:out value="${item.name}=${item.taxKeyName}"/>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${not item.optional and empty item.value}">
								<span title="${requiredParameterEmptyValue}" class="error"><c:out value="${item.name}=${item.value}"/></span>
							</c:when>
							<c:otherwise>
								<c:out value="${item.name}= ${item.value}"/>
							</c:otherwise>
						</c:choose>							
					</c:otherwise>
				</c:choose>
				<c:if test="${not status.last}">
					<br/>
				</c:if>
			</c:if>
		</c:forEach>
	</div>
</c:if>