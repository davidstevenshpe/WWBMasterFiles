<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:component name="/admin/homepage" prefix="nav"/>
<syswf:component name="/provision/createProxyWindow" prefix="create" wrap="false"/>

<c:if test="${this.backButtonInvoked}">
  <script>
  //<![CDATA[
      afterDeploy=function()
      {
      }

      Ext.onReady(function() { createProxyWindow('${domain}'); });
  
//]]>
</script>
</c:if>