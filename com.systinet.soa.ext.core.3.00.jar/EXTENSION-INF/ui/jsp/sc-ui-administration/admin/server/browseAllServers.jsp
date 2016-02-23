<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage" var="server_Messages" />
<fmt:message key="server.note.link" bundle="${server_Messages}" var="noteLink"/>
<c:if test="${domainId ne 'topLevelDomain'}">
	<syswf:block className="UI SystemMessage Info">
	    <div class="MessageContainer">
	    	<fmt:message key="server.note" bundle="${server_Messages}" />
	    	<c:if test="${isTopLevelDomainAdministrator}">
				<syswf:control id="domainLink" mode="anchor" caption="${noteLink}" targetTask="/admin/server/browse">
   					<syswf:param name="domainId" value="topLevelDomain"/>
				</syswf:control>	    	
	    		
	    	</c:if>
	    </div>
	</syswf:block>
</c:if>
--%>

<c:forEach  var="server" items="${servers}">
	<syswf:component name="/admin/server/listView" prefix="${server.artifacType}" wrap="false">
	    <syswf:param name="serverListInfo" value="${server}" />
	    <syswf:param name="domainId" value="${domainId}" />
	</syswf:component>
</c:forEach>

 