<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<syswf:component name="/core/table" prefix="Projects">
   <syswf:param name="customizationId" value="shared.project.projects"/>
   <syswf:param name="datasource" value="${dataSource}"/>
   <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:component>