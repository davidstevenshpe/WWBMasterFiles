<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="OK" var="OK" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />
<%--@elvariable id="consumptionBean" type="com.hp.systinet.lifecycle.ui.admin.automaticactionkinds.renderer.ConsumptionRowRenderer.Bean"--%>

<table class="UI Table Properties">        
    <col class="FormSelectCol">
    <col class="LongLabelCol">
    <col>            
    <col class="ControlCol">
    <col class="SpacerCol">
        <tr>
            <td><a id="aaction_${prefix}_switch"
                class="UI Icon Expand" href="javascript:void(0)"><span><fmt:message key="expandLink.label" bundle="${bundle}" /></span></a></td>
            <td><a class="IconAlign" href="javascript:void(0)"><span>${consumptionBean.metadata.name}</span></a></td>
            <td></td>
            <td>
            <div class="Text RightAlign">
                <c:if test="${not empty consumptionBean.metadata.editRendered}">
                <a id="aactionEdit_${prefix}" href="javascript:void(0)" class="UI Icon Edit">
                    <span><fmt:message key="automaticActionSection.edit" bundle="${bundle}"/></span>
                </a> &nbsp;
                </c:if>
                <a id="aaction_del_${prefix}" class="UI Icon Delete" href="javascript:void(0)">
                    <span><fmt:message key="automaticActionSection.remove" bundle="${bundle}" /></span>
               </a>
               <div id="RemoveAas${prefix}_content" class="x-hidden">
                    <div class="x-window-header"><fmt:message key="automaticActionSection.deletePopupTitle" bundle="${bundle}" /></div>
                    <div class="x-window-body">
                        <p class="Warning"><fmt:message key="automaticActionSection.deleteQuestion" bundle="${bundle}" /></p>
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
                <p class="Comment Plain"><syswf:out value="${consumptionBean.metadata.description}" context="HtmlBody"/></p>
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
                    handler: function(){ deleteAutomaticAction('${consumptionBean.configData.id}'); }
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
