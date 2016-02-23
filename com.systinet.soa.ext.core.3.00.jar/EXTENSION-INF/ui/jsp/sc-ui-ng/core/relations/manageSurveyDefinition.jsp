<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message bundle="${relationshipmessages}" key="surveyDefinition.description" var="description"/>
<c:set target="${item}" property="styleClass" value="with-text ${item.styleClass}"/>
<c:choose>
	<c:when test="${isAdmin}">
		<syswf:control id="manage" mode="script" caption="${controlName}" hint="" targetTask="/admin/browseArtifact?artifactType=r_scriptArtifact&tabId=survey"/>	
	</c:when>
	<c:otherwise>
	    </div>
        <c:set target="${item}" property="description" value="${description}"/>		
		<c:set target="${item}" property="disable" value="true"/>	
		<c:set target="${item}" property="disablable" value="true"/>
	</c:otherwise>
</c:choose>