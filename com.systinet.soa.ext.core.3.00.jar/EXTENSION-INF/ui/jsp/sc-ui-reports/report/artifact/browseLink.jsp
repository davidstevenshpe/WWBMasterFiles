<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${addRuler eq 'yes'}">
	<hr />
</c:if>

<div class="UI Text Links">
<syswf:control id="browse.artifact.report" caption="${label}" mode="anchor" targetTask="/reports/artifact/browseArtifactReport" targetDepth="0">
	<syswf:param name="customizationModeSwitch">true</syswf:param>
</syswf:control>    
</div>

