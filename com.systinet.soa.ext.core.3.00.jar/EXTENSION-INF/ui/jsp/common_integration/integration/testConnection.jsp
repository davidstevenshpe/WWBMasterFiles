<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage"
	var="serverMsg" />
<fmt:message key="edit.link.testConnection" var="testConn"
	bundle="${serverMsg}" />
<fmt:message key="edit.link.testConnection.hint" var="testConnHint"
	bundle="${serverMsg}" />
<c:choose>
	<c:when test="${componentType eq 'PageAction'}">
		<a href="javascript:void(0);" class="${styleClass}" id="${prefix}_test_connectionLink" title="${testConn}"></a>
		<syswf:control mode="script" action="test_connection" caption="${prefix}test_connection" >
		    <syswf:param name="artifact" value="${artifact}" />
		</syswf:control>
		<script type="text/javascript">
            //<![CDATA[
			attachOn('${prefix}_test_connectionLink','click',function() {
				${prefix}test_connection();
			});
            //]]>
		</script>

	</c:when>
	<c:when test="${componentType eq 'PageButton'}">
		<syswf:control mode="button" caption="${testConn}" hint="${testConnHint}" action="test_connection">
			<syswf:param name="artifact" value="${artifact}" />
			<syswf:attribute name="class" value="${styleClass}" />
		</syswf:control> 
	</c:when>
</c:choose>

