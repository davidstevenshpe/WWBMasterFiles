<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<syswf:control mode="script" action="toggleVisibility" caption="${prefix}_toggleVisibility" affects="../.." loadingMask="true"/>
<syswf:input id="${prefix}_to_toggle_id" name="toggleId" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

function ${prefix}_handle_toggleVisibility(id) {
    var element = Ext.get('${prefix}_to_toggle_id');
    element.dom.value = id;
    ${prefix}_toggleVisibility();        
}

//]]>
</script>

<c:choose>
    <c:when test="${column.visible}">
        <c:set var="toggleVisibilityClass" value="UI Icon VisibilityOn" />
    </c:when>
    <c:otherwise>
        <c:set var="toggleVisibilityClass" value="UI Icon VisibilityOff" />
    </c:otherwise>
</c:choose>

<a id="${prefix}_toggleVisibility" href="javascript:void(0);" class="${toggleVisibilityClass}"
   title="<fmt:message key="listEditorHiearchicalRow.toggleVisibility" bundle="${bundle}"/>"></a>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
            Ext.get('${prefix}_toggleVisibility').on('click', function() {
                ${prefix}_handle_toggleVisibility('${column.id}');
            });
    });

    $(document).ready(function(){
        // This function stops events beyond the element
        // We do this to stop selection of the row when the tab name is clicked.
        $('#${prefix}_toggleVisibility').bind('click',function(){
            return false;
        });
    });

//]]>
</script>

