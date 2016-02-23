<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<c:if test="${column.editableLabel}">
    <a id="${prefix}_editAction" href="javascript: void(0);" class="UI PageAction Edit" title="<fmt:message key="editAction.hint" bundle="${bundle}"/>">&nbsp;</a>
    
    <script type="text/javascript">
//<![CDATA[

    $(document).ready(function(){
    
    <%-- Turn into editable field on doubleclick --%>
        $('#${prefix}_editAction').bind('click',function(){
            <%--
            //$('#${containerId} .EditableLabelStatic').removeClass('x-hidden');
            //$('#${containerId} .EditableLabel').addClass('x-hidden');
        	
            //$('#${containerId} .EditableLabel .Active').blur();
            
            jQuery("#${containerId} .EditableLabel").each(function(i, value){
            	var id1 = $(this).attr('id');
            	var id2 = $('#${parentPrefix}_editableLabel_input').attr('id');
            	
            	if (id1 != id2  &&  $(this).hasClass('Active')) {
            		$(this).change();
            		//$(this).blur();
            	}
            });
            --%>
            $('#${parentPrefix}_tabEditableLabel1_input').removeClass('x-hidden');
            $('#${parentPrefix}_tabEditableLabel1_input').removeAttr('readonly');
            $('#${parentPrefix}_tabEditableLabel1_input').addClass('Active');
            $('#${parentPrefix}_tabEditableLabel1_input').focus();
            
            $('#${parentPrefix}_tabEditableLabel1_label').addClass('x-hidden');
            
            $('#${parentPrefix}_tabEditableLabel2_input').removeClass('x-hidden');
            $('#${parentPrefix}_tabEditableLabel2_input').removeAttr('readonly');
            $('#${parentPrefix}_tabEditableLabel2_input').addClass('Active');
            $('#${parentPrefix}_tabEditableLabel2_input').focus();
            
            $('#${parentPrefix}_tabEditableLabel2_label').addClass('x-hidden');
            
            
            return false; <%-- this prevents from selecting row when clicking on them --%>
        });
        
    });
    
//]]>
</script>
</c:if>
<c:if test="${not column.editableLabel}">
    &nbsp;
</c:if>
