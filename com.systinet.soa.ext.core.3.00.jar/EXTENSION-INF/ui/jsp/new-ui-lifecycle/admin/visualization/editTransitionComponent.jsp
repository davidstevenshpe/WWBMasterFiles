<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="editTransition.shareArtifactsLabel" var="shareArtifactsLabel" bundle="${messages}"/>

<%--@elvariable id="wrappingDivId" type="String"--%>
<%--@elvariable id="mode" type="java.lang.String"--%>
<%--@elvariable id="fromStages" type="java.lang.String"--%>
<%--@elvariable id="toStage" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="okButtonId" type="java.lang.String"--%>
<%--@elvariable id="okAction" type="java.lang.String"--%>
<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.admin.visualization.EditTransitionBean"--%>
<%--@elvariable id="eventsMap" type="Map<String, String>"--%>

<div id="${wrappingDivId}">
    <c:if test="${not empty mode}">
        <c:set var="comboVar" value="${prefix}_comboVar"/> <%-- javascript variable for the combo --%>
        <c:set var="comboShareVar" value="${prefix}_comboShareVar"/> <%-- javascript variable for the share combo --%>
        <c:set var="multiTransitions" value="${false}"/>
        <c:set var="checkAllDeleteRadiosFn" value="${prefix}_checkAllDeleteRadiosFn"/> <%-- function name --%>
        <c:set var="fromStagesArray" value="${prefix}_fromStagesArray"/> <%-- function name --%>
        <c:set var="stageNameHintEnabled" value="${mode eq 'ADD_STAGE' or mode eq 'ADD_INITIAL_STAGE'}"/>
        <script type="text/javascript">
//<![CDATA[

            var ${comboVar} = null;
            var ${comboShareVar} = null;
            var ${fromStagesArray} = [];
        
//]]>
</script>
        <c:if test="${mode ne 'EDIT_TRANSITION'}">
            <c:set var="comboId" value="${prefix}_comboId"/> <%-- id of the combo select element --%>
            <c:set var="comboShareId" value="${prefix}_comboShareId"/> <%-- id of the share combo select element --%>
            <c:set var="shareCheckboxId" value="${prefix}_shareCheckbox"/> <%-- id of the share stage checkbox --%>
            <table class="UI Table Properties">
                <col class="LabelCol" />
                <col/>
                <tr>
                    <td>
                        <label for="${comboId}" class="UI Label Inline"
                                ><fmt:message key="editTransition.stageLabel" bundle="${messages}"/>:</label>

                    </td>
                    <td>
                        <select id="${comboId}" name="${comboId}">
                            <c:forEach items="${bean.toStageOptions}" var="option">
                                <option value="<c:out value="${option.val}"/>"
                                        <c:if test="${!stageNameHintEnabled}">
                                            <c:if test="${option.val eq bean.toStage.val}">selected="selected"</c:if>
                                        </c:if>
                                        ><syswf:out context="HtmlBody" value="${option.name}"/></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <table class="UI Table Properties">
                            <col class="SmallLabelCol"/>
                            <col/>
                            <tr>
                                <td>
                                    <input type="checkbox" name="shareCheckbox" value="${bean.share}" id="${shareCheckboxId}"
                                           class="UI Form Checkbox Inline" <c:if test="${bean.share}">checked="checked"</c:if>/>
                                    <label class="UI Form Label Inline" for="${shareCheckboxId}">
                                        <c:out value="${shareArtifactsLabel}"/>
                                </td>
                                <td>
                                    <select id="${comboShareId}" name="${comboShareId}">
                                        <c:forEach items="${bean.events}" var="event">
                                            <option value="<c:out value="${event}"/>"
                                                    <c:if test="${event eq bean.selectedEvent}">selected="selected"</c:if>
                                                    ><c:out value="${eventsMap[event]}"/></option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
//<![CDATA[

                ${comboVar} = new Ext.form.ComboBox({
                    id : '${comboId}',
                    allowBlank: false,
                    minLength: 1,
                    maxLength:200,
                    invalidClass: '',
                    blankText: '',
                    invalidText: '',
                    transform : '${comboId}',
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    listWidth : 310,
                    width : 310,
                    triggerAction : 'all',
                    emptyText : '<fmt:message key="editTransition.selectStageHint" bundle="${messages}"/>',
                    tpl: '<tpl for="."><div class="x-combo-list-item">{text:htmlEncode}</div></tpl>'
                });

                ${comboShareVar} = new Ext.form.ComboBox({
                    id : '${comboShareId}',
                    allowBlank: false,
                    minLength: 1,
                    transform : '${comboShareId}',
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    listWidth : 186,
                    width : 186,
                    triggerAction : 'all'
                });

                Ext.onReady(function(){
                    var myCheckbox = Ext.get('${shareCheckboxId}');
                    if(${bean.share}){
                        Ext.getCmp('${comboShareId}').enable();
                    } else {
                        Ext.getCmp('${comboShareId}').disable();
                    }
                    myCheckbox.on('click',function(){
                        if(myCheckbox.dom.checked){
                            Ext.getCmp('${comboShareId}').enable();
                        } else {
                            Ext.getCmp('${comboShareId}').disable();
                        }
                    });
                });
            
//]]>
</script>
        </c:if>

        <c:if test="${mode ne 'ADD_INITIAL_STAGE' and mode ne 'EDIT_INITIAL_STAGE'}">
            <c:set var="countTransitions" value="${fn:length(bean.fromStages)}"/>
            <c:set var="multiTransitions" value="${countTransitions gt 1}"/>

            <c:forEach items="${bean.fromStages}" var="fromStage" varStatus="status">
                <syswf:component prefix="radioSelector_${status.index}"
                                 name="/newUi/lc/admin/visualization/transitionSelector" wrap="false">
                    <syswf:param name="fromStageName" value="${fromStage.name}"/>
                    <syswf:param name="toStageName" value="${bean.toStage.name}"/>
                    <syswf:param name="mode" value="${mode}"/>
                    <syswf:param name="selectedTransition" value="${bean.transitionTypes[status.index].value}"/>
                    <syswf:param name="availableTransitionTypes" value="${bean.availableTransitionTypes[status.index]}"/>
                    <syswf:param name="autoWarnings" value="${bean.autoWarnings[status.index]}"/>
                    <syswf:param name="approvedWarnings" value="${bean.approvedWarnings[status.index]}"/>
                    <syswf:param name="transitionTypeValue" value="${bean.transitionTypes[0].value}"/>
                    <syswf:param name="multiTransitions" value="${multiTransitions}"/>
                    <syswf:param name="checkAllDeleteRadiosFn" value="${checkAllDeleteRadiosFn}"/>
                    <syswf:param name="maxTransitionsToDelete" value="${countTransitions - 1}"/>
                </syswf:component>
                <script type="text/javascript">
//<![CDATA[

                    ${fromStagesArray}.push('<syswf:out context="HtmlJSText" value="${fromStage.val}"/>');
                
//]]>
</script>
            </c:forEach>
        </c:if>

        <script type="text/javascript">
//<![CDATA[


            Ext.onReady(function() {
                if (${comboVar} != null) {
                    ${comboVar}.on('invalid', function() {
                        Ext.getCmp('${okButtonId}').disable();
                    });
                    ${comboVar}.on('valid', function() {
                        Ext.getCmp('${okButtonId}').enable();
                    });

                    <c:if test="${stageNameHintEnabled}">
                        <%-- Show hint in the combo box after dialog is shown and disable ok button --%>
                        ${comboVar}.clearValue();
                    </c:if>
                    ${comboVar}.validate();
                } else {
                    <c:if test="${!stageNameHintEnabled}">
                        Ext.getCmp('${okButtonId}').enable();
                    </c:if>
                }
            });

            <%-- todo: replace with Ext.HP.ComboBox.getSelectedKey() function when available --%>
            <%-- attention: getValue() method is not usable here --%>
            function getComboValue(combo) {
                var record = combo.findRecord(combo.displayField, combo.getRawValue());
                return record ? record.id : null;
            }

            if (${multiTransitions}) {
                function ${checkAllDeleteRadiosFn}() {
                    var radioInputs = Ext.get('${wrappingDivId}').query("INPUT.Radio");
                    var fromStagesLength = ${fn:length(bean.fromStages)};
                    var count = 1;
                    var transition;
                    for (i = 0; i < (fromStagesLength); i++) {
                        transition = Ext.getCmp(radioInputs[i * 4].id).getGroupValue();
                        if (transition == 'DELETE_TRANSITION') {
                            count++;
                        }
                    }
                    var radio;
                    if (count >= fromStagesLength) {
                        for (i = 0; i < (fromStagesLength); i++) {
                            radio = Ext.getCmp(radioInputs[i * 4 + 3].id);
                            transition = radio.getGroupValue();
                            if (transition != 'DELETE_TRANSITION') {
                                radio.disable();
                            }
                        }
                    } else {
                        for (i = 0; i < (fromStagesLength); i++) {
                            radio = Ext.getCmp(radioInputs[i * 4 + 3].id);
                            if (radio.disabled) {
                                radio.enable();
                            }
                        }
                    }
                }
            }

            function ${okAction}() {
                var fromStagesLength = ${fn:length(bean.fromStages)};
                if (fromStagesLength == 0) {
                    fromStages = null;
                } else {
                    fromStages = ${fromStagesArray};
                }
                var toStage;
                var toStageName;
                var previousToStage;
                var share;
                if ('${mode}' == 'ADD_INITIAL_STAGE' || '${mode}' == 'ADD_STAGE') {
                    previousToStage = null;
                } else {
                    previousToStage = '<syswf:out context="HtmlJSText" value="${bean.toStage.val}"/>';
                }
                if (${comboVar} != null) {
                    toStage = getComboValue(${comboVar});
                    toStageName = ${comboVar}.getRawValue();
                    toStageName = toStageName.replace(/,\|;/g,",|:");
                    toStageName = toStageName.replace(/'/g,'`');
                } else {
                    toStage = '<syswf:out context="HtmlJSText" value="${bean.toStage.val}"/>';
                    toStageName = '<syswf:out context="HtmlJSText" value="${bean.toStage.name}"/>';
                }
                var transitionTypes = [];
                var radioInputs = Ext.get('${wrappingDivId}').query("INPUT.Radio");
                var multiplier = fromStagesLength>1 ? 4 : 3;
                if ('${mode}' == 'ADD_INITIAL_STAGE' || '${mode}' == 'EDIT_INITIAL_STAGE') {
                    transitionTypes = null;
                } else {
                    for (i=0; i<(fromStagesLength); i++) {
                        var transition = Ext.getCmp(radioInputs[i*multiplier].id).getGroupValue();
                        if (transition == 'DELETE_TRANSITION') {
                            transition = null;
                        }
                        transitionTypes.push(transition);
                    }
                }
                if ('${mode}' == 'EDIT_TRANSITION') {
                    share = '';
                } else {
                    if (Ext.get('${shareCheckboxId}').dom.checked) {
                        share = getComboValue(${comboShareVar});
                    } else {
                        share = '';
                    }
                }
                applyTransitionChange('${mode}', fromStages, toStage, toStageName, previousToStage, transitionTypes, share);
            }
        
//]]>
</script>
    </c:if>
</div>
