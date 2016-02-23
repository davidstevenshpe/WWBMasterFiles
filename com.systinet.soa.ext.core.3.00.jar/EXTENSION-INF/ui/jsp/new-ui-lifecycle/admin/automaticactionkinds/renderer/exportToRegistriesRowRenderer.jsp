<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
<fmt:message bundle="${bundle}" key="automaticActionSection.okButton" var="OK" />
<fmt:message bundle="${bundle}" key="automaticActionSection.cancelButton" var="Cancel" />
<fmt:message bundle="${bundle}" key="automaticActionSection.edit" var="Edit" />
<fmt:message bundle="${bundle}" key="automaticActionSection.remove" var="Remove" />
<fmt:message bundle="${bundle}" key="automaticActionSection.deletePopupTitle" var="DeletePopupTitle" />
<fmt:message bundle="${bundle}" key="automaticActionSection.deleteQuestion" var="DeleteQuestion" />
<fmt:message bundle="${bundle}" key="applyWhen.label" var="ApplyWhenLabel" />
<fmt:message bundle="${bundle}" key="environment.label" var="EnvironmentLabel" />

<%--@elvariable id="actionBean" type="com.hp.systinet.lifecycle.ui.admin.automaticactionkinds.renderer.ExportToRegistryRowRenderer.Bean"--%>

<table class="UI Table Properties">        
    <col class="FormSelectCol">
    <col class="LongLabelCol">
    <col>            
    <col class="ControlCol">
    <col class="SpacerCol">
        <tr>
            <td>
                <a id="aaction_${prefix}_switch"
                    class="UI Icon Expand" href="javascript:void(0)"><span><fmt:message key="expandLink.label" bundle="${bundle}" /></span>
                </a>
            </td>
            <td><a class="IconAlign" href="javascript:void(0)"><span>${actionBean.metadata.name}</span></a></td>
            <td></td>
            <td>
	            <div class="Text RightAlign">
                    <a id="${prefix}_aaction_exp_to_registries_edit" class="UI Icon Edit" href="javascript:void(0)">
                        <span>${Edit}</span>
                    </a> &nbsp;
	                <a id="${prefix}_aaction_exp_to_registries_remove" class="UI Icon Delete" href="javascript:void(0)">
	                    <span>${Remove}</span>
	               </a>
	               <div id="RemoveAas${prefix}_content" class="x-hidden">
	                    <div class="x-window-header">${DeletePopupTitle}</div>
	                    <div class="x-window-body">
	                        <p class="Warning">${DeleteQuestion}</p>
	                    </div>
	                </div>
	            </div>
            </td>
            <td></td>
        </tr>
</table>
<div id="aaction_${prefix}_content" class="Comment x-hidden">
    <table class="UI Table Properties">
        <col class="FormSelectCol"/>
        <col/>
        <tr>
            <td></td>
            <td>                       
                <p class="Comment Plain">
                <strong>${ApplyWhenLabel}:</strong> <syswf:out value="${actionBean.eventDescriptor}" context="HtmlBody"/>
                <br>
                <strong>${EnvironmentLabel}:</strong> <syswf:out value="${actionBean.environment.name}" context="HtmlBody"/>
                <br>
                <syswf:out value="${actionBean.metadata.description}" context="HtmlBody"/>
                </p>
            </td>
        </tr>
    </table>
</div>

<syswf:component name="/core/window" prefix="aasEditPopupPRA${prefix}">
    <syswf:param name="winId" value="aasEditPopupPRA${prefix}Popup_win" />
    <syswf:param name="winTitle"><fmt:message key="automaticActionSection.label" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winComponent" value="${actionBean.metadata.editRendered}"/>
    <syswf:param name="winOpenFunctionName" value="editPopupETRA${prefix}_open" />
    <syswf:param name="winOkAction" value="customAutomaticActionFn" />
    <syswf:param name="metadata" value="${actionBean.metadata}"/>
    <syswf:param name="configData" value="${actionBean.configData}"/>
    <syswf:param name="aasBean" value="${automaticActionsBean}"/>
    <syswf:param name="winRenderAlways" value="true" />
</syswf:component>
    
<script type="text/javascript">
//<![CDATA[

	Ext.get('${prefix}_aaction_exp_to_registries_edit').on('click',function(){
	    editPopupETRA${prefix}_open();
	});

    Ext.get('aaction_${prefix}_switch').on('click',function(){
        AdvancedOptions.Comment.Switch('aaction_${prefix}_switch','aaction_${prefix}_content');
    });

    Ext.onReady(function() {
        SPopup.Window.init('${prefix}_aaction_exp_to_registries_remove','RemoveAas${prefix}_content', {
            autoHeight: true,
            width: 350,
            shadow: false,
            centerOnScreen:true,
            buttonAlign: 'center',
            width:400,
            buttons:[
                {
                    text: '${OK}',
                    id: 'RemoveAas${prefix}Confirm',
                    handler: function(){ deleteAutomaticAction('${actionBean.configData.id}'); }
                },
                {
                    text: '${Cancel}',
                    handler: function(){ SPopup.Window.Instance.${prefix}_aaction_exp_to_registries_remove.hide(); }
                }
            ]
        });
    });
    //]]>
</script>
