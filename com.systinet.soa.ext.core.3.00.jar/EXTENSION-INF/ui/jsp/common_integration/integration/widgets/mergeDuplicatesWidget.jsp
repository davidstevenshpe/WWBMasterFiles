<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/integration/ucmdbImport/mergeDuplicates" prefix="mergeDuplicates">
    <syswf:param name="uuid" value="${artifactUuid}" />
    <syswf:param name="matchingStatus" value="${matchingStatus}" />    
</syswf:component>
