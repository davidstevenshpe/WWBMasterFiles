<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
List of possible input parameters for suggested search component:
    customizationId - customization xml file, resources/customization/default/suggestedSearch.xml, schema suggestedSearch.xsd
    suggestDatasource - dataSource, if not specified then dataSource is taken from customization
    selectionListener - implementation of SelectionListener interface, action is fired when item in combobox is selected (see notes below)
    combo - possible values: multi, single, keywords or nothing
    multi - no server action is performed on item selection (suggested text is put into text box, ie. keywords), it is possible to select more suggestions
    single - no server action is performed on item selection (suggested text is put into text box, ie. provider)
    not specified (nothing) - server action is involved on item selection
    afterSelectCallback - js function called after selection, can be used for additional cleaning (destroying combo box)
    afterSelectionFinished - js function called after selection finished (ajax with select actions finished), can be used for reaction to selection (submiting form, ...)
    inputId - id of input box, thorough this id is possible to decorate input box with Extjs
    value - data holder for input text used for passing between components
    classOfInput - used as a class for input box
    cssOfInput - complementary css class if no classOfInput is specified (UI Form Text Primary ${cssOfInput})
    styleOfInput - style used for input box
Notes:
    customizationId - required, specifies customization file
    selectionListener - must implement com.hp.systinet.sc.ui.impl.search.SuggestedSearchDataComponent.SelectionListener (perform operation, redirect)
    combo - if specified as multi or single it doesn't make sense to specify selectionListener (no server action is involved)
    value - suggest input text box can be pre-filled or value can be passed back to parent component, serves as communication box between components
    must implement com.hp.systinet.sc.ui.search.ValueHolder
    inputId - identification of suggested search input, can be used for ExtJS? customization
    
    Suggested search could be configured, to show fictive line at the end of the list of values. To achieve this, all following parameters has to be filled:
    fictiveLineControlName - name of javascript function, which is called on click to this fictive link
    fictiveLineColumnName - name of column, to which is fictive line rendered (values are in table, also fictive line is in one cell of table)
    fictiveLineDescription - implementation of special interface, which allows to define when a what to shown
    keywordsContent - id of table with top keywords (has meaning only for type keywords)
    availableArtifactTypes - define artifact types to search among 
    allowAllAvailableArtifactTypes - if true, data are filtered to all available artifact types, otherwise only artifacts from configuration could by shown
    suggestedSearchId - id for ext object (combobox), if null, default one is used
--%>

<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:if test="${empty suggestedSearchId}">       
   <c:set var="suggestedSearchId" value="${prefix}_search"/>
</c:if>


<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<c:if test="${empty inputId}">       
   <c:set var="inputId" value="${suggestedSearchId}_expression" />
</c:if>

<syswf:control mode="script" caption="${prefix}_submit" affects="${prefix}_data" action="suggestSearch">
</syswf:control>

<script type="text/javascript">
//<![CDATA[

	function ${prefix}_loadDataForSuggestedSearch() {
        var element = Ext.get('${prefix}_data_search_expression');
        if (element) {
           element.dom.value = ${suggestedSearchId}.getValue();
        }
		${prefix}_submit();
	};

//]]>
</script>

<c:choose>
    <c:when test="${not empty areaToUpdateOnSelect}">
        <syswf:control mode="script" caption="${prefix}_onSelect" action="${areaToUpdateOnSelect}$onSelectAction" affects="${areaToUpdateOnSelect}">
            <syswf:param name="suggestedSearchBean" value="${this.bean}"/> 
        </syswf:control>
    </c:when>
    <c:otherwise>
        <syswf:control mode="script" caption="${prefix}_onSelect" action="onSelectAction" affects="."/>
    </c:otherwise>
</c:choose>


<c:if test="${afterSelection and not empty afterSelectionFinished}" >
    <script type="text/javascript" >
    //<![CDATA[
        Ext.onReady(function(){
        	${afterSelectionFinished}();
        });
    
//]]>
</script>
</c:if>


<script type="text/javascript">
//<![CDATA[
	var isNavIconClick = false;
	function ${prefix}_actionOnSelect(record) {
		if(isNavIconClick) {
			isNavIconClick = false;
			return false;
		}
        var element = Ext.get('${prefix}_data_id');
        if (element) {
           element.dom.value = record.data['id'];
        }
        //in data could be fictive lines, which couldn't be selected, they have empty id
        if(record.data['id'] != null && record.data['id'] != '') {
    		${prefix}_onSelect();
            <c:if test="${not empty afterSelectCallback}">
                ${afterSelectCallback}(${suggestedSearchId});
            </c:if>
        }
	};
//]]>
</script>

<script type="text/javascript">
//<![CDATA[
    var ${prefix}_data_ds = new Ext.data.Store({
        proxy: new Ext.data.SCSubmitProxy("${prefix}_data", ${prefix}_loadDataForSuggestedSearch),
        reader: new Ext.data.JsonReader({
            root: 'records',
            totalProperty: 'totalRecords',
            id: '${prefix}_suggestedSearch'
        }, [
        	<c:forEach var="column" items="${this.config.table.columns}" varStatus="status">
        		{name: '${column.id}', mapping: '${column.id}' }<c:if test="${not status.last}">,</c:if>
        	</c:forEach>
        ])
    });

	Ext.onReady(function(){
	    var ${prefix}_resultTpl = new Ext.XTemplate(
	        '<tpl for="."><div class="UI Offset InteractiveSearch"><div class="search-item">',
        	<c:forEach var="column" items="${this.config.table.columns}">
        		<c:if test="${column.propertiesAsMap['hidden'] ne 'true'}" >
	            '<span class="SearchField ${column.propertiesAsMap['css']}">${column.label} <span class="Value">{${column.id}}</span></span>',
	            </c:if>
        	</c:forEach>
	        '</div></div><hr/></tpl>'
	    );

<c:choose>
    <c:when test="${combo eq 'keywords'}">
        ${suggestedSearchId} = new Ext.HP.KeywordField({
    </c:when>
    <c:when test="${combo eq 'multi'}">
          ${suggestedSearchId} = new Ext.HP.ComboBoxMulti({
    </c:when>
    <c:otherwise>
        ${suggestedSearchId} = new Ext.form.ComboBox({
    </c:otherwise>
</c:choose>
            id: '${prefix}_combo',
	    	store: ${prefix}_data_ds,
	        displayField:'name',
	        typeAhead: false,
	        tpl: ${prefix}_resultTpl,
            <c:choose>
            <c:when test="${empty width}">autoWidth: false,</c:when>
            <c:otherwise>width: ${width},</c:otherwise>
            </c:choose>
            <c:if test="${combo ne 'keywords'}">
	           hideTrigger:${this.config.hideTrigger},
            </c:if>            
	        applyTo: '${inputId}',
	        minChars: ${this.config.minCharacters},
            itemSelector: 'div.search-item',
            queryDelay: ${this.config.typedelay},
            <c:choose>
                <c:when test="${combo eq 'multi' or combo eq 'keywords'}">
                    sep: '<fmt:message key="suggestedSearchSeparator" bundle="${searchmessages}" />',
                    triggerAction: 'all',
                    selectOnFocus:true,
                </c:when>
                <c:when test="${combo eq 'single'}">
                </c:when>
                <c:otherwise>
                    onSelect: ${prefix}_actionOnSelect,
                    <c:if test="${not empty onTriggerClick}">
                        onTriggerClick: function(){${onTriggerClick};},
                    </c:if>
                </c:otherwise>
            </c:choose>
            <c:if test="${combo eq 'keywords' and not empty keywordsContent}">
                content: '${keywordsContent}',
            </c:if>
            <c:if test="${not empty autoSelect}">       
            	autoSelect: ${autoSelect},
            </c:if>
            onBeforeLoad: function() { this.selectedIndex = -1;}
		});
 
        var KeepSize = function() {
            <c:choose>
                <c:when test="${empty width}">
                    var diff = 0;
                    var myParent = ${suggestedSearchId}.getEl().dom.parentNode;
                    if (myParent) {
                        myParent = myParent.parentNode;
                        if (myParent) {
                            myParent = Ext.get(myParent);
                            if (myParent.hasClass('x-form-field-wrap')) {
                                myParent = Ext.get(myParent.dom.parentNode.parentNode);
                            }
                            diff = Math.round(myParent.dom.offsetWidth - 7);
                        }
                    }
                </c:when>
                <c:otherwise>
                    var diff = ${width};
                </c:otherwise>
            </c:choose> 
            if (diff > 0) {
            	${suggestedSearchId}.setWidth(diff); 
            }
            if (arguments[0]) { 
                setTimeout(function(){ KeepSize(true); }, 200);
            }
        }

        KeepSize(true);
        Ext.EventManager.onWindowResize(function(){ KeepSize(); });

	});
//]]>
</script>

<c:if test="${not empty fixedItem.value.callback}">
    <c:set var="fixedItemFce" value="${prefix}FixedItemFce" />
    <script type="text/javascript">
//<![CDATA[

        var ${fixedItemFce} = function() {
            ${fixedItem.value.callback}();
            <c:if test="${not empty afterSelectCallback}">
                ${afterSelectCallback}(${suggestedSearchId});
            </c:if>
        }
    
//]]>
</script>
</c:if>

<div class="x-hidden">
    <syswf:component name="/core/impl/search/suggestedSearchData" prefix="data">
        <syswf:param name="config" value="${this.config}" />
        <syswf:param name="bean" value="${this.bean}" />
        <syswf:param name="fixedItem" value="${fixedItem}" />
        <syswf:param name="fixedItemControlName" value="${fixedItemFce}" />
        <syswf:param name="allowAllAvailableArtifactTypes" value="${allowAllAvailableArtifactTypes}"/>
        <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
    </syswf:component>
</div>    

<c:out value="${jsonBuilder.output}"></c:out>

<syswf:input id="${inputId}" name="searchExpression" property="value" value="${value}">
    <c:choose>
        <c:when test="${not empty classOfInput}">
            <syswf:attribute name="class" value="${classOfInput}"/>
        </c:when>
        <c:otherwise>
	        <syswf:attribute name="class" value="UI Form Text Primary ${cssOfInput}"/>
        </c:otherwise>
    </c:choose>
    <c:if test="${not empty styleOfInput}">
        <syswf:attribute name="style" value="${styleOfInput}"/>
    </c:if>
    <c:if test="${not empty emptyText}">            	
        <syswf:attribute name="placeholder" value="${emptyText}"/>
  	</c:if>
</syswf:input>

