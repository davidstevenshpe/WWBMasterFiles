<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<syswf:component prefix="${prefix}_deleteArtifact"
	name="/core/contextActions/deleteArtifact">
	<syswf:param name="artifact" value="${artifact}" />
	<syswf:param name="includeSubArtifacts" value="false" />
	<syswf:param name="disableAdvancedOptions" value="true" />
</syswf:component>
