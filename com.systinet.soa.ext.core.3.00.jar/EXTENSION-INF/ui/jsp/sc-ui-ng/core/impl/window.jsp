<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${empty windowControlName}">
    <c:set var="windowControlName" value="${prefix}_render" />
</c:if>

<c:choose>
<c:when test="${render}">
    <syswf:component name="${component}" prefix="window" ajax="true">
        <syswf:paramSet value="${componentParams}" />
        <syswf:param name="warningMessageKey" value="${warningMessageKey}" />
        
        <syswf:param name="winDontShowMask" value="${null}" passNull="true" />
        <syswf:param name="winOnRenderCallback" value="${winOnRenderCallback}" />
    </syswf:component>
    <c:if test="${not empty winOnRenderCallback}">
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        ${winOnRenderCallback}();
    });
    
//]]>
</script>
    </c:if>
</c:when>
<c:when test="${empty winDontShowMask}">
    <div style="height:100px;width:200px;margin:0 auto" id="${prefix}mask">&nbsp;</div>
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        var myMask = new Ext.LoadMask('${prefix}mask');
        myMask.show();
    });
    
//]]>
</script>
</c:when>
</c:choose>
<c:if test="${alwaysRender || !render}">
    <syswf:control mode="ajax" action="render" caption="${prefix}doIt" />
</c:if>
<script type="text/javascript">
//<![CDATA[

var ${windowControlName} = function() {
    <c:if test="${!alwaysRender}">
        var winEl = Ext.get("${prefix}_window");
        if (!winEl) {
    </c:if>
         ${prefix}doIt(<c:if test="${not empty getParamsFunctionName}">${getParamsFunctionName}()</c:if>);
    <c:if test="${!alwaysRender}">
        }
    </c:if>
}

//]]>
</script>