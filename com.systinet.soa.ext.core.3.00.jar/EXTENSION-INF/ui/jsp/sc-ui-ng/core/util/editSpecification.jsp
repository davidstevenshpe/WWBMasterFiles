<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="utilmessages"/>
<fmt:message var="editSpecificationAction" key="editSpecificationAction" bundle="${utilmessages}"/>

<c:if test="${not common}"><!-- for compatibility with legacy versions -->
  <c:set var="blockClassName">EA-right-panel</c:set>
  <c:set var="linkClassName">UI PageAction Edit</c:set>
  <c:set var="linkText" value="${editSpecificationAction}"/>
  <c:set var="linkTooltip" value="${editSpecificationAction}"/>
</c:if>
<c:if test="${common}"><!-- context buttons displayed at top content -->
  <c:set var="blockClassName">UI Block Green</c:set>
  <c:set var="linkClassName">context-button Edit</c:set>
  <c:set var="linkText" value=""/>
  <c:set var="linkTooltip" value="${editSpecificationAction}"/>
</c:if>

<c:if test="${hasWritePermission}">

    <syswf:block className="${blockClassName}">    
    
        <a id="${prefix}editLink" href="javascript:void(0);" class="${linkClassName}" title="${linkTooltip}">${linkText}</a>
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.get('${prefix}editLink').on('click', function() {
                    ${editFunction}();
                });
            });
        
//]]>
</script>
    
    </syswf:block>

</c:if>