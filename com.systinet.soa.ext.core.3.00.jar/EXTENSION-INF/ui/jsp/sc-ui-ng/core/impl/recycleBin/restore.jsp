<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<c:choose>
    <c:when test="${not empty uuid}">
        <fmt:message bundle="${labels}" key="recycleBin.restoreConfirmOne" var="confirmMessage" />
    </c:when>
    <c:otherwise>
        <fmt:message bundle="${labels}" key="recycleBin.restoreConfirm" var="confirmMessage" />
    </c:otherwise>
</c:choose>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
<div id="${prefix}delete_window" class="x-hidden">
<div class="x-window-header"><fmt:message bundle="${labels}" key="recycleBin.restore" /></div>
<div class="x-window-body">
<div class="UI Offset">

<p class="Warning">${confirmMessage}</p>

<div class="UI AdvancedOptions Labeled Closed">
    <div class="OptionsOpener">
        <a href="javascript:void(0);" id="${prefix}opener"><span><fmt:message bundle="${messages}" key="general.advancedOptions" /></span></a>
    </div>
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        attachOn('${prefix}opener','click',function() {
            AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
        });
    });
    
//]]>
</script>
    <div class="Content">
        <syswf:selectOne id="${prefix}includeSubartifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${bulkUndeleteSettings}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}includeSubartifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
    </div>
</div>

</div>
</div>
</div>
</div>

<syswf:control mode="script" caption="${prefix}Restore" action="${controlAction}" />

<c:set var="customButtons">
    [{
        text     : '<fmt:message bundle="${labels}" key="OK" />',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}delete_window'].hide();
            ${prefix}Restore();
        },
        id: '${prefix}_okButton'
    },{
        text     : '<fmt:message bundle="${labels}" key="Cancel" />',
        handler  : function(){
            SPopup.Window.Instance['${prefix}delete_window'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    SPopup.Window.forceOpen('${prefix}delete_window','${prefix}delete_window',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 300, resizable: false, centerOnScreen: true
    });
}

//]]>
</script>
