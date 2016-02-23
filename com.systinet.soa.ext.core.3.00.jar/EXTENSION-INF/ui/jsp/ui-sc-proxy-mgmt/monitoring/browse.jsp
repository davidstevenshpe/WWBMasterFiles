<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<div id="pagetitle" class="gradient">
					<div class="UI PageIdentity ">
						<h1>Runtime contract SLO monitoring report</h1>
						<h2>Report</h2>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="UI Middle">
				<div style="font-style: italic; margin: 10px 0 0 10px;">
					Here you can see all contracts grouped by the consumed service;
					you can check service load distribution between different contracts
					on a single service (provider) by clicking 'Analyze..' on the group
					header. <br /> You can also monitor how the contract activity
					evolves in time by expanding the corresponding row of the table. <br />
					You need to configure the service performance monitoring before you
					can see meaningful data here.
				</div> <br /> <br />
			</td>
		</tr>
	</tbody>
</table>


<syswf:component name="/data/js" prefix="js">
	<syswf:param name="sourceId" value="UIHandler" />
	<syswf:param name="code">
     function getContractGraph(contractUUID)
     {
        return Packages.com.hp.systinet.proxy.mgmt.ui.MonitoringHandler.getInstance().getContractGraph(contractUUID);
     }

     function getProviderPie(providerUUID,since)
     {
        return Packages.com.hp.systinet.proxy.mgmt.ui.MonitoringHandler.getInstance().getProviderPie(providerUUID,since);
     }
  </syswf:param>
</syswf:component>

<div id="reportContainer" style='margin-right: 10px; margin-left: 10px'>
</div>

<c:if test="${this.backButtonInvoked}">
	<script>
  //<![CDATA[
		<syswf:component name="/data/windowManagement" prefix="windowMgmt" wrap="false"/>
		<syswf:component name="/data/RowExpander" prefix="expander" wrap="false"/>
		<syswf:component name="/operations/monitoring/main" prefix="main" wrap="false"/>

//]]>
	</script>
</c:if>


