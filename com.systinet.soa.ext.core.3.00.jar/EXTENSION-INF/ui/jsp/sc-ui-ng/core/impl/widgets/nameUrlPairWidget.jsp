<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${mode eq 'view'}">
	<c:if test="${not empty this.value }">
		 <a href="<syswf:out value="${this.value}" context="HtmlAttributeUrl"/>" ><syswf:out value="${this.value}" context="HtmlBody"/></a>
	</c:if>
</c:if>

<c:if test="${mode eq 'edit'}">
    <syswf:input id="${prefix}_nameUrlPairWidget" name="nameUrlPairWidget" value="${this}" property="value">
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
                applyTo : '<c:out value="${prefix}_nameUrlPairWidget" />'
                <c:if test="${not empty width}">, width: ${width}</c:if>
            });
        });
    
//]]>
</script>
</c:if>