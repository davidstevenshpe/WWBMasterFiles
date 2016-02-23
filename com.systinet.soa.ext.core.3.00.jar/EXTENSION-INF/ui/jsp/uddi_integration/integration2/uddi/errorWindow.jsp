<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}confirm_window" class="x-hidden">
        <div class="x-window-header"><c:out value="${dialog_title}"/></div>
        <div class="x-window-body">
            <p class="Warning"><c:out value="${message}"/></p>
        </div>
    </div>
</div>

<syswf:control mode="script" action="${callBackFunc}" caption="${prefix}close" />
    
<c:set var="customButtons">
    [{
        text     : '<fmt:message key="uddi.errorWindow.button_close" bundle="${l10n}"/>',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}confirm_window'].hide();
            ${prefix}close();
        },
        id: '${prefix}_okButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${jsOpenWindow} = function() {
    SPopup.Window.forceOpen('${prefix}confirm_window','${prefix}confirm_window',{
        autoHeight: true, 
        buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', 
        width: 300, 
        resizable: false, 
        centerOnScreen: true
        });
};

//]]>
</script>