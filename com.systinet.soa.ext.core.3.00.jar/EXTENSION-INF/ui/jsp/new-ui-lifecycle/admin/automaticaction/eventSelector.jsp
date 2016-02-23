<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="eventSelector.days" var="days" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<%--@elvariable id="esBean" type="com.hp.systinet.lifecycle.ui.admin.automaticaction.EventSelector.ESBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<tr>
    <th>
        <label class="UI Label Required Full"><c:out value="${esBean.label}"/></label>
        <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
    </th>

    <td>
        <c:choose>
            <%--VIEW--%>
            <c:when test="${esBean.readOnlyView}">
                <c:out value="${esBean.selectedDescription}" />
            </c:when>

            <%--EDIT--%>
            <c:otherwise>
                <table class="UI Table Properties">
                    <col class="LongLabelCol"/>
                    <col/>
                    <tr>
                        <td>
                            <syswf:selectOne id="${prefix}_eventTypes" name="eventTypes" mode="menu"
                                             optionValues="${esBean.events}" dataType="enum"
                                             optionCaptions="${esBean.eventDescriptions}"
                                             value="${esBean}" property="selected"/>
                            <script type="text/javascript">
                                //<![CDATA[
                                Ext.onReady(function() {
                                    var cmb_${prefix}_eventTypes = new Ext.HP.ComboBox({
                                        id: '${prefix}_eventTypes',
                                        transform: '${prefix}_eventTypes',
                                        disableKeyFilter : true,
                                        mode : 'local',
                                        autoHeight : true,
                                        resizable : true,
                                        listWidth : 240,
                                        width : 240,
                                        triggerAction : 'all'
                                    });

                                    cmb_${prefix}_eventTypes.on('select',
                                        function(combo, record) {
                                            AdvancedOptions.Form.Switch('${prefix}_eventTypes_extras', '${prefix}_eventTypes_extras_' + record.data.value);
                                        }
                                    );
                                });
                                //]]>
                            </script>
                        </td>
                        <td>
                            <div id="${prefix}_eventTypes_extras" class="UI OptionAreas">
                                <c:set var="class_STAGE_IDLE" value="x-hidden UI OptionArea Plain"/>
                                <c:if test="${esBean.eventsMap['STAGE_IDLE'] eq esBean.selected}">
                                    <c:set var="class_STAGE_IDLE" value="UI OptionArea Plain"/>
                                </c:if>
                                <div id="${prefix}_eventTypes_extras_com.hp.systinet.platform.lifecycle.automaticaction.AutomaticActionEvent$$STAGE_IDLE"
                                     class="${class_STAGE_IDLE}">
                                    <div class="UI Border">
                                        <syswf:input id="${prefix}_eventTypes_extras_STAGE_IDLE"
                                                     name="${prefix}_eventTypes_extras_STAGE_IDLE"
                                                     value="${esBean}" property="delayInDays"/> ${days}
                                        <script type="text/javascript">
                                            //<![CDATA[

                                            Ext.onReady(function() {
                                                new Ext.HP.Input({
                                                    applyTo : '${prefix}_eventTypes_extras_STAGE_IDLE',
                                                    width: 120
                                                });
                                            });
                                            //]]>
                                        </script>
                                    </div>
                                </div>
                                <c:set var="class_VOTING_IDLE" value="x-hidden UI OptionArea Plain"/>
                                <c:if test="${esBean.eventsMap['VOTING_IDLE'] eq esBean.selected}">
                                    <c:set var="class_VOTING_IDLE" value="UI OptionArea Plain"/>
                                </c:if>
                                <div id="${prefix}_eventTypes_extras_com.hp.systinet.platform.lifecycle.automaticaction.AutomaticActionEvent$$VOTING_IDLE"
                                     class="${class_VOTING_IDLE}">
                                    <div class="UI Border">
                                        <syswf:input id="${prefix}_eventTypes_extras_VOTING_IDLE"
                                                     name="${prefix}_eventTypes_extras_VOTING_IDLE"
                                                     value="${esBean}" property="delayInDays"/> ${days}
                                        <script type="text/javascript">
                                            //<![CDATA[

                                            Ext.onReady(function() {
                                                new Ext.HP.Input({
                                                    applyTo : '${prefix}_eventTypes_extras_VOTING_IDLE',
                                                    width: 120
                                                });
                                            });
                                            //]]>
                                        </script>
                                    </div>
                                </div>
                                <div id="${prefix}_eventTypes_extras_void" class="x-hidden UI OptionArea">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </c:otherwise>
        </c:choose>
    </td>
</tr>
