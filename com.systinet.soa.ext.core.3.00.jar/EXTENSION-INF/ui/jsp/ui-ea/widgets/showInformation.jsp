<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>
<fmt:message var="label" key="show.more.information" bundle="${uisccomponentsmessages}"/>

<div style="margin: 15px 0 10px 0; display: inline-block;">
	<div class="btn btn-gray btn-labeled em fa fa-info-circle" help-text="less" onclick="return layoutManager.toggleHelpText(this);">
		<span><c:out value="${label}"/></span>
	</div>
</div>