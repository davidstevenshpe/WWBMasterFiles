<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.edit.EditMessages" var="editMessages"/>

<c:if test="${true}">

<c:set var="textareacontent">
    <c:out value="${textEditorContent}"/>
</c:set>

<%-- Edit button label --%>
<c:if test="${empty openPopupButtonLabel}">
    <fmt:message 
        var="openPopupButtonLabel" 
        key="textEditor_editButton" 
        bundle="${editMessages}"/>
</c:if>

<%-- Save button label --%>
<c:if test="${empty saveButtonLabel}">
    <fmt:message 
        var="saveButtonLabel" 
        key="textEditor_saveButton" 
        bundle="${editMessages}"/>
</c:if>

<%-- Cancel button label --%>
<c:if test="${empty cancelButtonLabel}">
    <fmt:message 
        var="cancelButtonLabel" 
        key="textEditor_cancelButton" 
        bundle="${editMessages}"/>
</c:if>

<%-- Editor window title --%>
<c:if test="${empty windowTitle}">
    <fmt:message 
        var="windowTitle" 
        key="textEditor_editorTitle" 
        bundle="${editMessages}"/>
</c:if>

<%-- Window width --%>
<c:if test="${empty windowWidth}">
    <fmt:message 
        var="windowWidth" 
        key="textEditor_editorDefaultWidth" 
        bundle="${editMessages}"/>
</c:if>

<%-- Window height --%>
<c:if test="${empty windowHeight}">
    <fmt:message 
        var="windowHeight" 
        key="textEditor_editorDefaultHeight" 
        bundle="${editMessages}"/>
</c:if>

<%-- Default buttons --%>
<c:if test="${empty customButtons}">
    <c:set var="customButtons">
        [{
            text     : '<c:out value="${saveButtonLabel}"/>',
            disabled : false,
            handler  : function() {
                ${prefix}updateForm();
                SPopup.Window.Instance['${prefix}_extWindow'].hide();
                ${saveFunctionName}();
            },
            id:'${prefix}_saveButton'
        },{
            text     : '<c:out value="${cancelButtonLabel}"/>',
            handler  : function(){
                SPopup.Window.Instance['${prefix}_extWindow'].hide();
                <c:if test="${richText}">
                    CKEDITOR.instances.<c:out value="${prefix}_syswfTextArea"/>.setData(${prefix}_defaultValue);
                </c:if>
                Ext.get('<c:out value="${prefix}"/>_syswfTextArea').dom.value = ${prefix}_defaultValue;
            },
            id:'${prefix}_cancelButton'
        }]
    </c:set>
</c:if>

<a href="javascript:${prefix}_openWindow();" id="<c:out value="${prefix}"/>_editLink" <c:if test="${not empty openPopupButtonClass}">class="<c:out value="${openPopupButtonClass}" />"</c:if> <c:if test="${not empty openPopupButtonHint}">title="<c:out value="${openPopupButtonHint}" />"</c:if>><span><c:out value="${openPopupButtonLabel}"/></span></a>

<syswf:component prefix="w" name="/core/window">
    <syswf:param name="winId" value="${prefix}_extWindow"/>
    <syswf:param name="winTitle" value="${windowTitle}" />
    <syswf:param name="winOpenFunctionName" value="${prefix}_openWindow"/>
    <syswf:param name="winRenderContents" value="true"/>
    <syswf:param name="winResizable" value="false"/>
    <syswf:param name="winWidth" value="840"/>
    <syswf:param name="winCustomButtons" value="${customButtons}"/>
    <syswf:param name="winContents">
        <div id="${prefix}_editor" class="AJAXContainer Offset">
            <syswf:textArea name="textEditorContent" value="${textareacontent}" id="${prefix}_syswfTextArea" escapeXml="false">
                <%--syswf:attribute name="cols" value="180"/>
                <syswf:attribute name="rows" value="60"/--%>
            </syswf:textArea>
            <c:choose>
            <c:when test="${richText}">
                <syswf:component name="/core/impl/edit/richTextEditor" prefix="editor" wrap="false">
                    <syswf:param name="textAreaId" value="${prefix}_syswfTextArea"/>
                    <syswf:param name="parentPopupWindowElementId" value="${prefix}_extWindow"/>
                    <syswf:param name="height" value="500"/>
                    <syswf:param name="width" value="800"/>
                    <syswf:param name="eventToCreateEditor" value="uiReady"/>
                </syswf:component>
            </c:when>
            <c:otherwise>
                <script type="text/javascript">
//<![CDATA[

                    var editorContent = new Ext.BoxComponent(
                        {
                            autoShow: true,
                            applyTo: '<c:out value="${prefix}"/>_syswfTextArea',
                            width: 800,
                            height: 500
                        }
                    );
                
//]]>
</script>
            </c:otherwise>
            </c:choose>
        </div>
    </syswf:param>
</syswf:component>

<syswf:control mode="script" action="saveDialog" caption="${saveFunctionName}">
</syswf:control>

<script type="text/javascript">
//<![CDATA[

    var ${prefix}_defaultValue = Ext.get('<c:out value="${prefix}"/>_syswfTextArea').dom.value;

<c:choose>
    <c:when test="${richText}">
        <%-- RICH TEXT EDITOR --%>
        function ${prefix}updateForm() {
            ${prefix}_editor_updateContent();
        }
     </c:when>
     <c:otherwise>
        <%-- PLAIN EDITOR --%>

        function ${prefix}updateForm() {
            <%--var container = Ext.get('<c:out value="${prefix}"/>_textAreaContainer').dom;
            container.appendChild(Ext.get('<c:out value="${prefix}"/>_syswfTextArea').dom);--%>
        }

     </c:otherwise>
</c:choose>

$(document).on('themeReady',function() {
    moveWindow('${prefix}_extWindow','popupWindows');
});

//]]>
</script>

</c:if>