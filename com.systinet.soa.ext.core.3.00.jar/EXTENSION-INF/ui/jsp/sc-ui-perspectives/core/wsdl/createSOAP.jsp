<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uisccomponentsmessages"/>
<fmt:message bundle="${messages}" key="createSOAP.title" var="linkCaption"/>

<c:if test="${not common}"><%-- for compatibility with legacy versions --%>
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction Create</c:set>
  <c:set var="linkText" value="${linkCaption}"/>
</c:if>
<c:if test="${common}"><%-- context buttons displayed at top content --%>
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button Create</c:set>
  <c:set var="linkText" value=""/>
</c:if>

<c:if test="${not empty artifact.location && permissions.write && collectionPermissions.pureWrite}">

<div class="${blockClassName}">
<a id="${prefix}link" href="javascript:void(0);" class="${linkClassName}" title="${linkCaption}"><span>${linkText}</span></a>
</div>

<syswf:control mode="script" caption="${prefix}createWsdl" action="createWsdl"/>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Ext.get('${prefix}link').on('click', function(e) {
            Ext.MessageBox.show({
                title: "<fmt:message bundle="${messages}" key="createSOAP.title" />",
                msg: "<fmt:message bundle="${messages}" key="createSOAP.desc" />",
                buttons: {ok:'<fmt:message bundle="${messages}" key="createSOAP.Create" />', cancel:'<fmt:message bundle="${uisccomponentsmessages}" key="Cancel" />'},
                icon :  Ext.MessageBox.INFO,
                width : 300,
                fn: function(answer) {
                    if(answer == 'ok') {
                    	${prefix}createWsdl();
                    }
                }
            });
        });
    });

//]]>
</script>

</c:if>