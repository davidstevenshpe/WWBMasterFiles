<%-- MARKED FOR DELETION --%>
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
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="title" var="title" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="documentation" var="documentation" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="main" var="main" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="signIn" var="signIn" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="cancel" var="cancel" bundle="${webFrameworkUI_Messages}"/>

<fmt:message key="login_registerCaption" var="registerCaption" bundle="${frameworkJsp_Messages}"/>
<fmt:message key="login_registerHint" var="registerHint" bundle="${frameworkJsp_Messages}"/>
<fmt:message key="login_enterUserNameHint" var="enterUserNameHint" bundle="${frameworkJsp_Messages}"/>
<fmt:message key="login_enterPasswordHint" var="enterPasswordHint" bundle="${frameworkJsp_Messages}"/>
<fmt:message key="login_loginHint" var="loginHint" bundle="${frameworkJsp_Messages}"/>
<fmt:message key="login_cancelHint" var="cancelHint" bundle="${frameworkJsp_Messages}"/>

<c:set var="baseUrl" value="${secureUrl}" scope="request"/>
<c:set var="loggedUser" value="${globalSession['userName']}"/>

	<%-- login page header, sign in label and register link --%>
    <syswf:panel name="login">
        <syswf:component name="/layout/common" prefix="layoutDefinition" wrap="false"/>
        <syswf:area caption="${title}" name="title" defaultBox="title" placementPriority="10000">
            <div class="shrPageTitle">
              <h2>
                  <c:out value="${viewInstance.dialogCaption}" default="${viewInstance.taskCaption}"/> <c:if test="${not empty viewInstance.additionalTitle}"> <span>/ <c:out value="${viewInstance.additionalTitle}" escapeXml="no"/> </span> </c:if>
              </h2>
            </div>
        </syswf:area>

        <c:if test="${not(disableRegister eq 'true')}">
	        <syswf:area name="info" caption="${documentation}" defaultBox="info">
				<c:set var="controlRegister">
					<syswf:control targetDepth="${sessionStack.currentDepth}" targetTask="/account/registerUser" mode="anchor" caption="${registerCaption}" hint="${registerHint}">
						<syswf:attribute name="class" value="Control AddUserControl"/>
						<syswf:param name="collection" value="contactArtifacts"/>
		            </syswf:control>
				</c:set>
				<fmt:message key="login_registerInstruction" bundle="${frameworkJsp_Messages}">
					<fmt:param value="${controlRegister}"/>
				</fmt:message>		
	        </syswf:area>
        </c:if>
		
		<%-- content of login page --%>
        <syswf:area name="login" caption="${main}" defaultBox="content">
            <c:choose>
                <c:when test="${not empty loginError}">
                    <div class="shrPageErrorBox">
                        <strong><c:out value="${loginError}"/></strong> <fmt:message key="login_userNamePasswordError" bundle="${frameworkJsp_Messages}"/></div>
                </c:when>
                <c:when test="${not empty loggedUser and not newAccountCreated}">
                    <div class="shrPageErrorBox">
                        <fmt:message key="login_authenticationError" bundle="${frameworkJsp_Messages}"/></div>
                </c:when>
            </c:choose>

            <table class="shrTable">
                <tbody>
                    <tr>
                        <th class="first">
                        	<label for="<c:out value="${prefix}"/>_userName">
                        		<fmt:message key="userName" bundle="${webFrameworkUI_Messages}"/>:
                        	</label>
                        </th>
                        <td>
                            <syswf:input name="userName" value="${loggedUser}" hint="${enterUserNameHint}">
                                <syswf:attribute name="class" value="text UserName loginProcess"/>
                                <syswf:attribute name="autocomplete" value="off"/>
                                <%--             
                                <syswf:attribute name="onkeypress">if (event.keyCode==13) {<syswf:control mode="script" action="processLogin"/>;}</syswf:attribute>
                                --%>
                            </syswf:input>
                        </td>
                    </tr>
                    <tr>
                        <th class="first">
                        	<label for="<c:out value="${prefix}"/>_userPassword">
                        		<fmt:message key="password" bundle="${webFrameworkUI_Messages}"/>:
                        	</label>
                        </th>
                        <td>
                            <syswf:input name="userPassword" value="" mode="password" hint="${enterPasswordHint}">
                                <syswf:attribute name="class" value="text loginProcess"/>
                                <syswf:attribute name="autocomplete" value="off"/>
                            </syswf:input>
                        </td>
                    </tr>
                </tbody>
            </table>
            <script type="text/javascript">
//<![CDATA[
$('<c:out value="${prefix}"/>_userName').focus();

//]]>
</script>
        </syswf:area>
        
        <%-- bottom login buttons --%>
		<syswf:area caption="${main}" name="buttons" defaultBox="leftButtons">
       		<syswf:control action="processCancel" mode="postAnchor" caption="${cancel}">
				<syswf:attribute name="title" value="${cancelHint}"/>
               	<syswf:attribute name="class" value="shrRndButton"/>
			</syswf:control>
       		
       		<syswf:control action="processLogin" mode="postAnchor" caption="${signIn}">
				<syswf:attribute name="title" value="${loginHint}"/>
             	<syswf:attribute name="class" value="shrRndButton loginProcessButton"/>
			</syswf:control>
        </syswf:area>
    </syswf:panel>