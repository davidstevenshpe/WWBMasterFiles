<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="UI Table Properties">
    <colgroup><col class="LabelCol">
        <col>
    </colgroup>
    <tr id="location">
        <th><label class="UI Label Inline" title="url"> GET URL:</label>
        </th>
        <td>
<span class="IconAlign"><div id="geturl" class="AJAXContainer">
    <a href="${webContext}/query?dataSource=${this.location}">${webContext}/query?dataSource=${this.location}</a>
</div></span>
        </td>
    </tr>
</table>