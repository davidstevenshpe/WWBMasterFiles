<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table>
  <tr>
    <td style="width: 400px">
        <syswf:component name="/integration/ui/common/pieChartComponent" prefix="pieChart1">
            <syswf:param name="sectors" value="${pieChartSectors1}" />
            <syswf:param name="title" value="Sample Chart 1" />
            <syswf:param name="height" value="200" />
        </syswf:component>    
    </td>
    <td style="width: 400px">
        <syswf:component name="/integration/ui/common/pieChartComponent" prefix="pieChart2">
            <syswf:param name="sectors" value="${pieChartSectors2}" />
            <syswf:param name="title" value="Sample Chart 2" />
            <syswf:param name="height" value="200" />
        </syswf:component>
    </td>
  </tr>
</table>
