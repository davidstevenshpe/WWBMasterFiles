<%--
Component parameters

winActivator - ID of element on which onClick will be bound
winId - window ID (optional)
winTitle - title of the popup
winComponent - window contents component
winGetParamsFunctionName - name of the JS function that is called when the AJAX request is sent to the server.
                           The method should return a JS object with key-value pairs. It works only if AJAX
                           rendering is turned on (i.e. winRenderContents is not set)
winOpenAction - JS function name that is called when user opens the window
winWidth - window width (default 500)
winHeight - window height (default 100)
winRenderContents - when set, contents of the window will be rendered immediately
winRenderAlways - when set, contents of the window will be re-rendered on every window open. It works only if AJAX
                  rendering is turned on (i.e. winRenderContents is not set)
winForceRefresh - when set, the forceRefresh boolean argument of SPopup is set to its value (default false)
winContents - directly rendered contents, if 'winRenderContents' is true. Exclusive with winComponent
winCustomButtons - optional buttons

Copy&Paste window standard parameters:

<syswf:param name="winComponent" value="" />
<syswf:param name="winTitle" value="" />
<syswf:param name="winActivator" value="" />
<syswf:param name="winId" value="" />

--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${empty winId}">
    <c:set var="winId" value="${prefix}win"/>
</c:if>

<div class="webfw-Window" id="${prefix}-webfw-Window">
<div id="${winId}" class="x-hidden">
<div class="x-tip-header">${winTitle}</div>
<div class="x-tip-body">
<div class="hp-version-flow-viewport">

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
    
    <%-- Reset variables --%>
    <syswf:param name="winId" value="${null}" passNull="true" />
    <syswf:param name="winTitle" value="${null}" passNull="true" />
    <syswf:param name="winCustomButtons" value="${null}" passNull="true" />
    <syswf:param name="winComponent" value="${null}" passNull="true" />
    <syswf:param name="winActivator" value="${null}" passNull="true" />
    <syswf:param name="winGetParamsFunctionName" value="${null}" passNull="true" />
    <syswf:param name="winOpenAction" value="${null}" passNull="true" />
    <syswf:param name="winButtonAlign" value="${null}" passNull="true" />
    <syswf:param name="winWidth" value="${null}" passNull="true" />
    <syswf:param name="winRenderContents" value="${null}" passNull="true" />
    <syswf:param name="winRenderAlways" value="${null}" passNull="true" />
    <syswf:param name="winForceRefresh" value="${null}" passNull="true" />
    <syswf:param name="winContents" value="${null}" passNull="true" />
    <syswf:param name="winDontShowMask" value="${winDontShowMask}" />
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

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
    new Ext.HP.RichTip({
        id: '${prefix}richtip',
        autoScroll: true,
        height: <c:out value="${winHeight}" default="100" />,
        autoHeight: false,
        <c:if test="${not empty winCustomButtons}">
        buttons: ${winCustomButtons},
        buttonAlign: 'center',
        </c:if>
        target: '${winActivator}',
        width: <c:out value="${winWidth}" default="400" />,
        applyTo: '${winId}' // load content from the page
    });
    <c:if test="${empty winRenderContents}">
    attachOn('${winActivator}','click',function() {
    	${prefix}_render();
    });
    </c:if>
});

//]]>
</script>
