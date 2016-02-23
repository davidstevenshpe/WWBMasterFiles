<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${mode eq 'view' || mode eq 'table'}">
    <c:out value="${this.value}" />
</c:if>

<c:if test="${mode eq 'edit'}">
	
	<c:if test="${autocomplete eq 'off'}">
		<%-- solution to disable autocomplete --%>
		<input style="display:none;" type="text" autocomplete="off"/>
	</c:if>
    
    <syswf:input id="${prefix}_textWidget" name="textWidget" 
            value="${this}" property="value">
            <c:if test="${!empty autocomplete}">
                <syswf:attribute name="autocomplete" value="${autocomplete}"/>
            </c:if>
            <c:if test="${this.autoNaming}">					
				<syswf:attribute name="readonly" value="readonly"/>
				<syswf:attribute name="style" value="color: grey; background-color: #F0F0F0;"/>				
			</c:if>
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
        var nameButton;
        Ext.onReady(function() {
        	<c:choose>
			<c:when test="${this.autoNaming}">
				   nameButton = new Ext.HP.Input({
						applyTo : '<c:out value="${prefix}_textWidget" />'
					});		
			</c:when>
			<c:otherwise>
				  new Ext.HP.Input({
						applyTo : '<c:out value="${prefix}_textWidget" />'
					});	
			</c:otherwise>
		</c:choose>
        });
//]]>
</script>
</c:if>