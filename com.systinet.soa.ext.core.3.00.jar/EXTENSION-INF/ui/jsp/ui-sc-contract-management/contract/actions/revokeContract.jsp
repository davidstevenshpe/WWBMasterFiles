<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="messages" />


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

        function undeployContractOnServer(contractUUID)
        {
        return Packages.com.hp.systinet.proxy.mgmt.ui.ProxySynchronizationStatusHandler.getInstance().undeployContract(contractUUID);
        }

        function deleteProxies(proxiesJSON)
        {
        return Packages.com.hp.systinet.proxy.mgmt.ui.ProxySynchronizationStatusHandler.getInstance().deleteProxies(proxiesJSON);
        }
    </syswf:param>
</syswf:component>

<script>
    //<![CDATA[
    function afterDeploy()
    {
        window.location.reload();
    }
    function afterUndeployAndProxyRemoval()
    {
        window.location.reload();
    }
    function afterUndeploy()
    {
        window.location.reload();
    }

    <syswf:component name="/operations/contracts/undeploy" prefix="undeploy" wrap="false"/>
    <syswf:component name="/provision/progressMonitor" prefix="progress" wrap="false"/>

    //]]>
</script>
<c:choose>
    <c:when test="${model.deployed and model.hasWritePermissions}">
        <a id="RevokeArtifact" href="javascript:undeployContract('${artifact._uuid}','<syswf:out value='${artifact.name}' context='HtmlJSText'/>');" class="UI PageAction Revoke">
            <span>Undeploy</span></a>
    </c:when>
    <c:otherwise>
        <%--
       <c:if test="${not model.deployed}">
          <a id="RevokeArtifact" href="javascript:${prefix}openRevokeDialog();" class="UI PageAction Revoke">
           <span><syswf:out value="${action}" context="HtmlBody"/></span></a>
       </c:if> --%>
    </c:otherwise>
</c:choose>
