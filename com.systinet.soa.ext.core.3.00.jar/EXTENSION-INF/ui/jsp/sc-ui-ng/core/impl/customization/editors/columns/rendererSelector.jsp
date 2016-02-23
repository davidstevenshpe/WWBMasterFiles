<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${column.relation}">
<syswf:control mode="script" caption="${prefix}_select" action="select" affects="../.." loadingMask="true"/>

<%--
<syswf:input id="${prefix}_renderer_id" name="rendererId" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

function ${prefix}_handle_selectRenderer(id) {
    var element = Ext.get('${prefix}_renderer_id');
    element.dom.value = id;
    ${prefix}_select();        
}

//]]>
</script>
--%>

<syswf:selectOne id="${prefix}_renderer_selector" 
                 mode="menu" value="${column}" property="tableDefinitionId"
                 optionValues="${renderersSelectOneData.values}"
                 optionCaptions="${renderersSelectOneData.labels}"
                 name="rendererSelector">
</syswf:selectOne>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
            Ext.get('${prefix}_renderer_selector').on('change', function() {
                <%--
                var element = Ext.get('${prefix}_renderer_selector');
                
                ${prefix}_handle_selectRenderer(element.getValue());
                --%>
                ${prefix}_select();
            });
    });

    $(document).ready(function(){
        <%-- This function stops events beyond the element
             this selector stops selecting row when changing renderer --%>
    	$('#${prefix}_renderer_selector').bind('click',function(){
    		return false;
    	});
    });

//]]>
</script>
</c:if>