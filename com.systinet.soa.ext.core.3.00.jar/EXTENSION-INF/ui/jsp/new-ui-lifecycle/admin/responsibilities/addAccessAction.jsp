<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<syswf:control mode="script" action="addActor" caption="${controlName}"   />

<c:if test="${editActorsTableBean.actionName eq 'addRead'}">
	<syswf:component name="/newUi/lc/admin/responsibilities/addReadAccessAction" prefix="addReadAccessAction" />
</c:if>

<c:if test="${editActorsTableBean.actionName eq 'addWrite'}">
	<syswf:component name="/newUi/lc/admin/responsibilities/addWriteAccessAction" prefix="addWriteAccessAction" />
</c:if>
