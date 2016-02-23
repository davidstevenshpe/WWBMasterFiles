<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%--Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.favorites.favoritesmessages" var="fav_Message"/>

<%-- Get Message --%>
<fmt:message key="no_artifacts" var="no_artifacts" bundle="${fav_Message}"/>
<fmt:message key="more" var="more" bundle="${fav_Message}"/>
<fmt:message key="title" var="title" bundle="${fav_Message}"/>

<syswf:block className="UI Block Common">
	<div class="Title">
		<h3><c:out value="${title}" /></h3>
	</div>
	<div class="Content">
		<c:choose>
			<c:when test="${empty this.links}">
				<p><c:out value="${no_artifacts}" /></p>
			</c:when>
			<c:otherwise>
				<ul class="UI Bullets">
					<c:forEach items="${this.links}" var="link">
						<li><span>
                            <syswf:control mode="anchor" targetTask="${link.url}" caption="${link.name}" targetDepth="0" />
						</span></li>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="Footer">
        <syswf:control mode="anchor" targetTask="/common/favorites" caption="${more}" targetDepth="0" />
	</div>
</syswf:block>					
