<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>


<div class="shrBreadcrumbs" title="<fmt:message key="pageNavigationContext" bundle="${webFrameworkUI_Messages}"/>">

	<c:forEach items="${this.breadcrumbs}" var="level" varStatus="status">
    	<c:choose>
			<c:when test="${empty level.title and not empty level.titleKey}">
				<syswf:parseResourceKey key="${level.titleKey}" defaultBaseName="com.systinet.webfw.ui.WebFrameworkComponentMessages" varBundle="bundleName" varResource="finalCaptionKey"/>
				<fmt:setBundle basename="${bundleName}" var="dynamic_Message"/>
				<fmt:message key="${finalCaptionKey}" var="levelTitle" bundle="${dynamic_Message}"/>
			</c:when>
			<c:otherwise>
				<c:set var="levelTitle" value="${level.title}"/>
			</c:otherwise>
		</c:choose>
				
    
   		<c:if test="${status.index != 0}"><fmt:message key="nextDepthCharacter" bundle="${webFrameworkUI_Messages}"/></c:if>
		<c:choose>
    		<c:when test="${level.targetDepth>=0}">
       			<syswf:control mode="anchor" hint="${levelTitle}" caption="${levelTitle}" targetDepth="${level.targetDepth}">
            	</syswf:control>
		    </c:when>
    		<c:otherwise>
        	    <syswf:control mode="anchor" hint="${levelTitle}" caption="${levelTitle}" targetDepth="${level.depth}" targetTask="${level.targetTask}">
	        	</syswf:control>
	    	</c:otherwise>
		</c:choose>        	
    </c:forEach>
</div>
