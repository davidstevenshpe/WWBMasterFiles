<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">//<![CDATA[

Ext4.onReady(function(){
	layoutManager.loadStyle(['<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/templates.css']);

	emCommon['${prefix}-gradientor'] = Ext4.create('EA.portlets.visualization.BackgroundColorVisualization',{
		styleSchema: ['${gradientStartColor}','${gradientEndColor}'],
		minValue:0,
		maxValue: 4
	});
	<c:if test="${hoverEvent eq true}">
	$('#wz-steps-header > li > a').bind('mouseover',function() { $(this).trigger('click');});
	</c:if>
	$('#wz-steps-header > li > a').click(function() {
		$('#wz-steps-body > div > div > .arrow-tab').removeClass('active');
		var index = $(this).parent().index();
		var pa = $('#wz-steps-body > div > div').get(index);
		$('> .arrow-tab', pa).addClass('active');
	});
});

//]]></script>
<div id="content-container">
	<c:if test="${not empty description}">
		<c:out value="${description}" escapeXml="false" />
	</c:if>
	<div id="page-content" class="mar-left tabs">
		<div class="panel tabs mar-no">
			<div class="wz-heading mar-hor-2x">
				<div class="progress progress-sm progress-light-base">
					<div class="progress-bar progress-bar-primary"
						style="opacity: 0.5;width: ${100 - 100/fn:length(tabs.tabs)}%; margin:0 ${50/fn:length(tabs.tabs)}%"></div>
				</div>
				<ul id="wz-steps-header" class="wz-steps" style="display:flex">
					<c:forEach var="tab" items="${tabs.tabs}" varStatus="status">
						<li id="link-tab-${tab.id}" class="${tab.styleClass}" style="flex: 1">
							<a href="#tab-${tab.id}" data-toggle="tab" class="un-trans">
								<span class="icon-wrap icon-wrap-sm icon-circle bg-primary">
									<span class="fa-2x icon-txt text-bold" style="padding-top: 0">${status.count}</span>
								</span>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="flex-container mar-hor-2x">
				<c:forEach var="tab" items="${tabs.tabs}">
					<div class="text-center" style="white-space:nowrap;overflow:hidden">
						<h3>${tab.label}</h3>
					</div>
				</c:forEach>
			</div>
		</div>
		<div id="wz-steps-body" class="panel-body">
			<div class="flex-container" style="margin:0 20px">
			<c:forEach var="tab" items="${tabs.tabs}" varStatus="status">
				<div >
					<div class="arrow-tab ${tab.styleClass}" style="color:${fn:split(panelColor,';')[0]}"></div>
				</div>
			</c:forEach>
			</div>
			<%-- panel: box-shadow:0 -5px 10px 0 #ccc --%>
			<div class="tab-content mar-hor pad-all" style="background-color:${panelColor}">
				<c:forEach var="tab" items="${tabs.tabs}" varStatus="status">
					<div class="tab-pane fade ${tab.styleClass} in pad-btm" id="tab-${tab.id}">
						<p class="pad-all text-lg">
							<em><c:out value="${tab.description}" escapeXml="false"/></em>
						</p>
						<syswf:component name="${tab.componentName}" prefix="${tab.id}"
							wrap="false">
							<syswf:paramSet value="${tab.paramsMap}" />
							<syswf:param name="linkTabId" value="link-tab-${tab.id}" />
							<syswf:param name="isActive" value="${tab.styleClass eq 'active'}" />
							<syswf:param name="gradientor" value="${prefix}-gradientor" />
						</syswf:component>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<div style="display:none" id="downloadSparx">
    <syswf:component prefix="download.sparx" name="/homepage/downloadLink">
        <syswf:param name="title">Download and install the HP EM Extension for Sparx EA</syswf:param>
        <syswf:param name="filePrefix">hp-em-sparx-</syswf:param>
        <syswf:param name="fileSuffix">.msi</syswf:param>
    </syswf:component>
</div>
<script>
    function downloadSparx() {
        window.open($("#downloadSparx div a").get()[0].getAttribute('href'),'_blank');
    };
</script>