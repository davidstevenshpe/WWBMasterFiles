<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="removeWidget" var="removeMsg" bundle="${widgetMessages}"/>
<fmt:message key="removeWidgetHint" var="removeHint" bundle="${widgetMessages}"/>

<%--
Input: 
 status - iteration status object
 firstRemovable - boolean
 alignToId - id of component where remove icon will be rendered
 removeFce - javascript function used to remove condition
--%>

<c:if test="${empty status or (status.first and firstRemovable) or (status.index > 0)}">
    
    <a id="${prefix}removeLink"
        title="Click to remove this criteria"
        class="IconButton Transparent"
        href="javascript:void(0);"><span><span><span class="Remove"></span></span></span></a>
        
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('${prefix}removeLink').on('click', function() {
            	${removeFce}();
            });
        });
    
//]]>
</script>
    
</c:if>