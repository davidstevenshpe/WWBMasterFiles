<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="startGov_process" var="processLabel" bundle="${messages}"/>
<fmt:message key="manGov_stageLabel" var="stageLabel" bundle="${messages}"/>
<fmt:message key="manGov_approved" var="approvedLabel" bundle="${messages}"/>

<syswf:control mode="script" caption="setProcessPost" action="setProcessAction"/>
<syswf:control mode="script" caption="cancelProcessPost" action="cancelProcessAction"/>
<syswf:control mode="script" caption="setProcessRefreshPopup" action="change" affects="." />

<%--@elvariable id="setProcessBean" type="com.hp.systinet.lifecycle.ui.common.dialog.SetProcess.Bean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:if test="${setProcessBean.enabled}">
    <c:set var="onChangeAction">Ext.getCmp('setProcess_okButton').enable(); setProcessRefreshPopup();</c:set>
    <div class="Content" id="setProcessContent">
         <table class="UI Table Properties">
             <colgroup>
                <col class="LabelCol" />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td>
						<label class="UI Label Inline">${processLabel}</label>
					</td>
                    <td>
                        <span class="IconAlign">
	                        <syswf:component name="/newUi/lc/common/widget/chooseGPCombo" prefix="setProcess.processes">                            
	                            <syswf:param name="selectedProcessId" value="${setProcessBean}" property="selectedProcessId" />
	                            <syswf:param name="onChangeAction" value="${onChangeAction}" />
	                        </syswf:component>
                    	</span>
					</td>
                </tr>
                <c:if test="${setProcessBean.admin and not empty setProcessBean.selectedProcessId and not empty processes}">
                    <tr>
                        <th class="UI Label Inline"><c:out value="${stageLabel}"/></th>
                        <td>
                            <syswf:input name="newStateId" value="${setProcessBean}" property="selectedStateId" mode="hidden" dataType="long"/>
                            <syswf:input name="selectedState" value=""/>

                            <c:set var="selectedSateIndex" value="-1" />
                            <c:set var="selectedSateValue" value="not changed" />
                            <syswf:jsonValue type="array" var="processStates">
                                <c:forEach var="stage" items="${setProcessBean.states}" varStatus="j">
                                    <c:if test="${stage.id eq setProcessBean.selectedStateId}">
                                        <c:set var="selectedSateIndex" value="${j.index}" />
                                        <c:set var="selectedSateValue" value="${stage.state.name}" />
                                    </c:if>
                                    <syswf:jsonValue type="array">
                                        <syswf:jsonValue value="${stage.id}" />
                                        <syswf:jsonValue><syswf:out value="${stage.state.name}" context="HtmlBody"/></syswf:jsonValue>
                                    </syswf:jsonValue>
                                </c:forEach>
                            </syswf:jsonValue>

                            <script type="text/javascript">
                            //<![CDATA[

                                Ext.onReady(function(){
        
                                    var ${prefix}_dss = new Ext.data.SimpleStore({
                                        fields: ['id', 'name'],
                                        data: ${processStates}
                                    });

                                    // Custom rendering Template
                                    var resultTpl = new Ext.XTemplate(
                                        '<tpl for="."><div class="UI Offset InteractiveSearch"><div class="search-item">',
                                            '<span class="SearchField Name"><span class="Value">{name}</span></span>',
                                        '</div></div><hr/></tpl>'
                                    );

                                    var combo = new Ext.form.ComboBox({
                                        store: ${prefix}_dss,
                                        valueField: 'id',
                                        displayField: 'name',
                                        editable: false,
                                        typeAhead: true,
                                        mode: 'local',
                                        width: 250,
                                        triggerAction: 'all',
                                        // selectOnFocus: true,
                                        itemSelector: 'div.search-item',
                                        tpl: resultTpl,
                                        applyTo: '${prefix}_selectedState'
                                        <c:if test="${not empty selectedSateValue}">
                                        , value: <syswf:jsonValue value="${selectedSateValue}" /></c:if>
                                    });

                                    combo.on('beforeSelect', function(combo, record, index) {
                                        Ext.get('${prefix}_newStateId').dom.value = record.data.id;
                                    });
                                });
                            
                            //]]>
                            </script>
                        </td>
                    </tr>
                    <tr>
                        <th class="UI Label Inline">${approvedLabel}</th>
                        <td>
                            <syswf:input name="selectedApprovedValue" value="${setProcessBean}" property="approved" mode="hidden" dataType="boolean"/>
                            <syswf:input name="selectedApproved" value=""/>

                            <script type="text/javascript">
                            //<![CDATA[

                                Ext.onReady(function(){

                                    var ${prefix}_dsa = new Ext.data.SimpleStore({
                                        fields: ['value', 'label'],
                                        data: [[true, 'Yes'],[false, 'No'] ]
                                    });

                                    // Custom rendering Template
                                    var resultTpl = new Ext.XTemplate(
                                        '<tpl for="."><div class="UI Offset InteractiveSearch"><div class="search-item">',
                                            '<span class="SearchField Name"><span class="Value">{label}</span></span>',
                                        '</div></div><hr/></tpl>'
                                    );

                                    var combo = new Ext.form.ComboBox({
                                        store: ${prefix}_dsa,
                                        valueField: 'value',
                                        displayField: 'label',
                                        editable: false,
                                        typeAhead: true,
                                        mode: 'local',
                                        width: 250,
                                        triggerAction: 'all',
                                        emptyText: 'not changed',
                                        // selectOnFocus: true,
                                        itemSelector: 'div.search-item',
                                        tpl: resultTpl,
                                        applyTo: '${prefix}_selectedApproved'
                                        <c:if test="${not empty setProcessBean.approved}">
                                        , value: ${setProcessBean.approved}
                                        </c:if>
                                    });

                                    combo.on('beforeSelect', function(combo, record, index) {
                                        Ext.get('${prefix}_selectedApprovedValue').dom.value = record.data.value;
                                    });
                                });
                            
                            //]]>
                            </script>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>    
</c:if>
