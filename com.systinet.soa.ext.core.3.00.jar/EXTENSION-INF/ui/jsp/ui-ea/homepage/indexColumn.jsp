<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="columnName">
<c:choose>
	<c:when test="${fn:length(internalNavigation.groups) gt 0}">
	${internalNavigation.groups[0].id}_indexColumn
	</c:when>
	<c:otherwise>
	indexColumn
	</c:otherwise>
</c:choose>
</c:set>
<c:choose>
<c:when test="${empty accessGrantedCheck or (accessGrantedCheck eq true and this.accessGranted)}">
<c:set var="tpColor">
<c:choose>
	<c:when test="${not empty templateColor}">
	${templateColor}
	</c:when>
	<c:otherwise>
	#006696
	</c:otherwise>
</c:choose>
</c:set>
<div id="${prefix}_${columnName}" class="eam-portfolio-box" style="visibility:hidden;background-color:${tpColor}">
	<c:if test="${not empty include}">
		<jsp:include page="${include}.jsp"/>
	</c:if>
	<c:if test="${fn:length(internalNavigation.groups) gt 0}">
		<c:forEach var="item" items="${internalNavigation.groups[0].elements}">
			<c:choose>
	   			<c:when test="${itemType[item] == 2}">
	   				<syswf:component name="${item.componentName}" prefix="${item.id}">
	   					<syswf:paramSet value="${item.paramsMap}"/>
	   				</syswf:component>
	   			</c:when>
   			</c:choose>
		</c:forEach>
		<header>
	       <i class="icon-field icon-${internalNavigation.groups[0].id}" title="${internalNavigation.groups[0].label}"></i>
	       <h2>${internalNavigation.groups[0].label}</h2>
	       <span class="separator-top"></span>
	       <hr class="hr-c-top"/>
	       <hr class="hr-c-bottom"/>
	       <span class="separator-top"></span> 
	   </header>
	</c:if>
	<section>
			<span class="eam-box-content" style="scrollbar-face-color:${tpColor};scrollbar-track-color:${tpColor}">
	        <c:forEach var="group" items="${internalNavigation.groups}" varStatus="groupStatus">
	        <c:if test="${groupStatus.index gt 0}">
	        <c:set var="ulStyleClass">
                <c:choose>
                    <c:when test="${(groupStatus.index lt fn:length(internalNavigation.groups) - 1)}">separator-border c-body</c:when>
                    <c:otherwise><c:if test="${not (group.id eq 'favoritedPR' or group.id eq 'recentVisit' or group.id eq 'surveys2Answer')}">.c-body-bottom</c:if></c:otherwise>
                </c:choose>
            </c:set>
	        <ul class="${ulStyleClass}" id="${group.id}">
	        	<c:if test="${not empty group.label}">
	        		<h4 class="headerline">${group.label}</h4>
	        		<c:forEach var="item" items="${group.elements}">
	        		<li>     		
	        		<c:choose>
	        			<c:when test="${itemType[item] == 1}">
	        				<c:choose>
	        					<c:when test="${fn:contains(item.taskLocation, 'javascript:') }">
	        						<a href="javascript:void(0)" onclick="${item.taskLocation}">${item.label}</a>
	        					</c:when>
	        					<c:otherwise>
	        						<syswf:control id="${item.id}" mode="anchor" caption="${item.label}" targetTask="${item.taskLocation}">
	        			    			<syswf:paramSet value="${item.paramsMap}"/>
	                    			</syswf:control>
	        					</c:otherwise>
	        				</c:choose>
	        			</c:when>
	        			<c:when test="${itemType[item] == 2}">
			   				<syswf:component name="${item.componentName}" prefix="${item.id}">
			   					<syswf:paramSet value="${item.paramsMap}"/>
			   				</syswf:component>
			   			</c:when>
			   			<c:when test="${itemType[item] == 6}">
							<c:if test="${not empty item.parameters}">
								<script>
									//<![CDATA[
										<c:out value="${item.id}=${item.parametersAsJSON}" escapeXml="false"/>;
									//]]>
								</script>
							</c:if>
							<c:out value="${item.contentAsString}" escapeXml="false"/>
						</c:when>
	        		</c:choose>
	                    </li>
	        		</c:forEach>
	        	</c:if>
	        </ul>
	        </c:if>
	        </c:forEach>
		</span>
	</section>
</div>
<script type="text/javascript">
//<![CDATA[
           
    $(document).ready(function() {
    	layoutManager.loadStyle(RESOURCES_URI + '/skinem/css/home.css', function() {
    		$('#${prefix}_${columnName}').css('visibility', 'visible');
        	//workaround for IE
        	if(Ext.isIE) {
        		var containerWidth = 0;
            	$('.flex-container.center > div').each(function(){
            		containerWidth += $('.eam-portfolio-box', this).outerWidth() + 27;
            	});
            	$('.flex-container.center').css('width', containerWidth + 'px');
        	}
    	});
    });

//]]>
</script>
</c:when>
<c:otherwise>
<div id="${prefix}_${columnName}"></div>
<script type="text/javascript">
//<![CDATA[
    
     $(document).ready(function() {
    	$('#${prefix}_${columnName}').parent().parent().parent().remove();
    });

//]]>
</script>
</c:otherwise>
</c:choose>
