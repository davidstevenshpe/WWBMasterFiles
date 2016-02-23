<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="bean" type="com.hp.systinet.sc.ui.task.ScheduleTaskWindowBean"--%>
<%--@elvariable id="parentWinId" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.task.taskmessages" var="messages"/>

<syswf:control mode="script" affects="." action="updateSchedule" caption="fnUpdateSchedule" id="${prefix}fnUpdateSchedule"/>

<c:if test="${bean.closeWindow}">
    <script type="text/javascript">
//<![CDATA[

        ${closeWindowFce}();
    
//]]>
</script>
</c:if>

<div class="Offset" id="import_start_selection">
    <table class="UI Table Properties">
        <col class="MidLabelCol"/>
        <col class="FormSelectCol"/>

        <col class="FormSelectCol"/>
        <col class="FormSelectCol"/>
        <col/>
        <tr>
            <%-- Start: --%>
            <td><label class="UI Form Label Inline"><fmt:message key="scheduleTask.start" bundle="${messages}"/>:</label></td>
            <td>
                <%-- Start: Immediately --%>
               
                <syswf:selectOne id="${prefix}startMode_1" merge="true" name="startMode" mode="radio" value="${bean.contentBean}" property="startMode" dataType="int" optionValues="1" optionCaptions="">
                    <syswf:attribute name="class" value="UI Form Radio"/>
                </syswf:selectOne>
            </td>
            <td colspan="3">
                <label style="float:left;" class="UI Form Label Inline" for="${prefix}endMode_2"> <fmt:message key="scheduleTask.immediately" bundle="${messages}"/></label>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <%-- Start: On --%>
                
                <syswf:selectOne id="${prefix}startMode_2" merge="true" name="startMode" mode="radio" value="${bean.contentBean}" property="startMode" dataType="int" optionValues="2" optionCaptions="">
                    <syswf:attribute name="class" value="UI Form Radio"/>
                </syswf:selectOne>
            </td>
            <td>
                <label style="float:left;" class="UI Form Label Inline" for="${prefix}endMode_2"><fmt:message key="scheduleTask.on" bundle="${messages}"/>:</label>
            </td>
            <td colspan="2">
                
                <syswf:component prefix="startedOn" name="/core/impl/widget/dateWidget">
                    <syswf:param name="model" value="${bean.contentBean.startOnWidgetModel}"/>
                    <syswf:param name="mode" value="edit"/>
                    <syswf:param name="hideTime" value="${false}"/>
                    <syswf:param name="notEditableTime" value="${true}"/>
                    <syswf:param name="timeType" value="shortTime"/>
                </syswf:component>
                <c:if test="${bean.contentBean.startOnWidgetModel.errorMessage ne null}">
                    <em class="x-form-invalid-msg UI Invalid" style="width:100%">
                        <span>${bean.contentBean.startOnWidgetModel.errorMessage}</span>
                    </em>
                </c:if>                
            </td>
        </tr>
        <tr>
            <%-- Recurrence: --%>
            <td><label class="UI Form Label Inline"><fmt:message key="scheduleTask.recurrence" bundle="${messages}"/>:</label></td>
            <td colspan="4">
                <fmt:message var="optionCaptions" key="scheduleTask.recurrenceType.captions" bundle="${messages}"/>
                <syswf:selectOne name="recurrenceType" mode="menu" value="${bean.contentBean}" property="recurrenceType"
                                 optionValues="NONE,HOURLY,DAILY,WEEKLY,MONTHLY,YEARLY,INTERVAL"
                                 optionCaptions="${optionCaptions}"/>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function(){

                        var fnUpdateCombo = function(value) {
                            if (value == 'NONE' || value == '') {
                                AdvancedOptions.Form.HideChildrenOf('recurrenceTypeOptions');
                                Ext.get('${prefix}_customRepeatTimeInMinutes').value = "";
                            } else if (value == 'INTERVAL') {
                                AdvancedOptions.Form.Switch('recurrenceTypeOptions', 'recurrenceType_INTERVAL');                                                                
                                Ext.get('${prefix}_customRepeatTimeInMinutes').dom.value = '${bean.contentBean.customRepeatTimeInMinutes}';                                                       
                            } else {
                                AdvancedOptions.Form.Switch('recurrenceTypeOptions', 'recurrenceType_DATE');
                              	Ext.get('${prefix}_customRepeatTimeInMinutes').value = "";                                
                            }

                            SPopup.Window.Instance['${parentWinId}'].syncSize();
                        };

                        var recurrence_type = new Ext.HP.ComboBox({
                            id : '${prefix}_recurrenceType',
                            transform : '${prefix}_recurrenceType',
                            disableKeyFilter : true,
                            mode : 'local',
                            autoHeight : true,
                            resizable : true,
                            listWidth : 120,
                            width : 120,
                            triggerAction : 'all',
                            editable: false,
                            forceSelection: true                            
                        });
                        recurrence_type.on(	'select', function(combo,record) { fnUpdateCombo(record.data.value) });
                        fnUpdateCombo('${bean.contentBean.recurrenceType}');
                    });

                    // TODO section is not highlighted correctly
                
//]]>
</script>
            </td>
        </tr>
        <tr>
            <td colspan="5">

                <!-- BEGIN: Recurrence Hidden Areas. Only one of these is visible at any given time,
                            depending on the option selected in the combo above. -->
                <div id="recurrenceTypeOptions" class="UI OptionAreas">
                    <div id="recurrenceType_DATE" class="x-hidden UI OptionArea">
                        <div class="UI Border">
                            <table class="UI Table Properties">
                                <col width="158px"/>
                                <col class="FormSelectCol"/>
                                <col class="FormSelectCol"/>
                                <col class="FormSelectCol"/>
                                <col />
                                <tr>
                                    <%-- End: Indefinitely --%>
                                    <td><label class="UI Form Label Inline"><fmt:message key="scheduleTask.end" bundle="${messages}"/>:</label></td>
                                    <td >
                                        <syswf:selectOne id="${prefix}endMode_1" merge="true" name="endMode" mode="radio" value="${bean.contentBean}" property="endMode" dataType="int" optionValues="1" optionCaptions="">
                                            <syswf:attribute name="class" value="UI Form Radio"/>
                                        </syswf:selectOne>
                                    </td>
                                    <td colspan="3">
                                         <label style="float:left;" class="UI Form Label Inline"><fmt:message key="scheduleTask.indefinitely" bundle="${messages}"/></label>
                                    </td>
                                </tr>
                                <tr>
                                    <%-- End: On date --%>
                                    <td></td>
                                    <td>
                                        <syswf:selectOne id="${prefix}endMode_2" merge="true" name="endMode" mode="radio" value="${bean.contentBean}" property="endMode" dataType="int" optionValues="2" optionCaptions="">
                                            <syswf:attribute name="class" value="UI Form Radio"/>
                                        </syswf:selectOne>
                                    </td>
                                    <td>
                                        <label style="float:left;" class="UI Form Label Inline" for="${prefix}endMode_2"><fmt:message key="scheduleTask.on" bundle="${messages}"/>:</label>
                                    </td>
                                    <td colspan="3">
                                        <syswf:component prefix="repeatUntil" name="/core/impl/widget/dateWidget">
                                            <syswf:param name="model" value="${bean.contentBean.repeatUntilWidgetModel}"/>
                                            <syswf:param name="mode" value="edit"/>
                                            <syswf:param name="hideTime" value="${false}"/>
                                            <syswf:param name="notEditableTime" value="${true}"/>
                                        </syswf:component>
                                        <c:if test="${bean.contentBean.repeatUntilWidgetModel.errorMessage ne null}">
                                            <em class="x-form-invalid-msg UI Invalid">
                                                <span>${bean.contentBean.repeatUntilWidgetModel.errorMessage}</span>
                                            </em>
                                        </c:if>                                         
                                    </td>
                                </tr>
                                <tr>
                                    <%-- End: Repeat max --%>
                                    <td></td>
                                    <td colspan="5">
                                        <syswf:selectOne id="${prefix}endMode_3" merge="true" name="endMode" mode="radio" value="${bean.contentBean}" property="endMode" dataType="int" optionValues="3" optionCaptions="">
                                            <syswf:attribute name="class" value="UI Form Radio"/>
                                        </syswf:selectOne>
                                        <syswf:input name="repeatMax" value="${bean.contentBean}" property="repeatMax" dataType="int">
                                            <syswf:attribute name="class" value="UI Form Text Int"/>
                                        </syswf:input>
                                        <label class="UI Form Label Inline" for="${prefix}endMode_3"><fmt:message key="scheduleTask.times" bundle="${messages}"/></label>
                                        <c:if test="${bean.contentBean.repeatMaxErrorMessage ne null}">
                                            <em class="x-form-invalid-msg UI Invalid">
                                                <span>${bean.contentBean.repeatMaxErrorMessage}</span>
                                            </em>
                                        </c:if>                                        
                                        <script type="text/javascript">
//<![CDATA[

                                            var repeat_max = new Ext.form.NumberField({
                                                id : '${prefix}_repeatMax',
                                                applyTo : '${prefix}_repeatMax',
                                                disableKeyFilter : true,
                                                triggerAction : 'all',
                                                allowNegative : false,
                                                minValue : 1
                                            });
                                        
//]]>
</script>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="recurrenceType_INTERVAL" class="x-hidden UI OptionArea">
                        <div class="UI Border">
                            <table class="UI Table Properties">
                                <col width="157px"/>
                                <col class="FormSelectCol"/>
                                <col class="FormSelectCol"/>
                                <col class="FormSelectCol"/>
                                <col />
                                <tr>
                                    <%-- Custom Interval --%>
                                    <td><label class="UI Form Label Inline"><fmt:message key="scheduleTask.interval" bundle="${messages}"/>:</label></td>
                                    <td colspan="4">
                                        <syswf:input name="customRepeatTimeInMinutes" value="${bean.contentBean}" property="customRepeatTimeInMinutes" dataType="long">
                                            <syswf:attribute name="class" value="UI Form Text LongInt"/>
                                        </syswf:input>
                                        <c:if test="${bean.contentBean.customRepeatTimeInMinutesErrorMessage ne null}">
                                            <em class="x-form-invalid-msg UI Invalid">
                                                <span>${bean.contentBean.customRepeatTimeInMinutesErrorMessage}</span>
                                            </em>
                                        </c:if>                                           
                                        <script type="text/javascript">
//<![CDATA[

                                            var customRepeatTimeInMinutes = new Ext.form.NumberField({
                                                id : '${prefix}_customRepeatTimeInMinutes',
                                                applyTo : '${prefix}_customRepeatTimeInMinutes',
                                                disableKeyFilter : true,
                                                triggerAction : 'all',
                                                allowNegative : false,
                                                minValue : 1                                                    
                                            });
                                        
//]]>
</script>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="x-clear"></div>
                </div>
                <!-- END: Recurrence Hidden Areas. -->
            </td>
        </tr>
    </table>

    <syswf:wrap template="/templates/advancedOptions.jsp">
        <table class="UI Table Properties">
            <col width="164px"/>
            <col class="FormSelectCol"/>
            <col class="FormSelectCol"/>
            <col class="FormSelectCol"/>
            <col/>
            <tr>
                <td><label class="UI Form Label Inline"><fmt:message key="scheduleTask.afterDowntime" bundle="${messages}"/>:</label></td>
                <td>
                    <syswf:selectOne merge="true" name="runImmediatelyAfterRestart" mode="radio" value="${bean.contentBean}" property="runImmediatelyAfterRestart" dataType="boolean" optionValues="false" optionCaptions="">
                        <syswf:attribute name="class" value="UI Form Radio"/>
                    </syswf:selectOne>
                </td>
                <td colspan="3">
                    <label style="float:left;" class="UI Form Label Inline"><fmt:message key="scheduleTask.followSchedule" bundle="${messages}"/></label>
                </td>
                
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <syswf:selectOne merge="true" name="runImmediatelyAfterRestart" mode="radio" value="${bean.contentBean}" property="runImmediatelyAfterRestart" dataType="boolean" optionValues="true" optionCaptions="">
                        <syswf:attribute name="class" value="UI Form Radio"/>
                    </syswf:selectOne>
                </td>
                <td colspan="3">
                    <label style="float:left;" class="UI Form Label Inline"><fmt:message key="scheduleTask.runOnStart" bundle="${messages}"/></label>
                </td>
            </tr>
        </table>
    </syswf:wrap>

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            var fnUpdateVisibility = function(){
                Ext.getCmp('${prefix}_startedOn_date').disable();
                Ext.getCmp('${prefix}_startedOn_time_time').disable();
                Ext.getCmp('${prefix}_repeatUntil_date').disable();
                Ext.getCmp('${prefix}_repeatUntil_time_time').disable();
                Ext.getCmp('${prefix}_repeatMax').disable();

                if (Ext.get('${prefix}startMode_2_0').dom.checked) {
                    Ext.getCmp('${prefix}_startedOn_date').enable();
                    Ext.getCmp('${prefix}_startedOn_time_time').enable();
                }

                if (Ext.get('${prefix}endMode_2_0').dom.checked) {
                    Ext.getCmp('${prefix}_repeatUntil_date').enable();
                    Ext.getCmp('${prefix}_repeatUntil_time_time').enable();
                } else if (Ext.get('${prefix}endMode_3_0').dom.checked) {
                    Ext.getCmp('${prefix}_repeatMax').enable();
                }
            };
            Ext.select('INPUT.Radio').on('click', fnUpdateVisibility);
            fnUpdateVisibility();
        });
    
//]]>
</script>
</div>
