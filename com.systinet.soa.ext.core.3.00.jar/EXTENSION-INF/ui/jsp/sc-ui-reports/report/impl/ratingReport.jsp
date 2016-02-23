<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${not empty globalSession['userName']}">
<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.L10nReport" var="reportMessages" />
<script type="text/javascript">
//<![CDATA[
Ext4.onReady(function() {
		var report = Ext4.create("EA.scripts.RatingReport",{
			renderTo: '${prefix}-rating-report',
			id: 'applicationArtifactRatingReport',
			header:false,
			draggable: false,
			portletConfig: {
				defaultHeight: 0
			}
		});
});
//]]>
</script>
<div id="pagetitle" class="UI Block Common EA-Blue-Bar">
	<div class="EA-Block">
		<h3 class="EA-top-header"><fmt:message key="rating.report.title" bundle="${reportMessages}"/></h3>
	</div>
</div>
<div id="${prefix}-rating-report">
<div id="undefined-table"></div>
</div>
