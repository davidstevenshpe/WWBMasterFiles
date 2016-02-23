<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.integration.ui.bac.BacIntegrationUiL10n" var="bundle"/>

<table class="UI Table Properties">
  <col style="width:120px" />
  <col />
  <tbody>
  <tr>
    <td>
        <label class="UI Label Inline"><fmt:message key="bac.integration.detail.server" bundle="${bundle}" />:</label>
    </td>
    <td>
        <syswf:control mode="anchor" caption="${bacIntegrationSectionBean.serverName}" targetTask="/admin/server/view" >
            <syswf:param name="serverUUID" value="${bacIntegrationSectionBean.serverUuid}" />
        </syswf:control>
    </td>
 </tr>
 <tr>
    <td>
        <label class="UI Label Inline"><fmt:message key="bac.integration.detail.lastSynchronizedAt" bundle="${bundle}" />:</label>
    </td>
    <td>
        <fmt:formatDate type="both" value="${bacIntegrationSectionBean.lastSynchronized}" />
    </td>
  </tr>
  
  <c:forEach items="${bacIntegrationSectionBean.integrationProperties}" var="pair">
     <tr>
        <td>
            <label class="UI Label Inline"><syswf:out value="${pair.name}" context="HtmlBody"/>:</label>
        </td>
        <td>
            <syswf:out value="${pair.val}" context="HtmlBody"/>
        </td>
     </tr>  
  </c:forEach>

  </tbody>
</table>
