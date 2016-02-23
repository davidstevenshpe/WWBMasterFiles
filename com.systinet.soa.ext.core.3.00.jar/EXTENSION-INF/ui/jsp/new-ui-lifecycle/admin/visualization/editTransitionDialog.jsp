<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="processId" type="java.lang.String"--%>
<%--@elvariable id="flashObjectId" type="java.lang.String"--%>

<c:set var="winId" value="${prefix}_window"/>
<c:set var="winOpenFunctionName" value="${prefix}_open"/>
<c:set var="winGetParamsFunctionName" value="${prefix}_getParams"/>
<c:set var="winOkAction" value="${prefix}_okAction"/>
<c:set var="winOkButtonId" value="${prefix}_okButton"/>
<c:set var="winCancelAction" value="${prefix}_cancelAction"/>
<c:set var="okButtonId" value="${prefix}_okButton"/>
<c:set var="contentDivId" value="${prefix}_content"/>
<syswf:component name="/core/window" prefix="addInitialStageWindow">
    <syswf:param name="winId" value="${winId}"/>
    <syswf:param name="winComponent" value="/newUi/lc/admin/visualization/editTransitionComponent"/>
    <syswf:param name="winOpenFunctionName" value="${winOpenFunctionName}" />
    <syswf:param name="winGetParamsFunctionName" value="${winGetParamsFunctionName}"/>
    <syswf:param name="winOkAction" value="${winOkAction}" /> <%-- defined in content component --%>
    <syswf:param name="winCancelAction" value="${winCancelAction}" />    
    <syswf:param name="winOkButtonId" value="${winOkButtonId}"/>
    <syswf:param name="winButtonAlign" value="right"/>
    <syswf:param name="winWidth" value="450"/>
    <syswf:param name="winResizable" value="true"/>
    <syswf:param name="winRenderAlways" value="true"/>

    <syswf:param name="okAction" value="${winOkAction}" /> <%-- defined in content component --%>
    <syswf:param name="okButtonId" value="${winOkButtonId}"/>    
    <syswf:param name="wrappingDivId" value="${contentDivId}"/>
    <syswf:param name="processId" value="${processId}"/>
</syswf:component>

<fmt:message var="msgConfirmTitle" key="stageAction.delete.confirmTitle" bundle="${messages}"/>
<syswf:component prefix="stageDeleteDialog" name="/core/impl/util/dialog">
    <syswf:param name="controlName" value="openDeleteStageDialog" />
    <%--other parameters need not to be defined, because the dialog is displayed by calling javascript method directly--%>
</syswf:component>

<c:set var="dialogArgsVar" value="${prefix}_dialogArgs"/> <%-- javascript variable that will contain dialog arguments --%>
<script type="text/javascript">
//<![CDATA[


    var _deleteParentStageValues;
    var _deleteStageValue;
    var _redirectTransitions;
    var _cutCycles;
    var _isReference;

    function openDeleteStageWindow(fromStageValues, toStageValue, deleteStageName, redirectTransitions, cutCycles, isReference) {
        _deleteParentStageValues = fromStageValues;
        _deleteStageValue = toStageValue;
        _redirectTransitions = redirectTransitions;
        _cutCycles = cutCycles;
        _isReference = isReference;
        var element = Ext.get('${prefix}_stageDeleteDialog');
        ${prefix}_stageDeleteDialog_showDialog(element, '${msgConfirmTitle}',
               '<fmt:message key="stageAction.delete.confirmMessage.prefix" bundle="${messages}"/> <em>\''
                       + Ext.util.Format.htmlEncode(deleteStageName) + '\'</em> '
                       + (_isReference
                            ? '<fmt:message key="stageAction.delete.confirmMessage.referencePostfix" bundle="${messages}"/>'
                            : '<fmt:message key="stageAction.delete.confirmMessage.simplePostfix" bundle="${messages}"/>'),
               null, ${prefix}deleteAction, false);
    }

    var ${prefix}deleteAction = function() {
        getFlexApp('${flashObjectId}').deleteStage(_deleteParentStageValues, _deleteStageValue, _redirectTransitions, _cutCycles);
    };

    var ${dialogArgsVar} = null;

    function openEditTransitionDialog(mode, fromStages, toStage) {
        var fromStagesJoined = convertArrayToString(fromStages);
        ${dialogArgsVar} = {'mode' : mode, 'fromStages' : fromStagesJoined, 'toStage' : toStage};
        ${winOpenFunctionName}();

        var windowTitle = '';
        switch(mode) {
          case 'ADD_INITIAL_STAGE':
            windowTitle = '<fmt:message key="editTransition.windowTitle.ADD_INITIAL_STAGE" bundle="${messages}"/>';
            break;
          case 'EDIT_INITIAL_STAGE':
            windowTitle = '<fmt:message key="editTransition.windowTitle.EDIT_INITIAL_STAGE" bundle="${messages}"/>';
            break;
          case 'ADD_STAGE':
            windowTitle = '<fmt:message key="editTransition.windowTitle.ADD_STAGE" bundle="${messages}"/>';
            break;
          case 'EDIT_STAGE':
            windowTitle = '<fmt:message key="editTransition.windowTitle.EDIT_STAGE" bundle="${messages}"/>';
            break;
          case 'EDIT_TRANSITION':
            windowTitle = '<fmt:message key="editTransition.windowTitle.EDIT_TRANSITION" bundle="${messages}"/>';
            break;
        }
        SPopup.Window.Instance['${winId}'].setTitle(windowTitle);
    }

    function convertArrayToString(o) {
		var s = '';
        if (o != null && o.length > 0) {
            if (o[0] != null) {
                s = o[0];
                for (i=1; i<(o.length); i++) {
                    s +=  ",|;" + o[i];
                }
            }
        }
        return s;
	}

    function applyTransitionChange(mode, fromStages, toStage, toStageName, previousToStage, transitionTypes, share) {
        getFlexApp('${flashObjectId}').applyTransitionChange(mode, fromStages, toStage, toStageName, previousToStage,
                transitionTypes, share);
    }

    function ${winGetParamsFunctionName}() {
        return ${dialogArgsVar};
    }

    function ${winCancelAction}() {
        Ext.get('${contentDivId}').update('');
    }


//]]>
</script>
