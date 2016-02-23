<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${mode eq 'view' || mode eq 'table'}">
    <c:out value="${this.encryptedPassword.uiPassword}" />
</c:if>

<c:if test="${mode eq 'edit'}">

	<%-- always disable browsers auto-fill password --%>
	<input style="display:none;" type="password" autocomplete="off"/>

    <syswf:input id="${prefix}_password" name="${prefix}_plainTextPassword" 
        value="${this.encryptedPassword}" property="uiPassword" mode="password">
        <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
        <syswf:attribute name="autocomplete" value="off"/>
    </syswf:input>       
    
    <script type="text/javascript">    
//<![CDATA[

        Ext.onReady(function() {
            new Ext.HP.Input({
                applyTo : '<c:out value="${prefix}_password" />'
            });
        });
        
//]]>
    </script>
</c:if>