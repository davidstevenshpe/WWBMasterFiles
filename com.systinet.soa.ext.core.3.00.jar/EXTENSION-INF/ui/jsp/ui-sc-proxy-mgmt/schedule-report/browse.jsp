<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:component name="/admin/homepage" prefix="nav"/>


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

      function validationReport()
      {
      return Packages.com.hp.systinet.proxy.mgmt.reports.proxies.ProxyValidationReportHandler.getInstance().loadReports();
      }

      function deleteReports(policiesJSON)
      {
      return Packages.com.hp.systinet.proxy.mgmt.reports.proxies.ProxyValidationReportHandler.getInstance().deleteReports(policiesJSON);
      }
  </syswf:param>
</syswf:component>



<c:if test="${this.backButtonInvoked}">
  <script>
  //<![CDATA[
    <syswf:component name="/data/windowManagement" prefix="windowMgmt" wrap="false"/>
    <syswf:component name="/data/RowExpander" prefix="expander" wrap="false"/>
    <syswf:component name="/provision/progressMonitor" prefix="progress" wrap="false"/>
    <syswf:component name="/operations/schedule-report/main" prefix="main" wrap="false"/>
  
//]]>
</script>
</c:if>
