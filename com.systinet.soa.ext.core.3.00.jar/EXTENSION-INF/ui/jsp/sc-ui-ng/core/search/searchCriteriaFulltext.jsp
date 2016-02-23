<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages" />

<fmt:message var="searchButtonLabel" key="searchButtonLabel" bundle="${searchmessages}"/>
<fmt:message var="clearButtonLabel" key="clearButtonLabel" bundle="${searchmessages}" />
<fmt:message var="textToFindLabel" key="textToFindLabel" bundle="${searchmessages}"/>
<fmt:message var="searchInLabel" key="searchInLabel" bundle="${searchmessages}"/>

<syswf:control caption="${prefix}_refresh" mode="script" action="changeSearchIn"></syswf:control>

    <table class="UI Table Properties">
        <col class="LabelCol" />
    
        <col />
        <col class="LabelCol" />
        <col />
        <tr>
            <td colspan="4">
                <syswf:input id="${prefix}Fulltext" name="${prefix}_fulltext" value="${searchDefinition}" property="fulltext">
                    <syswf:attribute name="class" value="FullPageSearch" />
                </syswf:input>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var search = new Ext.form.TextField({
                                id: '${prefix}Fulltext',
                                emptyText: '${searchForLabel}',
                                applyTo: '${prefix}Fulltext',
                                stateful: false
                            });
                        });
                    
//]]>
</script>
            </td>
        </tr>
        <tr>
            <td>
                <label class="UI Label Inline" for="${prefix}_searchIn">${searchInLabel}</label>
            </td>    
            <td colspan="3">
                <syswf:selectOne id="${prefix}_searchIn" name="${prefix}_searchIn" value="${searchDefinition}" property="searchInValue" mode="radio" optionValues="${fulltextOptionValues}" optionCaptions="${fulltextOptionCaptions}" displayAsRow="true" >
                </syswf:selectOne>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                    	Ext.get('${prefix}_searchIn_0').on('click', ${prefix}_refresh);
                        Ext.get('${prefix}_searchIn_1').on('click', ${prefix}_refresh);
                    });
                
//]]>
</script>     
            </td>
        </tr>
        
        
    </table>
    
<syswf:block className="SearchControlButtons">
    <c:if test="${not empty resultTableId}">
        <c:set var="onSubmitHandler" value="${resultTableId}ShowLoading"/>
    </c:if>
    
    <a id="${prefix}ExecuteSearchLink" href="javascript:void(0);" class="Button Confirm"><span><span>${searchButtonLabel}</span></span></a>
	<syswf:control caption="${prefix}ExecuteSearch" mode="script" action="executeSearch" onSubmit="${onSubmitHandler}"/>
    
    <syswf:control caption="${prefix}ClearSearch" mode="script" action="clearSearch" onSubmit="${onSubmitHandler}"/>
    <div id="${prefix}ClearSearchBtn" class="MenuButton"></div>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            new Ext.Button({
                renderTo: '${prefix}ClearSearchBtn',
                iconCls: 'hp-reset-savedsearch',
                handler: ${prefix}ClearSearch,
                text: '${clearButtonLabel}'
            });
        });
    
//]]>
</script>
    
    <syswf:input id="${prefix}ResultTablePrefix" name="${prefix}ResultTablePrefix" value="${this}" property="resultTablePrefix" >
        <syswf:attribute name="class" value="x-hidden" />
    </syswf:input>    

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('${prefix}ExecuteSearchLink').on('click', function() {
            	<c:if test="${not empty resultTableId}">
                    if(typeof ${resultTableId}GetPrefix != 'undefined') {
                        Ext.get('${prefix}ResultTablePrefix').dom.value = ${resultTableId}GetPrefix();
                    }
                </c:if>
    
               ${prefix}ExecuteSearch();
            });
        });
    
//]]>
</script>
</syswf:block>

<hr/>
