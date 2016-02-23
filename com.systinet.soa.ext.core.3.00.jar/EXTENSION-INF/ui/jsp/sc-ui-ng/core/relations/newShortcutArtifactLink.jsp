<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<syswf:control id="${prefix}newShortcutArtifactLink" mode="script" caption="${prefix}newShortcutArtifactLink" targetTask="/catalog/newShortcutArtifact">
    <syswf:param name="sdmName" value="${shortcutToSdm}"/>
    <syswf:param name="creationListener" value="${shortcutNewArtifactListener}"/>
</syswf:control>

<script type="text/javascript">
//<![CDATA[
	${prefix}newShortcutArtifactLink();
//]]>
</script>