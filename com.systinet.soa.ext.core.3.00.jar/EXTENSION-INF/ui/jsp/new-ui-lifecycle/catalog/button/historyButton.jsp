<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<div class="EA-right-panel">
	<a href="javascript:void(0);" class="UI PageAction History" id="artifact_history"><span><fmt:message
        key="history_buttonLabel" bundle="${messages}"/></span></a>
</div>
<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.catalog.button.HistoryButton.HistoryBean"--%>
<%--@elvariable id="previousItemSatge" type="com.hp.systinet.repository.sdm.propertytypes.Category"--%>

<div id="artifact_history_source" class="x-hidden">
    <div class="x-window-header"><fmt:message key="history_dialogTitle" bundle="${messages}"/></div>
    <div class="x-window-body">
        <div class="Offset">
            <c:forEach items="${bean.items}" var="item" varStatus="status">
                <c:if test="${!(item.stage eq previousItemSatge)}"><%--STAGE HEADING--%>
                    <div class="GroupHeader">
                        <table class="UI Table Properties">
                            <col/>
                            <tr>
                                <td><strong class="IconAlign"><syswf:out value="${item.stage.name}" context="HtmlBody"/></strong></td>
                            </tr>
                        </table>
                    </div>
                </c:if>
                <div class="GroupChildren"><%--STAGE HISTORY ITEM--%>
                    <table class="UI Table Properties">
                        <col/>
                        <col class="MiniDateCol"/>
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${empty item.approvalHistoryRecordId}">
                                        <span class="UI Icon ${item.statusIconClass}"><syswf:out value="${item.summary}" context="HtmlBody"/></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:focusHistoryRecord('${item.approvalHistoryRecordId}');"
                                           class="UI Icon ${item.statusIconClass}"><span><syswf:out value="${item.summary}" context="HtmlBody"/></span></a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="AlignRight">
                                    <syswf:component prefix="progressEventDate_${status.index}"
                                                     name="/core/impl/util/enhancedDateRenderer" wrap="false">
                                        <syswf:param name="dateValue" value="${item.date}"/>
                                        <syswf:param name="styleClass" value="IconAlign"/>
                                    </syswf:component>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <c:set var="previousItemSatge" value="${item.stage}"/>
            </c:forEach>
        </div>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

    function focusHistoryRecord(historyRecordId) {
        SPopup.Window.Instance['artifact_history'].hide();
        geProcessVisualizationFlexApp().focusHistoryRecord(historyRecordId);
    }

    Ext.onReady(function() {
        SPopup.Window.init('artifact_history', 'artifact_history_source',
        {
            plain:false,
            height:300,
            width:350,
            autoScroll:true,
            autoHeight:${fn:length(bean.items) <= 5 ? "true" : "false"},
            centerOnScreen:true,
            buttonAlign:'center',
            buttons:[
                {
                    text:'Close',
                    handler: function() {
                        SPopup.Window.Instance['artifact_history'].hide();
                    }
                }
            ]});
       	moveWindow('artifact_history_source','popupWindows');
    });

//]]>
</script>
