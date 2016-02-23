<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsmessages"/>

<c:choose>
    <c:when test="${hasNoContent}">
        <fmt:message var="uploadFileDialogTitle" key="attachDataContent" bundle="${importsmessages}"/>
    </c:when>
    <c:otherwise>
        <fmt:message var="uploadFileDialogTitle" key="changeDataContent" bundle="${importsmessages}"/>
    </c:otherwise>
</c:choose>

<fmt:message var="uploadFileDialogOKButtonCaption" key="Upload" bundle="${importsmessages}"/>

<c:if test="${hasWritePermission}">

    <syswf:component name="/core/credstore/editCredential" prefix="saveCredential">
        <syswf:param name="openDialogFunction" value="__openCredStoreDialog" /> 
        <syswf:param name="winTitle" value="${saveCredentialTitle}" />
    </syswf:component>

    <c:if test="${empty controlName}">
        <c:set var="controlName" value="${prefix}OpenFce" />
    </c:if>
    
    <syswf:component name="/core/window" prefix="uploadDataContentWindow">
        <syswf:param name="winId">${prefix}uploadDataContentWin</syswf:param>
        <syswf:param name="winTitle">${uploadFileDialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/core/dataattachment/uploadDataContentInternal"/>
        <syswf:param name="winOpenFunctionName" value="${controlName}" />
        <syswf:param name="winWidth" value="800" />
        <syswf:param name="winOkAction" value="${prefix}Upload" />
        <syswf:param name="winOkLabel" value="${uploadFileDialogOKButtonCaption}" />
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="documentBean" value="${documentBean}" />
        <syswf:param name="artifact" value="${artifact}" />
        <syswf:param name="hasNoContent" value="${hasNoContent}" />
    </syswf:component>
    
    <syswf:control id="${prefix}Upload" mode="script" caption="${prefix}Upload" action="upload"/>
    
    <c:if test="${asLink}">
        <c:if test="${empty linkCaption}">
            <c:set var="linkCaption" value="${uploadFileDialogTitle}"/>
        </c:if>

        <c:if test="${empty linkClass}">
            <c:set var="linkClass" value="Attach"/>
        </c:if>

        <c:if test="${empty hint}">
            <c:set var="hint" value="${linkCaption}"/>
        </c:if>

        <a href="javascript:void(0);" id="${prefix}Link" class="UI PageAction ${linkClass}" title="${hint}">${linkCaption}</a>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.get('${prefix}Link').on('click', function() {
                    ${controlName}();
                });
                moveWindow('${prefix}uploadDataContentWin','popupWindows');
            });
        
//]]>
</script>
    </c:if>
    
</c:if>
