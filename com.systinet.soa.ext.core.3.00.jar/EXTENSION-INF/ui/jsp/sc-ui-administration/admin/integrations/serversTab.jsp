<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<i><p>
    To connect HP Enterprise Maps to external systems you need to configure an integration connector.
    The connectors limit the scope of the integration to a particular domain and its sub-domains. 
    Integration connectors defined in the top-level domain are global and apply to content of all domains.
    In order to create a new integration connector, start in <syswf:control id="add3" mode="anchor" caption="BROWSE DOMAINS" targetTask="/admin/domain/browse" hint="Browse domains" action="disable"/>, 
    select a domain that will limit the scope of integration, switch to Integrations tab and add the connector.
</p></i>
