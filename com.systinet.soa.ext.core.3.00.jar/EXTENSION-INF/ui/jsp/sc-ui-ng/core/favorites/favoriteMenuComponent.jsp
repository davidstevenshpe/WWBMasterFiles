<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%--Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.favorites.favoritesmessages" var="fav_Message"/>

<%-- Get Message --%>
<fmt:message key="more" var="more" bundle="${fav_Message}"/>
						
<c:if test="${not empty this.links}">
		<c:forEach items="${this.links}" var="link" varStatus="status">
			
			<c:set var="fixedLength" value="25"/>
			<c:set var="itemName" value="${link.name}"/>
			<c:if test="${fn:length(itemName) > fixedLength}">
				<c:set var="itemName" value="${fn:substring(link.name,0,fixedLength)}..."/>
				<c:set var="title" value="${link.name}"/>
			</c:if>
			
			<li>
					<syswf:control mode="anchor" targetTask="${link.url}" caption="${itemName}" targetDepth="0" id="${status.index}_name">
						<syswf:attribute name="title" value="${link.name}" />
						<c:if test="${not empty title and fn:length(title) > 0}">
				        	<syswf:attribute name="title" value="${title}" />
				        	<c:set var="title" value=""/>
			        	</c:if>
			        	<syswf:attribute name="class" value="menu-artifact-name" />
					</syswf:control>
					<syswf:control mode="anchor" targetTask="${link.url}" caption="${link.artifactLabel}" targetDepth="0" wrapper="em" id="${status.index}_type">
						<syswf:attribute name="class" value="menu-artifact-type" />
					</syswf:control>
			</li>
		</c:forEach>
		<li class="systinet-horizontal-menu-separator">
			<syswf:control mode="anchor" targetTask="/common/favorites" caption="${more}" targetDepth="0" />
		</li>
</c:if>
