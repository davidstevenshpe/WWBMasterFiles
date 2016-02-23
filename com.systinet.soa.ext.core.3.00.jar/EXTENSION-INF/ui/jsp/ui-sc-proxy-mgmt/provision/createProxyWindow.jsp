<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<syswf:component name="/data/js" prefix="js" wrap="false">
  <syswf:param name="sourceId" value="UIHandler"/>
  <syswf:param name="code">


      /** get list of available protocols for the device */
      function getFrontendProtocols(device)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.getProtocols(device);
      }

      function getFrontsideHandlers(device, protocol)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.getFrontsideHandlers(device,protocol);
      }

      function suggestProxyName(rootUUID)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.suggestProxyName(rootUUID);
      }

      function getProxyLayout(baseName,device, protocol, frontend, identityManagement, layout, root, endpoints)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.getProxyLayout(baseName, device, protocol, frontend, identityManagement, layout, root, endpoints);
      }

      function validateProxyLayout(baseName,device, protocol, frontend, identityManagement, layout, root, endpoints, changes)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.validateProxyLayout(baseName, device, protocol, frontend, identityManagement, layout, root, endpoints, changes);
      }

      function publishProxyLayout(baseName,device, protocol, frontend, identityManagement, layout, root, endpoints, changes, proxyJSONArray)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.publishProxyLayout(baseName, device, protocol, frontend, identityManagement, layout, root, endpoints, changes, proxyJSONArray);
      }

      function isValidNewProxyName(deviceUUID, name)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.isValidNewProxyName(deviceUUID, name);
      }

      function getEndpointDeploymentAlternativesList(rootUuid,endpoints)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.getEndpointDeploymentAlternativesList(rootUuid,endpoints);
      }

      function performCompleteReuseProxiesForContract(contractUUID,proxyJSONArray)
      {
      var handler=Packages.com.hp.systinet.proxy.mgmt.ui.CreateProxyWizardUIHandler.getInstance();
      return handler.performCompleteReuseProxiesForContract(contractUUID,proxyJSONArray);
      }


      function getTaskProgress(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskProgressJSON(task);
      }

      function getTaskResults(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskResult(task);
      }

  </syswf:param>
</syswf:component>


<script>
//<![CDATA[
  <syswf:component name="/data/windowManagement" prefix="windowMgmt" wrap="false"/>
  <syswf:component name="/provision/checkForExistingProxies" prefix="checkForExistingProxies" wrap="false"/>
  <syswf:component name="/provision/progressMonitor" prefix="progress" wrap="false"/>
  <syswf:component name="/provision/chooseEndpoints" prefix="endpoints" wrap="false"/>
  <syswf:component name="/provision/chooseFrontend" prefix="frontend" wrap="false"/>
  <syswf:component name="/provision/confirmLayout" prefix="confirm" wrap="false"/>

//]]>
</script>
