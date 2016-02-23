<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="groups_Messages" />
<fmt:message var="memberCaption" key="createGroup.memberCaption" bundle="${groups_Messages}" />


<syswf:block className="UI Block Common">			
	<syswf:component name="/core/table" prefix="groupMembersEdit" wrap="false">
	    <syswf:param name="customizationId" value="admin.group.groupEditTable" />
	    <syswf:param name="title" value="${memberCaption}"/>
	    <syswf:param name="wrapCaption" value="${memberCaption}"/>
	    <syswf:param name="datasource" value="${groupMembersDataSource}"/>
	    <syswf:param name="addMemberHolder" value="${addMemberHolder}"/> 
	    <syswf:param name="groupInfo" value="${groupInfo}"/>
	    <syswf:param name="kind" value="browse" />
	</syswf:component>					 
</syswf:block>
