<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- This page is the same as design of artifactDetail
     But we need to reserve separate one page for easier customization
      --%>
<div class="customPropertiesContainer">
    <jsp:include page="../layout/artifactDetail.jsp"/>

    <syswf:control id="gov6" mode="button" caption="View Details & Edit" targetTask="/catalog/viewArtifact">
        <syswf:param name="uuid" value="${artifact._uuid}"/>
    </syswf:control>
</div>

