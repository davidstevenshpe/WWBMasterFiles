<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>
<fmt:message var="searchButtonLabel" key="searchButtonLabel" bundle="${searchmessages}"/>
<fmt:message var="searchButtonTitle" key="searchButtonTitle" bundle="${searchmessages}"/>
<fmt:message var="clearButtonLabel" key="clearButtonLabel" bundle="${searchmessages}"/>

<fmt:message var="emptyText" key="headerSearch.emptyText" bundle="${searchmessages}"/>

<div id="${prefix}_myCustomId">		
                   	<syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch">
		         		 <syswf:param name="customizationId" value="${defaultView}.homepage.suggestedSearch"/>
			             <syswf:param name="value" value="${this.searchExpressionWrapper}"/>
			             <syswf:param name="inputId" value="${prefix}I"/>
			             <syswf:param name="suggestedSearchId" value="${prefix}IS"/>
			             <syswf:param name="classOfInput" value="SearchBox Blank" />
			             <syswf:param name="selectionListener" value="${this}"/>
			             <syswf:param name="emptyText" value="${emptyText}"/>
			             <syswf:param name="autoSelect" value="false"/>
                         <syswf:param name="onTriggerClick" value="${prefix}Go()"/>
                         <%-- <syswf:param name="rendersCustomizeLinks" value="true"/> --%>
		         	</syswf:component>  
</div>
	
<syswf:control id="${prefix}Go" mode="script" action="executeSearch" targetTask="/common/${this.defaultHomepageSearch}" caption="${prefix}Go">
    <syswf:param name="searchExpressionWrapper" value="${this.searchExpressionWrapper}"/>                                        
    <syswf:param name="viewId" value="${defaultView}"/>
</syswf:control>


<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        ${prefix}IS.on('specialkey', function(input, e) {
            if (e.getKey() === e.ENTER) {
            	${prefix}Go();
                e.stopEvent();
                return false;
            }
        }); 
    });

//]]>
</script>