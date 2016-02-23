<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<div class="flex-container">
	<div class="UI Middle">
	<syswf:component name="/core/table" prefix="historyTable">
	    <syswf:param name="customizationId" value="shared.history.historyTable" />
	    <syswf:param name="artifact" value="${artifact}" />
	    <syswf:param name="selectionBag" value="${selectionBag}" />
	</syswf:component>
	</div>
</div>