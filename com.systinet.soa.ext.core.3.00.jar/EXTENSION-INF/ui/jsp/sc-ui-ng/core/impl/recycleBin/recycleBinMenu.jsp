<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:message bundle="${messages}" key="recycleBin.menu" var="rbCaption"/>
<li id="recyclebinItemId" class="systinet-horizontal-menu-recyclebin">
	<syswf:control mode="anchor" caption="${rbCaption}" hint="Recycle Bin (${deletedItemCount})" targetTask="/common/recycleBin" targetDepth="0"/>
</li>