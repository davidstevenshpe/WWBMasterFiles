<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="messages" />

<c:if test="${not empty allLinkedArtifacts}">
	<div class="Content">
        <ul class="UI Bullets">
		   	<c:forEach var="linkHolder" items="${allLinkedArtifacts}" varStatus="status">
		    	 <li>
		     		<c:choose>
		      			<c:when test="${linkHolder.sdmName eq 'formValidation'}">
		      				<c:out value="${linkHolder.caption}"/> (<fmt:message key="referencedFrom_artifactValidation" bundle="${messages}"/>)
		      			</c:when>
		      			<c:when test="${linkHolder.sdmName eq 'lifeCycle'}">
		      				<syswf:component prefix="processLink_${status.index}" name="/newUi/lc/common/renderer/processLinkRenderer" wrap="false">
		      					<syswf:param name="caption" value="${linkHolder.caption}"/>
		      					<syswf:param name="processUuid" value="${linkHolder.uuid}"/>
		      				</syswf:component>
		      			</c:when>
						<c:otherwise>
			        		<syswf:component prefix="${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
			            		<syswf:param name="uuid" value="${linkHolder.uuid}"/>
			            		<syswf:param name="caption" value="${linkHolder.caption}"/>
			        		</syswf:component>
						</c:otherwise>		      	
		     		</c:choose>
		     	</li>
		   </c:forEach>		    
		 </ul>
	</div> 		  	
</c:if>
