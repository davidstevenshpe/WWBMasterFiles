<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${mode eq 'view'}">
    <a href="mailto:<c:out value="${this.value}" />"><c:out value="${this.value}" /></a>
</c:if>

<c:if test="${mode eq 'edit'}">
    <syswf:input id="${prefix}_emailWidget" name="emailWidget"
            value="${this}" property="value">
            <c:choose>
                <c:when test="${empty error}">
                    <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
                </c:when>
                <c:otherwise>
                    <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
                </c:otherwise>
            </c:choose>
    </syswf:input>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            new Ext.HP.Input({
                applyTo : '<c:out value="${prefix}_emailWidget" />'
            });
        });
    
//]]>
</script>
</c:if>
