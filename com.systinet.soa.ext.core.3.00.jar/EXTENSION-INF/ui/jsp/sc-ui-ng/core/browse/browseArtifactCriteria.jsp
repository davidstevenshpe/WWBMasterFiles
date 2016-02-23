<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.browse.browsemessages" var="browsemessages"/>

<fmt:message var="advancedOptionsComment" key="advancedOptionsComment" bundle="${browsemessages}"/>
<fmt:message var="addCriteriaControlLabel" key="addCriteriaControlLabel" bundle="${browsemessages}"/>
<fmt:message var="addCriteriaPopupTitle" key="addCriteriaPopupTitle" bundle="${browsemessages}"/>
<fmt:message var="goButtonLabel" key="goButtonLabel" bundle="${browsemessages}"/>
<fmt:message var="clearButtonLabel" key="clearButtonLabel" bundle="${browsemessages}"/>

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

<div class="${this.advancedOptionsStatus}">
    <c:if test="${this.advancedOptionsStatus == 'Closed'}" >
        <c:set var="style" value="display: none" />
    </c:if>
    <syswf:control mode="script" action="dialogToggle" caption="searchCriteriaDialogToggle" affects="."/>
    <div class="Content" style="${style}" id="collection-advanced-search-block">        
        <div class="EA-Block">
        	<br/>
            <div class="Comment">${advancedOptionsComment}</div>
          	<br/>
        </div>
        <div class="SearchProperties">
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

                <c:forEach var="criteriaWrapper" items="${this.criterias}" varStatus="status">
                <tr>
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
								<c:if test="${not(criteria.id eq 'domain')}">
									<td>
										<label class="UI Label Inline">${label}: </label>
									</td>
									<td  class="sep">
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
								</c:if>
                            </c:when>
                            <c:when test="${not criteria.customRendering}">
									<td colspan="4">
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
                                <td colspan="4">
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
                </tr>
                </c:forEach>
                
                    
                <c:choose>
                    <c:when test="${not empty this.searchDataModel.hiddenCriterias}">
                        <c:forEach var="criteria" items="${this.searchDataModel.hiddenCriterias}">
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
        </table>
        </div>
        <c:if test="${not empty resultTableId}">
            <c:set var="onSubmitHandler" value="${resultTableId}ShowLoading"/>
        </c:if>
        <c:if test="${empty confirmButtonClass}">
            <c:set var="confirmButtonClass" value="btn btn-primary"/>
        </c:if>
        <div id="${prefix}advanced-search-menu" class="advanced-search-menu">
        	<span id="${prefix}addCritBtn-container" class="trans-container"></span>
        	<a id="${prefix}AddCritLink" href="javascript:void(0);" class="btn btn-success">${addCriteriaControlLabel}</a>
			<a id="${prefix}ExecuteSearchLink" href="javascript:void(0);" class="${confirmButtonClass}">${goButtonLabel}</a>
			<a id="${prefix}ClearSearchLink" href="javascript:void(0);" class="btn btn-dark">${clearButtonLabel}</a>
						<script type="text/javascript">
//<![CDATA[

                                var addCritBtn = new Ext.Button ({
                                    renderTo: '${prefix}addCritBtn-container',
                                    menu: new Ext.HP.ActionMenu({
                                   		items:[
				                              <c:choose>
				                                <c:when test="${not empty this.searchDataModel.hiddenCriterias}">
				                                    <c:set var="firstItem" value="true"/>
				                                    <c:forEach var="criteria" items="${this.searchDataModel.hiddenCriterias}" varStatus="status">
				                                        <c:if test="${this.couldBeAdded[criteria] and not(criteria.type eq 'properties' and criteria.id eq 'nameAndDescription')}" >
				                                            <c:choose>
				                                                <c:when test="${not empty criteria.label}">                                
				                                                    <c:set var="label" >
				                                                        <c:out value="${criteria.label}" />
				                                                    </c:set>
				                                                </c:when>                                            
				                                                <c:otherwise>
				                                                    <%-- A default fallback as the label is optional. --%>
				                                                    <c:set var="label">
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
				                                </c:when>
				                                <c:otherwise>
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
							                                                        <c:set var="label" >
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
				                                        		]})
			                                            	}
				                                        <c:if test="${not groupStatus.last}">,</c:if>
				                                    </c:forEach>
				                                </c:otherwise>    
				                            </c:choose>
                                    ]})
                                
                                });
            
                            
//]]>
</script>
		</div>
		
            <syswf:control caption="${prefix}ExecuteSearch" mode="script" action="executeSearch" onSubmit="${onSubmitHandler}"/>
            <syswf:control caption="${prefix}ClearSearch" mode="script" action="clearSearch" onSubmit="${onSubmitHandler}"/>
            
            <script type="text/javascript">
//<![CDATA[
                Ext.onReady(function() {
                    Ext.get('${prefix}AddCritLink').on('click', function() {
                    	if(!addCritBtn.menu.isVisible()){
                    		addCritBtn.showMenu();
                    	}else{
                    		addCritBtn.hideMenu();
                    	}
                    	
                    });
                    Ext.get('${prefix}ExecuteSearchLink').on('click', function() {
                        ${prefix}ExecuteSearch();
                    });
                    Ext.get('${prefix}ClearSearchLink').on('click', function() {
                    	${prefix}ClearSearch();
                    });
                });
//]]>
</script>
    </div>  
</div>
