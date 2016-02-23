<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>
<fmt:message var="searchButtonLabel" key="searchButtonLabel" bundle="${searchmessages}"/>
<fmt:message var="searchButtonTitle" key="searchButtonTitle" bundle="${searchmessages}"/>
<fmt:message var="homepageSearchMoreOptionsLink" key="homepageSearchMoreOptionsLink" bundle="${searchmessages}"/>
<fmt:message var="clearButtonLabel" key="clearButtonLabel" bundle="${searchmessages}"/>

<div class="OffsetTop">&nbsp;</div>

<syswf:block className="UI Block Green SearchCatalog">
	<div class="Content" id="${prefix}_myCustomId">

        <table class="UI Layout">
            <colgroup>
                <col class="SearchInput" />
                <col class="SearchSubmit" />
            </colgroup>

            <tr>
                <td>
                    <syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch">
                        <syswf:param name="customizationId" value="${viewId}.homepage.suggestedSearch"/>
                        <syswf:param name="value" value="${this.searchExpressionWrapper}"/>
                        <syswf:param name="inputId" value="${prefix}I"/>
                        <syswf:param name="suggestedSearchId" value="${prefix}IS"/>
                        <syswf:param name="classOfInput" value="x-form-text x-form-field" />
                        <syswf:param name="selectionListener" value="${this}"/>
                    </syswf:component>
                </td>
                <td>
                    <syswf:control id="executeSearch" mode="postAnchor" action="executeSearch" targetTask="/${viewId}/${this.defaultHomepageSearch}" wrapper="span" caption="${searchButtonLabel}" hint="${searchButtonTitle}">
                        <syswf:param name="searchExpressionWrapper" value="${this.searchExpressionWrapper}"/>                                        
                        <syswf:param name="viewId" value="${viewId}"/>
                        <syswf:attribute name="class" value="Button"/>             
                    </syswf:control>
                </td>
            </tr>
        </table>
        
	</div>
	<div class="Footer">
	    <syswf:control id="advancedSearchLink" mode="anchor" targetTask="/${viewId}/${this.defaultHomepageSearch}" wrapper="span" caption="${homepageSearchMoreOptionsLink}" hint="">
            <syswf:param name="advancedOptionsExpanded" value="true"/>
        </syswf:control>                            
	</div>	
</syswf:block>	


<syswf:control id="${prefix}Go" mode="script" action="executeSearch" targetTask="/${viewId}/${this.defaultHomepageSearch}" caption="${prefix}Go">
    <syswf:param name="searchExpressionWrapper" value="${this.searchExpressionWrapper}"/>                                        
    <syswf:param name="viewId" value="${viewId}"/>
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

