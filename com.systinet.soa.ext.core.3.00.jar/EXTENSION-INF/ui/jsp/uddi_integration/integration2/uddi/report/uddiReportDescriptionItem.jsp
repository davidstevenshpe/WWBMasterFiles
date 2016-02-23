<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%--
Display description in table, not allow html tag.
 --%>
<div class="UI Text Description">
    <syswf:out context="HtmlBody" value="${description}"/>
</div> 