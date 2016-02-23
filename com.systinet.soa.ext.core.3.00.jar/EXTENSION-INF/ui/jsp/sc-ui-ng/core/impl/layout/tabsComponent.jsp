<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<c:if test="${not empty globalSession['userName']}">
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}"
		scope="page" />
</c:if>
<c:if test="${empty activeTab}">
	<c:set var="activeTab" value="partner" />
</c:if>
<c:set var="itemSize" value="${fn:length(availableTabs)}" />
<div id="top-header-tabs" class="carousel slide" data-interval="false" style="display:none">
	<div class="carousel-inner">
	<c:forEach items="${availableTabs}" var="tab" varStatus="stat">
		<c:set var="class">
		text-nowrap<c:if test="${tab.id eq activeTab}"> selected</c:if>
		</c:set>
		<syswf:control mode="anchor" targetDepth="0" targetTask="${tab.taskLocation}" caption="${tab.label}" hint="${tab.description}" wrapper="span" id="${tab.taskLocation}">
			<syswf:attribute name="target" value="_top" />
			<syswf:attribute name="class" value="${class}"/>
		</syswf:control>
	</c:forEach>
	</div>
	<a style="display:none" class="carousel-control left" data-slide="prev" href="#top-header-tabs"><i class="fa fa-chevron-left"></i></a>
	<a style="display:none" class="carousel-control right" data-slide="next" href="#top-header-tabs"><i class="fa fa-chevron-right"></i></a>
</div>
<script>
//<![CDATA[

$(document).on('bootstrapReady',function() {
	$('#top-header-tabs').show();
	var tabs = $('#top-header-tabs .carousel-inner');
	var mw = $('body').width() - $('#systinet-application-header-left').width() - $('#systinet-application-header-right').width() - 480;
	var as = $('>a',tabs), w, n = 0;
	while(as.length > 0) {
		w = $(as[0]).outerWidth();
		tabs.append('<div class="item"></div>');
		for(var i = 0; i < as.length && w < mw; i++) {
			$('> div.item:last', tabs).append(as[i]);
			w += (i < as.length - 1) ? $(as[i + 1]).outerWidth() : 0;
		}
		as = $('>a',tabs); n++;
	}
	if(n > 1) {
		$('#top-header-tabs .carousel-control').show();
	} else {
		$('#top-header-tabs').removeClass('carousel slide');
		$('#top-header-tabs > div').removeClass('carousel-inner');
	}
	$('a.selected', tabs).parent().addClass('active');
});      

//]]>
</script>