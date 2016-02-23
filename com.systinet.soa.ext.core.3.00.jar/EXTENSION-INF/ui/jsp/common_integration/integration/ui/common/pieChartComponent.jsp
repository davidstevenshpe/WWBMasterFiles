<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
Params:
title - title of the chart
sectors - sectors of the chart (List<PieChartSector>)
width - width of the chart in px
height - height of the chart in px

--%>

<h4 class="Subheader">${title}</h4>

<c:if test="${not empty data}">
    <c:if test="${width ne null}">
        <c:set var="widthStyle" value="width: ${width}px;"></c:set>
    </c:if>
    
    <div id="${prefix}pieDiv" style="height: ${height}px; ${widthStyle}">
    </div>
    
    <script type="text/javascript">
//<![CDATA[

        $(document).ready(function() { 
            setPieChart('${prefix}pieDiv', {
                animate: false,
                data: [${data}],
                legend: [${legend}],
                legendpos: 'east', 
                colors: [${colors}]
            });
        });
        //]]>
    </script>
</c:if>