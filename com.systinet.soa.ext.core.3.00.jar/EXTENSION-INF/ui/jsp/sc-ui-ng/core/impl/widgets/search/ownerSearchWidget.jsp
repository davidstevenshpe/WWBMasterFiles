<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<syswf:component name="/core/principal/selector" prefix="${id}PrincipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}Open" />
    <syswf:param name="windowTitle">
        <fmt:message bundle="${messages}" key="changeOwner.selectUser" />
    </syswf:param>
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="selectorWidth" value="570" />
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}" />
    <syswf:param name="allowBlockedAccounts">true</syswf:param>
    
</syswf:component>

<c:forEach items="${this.webConditions}" var="condition" varStatus="status">
        <c:set var="inputId" value="${prefix}OwnerWidget${status.index}" />
        
        <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects=".">
            <syswf:param name="condition" value="${condition}" />
        </syswf:control>  
        
       	<c:choose>
       		<c:when test="${condition.type eq 'USER'}">
       			<c:set var="cssIcon" value="UI Icon Contact Small" />
       			<fmt:message bundle="${labels}" var="title" key="principalSelector.user"/>
       		</c:when>
       		<c:when test="${condition.type eq 'ROLE'}">
       			<c:set var="cssIcon" value="UI Icon Role" />
       			<fmt:message bundle="${labels}" var="title" key="principalSelector.role"/>
       		</c:when>
       		<c:when test="${condition.type eq 'GROUP'}">
       			<c:set var="cssIcon" value="UI Icon OrganizationUnit" />
       			<fmt:message bundle="${labels}" var="title" key="principalSelector.group"/>
       		</c:when>
       		<c:otherwise>
       			<c:set var="cssIcon" value="IconAlign" />
       			<c:set var="title" value="" />
       		</c:otherwise>
      	</c:choose>
        
        <c:set var="content">
            <span class="${cssIcon}" title="${title}">
                <c:choose>
                    <c:when test="${empty condition.value}">
                    </c:when>
                    <c:when test="${empty condition.url}">
                        ${condition.name}
                    </c:when>
                    <c:otherwise>
                         <syswf:control mode="anchor" caption="${condition.name}" targetTask="${condition.url}">
                            <c:forEach items="${condition.params}" varStatus="status2">
                                <syswf:param name="${status2.current.key}" value="${status2.current.value}" />
                            </c:forEach>
                         </syswf:control>
                    </c:otherwise>
                </c:choose>
                &nbsp;(  
                <a href="javascript:void(0);" id="${inputId}Change"><span><fmt:message bundle="${labels}" key="Change" /></span></a>
                )
             </span>
         </c:set>
         
         <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
            <syswf:param name="content" value="${content}"/>
            <syswf:param name="visible" value="${visible}"/>
            <syswf:param name="webCondition" value="${condition}"/>
            <syswf:param name="status" value="${status}"/>
            <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
            <syswf:param name="removeFce" value="${prefix}remove${status.index}" />
        </syswf:component>
           
        <syswf:control mode="script" id="${inputId}Open" caption="${inputId}Open" action="openPrincipalSelector" affects=".">
            <syswf:param name="selectedCondition" value="${status.index}" />
        </syswf:control>
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function(){
                attachOn('${inputId}Change','click',function() {
                	${inputId}Open();
               })
            });
        
//]]>
</script>
    
    
</c:forEach>

<c:if test="${openSelector}" >
    <script type="text/javascript">
//<![CDATA[

        ${prefix}Open();
    
//]]>
</script>
</c:if>


    
