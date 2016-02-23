<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Attributes:

   searchButtonLabel (optional) - Label for execution button. If value is empty, default label is used.  
   hideClearButton (optional) - If value is true, clear button is hidden. Default value is false. 
   afterExecutionCallback (optional) - Js method, called after ajax response with execution is finished.
   refreshAfterExecution (default true) - if false, nothing is rendered after execution. This method should be used together with afterExecutionCallback.
   refreshAfterExecution_changedAreaId (optional) - area that will be refreash after execution
   
   --%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<fmt:message var="advancedOptionsComment" key="advancedOptionsComment" bundle="${searchmessages}"/>
<fmt:message var="addCriteriaControlLabel" key="addCriteriaControlLabel" bundle="${searchmessages}"/>
<fmt:message var="addCriteriaPopupTitle" key="addCriteriaPopupTitle" bundle="${searchmessages}"/>
<fmt:message var="searchSliderLabel" key="searchSliderLabel" bundle="${searchmessages}"/>
<fmt:message var="searchSliderHint" key="searchSliderHint" bundle="${searchmessages}"/>
<fmt:message var="loadButtonLabel" key="loadButtonLabel" bundle="${searchmessages}"/>
<fmt:message var="clearButtonLabel" key="clearButtonLabel" bundle="${searchmessages}"/>
<fmt:message var="textToFindLabel" key="textToFindLabel" bundle="${searchmessages}"/>
<fmt:message var="searchInLabel" key="searchInLabel" bundle="${searchmessages}"/>
<fmt:message var="saveSearchButtonLabel" key="saveSearchButtonLabel" bundle="${searchmessages}"/>
<fmt:message var="manageSavedButtonLabel" key="manageSavedButtonLabel" bundle="${searchmessages}"/>
            
<c:if test="${empty searchButtonLabel}">
    <fmt:message var="searchButtonLabel" key="searchButtonLabel" bundle="${searchmessages}"/>
</c:if>

<c:if test="${empty hideClearButton}">
    <c:set var="hideClearButton" value="${false}" />
</c:if>

<c:if test="${empty refreshAfterExecution}">
    <c:set var="refreshAfterExecution" value="${true}" />
</c:if>

<div class="SearchProperties" id="collection-advanced-search-block">

<c:if test="${this.admin and not empty this.errorMessagesList}">
    <div class="UI SystemMessage Error">
        <div class="MessageContainer">
            <div class="Text">
                <c:forEach var="errorMessage" items="${this.errorMessagesList}" varStatus="status">
                    ${errorMessage}
                    <c:if test="${not status.last}"><br/></c:if>
                </c:forEach>
            </div>
            <div class="x-clear"></div>
        </div>
    </div>
</c:if>

<%-- Refresh function used in switch to fulltext --%>
<syswf:control caption="${prefix}_refresh" mode="script" action="changeSearchIn"></syswf:control>

<%-- Main input field - nameAndDescription --%>
<table class="UI Table Properties">
    <colgroup>
	   <col class="LabelCol" />
	   <col />
	   <col class="LabelCol" />
	   <col />
    </colgroup>

    <tr>
         <td colspan="4">
            <c:forEach var="criteria" items="${this.searchDataModel.displayedCriterias}" varStatus="status">
                <c:if test="${status.index < defaultDisplayed && criteria.type eq 'properties' and criteria.id eq 'nameAndDescription'}">
                    <%-- DO NOT DISPLAY CRITERIA WHEN IT WAS NOT PROPERLY INITIALIZED.--%>  
                    <c:choose>                
                        <c:when test="${not empty criteria.component and not empty criteria.searchWidgetModel and not empty criteria.searchWidgetModel.value}">
                            <syswf:component name="${criteria.component}" prefix="${criteria.id}" wrap="false">
                                <syswf:param name="searchWidgetModel" value="${criteria.searchWidgetModel}" />
                                <syswf:param name="searchWidgetListener" value="${this.searchDataModel}" />
                                <syswf:param name="artifactType" value="${this.searchDataModel.artifactType}" />
                                <syswf:param name="visible" value="${criteria.visible}"/>
                                <c:forEach var="criteriaParam" items="${criteria.widgetParameters.parameters}">
                                    <syswf:param name="${criteriaParam.name}" value="${criteriaParam.value}"/>
                                </c:forEach>
                            </syswf:component>
                        </c:when>
                        <c:otherwise>
                            <%-- INITIALIZATION PROCESS ERROR MESSAGES ARE DISPLAYED TO ADMINISTRATOR AT THE TOP OF THIS COMPONENT --%>
                        </c:otherwise>
                    </c:choose>  
                </c:if>                               
            </c:forEach>
        </td>
    </tr>
    
    <%-- Possible radio boxes for switching to fulltext --%>
    <c:if test="${not empty searchDefinition and searchDefinition.fulltextAllowed}">
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
  </c:if>
  <%-- TODO REVIEW (Svata, Apr 4, 2009): Use varStatus, then test status.index % 2 eq 0 
                 Johnny - I need the columnFlag to correctly declare closing tr tag outside the forEach cycle --%>
    <c:forEach var="criteriaWrapper" items="${this.criterias}" varStatus="status">
	<c:if test="${(status.index -1) %2 == 0}">
    <tr>
	</c:if>
        <c:set var="criteria" value="${criteriaWrapper.criteria}" />
        <c:set var="criteriaId" value="${criteria.id}${criteriaWrapper.currentVisible}" />              
        <c:if test="${not (criteria.type eq 'properties' and criteria.id eq 'nameAndDescription') and not empty criteria.component and not empty criteria.searchWidgetModel and not empty criteria.searchWidgetModel.value}">
            <c:choose>
                <c:when test="${not empty criteria.label}">        
                    <c:set var="label" value="${criteria.label}" />
                </c:when>                                            
                <c:otherwise>
                    <%-- A default fallback as the label is optional. --%>
                    <c:set var="label" value="${criteria.id}: ${criteria.id}" />
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${not criteria.customRendering and criteriaWrapper.currentVisible}">
                    <td>
                        <label class="UI Label Inline">${label}: </label>
                    </td>
                    <td class="sep">
                        <syswf:component name="${criteria.component}" prefix="${criteriaId}">
                            <syswf:param name="searchWidgetModel" value="${criteria.searchWidgetModel}"/>
                            <syswf:param name="searchWidgetListener" value="${this.searchDataModel}"/>
                            <syswf:param name="artifactType" value="${this.searchDataModel.artifactType}"/>   
                            <syswf:param name="defaultVisible" value="${criteria.visible}"/>
                            <syswf:param name="visible" value="${criteriaWrapper.currentVisible}"/>
                            <c:forEach var="criteriaParam" items="${criteria.widgetParameters.parameters}">
                                <syswf:param name="${criteriaParam.name}" value="${criteriaParam.value}"/>
                            </c:forEach>
                        </syswf:component>
                    </td>
                </c:when>
                <c:when test="${not criteria.customRendering}">
                    <td colspan="2">
                        <syswf:component name="${criteria.component}" prefix="${criteriaId}">
                            <syswf:param name="label" value="${label}"/>
                            <syswf:param name="description" value="${criteria.description}"/>
                            <syswf:param name="searchWidgetModel" value="${criteria.searchWidgetModel}"/>
                            <syswf:param name="searchWidgetListener" value="${this.searchDataModel}"/>
                            <syswf:param name="artifactType" value="${this.searchDataModel.artifactType}"/>   
                            <syswf:param name="defaultVisible" value="${criteria.visible}"/>
                            <syswf:param name="visible" value="${criteriaWrapper.currentVisible}"/>
                            <c:forEach var="criteriaParam" items="${criteria.widgetParameters.parameters}">
                                <syswf:param name="${criteriaParam.name}" value="${criteriaParam.value}"/>
                            </c:forEach>
                        </syswf:component>
                    </td>
                </c:when>
                <c:otherwise>
                    <td colspan="2">
                        <syswf:component name="${criteria.component}" prefix="${criteriaId}">
                            <syswf:param name="label" value="${label}"/>
                            <syswf:param name="description" value="${criteria.description}"/>
                            <syswf:param name="searchWidgetModel" value="${criteria.searchWidgetModel}"/>
                            <syswf:param name="searchWidgetListener" value="${this.searchDataModel}"/>
                            <syswf:param name="artifactType" value="${this.searchDataModel.artifactType}"/>
                            <syswf:param name="defaultVisible" value="${criteria.visible}"/>
                            <syswf:param name="visible" value="${criteriaWrapper.currentVisible}"/>
                            <c:forEach var="criteriaParam" items="${criteria.widgetParameters.parameters}">
                                <syswf:param name="${criteriaParam.name}" value="${criteriaParam.value}"/>
                            </c:forEach>
                        </syswf:component>
                     </td>
                </c:otherwise>
            </c:choose>
        </c:if>
    <c:if test="${(status.index -1) %2 == 1}">
    </tr>
	</c:if>
    </c:forEach>

</table>
<script type="text/javascript">
//<![CDATA[
    Ext.onReady(function() {
        var arrows = jQuery('.x-form-arrow-trigger');
        if (arrows != null) {
            arrows.click(function(event) {
                var dropdown = jQuery(".x-keywords-menu").first();
                if (dropdown != null && dropdown.css('visibility')=='visible') {
                    jQuery('.x-combo-list').each(function(index){
                        if ($(this).css('visibility')=='visible') {
                            //jQuery(".x-keywords-menu").fadeOut();
                            jQuery(".x-keyword-trigger").trigger("click");
                            $(this).focus();
                            return;
                        }
                    });
                }
            });
        }
    });
//]]>
</script>
    <c:if test="${not empty resultTableId and not AJAXED_COMPONENT_LOADING_MASK}">
	        <c:set var="onSubmitHandler" value="${resultTableId}ShowLoading"/>
	 </c:if>
   	<div id="${prefix}advanced-search-menu" class="advanced-search-menu">
   	<c:set var="addCriteriaControls">
        <c:choose>
            <c:when test="${not empty this.searchDataModel.hiddenCriterias}">
                <c:forEach var="criteria" items="${this.searchDataModel.hiddenCriterias}" varStatus="status">
                    <c:if test="${not(criteria.type eq 'properties' and criteria.id eq 'nameAndDescription')}" >
                        <c:set var="functionName" value="${prefix}add${criteria.id}" />
                        <syswf:control mode="script" affects="." action="addCriteria" caption="${functionName}" id="add${functionName}">
                            <syswf:param name="criteria" value="${criteria}" />
                        </syswf:control>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach var="criteriaGroup" items="${this.searchDataModel.hiddenGroups}">
                    <c:forEach var="criteria" items="${criteriaGroup.elements}">
                        <c:if test="${not(criteria.type eq 'properties' and criteria.id eq 'nameAndDescription')}" >
                            <c:set var="functionName" value="${prefix}add${criteria.id}" />
                            <syswf:control mode="script" affects="." action="addCriteria" caption="${functionName}" id="add${functionName}">
                                <syswf:param name="criteria" value="${criteria}" />
                            </syswf:control>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </c:otherwise>    
        </c:choose>
    </c:set>   
   		<c:if test="${not empty addCriteriaControls}">
   			<c:out value="${addCriteriaControls}" escapeXml="false" />
			<span id="${prefix}addCritBtn-container" class="trans-container"></span>
	        <a id="${prefix}AddCritLink" href="javascript:void(0);" class="btn btn-success">${addCriteriaControlLabel}</a>
	        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady(function() {
                                var addCritBtn = new Ext.Button({
                                    renderTo: '${prefix}addCritBtn-container',
                                    arrowAlign: 'right',
                                    menu: new Ext.HP.ActionMenu({
                                    	items: [
				                            <c:choose>
				                                <c:when test="${not empty this.searchDataModel.hiddenGroups}">                                
						                            <c:forEach var="criteriaGroup" items="${this.searchDataModel.hiddenGroups}" varStatus="groupStatus">
						                                {
						                                    text: '${criteriaGroup.label}',
						                                    iconCls: 'hp-add-criteria-item',
						                                    cls: 'group',
						                                    menu: new Ext.HP.ActionMenu({
						                                    	cls:'leaf',
				                                            	items: [
									                                <c:set var="firstItem" value="true"/>
									                                <c:forEach var="criteria" items="${criteriaGroup.elements}" varStatus="status">
									                                    <c:if test="${this.couldBeAdded[criteria] and not(criteria.type eq 'properties' and criteria.id eq 'nameAndDescription')}" >
									                                        <c:choose>
									                                            <c:when test="${not empty criteria.label}">                                
									                                                <c:set var="label">
									                                                    <c:out value="${criteria.label}" />
									                                                </c:set>
									                                            </c:when>                                            
									                                            <c:otherwise>
									                                                <%-- A default fallback as the label is optional. --%>
									                                                <c:set var="label" >
									                                                    <c:out value="${criteria.id}" />
									                                                </c:set>
									                                            </c:otherwise>
									                                        </c:choose>  
									                                        <c:if test="${not firstItem}">,</c:if>    
									                                        {
									                                            text: '${label}',
									                                            iconCls: 'hp-add-criteria-item',
									                                            handler: ${prefix}add${criteria.id}
									                                        }
									                                        <c:set var="firstItem" value="false"/>
									                                    </c:if>
									                                </c:forEach>
									                                ]
						                                    })
					                                    }
						                                <c:if test="${not groupStatus.last}">,</c:if>
						                            </c:forEach>                                                                    
				                                </c:when>
				                                <c:otherwise>
					                                <c:set var="firstItem" value="true"/>
					                                <c:forEach var="criteria" items="${this.searchDataModel.hiddenCriterias}" varStatus="status">
					                                    <c:if test="${this.couldBeAdded[criteria] and not(criteria.type eq 'properties' and criteria.id eq 'nameAndDescription')}" >
					                                        <c:choose>
					                                            <c:when test="${not empty criteria.label}">                                
					                                                <c:set var="label">
					                                                    <c:out value="${criteria.label}" />
					                                                </c:set>
					                                            </c:when>                                            
					                                            <c:otherwise>
					                                                <%-- A default fallback as the label is optional. --%>
					                                                <c:set var="label" >
					                                                    <c:out value="${criteria.id}" />
					                                                </c:set>
					                                            </c:otherwise>
					                                        </c:choose>  
					                                        <c:if test="${not firstItem}">,</c:if>  
					                                        {
					                                            text: '${label}',
					                                            iconCls: 'hp-add-criteria-item',
					                                            handler: ${prefix}add${criteria.id}
					                                        }
					                                        <c:set var="firstItem" value="false"/>
					                                    </c:if>
					                                </c:forEach>
				                                </c:otherwise>    
				                            </c:choose>
	                                    ]}),
                                    split: true
                                });
                                
                                Ext.get('${prefix}AddCritLink').on('click', function() {
                                	if(!addCritBtn.menu.isVisible()){
                                		addCritBtn.showMenu();
                                	}else{
                                		addCritBtn.hideMenu();
                                	}
                                	
                                });
                            });
                    
//]]>
</script>
        </c:if>

	    <c:if test="${empty confirmButtonClass}">
	        <c:set var="confirmButtonClass" value="btn btn-primary"/>
	    </c:if>
	    <c:if test="${confirmButtonClass ne 'MenuButton'}">
	    	<a id="${prefix}ExecuteSearchLink" href="javascript:void(0);" class="${confirmButtonClass}">${searchButtonLabel}</a>
	    	<script type="text/javascript">
//<![CDATA[

var ${prefix}ExecuteSearch = function() {
	${prefix}ExecuteSearch2();
	<c:if test="${not empty afterExecutionCallback}">
        ${afterExecutionCallback}();
	</c:if>                
}

var ${prefix}doExecuteSearchLink = function() {
	<c:if test="${not empty resultTableId}">
		if(typeof ${resultTableId}GetPrefix != 'undefined') {
			Ext.get('${prefix}ResultTablePrefix').dom.value = ${resultTableId}GetPrefix();
		}
	</c:if>
   ${prefix}ExecuteSearch();
}

Ext.onReady(function() {
          Ext.get('${prefix}ExecuteSearchLink').on('click', ${prefix}doExecuteSearchLink);
});
	    
//]]>
</script>
	    </c:if>
	    <c:if test="${confirmButtonClass eq 'MenuButton'}">
	    	<label id="${prefix}ExecuteSearchLinkMenu" class="${confirmButtonClass}"></label>
			<script type="text/javascript">
//<![CDATA[
			Ext.onReady(function() {
				new Ext.Button({
					renderTo: '${prefix}ExecuteSearchLinkMenu',
					handler: ${prefix}doExecuteSearchLink,
					text: '${searchButtonLabel}'
				});
			});
		
//]]>
			</script>
	    </c:if>
    <c:choose>
        <c:when test="${refreshAfterExecution}" >
          <c:choose>
            <c:when test="${empty refreshAfterExecution_changedAreaId}">
              <syswf:control caption="${prefix}ExecuteSearch2" mode="script" action="executeSearch" onSubmit="${onSubmitHandler}"/>
            </c:when>
            <c:otherwise>
              <syswf:control caption="${prefix}ExecuteSearch2" mode="script" action="executeSearch" onSubmit="${onSubmitHandler}" affects="${refreshAfterExecution_changedAreaId}"/>
            </c:otherwise>
          </c:choose>
        </c:when>
        <c:otherwise>
            <syswf:control caption="${prefix}ExecuteSearch2" mode="script" action="executeSearch" onSubmit="${onSubmitHandler}" affects="."/>
        </c:otherwise>
    </c:choose>
    <syswf:input id="${prefix}ResultTablePrefix" name="${prefix}ResultTablePrefix" value="${this}" property="resultTablePrefix" >
        <syswf:attribute name="class" value="x-hidden" />
    </syswf:input>
    
    <c:if test="${allowSave and saveAllowed}" >
    	<syswf:control caption="${prefix}SaveSearch" mode="script" action="saveSearch" affects="."/>
        <a id="${prefix}SaveSearchBtn" class="btn btn-primary" href="javascript:void(0)" onclick="${prefix}SaveSearch()">${saveSearchButtonLabel}</a>
        <span id="LoadSearchBtn-container" class="trans-container"></span>
        <a id="${prefix}LoadSearchBtn" class="btn btn-primary" href="javascript:void(0)">${loadButtonLabel}</a>
        <script type="text/javascript">
//<![CDATA[
            Ext.onReady(function() {
                var loadSearchBtn = new Ext.Button({
                    renderTo: 'LoadSearchBtn-container',
                    iconCls: 'hp-load-savedsearch',
                    arrowAlign: 'right',
                    menu: new Ext.HP.ActionMenu({
                    	items: [
	                    	<c:forEach var="ssd" items="${savedSearchDefinitions}" varStatus="status">
		                    	<c:set var="ssdCount" value="${status.count}" />
		                    	<c:if test="${status.index < 10}">
		                        	{text: '<c:out value="${ssd.name}" />', 
		                         	href: '${savedSearchDefinitionBaseUrl}${ssd.uuid}'},
		                         </c:if>
		                    </c:forEach>
	                    	<c:if test="${ssdCount > 10}">
	                    		{text: '...', handler: ${prefix}OpenManageSavedWindowFce},
	                    	</c:if>
	                        {text: '${manageSavedButtonLabel}', handler: ${prefix}OpenManageSavedWindowFce,iconCls: 'UI Icon ManageFolder'}
	                    ]}),
                    split: true
                });
                
                Ext.get('${prefix}LoadSearchBtn').on('click', function() {
                	if(!loadSearchBtn.menu.isVisible()){
                		loadSearchBtn.showMenu();
                	}else{
                		loadSearchBtn.hideMenu();
                	}
                	
                });
            });
        
//]]>
</script>
    </c:if>
    
    <c:if test="${not hideClearButton}" >
        <c:choose>
            <c:when test="${empty refreshAfterExecution_changedAreaId}">
              <syswf:control caption="${prefix}ClearSearch" mode="script" action="clearSearch" onSubmit="${onSubmitHandler}"/>
            </c:when>
            <c:otherwise>
              <syswf:control caption="${prefix}ClearSearch" mode="script" action="clearSearch" onSubmit="${onSubmitHandler}" affects="${refreshAfterExecution_changedAreaId}"/>
            </c:otherwise>
        </c:choose>
        <a id="${prefix}ClearSearchLink" class="btn btn-dark" onclick="${prefix}ClearSearch()" href="javascript:void(0)">${clearButtonLabel}</a>
    </c:if>  
                                        
</div>
		<c:if test="${allowSave and saveAllowed}" >
		    <syswf:component name="/core/search/savedSearch/manageSavedWindow" prefix="_manageSavedSearches" ajax="true">
		        <syswf:param name="jsOpenFunction" value="${prefix}OpenManageSavedWindowFce" />
		        <syswf:param name="refreshParent" value="${prefix}RefreshThis" />
		        <syswf:param name="savedSearchDefinitionBaseUrl" value="${savedSearchDefinitionBaseUrl}" />
		        <syswf:param name="filterLabelResolver" value="${filterLabelResolver}" />
		    </syswf:component>
		</c:if>
	</div>

    <c:if test="${openSaveWindow}" >
        <syswf:component name="/core/search/savedSearch/saveSearchWindow" prefix="savedSearchSave" ajax="true">
            <syswf:param name="jsOpenFunction" value="${prefix}OpenSaveWindowFce" />
            <syswf:param name="savedSearchDefinition" value="${savedSearchDefinition}" />
            <syswf:param name="refreshParent" value="${prefix}RefreshThis" />
            <syswf:param name="savedSearchDefinitionBaseUrl" value="${savedSearchDefinitionBaseUrl}" />
            <syswf:param name="filterLabelResolver" value="${filterLabelResolver}" />
        </syswf:component>

    
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                ${prefix}OpenSaveWindowFce();
            });
        
//]]>
</script>
    </c:if>

<syswf:control mode="script" caption="${prefix}RefreshThis" affects="."></syswf:control>

<c:if test="${not searchExecuted}">
    <hr></hr>
</c:if>

