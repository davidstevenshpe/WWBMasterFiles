<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<i>
  <p>
  Each integration connector requires a mapping configuration that correlates the data from the external data source with the artifacts of HP Enterprise Maps.
  All mapping configurations are managed in system configuration of the top-level domain as properties starting with <code>platform.sync.mapping</code>.
  You can change or create mapping configurations in <syswf:control id="add3" mode="anchor" caption="CONFIGURATION PROPERTIES" targetTask="/admin/configuration/homepage" hint="Configure the system" action="disable"><syswf:param name="tabId" value="systemSettings"/></syswf:control>.
  </p>
</i>
