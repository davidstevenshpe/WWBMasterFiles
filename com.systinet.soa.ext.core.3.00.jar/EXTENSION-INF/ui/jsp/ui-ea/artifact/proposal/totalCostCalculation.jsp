<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${not empty globalSession['userName']}">
<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uiMessages"/>

<fmt:message var="internalEffort" key="proposal.total.internalEffort" bundle="${uiMessages}" />
<fmt:message var="externalEffort" key="proposal.total.externalEffort" bundle="${uiMessages}" />
<fmt:message var="cost" key="proposal.total.cost" bundle="${uiMessages}" />
<fmt:message var="na" key="proposal.total.na" bundle="${uiMessages}" />

<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
	
	var proposalScriptLocation = '${proposalScriptLocation}';
	var proposalUuid = '${proposalUuid}';
	var datasource=Ext4.create('EA.model.tools.DataSourceStore', 
			{ 
				dataSource: proposalScriptLocation, 
				pageSize: 1, 
			  	extraParams: {
					proposalUuid: proposalUuid, 
					prerequisite1: '${prerequisite1}',
					prerequisite2: '${prerequisite2}'
				}
			}
	);
	datasource.maskElement = 'proposalCost';
	
    datasource.on('load',
        function(store) {			
			store.data.each(function(i) {
				$('#proposal_internalEffort').text(blankToZero(i.raw.internalEffort));
				$('#proposal_externalEffort').text(blankToZero(i.raw.externalEffort));
				$('#proposal_cost').text(blankToZero(i.raw.cost));
			});
		}
    );
    datasource.load();
    
    function blankToZero(value) {
    	if (value == undefined || value == null || value == '') {
    		return 0;
    	}
    	return value;
    }
});
//]]>
</script>
<br />
<div id="proposalCost">
	<table class="UI Table Properties">
		<tr>
			<th title="${internalEffort}" width="180"><label class="UI Label Inline">${internalEffort}:</label></th>
			<td><span id="proposal_internalEffort" title="${internalEffort}">${na}</span></td>
		</tr>
		<tr>
			<th title="${externalEffort}"><label class="UI Label Inline">${externalEffort}:</label></th>
			<td><span id="proposal_externalEffort" title="${externalEffort}">${na}</span></td>
		</tr>
		<tr>
			<th title="${cost}"><label class="UI Label Inline">${cost}:</label></th>
			<td><span id="proposal_cost" title="${cost}">${na}</span></td>
		</tr>
	</table>
</div>