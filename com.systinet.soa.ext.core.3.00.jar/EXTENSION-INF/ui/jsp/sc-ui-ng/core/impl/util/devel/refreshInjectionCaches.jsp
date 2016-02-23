<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<tr>
    <th class="UI Label Inline">Injection Caches:</th>
    <td><syswf:control mode="button" action="refresh.injectionCaches" caption="Refresh"
        targetComponent="${prefix}"
    /></td>
</tr>
