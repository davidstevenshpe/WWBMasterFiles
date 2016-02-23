<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.documentation.documentationmessages" var="documentationmessages"/>

<fmt:message var="addDocumentReferenceTitle" key="addDocumentReferenceTitle" bundle="${documentationmessages}"/>
<fmt:message var="addDocumentReferenceAddLabel" key="addDocumentReferenceAddLabel" bundle="${documentationmessages}"/>

<c:if test="${hasWritePermission}">

    <syswf:component name="/core/window" prefix="addDocReferenceWindow">
        <syswf:param name="winId">${prefix}Win</syswf:param>
        <syswf:param name="winTitle">${addDocumentReferenceTitle}</syswf:param>
        <%-- The 'internal' component JSP should be in impl package/directory --%>
        <syswf:param name="winComponent" value="/core/documentation/addDocumentReferenceInternal"/>
        <syswf:param name="winOpenFunctionName" value="${controlName}" />
        <syswf:param name="winWidth" value="800" />
        <syswf:param name="winOkAction" value="${prefix}Add" />
        <syswf:param name="winOkLabel" value="${addDocumentReferenceAddLabel}" />
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="holder" value="${holder}" />
    </syswf:component>
    
    <syswf:control id="${prefix}Add" mode="script" caption="${prefix}Add" action="add"/>

    
</c:if>