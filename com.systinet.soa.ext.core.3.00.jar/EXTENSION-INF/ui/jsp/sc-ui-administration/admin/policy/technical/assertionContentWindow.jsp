<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />
<fmt:message var="requiredTitle" key="addParameter.required.title" bundle="${tpMessages}" />
<fmt:message var="requiredLabel" key="addParameter.required" bundle="${tpMessages}" />
<fmt:message var="okButtonLabel" key="addParameter.okButtonLabel" bundle="${tpMessages}" />
<fmt:message var="cancelButtonLabel" key="addParameter.cancelButtonLabel" bundle="${tpMessages}" />

<syswf:input id="paramName" name="paramName" value="" mode="hidden"/>
<syswf:control mode="ajax" action="openSelectCategory" caption="${prefix}openSelectCategory" />
<syswf:control mode="ajax" action="removeCategory" caption="${prefix}removeSelectedCategory" />
<div class="assCntWnd">
<script type="text/javascript">
//<![CDATA[

	function storeEditingProperties(value1) {
	    Ext.get('paramName').dom.value = value1;
	}
	function ${prefix}openCategoryDialog(paramName) {
		storeEditingProperties(paramName);
		${prefix}openSelectCategory();
	}	
	function ${prefix}removeCategoryParam(paramName) {
		storeEditingProperties(paramName);
		${prefix}removeSelectedCategory();
	}

//]]>
</script>

<c:set var="buttons">
	[{
		text     : '${okButtonLabel}',
		disabled : false,
		handler  : function() {
		    ${prefix}selectCategory();
		    SPopup.Window.Instance['${prefix}selectCategoryWindow'].hide();
		},
		id:'${prefix}_addButton'
	},{
		text     : '${cancelButtonLabel}',
		handler  : function(){
		    ${prefix}cancel();
		    SPopup.Window.Instance['${prefix}selectCategoryWindow'].hide();
		},
		id:'${prefix}_cancelButton'
	}]
</c:set>

<c:if test="${openSelectCategoryDialog}">
	<syswf:control mode="script" action="selectCategory" caption="${prefix}selectCategory" >
		<syswf:param name="inputBean" value="${inputBean}"/>										
        <syswf:param name="categoryDSCache" value="${categoryDSCache}" />	
	</syswf:control>
	
	<syswf:component name="/core/window" prefix="taxonomyBrowser">
	    <syswf:param name="winTitle" value="${selectCategoryWindowTitle}" />
	    <syswf:param name="winId" value="${prefix}selectCategoryWindow" />
	    <syswf:param name="winComponent" value="/core/impl/widget/util/taxonomyBrowser"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openCategorySelector" />
	    <syswf:param name="winCustomButtons" value="${buttons}" />	    
        <syswf:param name="hiddenShowAllTaxonomies" value="true" />
        <syswf:param name="selectedCategories" value="${selectedCategories}"/>
        <syswf:param name="taxonomyBrowserListener" value="${taxonomyBrowserListener}"></syswf:param>
        <syswf:param name="preSelectedTaxonomy" value="${preSelectedTaxonomy}" />                
        <syswf:param name="taxonomyDSCache" value="${taxonomyDSCache}" />
        <syswf:param name="categoryDSCache" value="${categoryDSCache}" />
        <syswf:param name="cancelFunc" value="${prefix}cancel" />        
        <syswf:param name="overrideselectionModel" value="one" />        
        <syswf:param name="annotation" value="${annotation}" />        
        <syswf:param name="winWidth" value="500" />
		<syswf:param name="winButtonAlign" value="right" />        
    </syswf:component>
        
    <script type="text/javascript">
//<![CDATA[

		Ext.onReady(function() {
			${prefix}openCategorySelector();
		})
	
//]]>
</script>
</c:if>

<table class="UI Table Properties">
	<tr>
		<th><label class="UI Label Inline"><fmt:message key="addParameter.assertion" bundle="${tpMessages}"/></label></th>
		<td>
			<span class="IconAlign"><label class="UI Label Inline"><c:out value='${assertion.assertionName}'/></label></span>
		</td>                                   
	</tr>
	<tr>
		<th><label class="UI Label Inline"><fmt:message key="addParameter.severity" bundle="${tpMessages}"/></label></th>
		<td>
			<syswf:selectOne id="${prefix}selectSeverity" name="assertionBeanControl" value="${assertion}" property="severity" mode="radio" optionValues="${severityValues}" optionCaptions="${severityCaptions}" displayAsRow="true" dataType="int">
			</syswf:selectOne>
		</td>                            
	</tr>
</table>
<c:if test="${not empty assertion.params}">	
	<h4><fmt:message key="addParameter.parameters" bundle="${tpMessages}"/></h4>
	<div class="UI Offset">
		<table class="UI Table Properties">
			<c:forEach var="item" items="${assertion.params}">
				<c:set var="errorMessage" value="${errors[item.name]}"/>
				<tr>
					<c:if test="${item.optional}">
						<th>
							<label class="UI Label Inline">${item.name}:</label>
						</th>
					</c:if>
										
					<c:if test="${not item.optional}">
						<th>
							<label class="UI Label Inline">${item.name}:</label>
							<sup class="Required" title="${requiredTitle}">${requiredLabel}</sup>
						</th>
					</c:if>									
										
					<c:if test="${item.isTaxonomyParameter}">
						<td>									
							<c:if test="${not empty item.value}">												
								<syswf:input id="${prefix}${item.name}_hidden" name="${prefix}${item.name}_hidden" value="${item.name}" mode="hidden"/>										
								<label class="UI Label Inline"><c:out value='${item.taxKeyName}'/></label>
								<span>
									<a href="javascript:void(0);" class="UI Icon Delete Context" id="${item.name}_Remove"></a>
									<a href="javascript:void(0);" class="UI Icon Edit" id="${item.name}_Change"></a>							                    
								</span>								                									
								<script type="text/javascript">
//<![CDATA[

									Ext.onReady(function(){
										attachOn('${item.name}_Change','click',function() {		
											${prefix}openCategoryDialog(Ext.get('${prefix}${item.name}_hidden').dom.value);    
										});	
										attachOn('${item.name}_Remove','click',function() {		
											${prefix}removeCategoryParam(Ext.get('${prefix}${item.name}_hidden').dom.value);    
										});
									});	
								
//]]>
</script>			
							</c:if>
																						
							<c:if test="${empty item.value}">												
								<syswf:input id="${prefix}${item.name}_hidden" name="${prefix}${item.name}_hidden" value="${item.name}" mode="hidden"/>												
								<span>
									<a href="javascript:void(0);" class="UI Icon Add" id="${prefix}${item.name}_Add">Click here to set</a>
								</span>								                
								<script type="text/javascript">
//<![CDATA[

									Ext.onReady(function(){
										attachOn('${prefix}${item.name}_Add','click',function() {
											${prefix}openCategoryDialog(Ext.get('${prefix}${item.name}_hidden').dom.value);    
										});	
									});	
								
//]]>
</script>												
							</c:if>
						</td>								
					</c:if>				
										
					<c:if test="${not item.isTaxonomyParameter}">
						<td>
							<c:if test="${not empty errorMessage}">
								<span>
									<syswf:input name="${item.name}" value="${item}" property="value">
										<syswf:attribute name="class" value="x-form-text UI Input x-form-invalid x-form-field"></syswf:attribute>
										<syswf:attribute name="style" value="width:90%"></syswf:attribute>
									</syswf:input>
								</span>
							</c:if>
													
							<c:if test="${empty errorMessage}">
								<span>
									<syswf:input name="${item.name}" value="${item}" property="value">
										<syswf:attribute name="class" value="UI Form Text String"></syswf:attribute>
									</syswf:input>
								</span>
							</c:if>											
						</td>
					</c:if>													
				</tr>								
									
				<c:if test="${not empty errorMessage}">
					<tr>
						<td></td>
						<td>
							<em class="x-form-invalid-msg UI Invalid">
								<span class="Comment">${errorMessage}</span>
							</em>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty item.description}">
					<tr>
						<td></td>
						<td>																			
							<label class="UI Label Inline">
								<span class="Comment"><syswf:out context="HtmlBody" value="${item.description}"/></span>
							</label>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>
</c:if>
</div>
