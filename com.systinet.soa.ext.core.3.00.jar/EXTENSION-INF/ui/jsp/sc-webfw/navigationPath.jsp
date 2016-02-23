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

<div id="NavigationContext" class="NavigationContext" title="<fmt:message key="pageNavigationContext" bundle="${webFrameworkUI_Messages}"/>">
  <p><strong><fmt:message key="path" bundle="${webFrameworkUI_Messages}"/>: </strong>
  	<c:forEach items="${pathLevels}" var="level" varStatus="status">
		<c:choose>
			<c:when test="${empty level.caption and not empty level.captionKey}">
				<syswf:parseResourceKey key="${level.captionKey}" defaultBaseName="com.systinet.webfw.ui.WebFrameworkComponentMessages" varBundle="bundleName" varResource="finalCaptionKey"/>
				<fmt:setBundle basename="${bundleName}" var="dynamic_Message"/>
				<fmt:message key="${finalCaptionKey}" var="navigationCaption" bundle="${dynamic_Message}"/>
			</c:when>
			<c:otherwise>
    	    	<c:set var="navigationCaption" value="${level.caption}"/>
           	</c:otherwise>
		</c:choose>

    	<c:if test="${status.index != 0}"><span class="Divider"><fmt:message key="nextDepthCharacter" bundle="${webFrameworkUI_Messages}"/></span></c:if>
	   	<syswf:control mode="anchor" hint="${navigationCaption}" caption="${navigationCaption}" targetDepth="${level.depth}">
      	</syswf:control>     
    </c:forEach>
  </p>
</div>