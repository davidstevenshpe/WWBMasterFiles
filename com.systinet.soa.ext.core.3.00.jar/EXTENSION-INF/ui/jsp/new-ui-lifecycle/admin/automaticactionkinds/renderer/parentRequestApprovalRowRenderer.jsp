<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="metadata" type="com.hp.systinet.platform.lifecycle.automaticaction.AutomaticActionMetadata"--%>
<%--@elvariable id="configData" type="com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean.ConfigData"--%>
<%--@elvariable id="artifact" type="java.lang.String"--%>
<%--@elvariable id="stage" type="java.lang.String"--%>
<%--@elvariable id="automaticActionsBean" type="com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="expandLink.label" var="expandLinkLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.remove" var="removeLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.deletePopupTitle" var="deletePopupTitle" bundle="${messages}" />
<fmt:message key="automaticActionSection.deleteQuestion" var="deleteQuestion" bundle="${messages}" />
<fmt:message key="parentRequestApproval.artifactLabel" var="artifactLabel" bundle="${messages}" />
<fmt:message key="parentRequestApproval.stageLabel" var="stageLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.edit" var="editLabel" bundle="${messages}"/>
<fmt:message key="notify.renderer.eventLabel" var="eventLabel" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message key="OK" var="OK" bundle="${labels}" />
<fmt:message key="Cancel" var="Cancel" bundle="${labels}" />

<table class="UI Table Properties">
    <col class="FormSelectCol">
    <col class="LongLabelCol">
    <col>
    <col class="ControlCol">
    <col class="SpacerCol">
        <tr>
            <td><a id="aaction_PRA${prefix}_switch"
                class="UI Icon Expand" href="javascript:void(0)"><span>${expandLinkLabel}</span></a></td>
            <td><a class="IconAlign" href="javascript:void(0)"><span>${metadata.name}</span></a></td>
            <td></td>
            <td>
                <div class="Text RightAlign">
                    <a id="aaction_edit_PRA${prefix}" class="UI Icon Edit" href="javascript:void(0)">
                        <span>${editLabel}</span>
                    </a> &nbsp;
                    <a id="aaction_del_PRA${prefix}" class="UI Icon Delete" href="javascript:void(0)">
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
<div id="aaction_PRA${prefix}_comment" class="Comment x-hidden">
    <table class="UI Table Properties">
        <col class="FormSelectCol"/>
        <col/>
        <tr>
            <td></td>
            <td>
                <p class="Comment Plain">
                    <strong>${artifactLabel}</strong>
                    <c:out value="${artifact}"/>
                    <br>
                    <strong>${stageLabel}</strong>
                    <c:out value="${stage}"/>
                    <br>
                    <syswf:out value="${metadata.description}" context="HtmlBody"/>
                </p>
            </td>
        </tr>
    </table>
</div>
    <syswf:component name="/core/window" prefix="aasEditPopupPRA${prefix}">
        <syswf:param name="winId" value="aasEditPopupPRA${prefix}Popup_win" />
        <syswf:param name="winTitle"><fmt:message key="automaticActionSection.label" bundle="${messages}"/></syswf:param>
        <syswf:param name="winComponent" value="${metadata.editRendered}"/>
        <syswf:param name="winOpenFunctionName" value="editPopupPRA${prefix}_open" />
        <syswf:param name="winOkAction" value="customAutomaticActionFn" />
        <syswf:param name="metadata" value="${metadata}"/>
        <syswf:param name="configData" value="${configData}"/>
        <syswf:param name="aasBean" value="${automaticActionsBean}"/>
        <syswf:param name="winRenderAlways" value="true" />
    </syswf:component>
<script type="text/javascript">
//<![CDATA[

    Ext.get('aaction_edit_PRA${prefix}').on('click',function(){
        editPopupPRA${prefix}_open();
    });

    Ext.get('aaction_PRA${prefix}_switch').on('click',function(){
        AdvancedOptions.Comment.Switch('aaction_PRA${prefix}_switch','aaction_PRA${prefix}_comment');
    });

    Ext.onReady(function() {
        SPopup.Window.init('aaction_del_PRA${prefix}','RemoveAas${prefix}_content', {
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
                    handler: function(){ SPopup.Window.Instance.aaction_del_PRA${prefix}.hide(); }
                }
            ]
        });
    });
    //]]>
</script>

