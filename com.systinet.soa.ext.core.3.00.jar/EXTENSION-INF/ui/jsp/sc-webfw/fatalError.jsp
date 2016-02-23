<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String url = request.getContextPath();
%>
<%--
    Displays the "Fatal error" exception to the user. It is used when an exception is thrown during exception processing
    so the "usual" exception page could not be rendered. It will display both exceptions: the original one, and the
    one that happened during error processing :0
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages" />
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messagess" />
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages" />

<fmt:message key="rebranding.productName" var="productName" bundle="${rebranding_Messages}" />
<meta http-equiv="Content-Type" content="<c:out value="${contentType}"/>" />
<title><c:out value="${productName}" /></title>
<link rel="icon" href="<c:out value='${webResourcePath}'/>/img/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="<c:out value='${webResourcePath}'/>/img/favicon.ico" type="image/x-icon" />

<link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin/ext3/resources/css/ext-all.css" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin/css/index.css" />
</head>
<body>
<div style="display: none" id="windowContent"></div>
<div class="UI PageHeader">
<div class="PortalData">&nbsp;</div>
<div class="Product HP-font"><a href="<%= url %>"><span>${productName}</span></a></div>
<div class="UI ProductTabs">&nbsp;</div>
</div>
<div class="UI Page">
<table class="UI Layout">
    <tr>
        <td class="UI Middle" id="pagecontentdata" style="padding-left: 10px">

        <div class="UI Block Green">
        <div class="UI Edge">
        <div class="UI Edge">
        <div class="UI Edge">
        <div class="UI Canvas">
        <div class="Title HP-font">
            <h3><fmt:message key="fatalError_webAppFatalError" bundle="${frameworkJsp_Messagess}" /></h3>
        </div>
        <div class="Content HP-font">
            <p><strong><fmt:message key="fatalError_AppEncounterFatalError" bundle="${frameworkJsp_Messagess}" /></strong></p>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>

        <%--<c:if test="${debug}">
        <div class="UI Block Common">
        <div class="UI Edge">
        <div class="UI Edge">
        <div class="UI Edge">
        <div class="UI Canvas">
        <div class="Title">
            <h3><fmt:message key="fatalError_webAppFatalError" bundle="${frameworkJsp_Messagess}" /></h3>
        </div>
        <div class="Content">
            <c:if test="${not empty exception}">
                <span class="shrException">
                  <fmt:message key="fatalError_originalExceptionError" bundle="${frameworkJsp_Messagess}">
                     <fmt:param>${exception.className}: ${exception.message}</fmt:param>
                  </fmt:message>
                </span>
                <c:if test="${visibleStackTrace}">
                <c:forEach items="${exception.stackTrace}" var="varTraceLine">
                    <span class="shrModule"><fmt:message key="at" bundle="${webFrameworkUI_Messages}" /> <c:out value="${varTraceLine}" /><br />
                    </span>
                </c:forEach>
                </c:if>
            </c:if><br/>
            <c:if test="${not empty fatalException}">
                <div class="shrTrayHeader">
                  <fmt:message key="fatalError_processingExceptionError" bundle="${frameworkJsp_Messagess}">
                     <fmt:param>${fatalException.className}: ${fatalException.message}</fmt:param>
                  </fmt:message>
                </div>
                <c:if test="${visibleStackTrace}">
                <c:forEach items="${fatalException.stackTrace}" var="varTraceLine">
                    <span class="shrModule"><fmt:message key="at" bundle="${webFrameworkUI_Messages}" /> <c:out value="${varTraceLine}" /><br />
                    </span>
                </c:forEach>
                </c:if>
            </c:if>
            </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        </c:if>--%>

        </td>
    </tr>
</table>
</div>
</body>
</html>