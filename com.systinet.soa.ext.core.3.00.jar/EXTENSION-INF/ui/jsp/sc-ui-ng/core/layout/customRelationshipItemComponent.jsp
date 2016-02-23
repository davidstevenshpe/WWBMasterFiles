<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="relationshipTypeLinkNew" bundle="${relationshipmessages}" key="relationship.type.link.new"/>
<fmt:message var="relationshipTypeLinkExisting" bundle="${relationshipmessages}" key="relationship.type.link.existing"/>
<fmt:message var="tableView" bundle="${relationshipmessages}" key="table.view.text"/>

<c:forEach var="relationship" items="${hiddenRelationships}">
    <syswf:component name="/core/layout/relationshipItemComponent" prefix="${relationship}ItemComponent" >
       <syswf:param name="relationshipName" value="${relationship}"/>
       <syswf:param name="artifact" value="${artifact}" />
       <syswf:param name="customRelationship" value="false" />
    </syswf:component>
</c:forEach>
<c:forEach var="relationship" items="${customRelationships}">
    <syswf:component name="/core/layout/relationshipItemComponent" prefix="${relationship}ItemComponent" >
       <syswf:param name="relationshipName" value="${relationship}"/>
       <syswf:param name="artifact" value="${artifact}" />
       <syswf:param name="customRelationship" value="true" />
    </syswf:component>
</c:forEach>