<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:forEach var="type" items="${messageTypes}">
	<c:set var="uimessages" value="${messageStores[type]}" />
	
	<c:if test="${not empty uimessages}">
	<%-- Get Message --%>
	
		<c:forEach var="message" items="${uimessages}" varStatus="i">
		    
            <c:choose>
                <c:when test="${type eq 'info'}">
                    <c:set var="class">Info</c:set>
                    <c:set var="icon"></c:set>
                </c:when>
                <c:when test="${type eq 'warning'}">
                    <c:set var="class">Warning</c:set>
                    <c:set var="icon">Warning</c:set>
                </c:when>
                <c:when test="${type eq 'error'}">
                    <c:set var="class">Error</c:set>
                    <c:set var="icon">Error</c:set>
                </c:when>
            </c:choose>
		
			<c:choose>
				<c:when test="${not empty message.component}">
					<syswf:component name="${message.component}" prefix="c${type}${i.index}${message.messageId}" wrap="false">
						<syswf:param name="type" value="${type}" />
						<syswf:param name="class" value="${class}" />
						<c:if test="${not empty message.componentParameters}">
							<c:forEach var="item" items="${message.componentParameters}">
								<syswf:param name="${item.key}" value="${item.value}" />
							</c:forEach>
						</c:if>
					</syswf:component>
				</c:when>
				<c:otherwise>
				    <syswf:component name="/core/impl/layout/uiMessage" prefix="}${type}${i.index}${message.messageId}" >
						<syswf:param name="class" value="${class}" />
						<syswf:param name="controls" value="${message.controls}" />
						<syswf:param name="text" value="${message.text}" />
                        <syswf:param name="icon" value="${icon}" />
				    </syswf:component>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:if>
</c:forEach>
