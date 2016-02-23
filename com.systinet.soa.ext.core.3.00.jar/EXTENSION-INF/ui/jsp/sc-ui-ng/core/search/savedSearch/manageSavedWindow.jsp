<%--
Parameters:
    jsOpenFunction = name of a function that opens the window, has to be bound to an element onClick method
                     this javascript method also contains calling of javascript method fro loading internal content
    refreshParent - name of javascript function, which refresh parent (needed on close)                      
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
 
<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<fmt:message var="closeButtonLabel" key="Close" bundle="${messages}"/>
<fmt:message var="windowTitle" key="search.savedSearchesWindowTitle" bundle="${searchmessages}"/>

<div class="webfw-Window" id="${prefix}manageSaved-webfw-Window">
    <div id="${prefix}manageSavedWindow" class="x-hidden">
        <div class="x-window-header">${windowTitle}</div>
        <div class="x-window-body">
			<div class="UI Offset SaveSearchDialog">
	            <syswf:component name="/core/search/savedSearch/manageSavedWindowInternal" prefix="manageSavedWindowInternal" ajax="true">
	                <syswf:param name="jsLoadFunction" value="${prefix}LoadInternal" />
	                <syswf:param name="savedSearchDefinitionBaseUrl" value="${savedSearchDefinitionBaseUrl}" />
	                <syswf:param name="filterLabelResolver" value="${filterLabelResolver}" />
	            </syswf:component>
			</div>
        </div>
    </div>

    <script type="text/javascript">
//<![CDATA[

        var ${prefix}buttons = [
            {text: '${closeButtonLabel}', handler: function(){SPopup.Window.Instance['${prefix}manageSavedWindow'].hide();}}
        ];
        var ${jsOpenFunction}= function() {
        	SPopup.Window.Instance['${prefix}manageSavedWindow'] = undefined;
            SPopup.Window.forceOpen('${prefix}manageSavedWindow','${prefix}manageSavedWindow',{
               autoHeight: true, plain: true, buttons: ${prefix}buttons, width: 650, resizable: false, centerOnScreen:true
            });
            ${prefix}LoadInternal();
            SPopup.Window.Instance['${prefix}manageSavedWindow'].on("beforeHide", function() {
            	${refreshParent}();
            });
        };
    
//]]>
</script>
</div>
