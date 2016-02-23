<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />


<div class="UI Offset">
	<table class="UI Table Layout">
		<tr>
            <td width="30%"><label class="UI Label Inline"><fmt:message key="applicableTo.title" bundle="${tpMessages}"/></label></td>
            <td>            	
            	<a href="javascript:void(0);" class="UI Icon Info" id="explain_destination"></a>       
            	<span class="IconAlign"><label class="UI Label Inline"><syswf:out value="${applicableTo}" context="HtmlBody"/></label></span>     	 
            </td>                                        
        </tr>
	</table>
</div>

<!-- DROPDOWN MENU -->
<div class="x-hidden flyout-menu UI Dropdown" id="explain_destination_content">
	<div class="DropdownContent">
		<p class="Comment" style="padding:3px;" ><fmt:message key="applicableTo.explanation" bundle="${tpMessages}"/></p>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
		Dropdown.init('explain_destination', 'explain_destination_content',{
			align: 'tl-tr', forceRefresh:true, alignOffset:[0,4]
		});
	});	

//]]>
</script>