    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.documentation.documentationmessages" var="documentationmessages"/>

<fmt:message var="uploadFileDialogTitle" key="uploadFileDialogTitle" bundle="${documentationmessages}"/>
<fmt:message var="uploadFileDialogOKButtonCaption" key="uploadFileDialogOKButtonCaption" bundle="${documentationmessages}"/>

<c:if test="${hasWritePermission}">

    <c:if test="${empty controlName}">
        <c:set var="controlName" value="${prefix}OpenFce" />
    </c:if>
    
    <syswf:component name="/core/window" prefix="uploadDocumentWindow">
        <syswf:param name="winId" value="${prefix}uploadDocWin" />
        <syswf:param name="winTitle">${uploadFileDialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/core/documentation/uploadDocumentInternal"/>
        <syswf:param name="winOpenFunctionName" value="${controlName}" />
        <syswf:param name="winWidth" value="800" />
        <syswf:param name="winOkAction" value="${prefix}Upload" />
        <syswf:param name="winOkLabel" value="${uploadFileDialogOKButtonCaption}" />
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="documentBean" value="${documentBean}" />
        <syswf:param name="artifact" value="${artifact}" />        
    </syswf:component>
    
    <syswf:control id="${prefix}Upload" mode="script" caption="${prefix}Upload" action="upload"/>
    
    <c:if test="${asLink}">
	    <c:choose>
			<c:when test="${ contextMenu == true}">
				<div class="EA-left-panel">
					<a id="${prefix}Link" class="UI PageAction Attach" title="${uploadFileDialogTitle}" href="javascript:void(0)"><span>${uploadFileDialogTitle}</span></a>					
				</div>
			</c:when>
			<c:otherwise>
				<a href="javascript:void(0);" id="${prefix}Link" class="context-button Attach" title="${uploadFileDialogTitle}"></a>
			</c:otherwise>
		</c:choose>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
           		attachOn('${prefix}Link','click',${controlName});
            });
        
//]]>
</script>
    </c:if>
    
<script type="text/javascript">
//<![CDATA[

      Ext.onReady(function() {
      	    moveWindow('${prefix}uploadDocWin','popupWindows');
      });
        
//]]>
</script>
    
</c:if>
