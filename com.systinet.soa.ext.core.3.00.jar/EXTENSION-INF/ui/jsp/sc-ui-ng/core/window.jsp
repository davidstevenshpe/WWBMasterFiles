<%--
Component parameters

winId - window ID (optional)
winTitle - title of the popup
winComponent - window contents component
winOpenFunctionName - name of the JS function that opens this window, the name has to be bound to
                      a click action on an element. The function is generated here, called from
                      parent component
winCustomButtons - buttons that are used for creation of window. If null, default buttons (ok, cacncel) are created. 
winGetParamsFunctionName - name of the JS function that is called when the AJAX request is sent to the server.
                           The method should return a JS object with key-value pairs. It works only if AJAX
                           rendering is turned on (i.e. winRenderContents is not set)
winOkButtonId - OK button id (optional)
winOkLabel - label of the OK button (default OK)
winOkAction - JS function name that is called when user click OK button
winCancelButtonId - Cancel button id (optional)
winCancelLabel - label of the Cancel button (default Cancel)
winCancelAction - JS function name that is called when user clicks Cancel button, should return
                  window content to its original state
winOpenAction - JS function name that is called when user opens the window
winButtonAlign - button alignment (left, center, right) (default center)
winWidth - window width (default 500)
winResizable - true to make window resizable (default false)
winAutoScroll - true to make window auto scroll (default false)
winRenderContents - when set, contents of the window will be rendered immediately
winRenderAlways - when set, contents of the window will be re-rendered on every window open. It works only if AJAX
                  rendering is turned on (i.e. winRenderContents is not set)
winForceRefresh - when set, the forceRefresh boolean argument of SPopup is set to its value (default false)
winContents - directly rendered contents, if 'winRenderContents' is true. Exclusive with winComponent
winDontShowMask - mask Loading will not be shown

Copy&Paste window standard parameters:

<syswf:param name="winComponent" value="" />
<syswf:param name="winTitle" value="" />
<syswf:param name="winOpenFunctionName" value="" />
<syswf:param name="winOkLabel" value="" />
<syswf:param name="winOkAction" value="" />
<syswf:param name="winId" value="" />

--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<fmt:message bundle="${labels}" key="OK" var="OK" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

<c:if test="${empty winId}">
    <c:set var="winId" value="${prefix}win"/>
</c:if>


<c:if test="${empty winOkButtonId}">
    <c:set var="winOkButtonId" value="${prefix}_okButton"/>
</c:if>

<c:if test="${empty winCancelButtonId}">
    <c:set var="winCancelButtonId" value="${prefix}_cancelButton"/>
</c:if>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
<div id="${winId}" class="x-hidden">
<div class="x-window-header"><syswf:out context="HtmlBody" value="${winTitle}"/></div>
<div class="x-window-body">

<c:choose>
 <c:when test="${empty winWrapperClass}">
     <div class="UI Offset">
 </c:when>
 <c:otherwise>
      <div class="${winWrapperClass}">
 </c:otherwise>
</c:choose>

<script type="text/javascript">
//<![CDATA[

    var ${winId}_showHandlers = new Array();

//]]>
</script>
    
<c:choose>
    <c:when test="${empty winRenderContents}">
<syswf:component name="/core/impl/window" prefix="w">
    <syswf:paramSet value="${componentParams}" />
    <syswf:param name="component" value="${winComponent}" />
    <syswf:param name="windowControlName" value="${prefix}_render" />
    <syswf:param name="alwaysRender" value="${winRenderAlways}" />
    <syswf:param name="getParamsFunctionName" value="${winGetParamsFunctionName}" />
    <syswf:param name="warningMessageKey" value="${warningMessageKey}" />
    
    <%-- Reset variables --%>
    <syswf:param name="winId" value="${null}" passNull="true" />
    <syswf:param name="winTitle" value="${null}" passNull="true" />
    <syswf:param name="winComponent" value="${null}" passNull="true" />
    <syswf:param name="winOpenFunctionName" value="${null}" passNull="true" />
    <syswf:param name="winCustomButtons" value="${null}" passNull="true" />
    <syswf:param name="winGetParamsFunctionName" value="${null}" passNull="true" />
    <syswf:param name="winOkButtonId" value="${null}" passNull="true" />
    <syswf:param name="winOkLabel" value="${null}" passNull="true" />
    <syswf:param name="winOkAction" value="${null}" passNull="true" />
    <syswf:param name="winCancelButtonId" value="${null}" passNull="true" />
    <syswf:param name="winCancelLabel" value="${null}" passNull="true" />
    <syswf:param name="winCancelAction" value="${null}" passNull="true" />
    <syswf:param name="winOpenAction" value="${null}" passNull="true" />
    <syswf:param name="winButtonAlign" value="${null}" passNull="true" />
    <syswf:param name="winWidth" value="${null}" passNull="true" />
    <syswf:param name="winResizable" value="${null}" passNull="true" />
    <syswf:param name="winRenderContents" value="${null}" passNull="true" />
    <syswf:param name="winRenderAlways" value="${null}" passNull="true" />
    <syswf:param name="winForceRefresh" value="${null}" passNull="true" />
    <syswf:param name="winContents" value="${null}" passNull="true" />
    <syswf:param name="winDontShowMask" value="${winDontShowMask}" />
    <syswf:param name="winOnRenderCallback" value="${winOnRenderCallback}" />
</syswf:component>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${empty winComponent}">
                <c:out value="${winContents}" escapeXml="false"/>
            </c:when>
            <c:otherwise>
                <syswf:component name="${winComponent}" prefix="w">
                    <syswf:paramSet value="${componentParams}" />
                </syswf:component>
            </c:otherwise>
        </c:choose>
    </c:otherwise>

</c:choose>

</div>
</div>
</div>
</div>

<c:if test="${empty winCustomButtons}">
    <c:set var="winCustomButtons">
        [{
        	xtype:'flatbutton',
            text     : '<c:out value="${winOkLabel}" default="${OK}" />',
            iconCls:'btn btn-primary',
            disabled : false,
            handler  : function() {
                <c:choose><c:when test="${not empty winOkAction}">${winOkAction}();</c:when>
                <c:otherwise>alert('No OK action defined');</c:otherwise></c:choose>
                <c:if test="${not empty winCancelAction}">
                SPopup.Window.Instance['${winId}'].removeListener('beforehide',${winCancelAction});
                </c:if>
                SPopup.Window.Instance['${winId}'].hide();
            },
            id: '${winOkButtonId}'
        },{
         	xtype:'flatbutton',
            text     : '<c:out value="${winCancelLabel}" default="${Cancel}" />',
            iconCls:'btn btn-gray',
            handler  : function(){
                SPopup.Window.Instance['${winId}'].hide();
                return false;
            },
            id: '${winCancelButtonId}'
        }]
    </c:set>
</c:if>

<script type="text/javascript">
//<![CDATA[

var ${winOpenFunctionName} = function() {
    <c:if test="${empty winRenderContents}">
    ${prefix}_render();
    </c:if>
    <c:if test="${winRenderAlways and not winDontShowMask}">
        Ext.get('${prefix}_w').update('<div style="height:100px;width:200px;margin:0 auto" id="${prefix}mask">&nbsp;</div>');
        var myMask = new Ext.LoadMask('${prefix}mask');
        myMask.show();
    </c:if>    
    SPopup.Window.forceOpen('${winId}','${winId}',{
        <c:choose><c:when test="${not empty winHeight}">height:${winHeight}</c:when><c:otherwise>autoHeight: true</c:otherwise></c:choose>, buttons: <c:out value="${winCustomButtons}" escapeXml="false"/>, forceRefresh:<c:out value="${winForceRefresh}" default="false" />,
        buttonAlign: '<c:out value="${winButtonAlign}" default="center" />', width: <c:out value="${winWidth}" default="500" />, resizable: <c:out value="${winResizable}" default="false" />, centerOnScreen: true, autoScroll:<c:out value="${winAutoScroll}" default="false" />,
        listeners: {
            'show' : function() {
            	if(${winId}_showHandlers.length > 0){					
					for(i=0; i<${winId}_showHandlers.length; i++){
						var h = ${winId}_showHandlers[i];
						h();
					}
				}
                <c:if test="${not empty winOpenAction}">
                ${winOpenAction}();
                </c:if>
            }
        }
    });
    <c:if test="${not empty winCancelAction}">
    SPopup.Window.Instance['${winId}'].addListener('beforehide',${winCancelAction});
    </c:if>
}

SPopup.Window.Instance['${winId}'] = undefined;


//]]>
</script>

