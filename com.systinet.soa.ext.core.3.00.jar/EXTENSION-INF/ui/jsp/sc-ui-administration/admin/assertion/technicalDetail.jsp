<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.assertion.AssertionMessages" var="messages" />
<fmt:message var="paramsTitle" key="assertion.parameters" bundle="${messages}"/>
<fmt:message var="errorMessage" key="assertion.technicalDetail.error" bundle="${messages}"/>

<c:if test="${inaccessableBean}">
	<span class="Comment">${errorMessage}</span>
</c:if>
<c:if test="${empty inaccessableBean}">
	<c:if test="${not empty assertionBean.parameterDefinitions}">
		<syswf:component name="/core/table" prefix="parameters" wrap="false">
		    <syswf:param name="customizationId" value="shared.viewArtifact.assertionArtifact.details.properties.parameters" />       
		    <syswf:param name="title" value="${paramsTitle}"/>
		    <syswf:param name="assertionBean" value="${assertionBean}"/>
		    <syswf:param name="wrapCaption" value="${paramsTitle}"/>
		</syswf:component>
	</c:if>
	
	<syswf:block className="UI Block Common">
	    <div class="Content">
			<c:forEach var="definition" items="${assertionBean.validationDefinitions}" varStatus="defStatus">
			    <syswf:component name="/admin/assertion/implementation" prefix="definition${defStatus.index}">
			        <syswf:param name="definition" value="${definition}"/>
			    </syswf:component>
			</c:forEach>
		</div>
	</syswf:block>
</c:if>