<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />

<c:if test="${not empty chartBean.datas}">
<td width="240">				
<syswf:block className="UI Block Common">
	<div class="Title">
		<h3>
			<fmt:message key="policyreport.overview.compliance.header" bundle="${pr_Messages}" />
		</h3>
	</div>
	<div class="Content">
	    <div id="${prefix}_piechart" style="height:250px">
        </div>
 		<script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
	            setPieChart('${prefix}_piechart', 
	               { 
	            	 data: ${chartBean.datas},
	            	 legend: ${chartBean.labels},
	            	 colors: ${chartBean.colors},
	            	 legendpos: 'south'
	               }
	            );
            });
        
//]]>
</script>
	</div>
</syswf:block>
</td>
</c:if>
