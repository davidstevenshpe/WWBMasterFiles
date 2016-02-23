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
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJspMessages"/>

<%-- Get Messages. --%>
<fmt:message key="home" var="home" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="gotoProductHomePage" var="gotoProductHomePage" bundle="${webFrameworkUI_Messages}"/>


<c:set var="viewInstance.additionalTitle" value="" />

<div class="shrPageTitle">
    <h2><c:out value="${viewInstance.taskCaption}"/></h2>
    <span class="shrArtifactType">
        <fmt:message key="error" bundle="${webFrameworkUI_Messages}"/>
    </span>
    <div class="clear"></div>
</div>
<div class="clear"></div>

<p class="shrWarning">
    <c:out value="${exceptionHolder.message}" default="${exceptionHolder.className}" />
</p>
<c:if test="${not empty debug}">
<div class="shrTrayBlock">
    <div class="shrTrayHeader">
        <h3><fmt:message key="error_technicalDetails" bundle="${frameworkJspMessages}"/></h3>
        <a id="<c:out value='${prefix}_trace'/>" class="fold closed" href="javascript:void(0);" onclick="swapPageMenuItem(this.id); return false;"></a>
    </div>

    <div id="<c:out value='${prefix}_trace'/>_area" <c:if test="${not fatal}">style="display:none;"</c:if>>
        <div class="shrStackTrace">
        	<div class="errorCode">
                <syswf:component prefix="genericError" name="formattedStackTrace"/>
	            <div class="clear"></div>
        	</div>
        </div>
    </div>
</div>
</c:if>

<c:choose>
	<c:when test="${not fatal}">
	    <div class="shrButtonsActions">
	    	<fmt:message key="back" var="back" bundle="${webFrameworkUI_Messages}"/>
	        <syswf:control mode="button" targetHistory="${currentHistory-1}" caption="${back}"/>
	    </div>
	</c:when>
	<c:otherwise>
	    <div align="right">
	    	<a href="<c:out value="${unsecureUrl}"/>"><c:out value="${home}"/></a>
	    </div>
 	</c:otherwise>
</c:choose>
