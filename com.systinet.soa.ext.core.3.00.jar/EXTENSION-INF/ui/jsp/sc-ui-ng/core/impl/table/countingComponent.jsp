<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uiMessages"/>
<fmt:message key="TABLE_COMPONENT_STATUS" bundle="${uiMessages}" var="statusLabel"/>

<syswf:control mode="ajax" id="${tableId}reloadControl" caption="${tableId}reloadControl"/>

<script type="text/javascript">
    if (${store}.reader.jsonData != null && ${store}.reader.jsonData.countRetrievalMethod == 'parallel' && ${store}.totalLength < 0) {
        if (${count} >= 0) {
            ${store}.totalLength = ${count};
            ${pagingBar}.displayMsg = '${statusLabel}';
            ${pagingBar}.bind(${store});
            ${pagingBar}.setDisabled(false);
            ${grid}.filters.enableFilters();
        } else {
            setTimeout("${tableId}reload()", ${countRefreshInterval});
        }
    }
    function ${tableId}reload() {
        ${tableId}reloadControl();
    }

</script>
