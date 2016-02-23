<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${report}" />    
</syswf:component>

<c:if test="${(not empty reportData) and reportContentType eq 'text/plain'}">
	<syswf:block className="UI Block Common">
		<div class="Content">
			<pre class="HorizontalSrollBar"><syswf:out value="${reportData}" context="HtmlBody"/></pre>
		</div>
	</syswf:block>
</c:if>
