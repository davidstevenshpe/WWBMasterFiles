<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="UI Layout">
<tbody>
<tr>
<td class="UI Middle">
<div class="UI PageIdentity ">
<h1>Automatic Contract Deployment Failure Reports</h1>
<h2>Report</h2>
</div>

<tr>
<td class="UI Middle">
  <div style="font-style:italic;">
   Here you can see reports of failed contract deployments / undeployments. You will need to resolve the issue manually,
   most probably using manual deployment/undeployment.<br/> To get the information from the report use the plus sign to expand it.
   Reports have one month expiration time by default and are automatically deleted then.
  </div>
  <br/>
</td>
</tr>

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

      function failureReport()
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.FailureReportHandler.getInstance().loadReports();
      }

      function deleteReports(policiesJSON)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.FailureReportHandler.getInstance().deleteReports(policiesJSON);
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
//]]>
</script>
    <syswf:component name="/operations/failure-report/main" prefix="main" wrap="false"/>

</c:if>
