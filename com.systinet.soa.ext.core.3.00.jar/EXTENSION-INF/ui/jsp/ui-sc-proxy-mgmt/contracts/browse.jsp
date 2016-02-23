<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="UI Layout">
<tbody>
<tr>
<td class="UI Middle">
<div class="UI PageIdentity ">
<h1>Contract Deployment Status</h1>
<h2>Report</h2>
</div>
</td>
</tr>
<tr>
<td class="UI Middle">
  <div style="font-style:italic;">
   Here you can see all accepted contracts in the repository and see whether are deployed or not. You can manually deploy or undeploy
   a contract by expanding a contract row and clicking the corresponding button.<br/> You can change the contract ID of an contract as well, but
   note that it is possible only for contract that are not deployed.
  </div>
  <br/>
  <br/>
</td>
</tr>


</tbody>
</table>

<syswf:component name="/provision/createProxyWindow" prefix="create" wrap="false"/>


<syswf:component name="/data/js" prefix="js">
  <syswf:param name="sourceId" value="UIHandler"/>
  <syswf:param name="code">
      /* available in createProxyWindow
      function getTaskProgress(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskProgressJSON(task);
      }

      function getTaskResults(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskResult(task);
      }*/

      function undeployContractOnServer(contractUUID)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.ProxySynchronizationStatusHandler.getInstance().undeployContract(contractUUID);
      }

      function deleteProxies(proxiesJSON)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.ProxySynchronizationStatusHandler.getInstance().deleteProxies(proxiesJSON);
      }

      function setContractID(contractUUID,newID)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.ContractPromotionHandler.getInstance().changeContractID(contractUUID,newID);
      }

      function getWSDLsForContract(contractUUID)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.ContractPromotionHandler.getInstance().collectRelevantWSDLs(contractUUID);
      }
  </syswf:param>
</syswf:component>

<div id="reportContainer" style='margin-right:10px'>
</div>


<c:if test="${this.backButtonInvoked}">
  <script>
  //<![CDATA[
    <syswf:component name="/data/windowManagement" prefix="windowMgmt" wrap="false"/>
    <syswf:component name="/data/RowExpander" prefix="expander" wrap="false"/>
    <syswf:component name="/operations/contracts/undeploy" prefix="undeploy" wrap="false"/>
//]]>
</script>
    <syswf:component name="/data/GridFilters" prefix="filters" wrap="false"/>
    <syswf:component name="/operations/contracts/main" prefix="main" wrap="false"/>
</c:if>

<script>
//<![CDATA[
Ext.onReady(function() {
  buildContractView('${domain}');
});

//]]>
</script>

