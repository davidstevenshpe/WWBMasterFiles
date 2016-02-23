<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<syswf:component name="core/catalog/menuItemCatalogRenderer" prefix="browser">
    <syswf:param name="artifacts" value="${artifacts}"/>
    <syswf:param name="hideMoreLink" value="${hideMoreLink}"/>
    <syswf:param name="rendersCustomizeLinks" value="true"/>
    <syswf:param name="artifactLink" value="true"/>
    <syswf:param name="notPolicyAndCustomReportMenu" value="true"/>
</syswf:component>
