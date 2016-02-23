<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="taskBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.TaskBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="validateTaskFn" type="java.lang.String"--%>
<%--@elvariable id="currentState" type="com.hp.systinet.repository.sdm.propertytypes.Category"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<c:set var="nameEmptyErrorId" value="${prefix}nameEmptyError"/> <%-- id of empty name error message element --%>
<c:set var="nameLongErrorId" value="${prefix}nameLongError"/> <%-- id of long name error message element --%>
<c:set var="descLongErrorId" value="${prefix}descLongError"/> <%-- id of long description error message element --%>
<c:set var="nameVar" value="${prefix}name"/> <%-- name of javascript variable holding the name input field --%>
<c:set var="descVar" value="${prefix}desc"/> <%-- name of javascript variable holding the description input field --%>
<c:set var="maxNameLength" value="200"/> <%-- max task name length --%>
<c:set var="maxDescLength" value="2000"/> <%-- max task description length --%>
<div class="Content">
    <table class="UI Table Properties" summary="">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
        <%-- Name --%>
        <tr>
            <th>
                <label class="UI Label Required Full" for="taskName"><fmt:message key="taskDialog.name" bundle="${bundle}"/>:</label>
                <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
            </th>
            <td>
                <syswf:input id="taskName" name="name" value="${taskBean}" property="name">
                    <syswf:attribute name="class" value="x-form-text UI Input"/>
                </syswf:input>
                <script type="text/javascript">
//<![CDATA[

                    var ${nameVar} = null;
                    Ext.onReady(function() {
                        ${nameVar} = new Ext.HP.Input({ applyTo: 'taskName' });
                    });
                
//]]>
</script>
                <em id="${nameEmptyErrorId}" class="x-form-invalid-msg UI Invalid" style="display: none" >
                    <span><fmt:message key="taskDialog.nameEmpty" bundle="${bundle}" /></span>
                </em>
                <em id="${nameLongErrorId}" class="x-form-invalid-msg UI Invalid" style="display: none" >
                    <span>
                        <fmt:message key="taskDialog.nameLong" bundle="${bundle}">
                            <fmt:param value="${maxNameLength}"/>
                        </fmt:message>
                    </span>
                </em>
            </td>
        </tr>
        <%-- Description --%>
        <tr>
            <th>
                <label class="UI Label Inline" for="taskDesc"><fmt:message key="taskDialog.description" bundle="${bundle}"/>:</label>
            </th>
            <td>
                <syswf:textArea name="taskDesc" id="taskDesc" value="${taskBean}" property="description">
                    <syswf:attribute name="class" value="UI Form Text Full"/>
                    <syswf:attribute name="rows" value="5"/>
                    <syswf:attribute name="cols" value="40"/>
                </syswf:textArea>
                <script type="text/javascript">
//<![CDATA[

                    var ${descVar} = null;
                    Ext.onReady(function() {
                    ${descVar} = new Ext.form.TextArea({
                            applyTo: 'taskDesc',
                            allowBlank: true
                        });
                    });
                
//]]>
</script>
                <em id="${descLongErrorId}" class="x-form-invalid-msg UI Invalid" style="display: none" >
                    <span>
                        <fmt:message key="taskDialog.descLong" bundle="${bundle}">
                            <fmt:param value="${maxDescLength}"/>
                        </fmt:message>
                    </span>
                </em>
            </td>
        </tr>
        <%-- Assigned To --%>
        <tr>
            <th>
                <label class="UI Label Inline"><fmt:message key="taskDialog.assignedTo" bundle="${bundle}"/>:</label>
            </th>
            <td>
                <syswf:component name="/newUi/lc/admin/visualization/taskDialogAssigneeValue" prefix="assigneeVal">
                    <syswf:param name="taskBean" value="${taskBean}"/>
                </syswf:component>
            </td>
        </tr>
        <%-- Verified by Policy --%>
        <tr>
            <th>
                <label class="UI Label Inline"><fmt:message key="taskDialog.verifiedByPolicy" bundle="${bundle}"/>:</label>
            </th>
            <td>
                <syswf:component name="/newUi/lc/admin/visualization/taskDialogPolicyValue" prefix="policyVal">
                    <syswf:param name="taskBean" value="${taskBean}"/>
                    <syswf:param name="currentState" value="${currentState}"/>
                    <syswf:param name="applicableLabelSection" value="${prefix}_policyApplicableLabel"/>                                                            
                    <syswf:param name="applicableSection" value="${prefix}_policyApplicableTo"/>
                </syswf:component>
            </td>
        </tr>
            <tr>
                <th>
                    <syswf:component name="/newUi/lc/admin/visualization/taskDialogPolicyApplicableLabel" prefix="policyApplicableLabel">
                        <syswf:param name="taskBean" value="${taskBean}"/>
                    </syswf:component>
                </th>
                <td>
                    <syswf:component name="/newUi/lc/admin/visualization/taskDialogPolicyApplicableTo" prefix="policyApplicableTo">
                        <syswf:param name="taskBean" value="${taskBean}"/>
                        <syswf:param name="validateApplicableFunctionName" value="${prefix}validateApplicable"/>                        
                    </syswf:component>
                </td>
            </tr>
        </tbody>
    </table>

</div>

<script type="text/javascript">
//<![CDATA[

    function ${validateTaskFn}() {
        var isNameBlank = ${nameVar}.getValue().search(/^\s*$/) != -1;

        var result = true;        
        
        if (!isNameBlank){
            Ext.get('${nameEmptyErrorId}').dom.style.display="none";
        }else{
        	Ext.get('${nameEmptyErrorId}').dom.style.display="block";
            result = false;
        }

        var isNameLong = ${nameVar}.getValue().length > ${maxNameLength};

        if (!isNameLong){
            Ext.get('${nameLongErrorId}').dom.style.display="none";
        }else{
        	Ext.get('${nameLongErrorId}').dom.style.display="block";
            result = false;
        }

        var isDescLong = ${descVar}.getValue().length > ${maxDescLength};

        if (!isDescLong){
            Ext.get('${descLongErrorId}').dom.style.display="none";
        }else{
        	Ext.get('${descLongErrorId}').dom.style.display="block";
            result = false;
        }
        
        var result2 = ${prefix}validateApplicable();     
        result = result && result2;        
        
        return result;
    }

//]]>
</script>
