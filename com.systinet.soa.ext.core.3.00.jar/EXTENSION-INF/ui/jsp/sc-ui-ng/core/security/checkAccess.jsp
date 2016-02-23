<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.security.securitymessages" var="securitymessages"/>
<fmt:message var="checkAccessContextActionLink" key="checkAccessContextActionLink" bundle="${securitymessages}"/>
<fmt:message var="checkAccessDialogTitle" key="checkAccessDialogTitle" bundle="${securitymessages}"/>
<fmt:message var="selectButtonLabel" bundle="${labels}" key="Select" />
<fmt:message var="closeButtonLabel" bundle="${labels}" key="Close" />
 
<c:if test="${isActionPermitted}">
 <div class="EA-right-panel">
    <a href="javascript:void(0);" class="UI PageAction CheckAccess" id="${prefix}checkAccessLink">${checkAccessContextActionLink}</a>
</div>        
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('${prefix}checkAccessLink').on('click', ${prefix}openCheckAccessWindow);
        });
    
//]]>
</script>
    
    <syswf:control mode="script" caption="${prefix}windowClosed" action="${prefix}_checkAccessContent_w_window$cleanSelection" affects="${prefix}_checkAccessContent_w_window"/>
    <syswf:control mode="script" caption="${prefix}principalSelected" action="${prefix}_checkAccessContent_w_window$principalSelected" affects="${prefix}_checkAccessContent_w_window"/>
    
    <c:set var="buttons">
        [
         {
            text: '${selectButtonLabel}',
            handler: function(){ 
                ${prefix}principalSelected();
            }, 
            id: '${prefix}_select'
         },
         {
            text: '${closeButtonLabel}',
            handler: function(){ 
                SPopup.Window.Instance['${prefix}checkAccessContent'].hide(); 
                ${prefix}windowClosed();
            }, 
            id: '${prefix}_close'
         }
        ]
    </c:set>
    
    <syswf:component name="/core/window" prefix="checkAccessContent">
        <syswf:param name="winId">${prefix}checkAccessContent</syswf:param>
        <syswf:param name="winOpenFunctionName" value="${prefix}openCheckAccessWindow"/>
        <syswf:param name="winTitle">${checkAccessDialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/core/security/checkAccessContent"/>
        <syswf:param name="winCustomButtons" value="${buttons}"/>
        <syswf:param name="winWidth" value="400"/>
        <syswf:param name="winButtonAlign" value="center"/>
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="parentPrefix" value="${prefix}"/>
    </syswf:component>

</c:if>