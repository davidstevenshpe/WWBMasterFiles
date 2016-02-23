<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<table class="UI Table Properties">
    <col class="MidLabelCol">
    <col>
    <tbody>
        <tr>
            <td>
                <select size="10" id="${prefix}selectDomain_selectedDomain" name="selectDomain_selectedDomain" class="UI Form Select Primary Full">
                    <c:forEach items="${domains}" var="domain">
                        <c:choose>
                            <c:when test="${(not empty selectedDomain) and (domain.domainId eq selectedDomain.domainId)}">
                                <option selected id="selectDomain_selectedDomain_${domain.domainId}" value="${domain.domainId}"><syswf:out value="${domain.name}" context="HtmlBody"/></option>
                            </c:when>
                            <c:otherwise>
                                <option id="selectDomain_selectedDomain_${domain.domainId}" value="${domain.domainId}"><syswf:out value="${domain.name}" context="HtmlBody"/></option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </td>
            <td>
                <div id="selectDomain_info">
                    <h4>Description:</h4>
                    <div class="UI Text Description" style="color:black;"><syswf:out value="${selectedDomain.description}" context="HtmlBody"/></div>
                </div>
            </td>
        </tr>
    </tbody>
</table>

<syswf:control mode="ajax" action="changeDomain" caption="${prefix}changeDomain" />

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    var domainSelect = Ext.get("${prefix}selectDomain_selectedDomain");
    domainSelect.on('change',function(){
        ${prefix}changeDomain();
    });
});

//]]>
</script>