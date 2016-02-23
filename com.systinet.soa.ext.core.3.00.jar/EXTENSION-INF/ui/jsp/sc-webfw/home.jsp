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

<%-- Get Messages. --%>
<fmt:message key="linkJavaScriptFreeVersionDescription" var="linkJavaScriptFreeVersionDescription" bundle="${webFrameworkUI_Messages}"/>

<html>
 <body>
    <form name="detectionForm" id="detectionForm" method="POST" action="<c:out value="${baseUrl}"/>" <c:if test="${not empty enctype}">enctype="<c:out value="${enctype}"/>"</c:if>>
         <input type="hidden" name="sessionId" value="<c:out value='${sessionId}'/>" />          
         <input type="hidden" name="history" value="<c:out value='${historyTimestamp}'/>" />
         <input type="hidden" id="javascriptSupport" name="javascriptSupport" value="false" />

         <script type="text/javascript">
//<![CDATA[

            function beforeSubmit(form) {
            }       
         
//]]>
</script>

         <syswf:control mode="script" formName="detectionForm" caption="go" targetTask="/design/home" targetDepth="0"/>
         <script type="text/javascript">
//<![CDATA[

            document.getElementById('javascriptSupport').value='true';
            go();
         
//]]>
</script>
         <c:out value="${linkJavaScriptFreeVersionDescription}"/>
        <%--
         <syswf:control mode="anchor" caption="${linkJavaScriptFreeVersionDescription}" targetTask="/design/home" targetDepth="0"/>
         --%>
    </form>
  </body>
</html>
  