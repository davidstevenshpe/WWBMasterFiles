<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="utilmessages"/>
<fmt:message var="editSpecificationAction" key="editSpecificationAction" bundle="${utilmessages}"/>

<c:if test="${hasWritePermission}">

<a id="${prefix}editLink" href="javascript:void(0);" class="context-button Edit" title="${editSpecificationAction}"></a>
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.get('${prefix}editLink').on('click', function() {
                    ${editFunction}();
                });
            });
        
//]]>
</script>

  

</c:if>