<%--
Parameters:
    jsOpenFunction - name of a function that opens the window, has to be bound to an element onClick method
    savedSearchDefinition - recently saved search
    resultUpdateIdHolder - holder with id of result window id to refresh after save
    refreshParent - name of javascript function, which refresh parent (needed on close)
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<fmt:message var="closeButtonLabel" key="Close" bundle="${messages}"/>
<fmt:message var="windowTitle" key="search.saveResultWindowTitle" bundle="${searchmessages}"/>
<fmt:message var="savedSuccesfullyLabel" key="search.savedSuccesfullyLabel" bundle="${searchmessages}"/>
<fmt:message var="accessLabel" key="search.accessLabel" bundle="${searchmessages}"/>

<div class="webfw-Window" id="${prefix}successfull-webfw-Window">
    <div id="${prefix}successfullWindow" class="x-hidden">
        <div class="x-window-header">${windowTitle}</div>
        <div class="x-window-body">
            <div class="UI Offset SavedSearchDialog">
                <div class="UI SystemMessage Info">
                        <div class="MessageContainer">
                            <div class="Text">
                                <strong class="UI Icon Completed">${savedSuccesfullyLabel}.</strong>
                            </div>
                            <div class="x-clear"></div>
                        </div>
                    </div>
                    <p>${accessLabel}:</p>
                    <p>
                        <c:if test="${not empty savedSearchDefinition.uuid}">
                            <a href="${savedSearchDefinitionBaseUrl}${savedSearchDefinition.uuid}">${savedSearchDefinitionBaseUrl}${savedSearchDefinition.uuid}</a>
                        </c:if>
                    </p>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

    var buttonsSuccessfull = [
        {text: '${closeButtonLabel}',  handler: function(){SPopup.Window.Instance['${prefix}successfullWindow'].hide();}}
    ];
    var ${jsOpenFunction}= function() {
    	SPopup.Window.Instance['${prefix}successfullWindow'] = undefined;
        SPopup.Window.forceOpen('${prefix}successfullWindow','${prefix}successfullWindow',{
            autoHeight: true, plain: true, buttons: buttonsSuccessfull, width: 500, resizable: false, centerOnScreen:true,
            listeners : {collapse : function() {alert('test');}}
        });
        SPopup.Window.Instance['${prefix}successfullWindow'].on("beforeHide", function() {
        	${refreshParent}();
        });
    };

    

//]]>
</script>