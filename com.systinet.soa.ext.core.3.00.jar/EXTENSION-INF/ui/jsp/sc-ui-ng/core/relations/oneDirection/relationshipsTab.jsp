<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<fmt:message bundle="${relationshipmessages}" key="Outgoing" var="outgoingLabel" />
<fmt:message bundle="${relationshipmessages}" key="Incoming" var="incomingLabel" />
<div class="flex-container">
	<div class="UI Middle">
    <syswf:block className="UI Block Common">     
        <div class="Title">
            <h3><span>${outgoingLabel}</span></h3>
        </div>        
        <div class="Content">
            <syswf:component name="/core/relations/genericRelationshipComponent" prefix="outgoing.table">
                <syswf:param name="tableDefinitionId">shared.properties._outgoingRelationships.predefined</syswf:param>
                <syswf:param name="relation" value="_outgoingRelationships" />
                <syswf:param name="artifact" value="${artifact}" />
            </syswf:component> 
        </div>
    </syswf:block>
    
    
    <syswf:block className="UI Block Common">     
        <div class="Title">
            <h3><span>${incomingLabel}</span></h3>
        </div>        
        <div class="Content">
            <syswf:component name="/core/relations/genericRelationshipComponent" prefix="incoming.table">
                <syswf:param name="tableDefinitionId">shared.properties._incomingRelationships.predefined</syswf:param>
                <syswf:param name="relation" value="_incomingRelationships" />
                <syswf:param name="artifact" value="${artifact}" />
            </syswf:component> 
        </div>
    </syswf:block>
    </div>
</div>