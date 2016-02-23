<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
    REQUIRED PARAMETERS:
--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="windowId" type="java.lang.String"--%>
<%--@elvariable id="submitFunction" type="java.lang.String"--%>
<%--@elvariable id="msgBean" type="java.lang.Object"--%>
<%--@elvariable id="msgProperty" type="java.lang.String"--%>
<%--@elvariable id="maxLength" type="java.lang.String"--%>
<%--
    OPTIONAL PARAMETERS:
--%>
<%--@elvariable id="subTitle" type="java.lang.String"--%>
<%--@elvariable id="actionCaption" type="java.lang.String"--%>
<%--@elvariable id="emptyText" type="java.lang.String"--%>
<%--@elvariable id="minLength" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<%-- Set default values for optional parameters --%>
<c:if test="${empty subTitle}">
    <c:set var="subTitle"><fmt:message key="messageInput.defaultSubTitle" bundle="${messages}"/></c:set>
</c:if>
<c:if test="${empty actionCaption}">
    <c:set var="actionCaption"><fmt:message key="messageInput.defaultSubmitButton" bundle="${messages}"/></c:set>
</c:if>
<c:if test="${empty emptyText}">
    <c:set var="emptyText"><fmt:message key="messageInput.defaultEmptyText" bundle="${messages}"/></c:set>
</c:if>

<c:if var="allowEmptyText" test="${empty minLength || minLength == 0}"/>

<div id="${windowId}_content" class="x-hidden">
    <div class="x-window-header"><c:out value="${title}"/></div>
    <div class="x-window-body">
        <label class="HorizontalLabel" for="${windowId}_msgInput">
            <c:out value="${subTitle}"/>:
            <c:if test="${not allowEmptyText}">
                <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
            </c:if>
        </label>

        <div class="Offset">
            <syswf:textArea name="${windowId}_msgInput" id="${windowId}_msgInput" value="${msgBean}" property="${msgProperty}">
                <syswf:attribute name="class" value="UI Form Text Full"/>
                <syswf:attribute name="rows" value="5"/>
                <syswf:attribute name="cols" value="40"/>
                <syswf:attribute name="placeholder" value="${emptyText}"/>
            </syswf:textArea>

            <div class="UI Message Error x-hidden" id="${windowId}_msgInputError">
                <span><c:choose>
                    <c:when test="${empty minLength}">
                        <fmt:message key="messageInput.maxLimitError" bundle="${messages}">
                            <fmt:param value="${maxLength}"/>
                        </fmt:message>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="messageInput.minMaxLimitError" bundle="${messages}">
                            <fmt:param value="${minLength}"/>
                            <fmt:param value="${maxLength}"/>
                        </fmt:message>
                    </c:otherwise>
                </c:choose></span>
            </div>
        </div>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
            	moveWindow('RequestApproval_content','popupWindows');
                ${windowId}_msgTextArea = 	new Ext.form.TextArea({
                    applyTo: '${windowId}_msgInput',
                    allowBlank: <c:out value="${allowEmptyText}"/>,
                    <c:if test="${not allowEmptyText}">minLength: ${minLength},</c:if>
                    maxLength: ${maxLength},
                    emptyText: '<c:out value="${emptyText}"/>'
                });
                ${windowId}_msgTextArea.on('invalid', function() {
                    Ext.get('${windowId}_msgInputError').removeClass('x-hidden');
                    Ext.getCmp('${windowId}msgSubmitButton').disable();
                });
                ${windowId}_msgTextArea.on('valid', function() {
                    Ext.get('${windowId}_msgInputError').addClass('x-hidden');
                    Ext.getCmp('${windowId}msgSubmitButton').enable();
                });
            });
        
//]]>
</script>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        SPopup.Window.init('${windowId}','${windowId}_content', {
            autoHeight: true,
            resizable: true,
            shadow: false,
            centerOnScreen:true,
            width:450,
            forceRefresh: true, // to survive ajax reload
            buttons:[{
                text: '<c:out value="${actionCaption}"/>',
                id: '${windowId}msgSubmitButton',
                handler: function() {
                    if (${windowId}_msgTextArea.isValid()) {
                        ${windowId}_msgTextArea.setRawValue(${windowId}_msgTextArea.getValue());
                        SPopup.Window.Instance.${windowId}.hide();
                        ${submitFunction}();
                    } else {
                        ${windowId}_msgTextArea.focus();
                    }
                }
            }, {
                text: '<fmt:message key="messageInput.cancelButton" bundle="${messages}"/>',
                handler: function() {
                    ${windowId}_msgTextArea.reset();
                    SPopup.Window.Instance.${windowId}.hide();
                }
            }]
        });
    });

//]]>
</script>
