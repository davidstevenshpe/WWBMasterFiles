<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="clearProviderLinkLabel" key="clearProviderLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="changeProviderLinkLabel" key="changeProviderLinkLabel" bundle="${contactmessages}"/>

<%-- Default using providerArtifactTypesFilter for filtering in suggest search provider, If empty then using availableArtifactTypes --%>
<c:choose>
	<c:when test="${not empty providerArtifactTypesFilter}">
		<c:set var="artifactTypesFilter" value="${providerArtifactTypesFilter}"/>
	</c:when>
	<c:otherwise>
		<c:set var="artifactTypesFilter" value="${availableArtifactTypes}"/>
	</c:otherwise>
</c:choose>

<syswf:component name="/core/selector/providerSelector" prefix="${id}ProviderSelector">
    <syswf:param name="openFceName" value="${prefix}Open" />
    <syswf:param name="providerSelectorListener" value="${providerSelectorListener}" />
    <syswf:param name="affectsOnSelection" value="${prefix}"/>
    <syswf:param name="allowCreation" value="${false}"/>
    <syswf:param name="availableArtifactTypes" value="${artifactTypesFilter}"/>
</syswf:component>

<c:forEach items="${this.webConditions}" var="condition" varStatus="status">
        <c:set var="inputId" value="${prefix}OwnerWidget${status.index}" />
        
        <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects=".">
            <syswf:param name="condition" value="${condition}" />
        </syswf:control> 
       
        <c:set var="selectedCondition" value="${status.index}" />

        <c:set var="content">
            <span class="IconAlign">
                <c:choose>
                    <c:when test="${empty condition.url}">
                        ${condition.name}
                    </c:when>
                    <c:otherwise>
                         <syswf:control id="${inputId}Link" mode="anchor" caption="${condition.name}" targetTask="${condition.url}" >
                            <syswf:attribute name="class" value="UI Icon ${condition.iconCss}" />
                            <c:forEach items="${condition.params}" varStatus="status2">
                                <syswf:param name="${status2.current.key}" value="${status2.current.value}" />
                            </c:forEach>
                         </syswf:control>
                    </c:otherwise>
                </c:choose>
                &nbsp;(                
                <a href="javascript:void(0);" id="${inputId}Change"><c:out value="${changeProviderLinkLabel}" /></a>
                <c:if test="${not empty condition.uuid}" >
                    ,&nbsp;
                    <a href="javascript:void(0)"  id="${inputId}ClearProvider">
                        <span>
                            <c:out value="${clearProviderLinkLabel}" />
                        </span>
                    </a>
                    
                    <syswf:control mode="script" id="${inputId}Cl" caption="${inputId}Cl" action="clear" affects="." >
                        <syswf:param name="index" value="${status.index}" />
                    </syswf:control>
                    
                    <script type="text/javascript">
//<![CDATA[

                        Ext.get('${inputId}ClearProvider').on('click', function() {
                            ${inputId}Cl();
                        });
                    
//]]>
</script>
                    
                </c:if>
                )
             </span>
         </c:set>
         
         <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
            <syswf:param name="content" value="${content}"/>
            <syswf:param name="visible" value="${visible}"/>
            <syswf:param name="webCondition" value="${condition}"/>
            <syswf:param name="status" value="${status}"/>
            <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
            <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
        </syswf:component>
    
     
    
        <syswf:control mode="script" id="${inputId}Open" caption="${inputId}Open" action="openPrincipalSelector" affects=".">
            <syswf:param name="selectedCondition" value="${selectedCondition}" />
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

        Ext.onReady(function(){
            ${prefix}Open();
        });
    
//]]>
</script>
</c:if>


    
