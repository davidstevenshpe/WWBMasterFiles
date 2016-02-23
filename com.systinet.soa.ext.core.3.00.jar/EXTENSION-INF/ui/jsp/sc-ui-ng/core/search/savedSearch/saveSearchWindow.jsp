<%--
Parameters:
    jsOpenFunction = name of a function that opens the window, typically function is bound to some action on UI
    savedSearchDefinition = object which holds all data, instance of saved (to be saved) search
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<fmt:message var="saveButtonLabel" key="Save" bundle="${messages}"/>
<fmt:message var="cancelButtonLabel" key="Cancel" bundle="${messages}"/>
<fmt:message var="windowTitle" key="search.saveWindowTitle" bundle="${searchmessages}"/>
<fmt:message var="savingLabel" key="savingLabel" bundle="${searchmessages}"/>

<%-- Result window is rendered but not visible until save finishes --%>
<syswf:component name="/core/search/savedSearch/saveSearchResultWindow" prefix="saveSearchResultWindow" ajax="true">
    <syswf:param name="jsOpenFunction" value="${prefix}OpenResultWindowFce" />
    <syswf:param name="savedSearchDefinition" value="${savedSearchDefinition}" />
    <syswf:param name="resultUpdateIdHolder" value="${resultUpdateIdHolder}" />
    <syswf:param name="refreshParent" value="${refreshParent}" />
    <syswf:param name="savedSearchDefinitionBaseUrl" value="${savedSearchDefinitionBaseUrl}" />
</syswf:component>

<%--Id for window --%>
<c:set var="windowId" value="${prefix}window" />

<%-- close function is used inside internal window component, so is created as javascript function --%>
<script type="text/javascript">
//<![CDATA[

    var ${prefix}CloseSaveWindow = function() {
    	SPopup.Window.Instance['${windowId}'].hide();
    };

//]]>
</script>

<%-- Id for save button. Because if validation of name fails, button's class has to be changed back and has to be enabled. --%>
<c:set var="saveButtonId" value="${prefix}SaveButtonId" />

<div class="webfw-Window" id="${prefix}-webfw-Window">
    <div id="${windowId}" class="x-hidden">
        <div class="x-window-header">${windowTitle}</div>
        <div class="x-window-body">
            <div class="UI Offset SaveSearchDialog">
                <%-- Internal part of window, it handles save action --%>
                <syswf:component name="/core/search/savedSearch/saveSearchWindowInternal" prefix="savedSearchSaveInternal" ajax="true">
                    <syswf:param name="saveFce" value="${prefix}save" />
                    <syswf:param name="openResultWindowFce" value="${prefix}OpenResultWindowFce" />
                    <syswf:param name="closeWindowFce" value="${prefix}CloseSaveWindow" />
                    <syswf:param name="savedSearchDefinition" value="${savedSearchDefinition}" />
                    <syswf:param name="resultUpdateIdHolder" value="${resultUpdateIdHolder}" />
                    <syswf:param name="windowId" value="${windowId}" />
                    <syswf:param name="saveButtonId" value="${saveButtonId}" />
                    <syswf:param name="filterLabelResolver" value="${filterLabelResolver}" />                    
                </syswf:component>
                    
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
//<![CDATA[

    var buttons = [
        {id: '${saveButtonId}', text: '${saveButtonLabel}', handler: function(){SPopup.Window.Instance['${windowId}'].getEl().mask('${savingLabel}'); ${prefix}save();}},
        {text: '${cancelButtonLabel}', handler: function(){ ${prefix}CloseSaveWindow(); }}
    ];
    var ${jsOpenFunction}= function() {
    	SPopup.Window.Instance['${windowId}'] = undefined; 
        SPopup.Window.forceOpen('${windowId}','${windowId}',{
            autoHeight: true, plain: true, buttons: buttons, width: 500, resizable: false, centerOnScreen:true
        });
    };


    

//]]>
</script>