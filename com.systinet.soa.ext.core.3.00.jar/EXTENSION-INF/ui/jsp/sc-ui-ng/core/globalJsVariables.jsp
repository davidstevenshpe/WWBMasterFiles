<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
var SERVER_URI = '<c:out value="${webdataPath}"/>';
var RESOURCES_URI = '<c:out value="${webResourcePath}"/>';
var EM = {
  user: {
    name: '<c:out value="${securityContext.name}"/>',
    roles: [<c:forEach items="${securityContext.roles}" var="role" varStatus="status">'<c:out value="${role}"/>'<c:if test="${!status.last}" >,</c:if></c:forEach>],
    workingDomainId: '<c:out value="${securityContext.workingDomainId}"/>',
    hasRole: function(role){return EM.user.roles.indexOf(role)>=0;}
  },
  currencySymbol: '<c:out value="${uiPreferences.currencySymbol}"/>',
  formatCurrency: function(val,symbol,decimals){
      var s=symbol ? symbol : EM.currencySymbol;
      if (typeof(Ext4) === 'undefined') {
          return (val === null || (typeof(val) === 'undefined')) ? 'N/A' : s==='$' ? (s + val) : (val+s);
      } else {
          return Ext4.util.Format.currency(val, s, decimals,s!=='$');
      }
  },
  SERVER_URI: '<c:out value="${webdataPath}"/>',
  RESOURCES_URI: '<c:out value="${webResourcePath}"/>',
  docBaseUrl: '<c:out value="${sharedDocUrlBase}"/>'
};
//]]>
</script>
