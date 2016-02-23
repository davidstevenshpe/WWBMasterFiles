<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
Display description in table, allow html tag.
Restriction to use in publishing and UDDI import report with safe javascript links.
 --%>
<div class="UI Text Description">
    <c:out value="${description}" escapeXml="false"/>
</div> 