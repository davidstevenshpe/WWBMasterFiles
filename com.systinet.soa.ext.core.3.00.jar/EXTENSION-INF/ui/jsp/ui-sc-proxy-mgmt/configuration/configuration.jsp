<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="configurationContent">
</div>
<style>
.osb-template {
padding-left:7px;
} 
</style>
<syswf:component name="/operations/configuration/osbtemplate/upload" prefix="uploadZipTemplate" wrap="false">
	<syswf:param name="type" value="file"/>
	<syswf:param name="dialog_title" value="Import OSB template zip file to system configuration"/>
	<syswf:param name="controlName" value="osbUploadShow"/>	
	<syswf:param name="domain" value="${domainId}"/>	
</syswf:component>
<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="configuration"/>
  <syswf:param name="code">
     function getConfiguration(domain)
     {
        return Packages.com.hp.systinet.proxy.mgmt.impl.ProxyManagementConfiguration.getInstance().toJSON(domain);
     }

     function updateConfiguration(configuration)
     {
        return Packages.com.hp.systinet.proxy.mgmt.impl.ProxyManagementConfiguration.getInstance().update(configuration);
     }
  </syswf:param>
</syswf:component>
<%--
<c:if test="${this.backButtonInvoked}">
</c:if>
--%>
<script>
    <syswf:component name="/data/windowManagement" prefix="windowMgmt" wrap="false"/>
    <syswf:component name="/operations/configuration/main" prefix="main" wrap="false"/>
</script>
