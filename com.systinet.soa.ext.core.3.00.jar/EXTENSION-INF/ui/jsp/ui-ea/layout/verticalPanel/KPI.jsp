<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<div class="panel media pad-all" style="${style}">
	<div class="media-left">
		<c:choose>
			<c:when test="${fn:startsWith(color, '#')}">
				<span class="icon-wrap icon-wrap-sm icon-circle" style="background-color:${color};color:#fff">
					<i class="fa fa-${icon} fa-2x"></i>
				</span>
			</c:when>
			<c:otherwise>
				<span class="icon-wrap icon-wrap-sm icon-circle bg-${color}">
					<i class="fa fa-${icon} fa-2x"></i>
				</span>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="media-body">
		<p class="text-2x mar-no text-thin" id="${prefix}-number">&nbsp;</p>
		<p class="mar-no">
			<c:choose>
				<c:when test="${not empty collection}">
					<c:if test="${not empty filter}">
						<syswf:input id="${prefix}filter" name="filter" value="${filter}" mode="hidden"/>
						<syswf:input id="${prefix}filterName" name="filterName" value="${label}" mode="hidden"/>
					</c:if>
				    <syswf:control id="${prefix}_redirectToCollection" mode="script" caption="${prefix}_redirect" action="redirect" affects=".">
				    	<syswf:param name="artifactType" value="${collection}"/>
				    	<syswf:param name="targetTask" value="/common/browseArtifact"/>
				    	<syswf:param name="targetParams" value="artifactType"/>
				    </syswf:control>
				    <c:set var="tooltip">
				    	<c:if test="${not empty description}">
				    		title="<c:out value='${description}'/>"
				    	</c:if>
				    </c:set>
					<a ${tooltip} class="text-dark link-hover-underline" href="javascript:void(0)" onclick="${prefix}_redirect({callback: function(){window.location='../common/browseArtifact?artifactType=${collection}';}})">${label}</a>
				</c:when>
				<c:otherwise>
					<c:out value="${label}" />
				</c:otherwise>
			</c:choose>
		</p>
	</div>
</div>
<script type="text/javascript">
//<![CDATA[
Ext4.onReady(function() {
    var extraParamsObj = {};
    <c:if test="${not empty dqlParameters}">
        var dqlParameters = '${dqlParameters}';
        try {
        	extraParamsObj = JSON.parse(dqlParameters);
        } catch(e){};
    </c:if>
    var dqlStore = Ext4.create('EA.model.tools.DQLStore', {
    	<c:choose>
    		<c:when test="${not empty filter}">
    			query: "<query>${fn:replace(filter, ':columns', 'count(1) as numberArtifact')}</query>", 
    		</c:when>
    		<c:otherwise>
    			query: "<query>select count(1) as numberArtifact from ${collection} b</query>", 
    		</c:otherwise>
    	</c:choose>
        fields: [],
        extraParams: extraParamsObj
    });
    dqlStore.on('load', function(res) {
        $('#${prefix}-number').text(res.data.items[0].raw.numberArtifact);
    });
    dqlStore.load();
});
//]]>
</script>