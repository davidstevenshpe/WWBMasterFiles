<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>
<fmt:message var="browseResultsTitle" key="browseResultsTitle" bundle="${searchmessages}"/>
<fmt:message var="tooltipTop" key="query.predefined.tooltip.topLevel" bundle="${searchmessages}"/>
<fmt:message var="tooltipAll" key="query.predefined.tooltip.all" bundle="${searchmessages}"/>
<fmt:message var="tooltipMy" key="query.predefined.tooltip.my" bundle="${searchmessages}"/>
<fmt:message var="tooltipFav" key="query.predefined.tooltip.favourite" bundle="${searchmessages}"/>
<c:set var="styleClass">
<c:choose>
<c:when test="${render eq 'survey'}">survey-filter</c:when>
<c:otherwise>EA-Blue-Bar</c:otherwise>
</c:choose>
</c:set>
<c:if test="${fn:length(this.queryList.items) > 1}">
	<div class="UI Block Common ${styleClass} cell-container">
		<div class="EA-Block EA-Right-Sep-Bor" id="${prefix}filter">
		<select id="${prefix}filterCombobox">
			<c:forEach var="item" items="${this.queryList.items}" varStatus="status">
				<c:choose>
	                <c:when test="${not empty item.label}">
	                    <c:set var="caption" value="${item.label}"/>
	                </c:when>
	                <c:otherwise>
	                    <!-- A default fallback as the label is optional. -->
	                    <c:set var="caption" value="${item.id}"/>
	                </c:otherwise>
	            </c:choose>
	            <c:set var="value">
	            	<syswf:control mode="href" id="${prefix}_facet_${status.index}">
	                    <syswf:param name="selected" value="${status.index}" />
	                    <syswf:param name="artifactType" value="${artifactType}" />
	                    <syswf:param name="title" value="${title}" />
	                </syswf:control>
	            </c:set>
				<option value="${value}" <c:if test="${this.actual eq status.index}">selected</c:if>>
					<c:out value="${caption}"/>
				</option>			
			</c:forEach>
		</select>
		</div>
		<c:if test="${render ne 'survey'}">
			<div class="EA-Block EA-Right-Sep-Bor Domain-Filter" style="padding: 0; color: #fff !important;">
				<syswf:component prefix="domainSelectionInCatalog" name="/core/impl/layout/domainSelectionInBrowserPage" wrap="false" trim="true">
					<syswf:param name="context" value="${context}" />
					<syswf:param name="browseArtifact" value="${browseArtifact}"/>
				</syswf:component>
			</div>
		</c:if>
		<c:if test="${not empty this.searchModel.criteriaXml}">
			<div class="EA-Block">
			<c:choose>
			<c:when test="${render eq 'survey'}">
				<a class="btn btn-gray btn-em filter" onclick="$('#collection-advanced-search-block').toggle();searchCriteriaDialogToggle();return false;"><span>Filter</span></a>
			</c:when>
			<c:otherwise>
				<a onclick="$('#collection-advanced-search-block').toggle();searchCriteriaDialogToggle()" class="EA-header EA-white-link" href="javascript:void(0)"> 
					<span class="fa fa-filter" style="font-size: 26px;position: relative;">
						<span class="fa fa-filter" style="position: absolute;left: 13px;top: 13px;font-size: 70%;"/>
					</span>
				</a>
				</c:otherwise>
			</c:choose>	
			</div>
	    </c:if>
	</div>
	<script type="text/javascript">
	//<![CDATA[
		     
	<c:choose>
	<c:when test="${render eq 'survey'}">
	Ext.onReady(function() {
		<c:if test="${empty assessment}">
			$('#pagetitle').removeClass('EA-Blue-Bar').addClass('survey-header');
		 </c:if>
		$('#${prefix}filterCombobox').change(function() {
			console.log($(this).val);
			window.location=$(this).val();
		});
	});
	</c:when>
	<c:otherwise>
	if($('#pagetitle').length > 0) {
		var html = $('#pagetitle').html();
		$('#pagetitle').remove();
		$('#${prefix}filter').before(html).attr('id','pagetitle');
	}

    Ext.onReady(function() {
        Ext.QuickTips.init();
        var ${prefix}filter_artifact_status = new Ext.form.ComboBox({
            id: '${prefix}cbbox',
            cls:'SearchBox Blank',
            transform: '${prefix}filterCombobox',
            forceSelection: true,
            typeAhead: true,
            disableKeyFilter: false,
            editable: false,
            triggerAction: 'all',
            onSelect: function(record){
            	if(record.id != this.getValue()){
                	this.setValue(record.id);
                    window.location=record.id;
            	}
            	this.collapse();
            },
            listeners: {
                afterrender: function() {
                    Ext.QuickTips.register({ target: this.getEl(), text: getQueryTooltip(this.getEl().getValue()) });
                },
                expand: function() {
                    var itemList = jQuery(".x-combo-list-item");
                    if (!!itemList) itemList.each(function() {
                        var oldTooltip = jQuery(this).attr("title");
                        if (!oldTooltip) {
                            jQuery(this).attr("title", getQueryTooltip(jQuery(this).text()));
                        }
                    });
                }
            }
        });
        
        function keepSize(){
            //Get the window's width: (NOT including toolbars/scrollbars)
            var winWidth = window.innerWidth;
            if (typeof(winWidth)=='undefined'){
                winWidth = $(window).width();
            }
            ${prefix}filter_artifact_status.setWidth(Math.round(winWidth/3));
        }
        keepSize();
        Ext.EventManager.onWindowResize(keepSize);
    });
		</c:otherwise>
	</c:choose>	

    function getQueryTooltip(label) { // pre-defined
        if (!label) return "";
        var textLabel = label.trim().toLowerCase();
        if (textLabel.indexOf("top") == 0) {
            return "${tooltipTop}";
        }
        if (textLabel.indexOf("all") == 0) {
            return "${tooltipAll}";
        }
        if (textLabel.indexOf("my") == 0) {
            return "${tooltipMy}";
        }
        if (textLabel.indexOf("fav") == 0) {
            return "${tooltipFav}";
        }
        return textLabel;
    };
    
    //]]>
    </script>
</c:if>
<c:if test="${not empty this.searchModel.criteriaXml}">
    <syswf:component prefix="searchCriteria${this.searchModel.criteriaXml}" name="/core/browse/browseArtifactCriteria" wrap="false">
        <syswf:param name="customizationId" value="${parentCustomizationId}.${this.searchModel.criteriaXml}" />
        <syswf:param name="sharedDataSourceWrapper" value="${this.searchModel}" />
        <syswf:param name="resultTableId" value="queryListResults"/>
    </syswf:component>
    <c:if test="${render ne 'survey'}">
    <script type="text/javascript">
	//<![CDATA[
	           $('#collection-advanced-search-block').addClass('EA-Blue-Border');
	//]]>
   	</script>
   	</c:if>
</c:if>
<%-- artifact type definition--%>
<div>
	<syswf:component prefix="${prefix}ArtifactTypeDescriptionComponent" name="/core/layout/artifactTypeDescription" wrap="false">
        <syswf:param name="artifactType" value="${artifactType}"/>
        <%-- need tableId to call doLayout() to avoid table trimmed from the right --%>
        <syswf:param name="tableId" value="queryListResults"/>
    </syswf:component>
</div>
<%-- end of querylist, start of result table --%>
<div class="Content">
    <syswf:component prefix="resultTable${this.searchModel.tableXml}" name="/core/table" wrap="false">
        <syswf:param name="customizationId" value="${parentCustomizationId}.${this.searchModel.tableXml}" />
        <syswf:param name="datasource" value="${this.searchModel.dataSource}" />
        <syswf:param name="tableId" value="queryListResults"/>
    </syswf:component>
</div>
		