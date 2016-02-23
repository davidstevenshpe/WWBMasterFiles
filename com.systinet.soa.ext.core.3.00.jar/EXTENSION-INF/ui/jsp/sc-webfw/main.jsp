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
<fmt:message key="rootLayout" var="rootLayout" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="status" var="status" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="history" var="history" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="content" var="content" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="navigation" var="navigation" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="title" var="title" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="notices" var="notices" bundle="${webFrameworkUI_Messages}"/>

<%-- Get captionKey value. --%>
<c:if test="${empty viewInstance.dialogCaption and empty viewInstance.taskCaption and not empty captionKey}">
	<syswf:parseResourceKey key="${captionKey}" defaultBaseName="com.systinet.webfw.ui.WebFrameworkComponentMessages" varBundle="bundleName" varResource="finalCaptionKey"/>
	<fmt:setBundle basename="${bundleName}" var="dynamic_Message"/>
    <fmt:message key="${finalCaptionKey}" var="dialogCaption" bundle="${dynamic_Message}"/>
</c:if>

<syswf:panel name="main" wrap="false">

  <syswf:layout name="/layout/rootLayout">
    <syswf:box name="main" caption="${rootLayout}"/>
  </syswf:layout>

  <syswf:area caption="${status}" name="status" defaultBox="status">
    <syswf:component name="/design/situationBar" prefix="situation"/>
  </syswf:area>

  <syswf:area caption="${history}" name="history" defaultBox="history">
    <syswf:component name="breadcrumbs" prefix="path"/>
  </syswf:area>

  <syswf:area caption="${content}" name="content" defaultBox="content">
    <syswf:component name="${contentArea}" prefix="content" params="${contentParameters}" wrap="false"/>
  </syswf:area>

  <syswf:area caption="${navigation}" name="navigation" defaultBox="navigation">
    <syswf:component name="/design/menu" prefix="navigation"/>
  </syswf:area>

  <syswf:area caption="${title}" name="title" defaultBox="title">
    <h2 class="PageTitle"><c:out value="${viewInstance.dialogCaption}" default="${viewInstance.taskCaption}"/> <c:out value="${viewInstance.additionalTitle}" escapeXml="no"/></h2>
  </syswf:area>

  <syswf:area caption="${notices}" name="notices" defaultBox="notices">
    <%--jsp:include page="/shared/pageFooter.jsp" /--%>
  </syswf:area>

</syswf:panel>

