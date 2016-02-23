<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="expandLink.label" var="expandLinkLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.remove" var="removeLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.deletePopupTitle" var="deletePopupTitle" bundle="${messages}" />
<fmt:message key="automaticActionSection.deleteQuestion" var="deleteQuestion" bundle="${messages}" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message key="OK" var="OK" bundle="${labels}" />
<fmt:message key="Cancel" var="Cancel" bundle="${labels}" />

<%--@elvariable id="metadata" type="com.hp.systinet.platform.lifecycle.automaticaction.AutomaticActionMetadata"--%>
<%--@elvariable id="configData" type="com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean.ConfigData"--%>

<table class="UI Table Properties">
    <col class="FormSelectCol">
    <col class="LongLabelCol">
    <col>
    <col class="ControlCol">
    <col class="SpacerCol">
        <tr>
            <td><a id="aaction_${prefix}_switch"
                class="UI Icon Expand" href="javascript:void(0)"><span>${expandLinkLabel}</span></a></td>
            <td><a class="IconAlign" href="javascript:void(0)"><span>${metadata.name}</span></a></td>
            <td></td>
            <td>
            <div class="Text RightAlign">
                <a id="aaction_del_${prefix}" class="UI Icon Delete" href="javascript:void(0)">
                    <span>${removeLabel}</span>
                </a>
                <div id="RemoveAas${prefix}_content" class="x-hidden">
                    <div class="x-window-header">${deletePopupTitle}</div>
                    <div class="x-window-body">
                        <p class="Warning">${deleteQuestion}</p>
                    </div>
                </div>
            </div>
            </td>
            <td></td>
        </tr>
</table>
<div id="aaction_${prefix}_comment" class="Comment x-hidden">
    <table class="UI Table Properties">
        <col class="FormSelectCol"/>
        <col/>
        <tr>
            <td></td>
            <td>
                <p class="Comment Plain"><syswf:out value="${metadata.description}" context="HtmlBody"/></p>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
//<![CDATA[

    Ext.get('aaction_${prefix}_switch').on('click',function(){
        AdvancedOptions.Comment.Switch('aaction_${prefix}_switch','aaction_${prefix}_comment');
    });

    Ext.onReady(function() {
        SPopup.Window.init('aaction_del_${prefix}','RemoveAas${prefix}_content', {
            autoHeight: true,
            resizable: true,
            shadow: false,
            centerOnScreen:true,
            buttonAlign: 'center',
            width:400,
            buttons:[
                {
                    text: '${OK}',
                    id: 'RemoveAas${prefix}Confirm',
                    handler: function(){ deleteAutomaticAction('${configData.id}'); }
                },
                {
                    text: '${Cancel}',
                    handler: function(){ SPopup.Window.Instance.aaction_del_${prefix}.hide(); }
                }
            ]
        });
    });
    //]]>
</script>
