<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Set locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsMessages"/>

<fmt:message var="importFile_pageTitle" key="importFile.pageTitle" bundle="${importsMessages}"/>
<fmt:message var="importFile_pageDescription" key="importFile.pageDescription" bundle="${importsMessages}"/>
<fmt:message var="importFile_importButton" key="importFile.importButton" bundle="${importsMessages}"/>
<fmt:message var="importFile_cancelButton" key="importFile.cancelButton" bundle="${importsMessages}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${importFile_pageTitle}"/>
</syswf:component>

<syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
    <syswf:param name="message"><syswf:out value="${importFile_pageDescription}" context="HtmlBody"/></syswf:param>
</syswf:component><br/>

<syswf:component name="/core/layout/dropdowns" prefix="publishingDropdowns" wrap="false">
    <syswf:param name="customizationId" value="${customizationId}" />
    <syswf:param name="importFileBean" value="${importFileBean}"/>
    <syswf:param name="widthDropdown" value="110"/>
</syswf:component>

<syswf:block className="UI Block Green Last">
    <div class="Content">
        <div class="UI Form Controls">
            <syswf:control id="${prefix}Import" mode="postAnchor" caption="${importFile_importButton}" action="importFile" wrapper="span">
                <syswf:attribute name="class" value="btn btn-primary"/>
            </syswf:control>
            <syswf:control id="${prefix}Cancel" mode="postAnchor" caption="${importFile_cancelButton}" action="cancel" wrapper="span" targetDepth="${sessionStack.currentDepth - 1}">
                <syswf:attribute name="class" value="btn btn-gray"/>
            </syswf:control>            
          </div>
    </div>
</syswf:block>