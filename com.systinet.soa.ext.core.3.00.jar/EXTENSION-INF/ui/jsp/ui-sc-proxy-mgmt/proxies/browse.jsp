<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="UI Layout">
<tbody>
<tr>
<td class="UI Middle">
<div class="UI PageIdentity ">
<h1>Proxy Synchronization Status</h1>
<h2>Report</h2>
</div>
</td>
</tr>
<tr>
<td class="UI Middle">
  <div style="font-style:italic;">
   Here you can see all proxies known to Systinet, those that are registered in the repository and those that are available on the device as well.<br/>
   Those that are available in the repository and a matching proxy is found on the device are marked as <span style="color:green">SYNCHRONIZED</span> otherwise
   their status in <span style="color:red">UNSYNCHRONIZED</span>.<br/> Expand the row with the proxy to get more information about the problem.
   You can generate this report regularly also by scheduling a task so you don't need to wait while the report is generated.
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

      function listProxies()
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.ProxySynchronizationStatusHandler.getInstance().listProxies();
      }

      function deleteProxies(proxiesJSON)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.ProxySynchronizationStatusHandler.getInstance().deleteProxies(proxiesJSON);
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
    <syswf:component name="/operations/proxies/main" prefix="main" wrap="false"/>

    Ext.onReady(function() {
      listProxies(dataLoadedHandler);
    });

  
//]]>
</script>
</c:if>

