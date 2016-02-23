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
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messagess"/>

<%-- Get Messages. --%>
<fmt:message key="message" var="message" bundle="${webFrameworkUI_Messages}"/>

<fmt:message key="uddiError_uddiErrorCaption" var="uddiErrorCaption" bundle="${frameworkJsp_Messagess}"/>
<fmt:message key="uddiError_errorCode" var="errorCode" bundle="${frameworkJsp_Messagess}"/>
<fmt:message key="uddiError_errorNumber" var="errorNumber" bundle="${frameworkJsp_Messagess}"/>


<c:choose>
  <c:when test="${not empty uddiExceptionV3}" >
    <div class="Error UDDIExceptionV3Error">
    <h4><c:out value="${uddiErrorCaption}"/></h4>
    <c:if test="${not empty uddiExceptionV3.dispositionReport}">
      <c:forEach items="${exception.dispositionReport.resultArrayList}" var="result" >
        <dl>
          <dt><c:out value="${message}"/>:</dt>
          <dd class="RawCode"><strong><c:out value="${result.errInfo.value}"/></strong></dd>
          <dt><c:out value="${errorCode}"/>:</dt>
          <dd><c:out value="${result.errInfo.errCode}"/></dd>
          <dt><c:out value="${errorNumber}"/>:</dt>
          <dd><c:out value="${result.errno}"/></dd>
        <c:if test="${not empty result.keyType}">
          <dt><fmt:message key="uddiError_keyType" bundle="${frameworkJsp_Messagess}"/>:</dt>
          <dd><c:out value="${result.keyType.value}"/></dd>
        </c:if>
        </dl>
      </c:forEach>
    </c:if>
    </div>
  </c:when>

  <c:when test="${not empty uddiException}" >
    <div class="Error UDDIExceptionError">
    <h4><c:out value="${uddiErrorCaption}"/></h4>
    <dl>
      <dt><c:out value="${message}"/>:</dt>
      <dd><strong><c:out value="${exception.message}" default="${exception.class.name}"/></strong></dd>
      <dt><c:out value="${errorNumber}"/>:</dt>
      <dd><c:out value="${exception.errno}"/></dd>
    </dl>
    </div>
  </c:when>

  <c:when test="${not empty invalidParameterException}" >
    <div class="Error InvalidParameterExceptionError">
    <h4><fmt:message key="uddiError_invalidParameter" bundle="${frameworkJsp_Messagess}"/></h4>
    <dl>
      <dt><c:out value="${message}"/>:</dt>
      <dd class="RawCode"><strong><c:out value="${exception.message}" default="${exception.class.name}"/></strong></dd>
      <dt><c:out value="${errorCode}"/>:</dt>
      <dd><c:out value="${exception.errorCodes}"/></dd>
    </dl>
    </div>
  </c:when>

  <c:when test="${not empty clientException}" >
    <div class="Error ClientExceptionError">
    <h4><fmt:message key="uddiError_clientError" bundle="${frameworkJsp_Messagess}"/></h4>
    <dl>
      <dt><c:out value="${message}"/>:</dt>
      <dd><strong><c:out value="${exception.errorReport.value}"/></strong></dd>
      <dt><c:out value="${errorCode}"/>:</dt>
      <dd><c:out value="${exception.errorReport.errorCode}"/></dd>
    </dl>
    </div>
  </c:when>

  <c:otherwise>
    <div class="Error">
    <h4><fmt:message key="uddiError_internalError" bundle="${frameworkJsp_Messagess}"/></h4>
    <dl>
      <dt><c:out value="${message}"/>:</dt>
      <dd><strong><c:out value="${exception.message}" default="${exception.class.name}" /></strong></dd>
    </dl>
    </div>
  </c:otherwise>

</c:choose>