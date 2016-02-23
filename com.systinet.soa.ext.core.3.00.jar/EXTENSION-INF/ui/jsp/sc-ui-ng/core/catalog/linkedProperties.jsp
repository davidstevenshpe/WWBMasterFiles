<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<c:forEach var="linkedArtifact" items="${linkedArtifacts}" varStatus="status">
    <syswf:component name="/core/catalog/linkedPropertiesDetail" prefix="${prefix}${status.index}LinkedPropertiesDetailId">
        <syswf:param name="artifact" value="${linkedArtifact}" />
        <syswf:param name="linkedProperties" value="${linkedProperties}" />
        <syswf:param name="mode" value="view" />
    </syswf:component>
</c:forEach>
    

