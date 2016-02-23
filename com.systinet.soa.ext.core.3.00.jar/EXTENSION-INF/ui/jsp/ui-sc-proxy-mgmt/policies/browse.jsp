<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="UI Layout">
<tbody>
<tr>
<td class="UI Middle">
<div class="UI PageIdentity ">
<h1>Runtime Policy Synchronization Status</h1>
<h2>Report</h2>
</div>
</td>
</tr>
<tr>
<td class="UI Middle">
  <div style="font-style:italic;">
   Here you can see all runtime policies known to Systinet, those that are registered in the repository and those that are available on the device as well.<br/><br/>
   Legend:<br/><br/>
   <table>
        <tr><td><span style="color:red">UNSYNCHRONIZED&nbsp;&nbsp;</span></td><td>Policy has been found on the device but it is not known to the repository.</td></tr>
        <tr><td><span style="color:green">SYNCHRONIZED</span></td><td>Policy has been imported into the repository and it contents is the same as on the device.</td></tr>
        <tr><td><span style="color:darkgray">CHANGED</span></td><td>Policy has been imported into the repository but it's contents is different than on the device.</td></tr>
        <tr><td><span style="color:darkgray">OBSOLETE</span></td><td>Policy has been imported into the repository but it can't be found on any device.</td></tr>
   </table>
<br/>
   You can delete individual policies but only the repository representation is removed. The policy on the device remains untouched.

  </div>
  <br/>
  <br/>
</td>
</tr>
</tbody>
</table>



<syswf:component name="/data/js" prefix="js">
  <syswf:param name="sourceId" value="UIHandler"/>
  <syswf:param name="code">

      function getTaskProgress(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskProgressJSON(task);
      }

      function getTaskResults(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskResult(task);
      }

      function policyReport()
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.PolicyManagementHandler.getInstance().policyReport();
      }

      function synchronizePolicies(policiesJSON)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.PolicyManagementHandler.getInstance().synchronizePolicies(policiesJSON);
      }

      function deletePolicies(policiesJSON)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.PolicyManagementHandler.getInstance().deletePoliciesFromRepository(policiesJSON);
      }

      function getPolicyDepencies(deviceUUID,guid,version)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.PolicyManagementHandler.getInstance().getPolicyDepencies(deviceUUID,guid,version);
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
    <syswf:component name="/provision/progressMonitor" prefix="progress" wrap="false"/>
    <syswf:component name="/operations/policies/main" prefix="main" wrap="false"/>
  
//]]>
</script>
</c:if>
