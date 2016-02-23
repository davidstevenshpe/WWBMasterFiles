<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.cloudmigration" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uimessages"/>
<fmt:message var="showMoreInformation" key="show.more.information" bundle="${uimessages}"/>
<fmt:message var="msg_financialAlignment" key="cloud.migration.financial.alignmentScore" bundle="${messages}"/>
<fmt:message var="msg_financialAlignmentDesc" key="cloud.migration.financial.alignmentScore.desc" bundle="${messages}"/>
<fmt:message var="msg_estimateType" key="cloud.migration.financial.estimateType" bundle="${messages}"/>
<fmt:message var="msg_estimateTypeDesc" key="cloud.migration.financial.estimateType.desc" bundle="${messages}"/>
<fmt:message var="msg_dataCenter" key="cloud.migration.financial.currentDataCenter" bundle="${messages}"/>
<fmt:message var="msg_recommendedDataCenter" key="cloud.migration.financial.recommendedDataCenter" bundle="${messages}"/>
<fmt:message var="msg_dataCenterDesc" key="cloud.migration.financial.currentDataCenter.desc" bundle="${messages}"/>
<fmt:message var="msg_currentCost" key="cloud.migration.financial.currentCost" bundle="${messages}"/>
<fmt:message var="msg_currentCostDesc" key="cloud.migration.financial.currentCost.desc" bundle="${messages}"/>
<fmt:message var="msg_deploymentAlternative" key="cloud.migration.financial.deploymentAlternative" bundle="${messages}"/>
<fmt:message var="msg_deploymentAlternativeDesc" key="cloud.migration.financial.deploymentAlternative.desc" bundle="${messages}"/>
<fmt:message var="msg_deploymentAlternativeTable" key="cloud.migration.financial.deploymentAlternative.table" bundle="${messages}"/>
<fmt:message var="msg_currentStatus" key="cloud.migration.financial.currentStatus" bundle="${messages}"/>
<fmt:message var="msg_deploymentCosts" key="cloud.migration.financial.deploymentCosts" bundle="${messages}"/>
<fmt:message var="msg_current" key="cloud.migration.financial.current" bundle="${messages}"/>
<fmt:message var="msg_lowestCost" key="cloud.migration.financial.lowestCost" bundle="${messages}"/>
<fmt:message var="msg_legend" key="cloud.migration.financial.deploymentAlternative.legend" bundle="${messages}"/>
<fmt:message var="msg_legend_basedOnServers_1" key="cloud.migration.financial.deploymentAlternative.legend.basedOnServers_1" bundle="${messages}"/>
<fmt:message var="msg_legend_basedOnServers_2" key="cloud.migration.financial.deploymentAlternative.legend.basedOnServers_2" bundle="${messages}"/>
<fmt:message var="msg_legend_basedOnServers_3" key="cloud.migration.financial.deploymentAlternative.legend.basedOnServers_3" bundle="${messages}"/>
<fmt:message var="msg_legend_basedOnServers_4" key="cloud.migration.financial.deploymentAlternative.legend.basedOnServers_4" bundle="${messages}"/>
<fmt:message var="msg_legend_basedOnServers_5" key="cloud.migration.financial.deploymentAlternative.legend.basedOnServers_5" bundle="${messages}"/>
<fmt:message var="msg_legend_basedOnDeployments" key="cloud.migration.financial.deploymentAlternative.legend.basedOnDeployments" bundle="${messages}"/>
<fmt:message var="msg_associatedDeployments" key="cloud.migration.financial.deploymentAlternative.associatedDeployments" bundle="${messages}"/>
<fmt:message var="msg_deploymentCosts_legend" key="cloud.migration.financial.deploymentCosts.legend" bundle="${messages}"/>

<syswf:component name="/core/relations/selectArtifacts" prefix="${prefix}ArtifactSelection"/>

<div class="UI Block">
	<div class="Title">
		<h3><span>${msg_deploymentCosts}</span></h3>
	</div>
	<div style="padding: 0px 0px 5px 0px;">
		<i>${msg_deploymentCosts_legend}</i>
	</div>
	<table class="UI Table Properties">
	   <colgroup>
	      <col class="LabelCol">
	      <col>
	   </colgroup>
	   <tbody>		   	   
		   <tr>
			  <td colspan="2">
				 <div class="help-text ${linkTabId}" style="display: none;">${msg_estimateTypeDesc}</div>
			  </td>
		   </tr>
		    <tr>
			  <th><label style="padding-top:6px" class="UI Label Inline" title="${msg_estimateType}">${msg_estimateType}:</label></th>
				<td>
					<syswf:control mode="script" caption="${prefix}Select" action="setDeploymentModel" affects="." loadingMask="true"/>
					<c:set var="selectedValue" value="${infraserviceUuid}" />
					<c:if test="${empty infraserviceUuid}">
						<c:set var="selectedValue" value="total" />
					</c:if>
					<div id="estimateTypeDropdown" class="btn-group" style="position: absolute;">
						<c:forEach items="${infraServices}" var="infraService" varStatus="stat">
							<c:if test="${selectedValue eq infraService.uuid}">
								<button class="btn btn-default value" onclick="javascript:return false;">${infraService.name}</button>
							</c:if>
						</c:forEach>
						<button class="btn btn-default dropdown-toggle dropdown-toggle-icon" data-toggle="dropdown" type="button">
							<i class="dropdown-caret fa fa-caret-down"></i>
						</button>
						<ul class="dropdown-menu">
							<c:forEach items="${infraServices}" var="infraService" varStatus="stat">
								<li><a href="javascript:${prefix}Select({infraserviceUuid: '${infraService.uuid}'})">${infraService.name}</a></li>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
		   <tr>
			  <td colspan="2">
				 <div class="help-text ${linkTabId}" style="display: none;">${msg_dataCenterDesc}</div>
			  </td>
		   </tr>
		</tbody>
	</table>
</div>

<div class="em-component-box" style="margin-top:15px;">
	<div class="em-component-arrow"></div>

	<div class="flex-container align-center wrap-1200">
		<div class="UI Block" style="flex-grow:2">
	        <syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}currentDataCenterItemComponent">
	            <syswf:param name="relationshipName" value="assignedFrom" />
	            <syswf:param name="artifact" value="${artifact}" />
	            <syswf:param name="artifactTypes" value="dataCenterArtifact" />
	            <syswf:param name="labelUI" value="${msg_dataCenter}"/>
	            <syswf:param name="notShowLinkNew" value="true"/>
	        </syswf:component>
	        <table class="UI Table Properties">
	            <colgroup>
	              <col class="LabelCol">
	              <col>
	            </colgroup>
	            <tbody>
				   <tr>
					  <td colspan="2">
						 <div class="help-text ${linkTabId}" style="display: none;">
							${msg_currentCostDesc}
						 </div>
					  </td>
				   </tr>
				   <tr>
					  <th><label class="UI Label Inline" title="Current Costs">${msg_currentCost}:</label></th>
					  <td>
                          <span class="IconAlign"><c:choose><c:when test="${empty currentTotalCost}">N/A</c:when><c:otherwise><c:choose><c:when test="${currencySymbol eq '$'}">${currencySymbol}${currentTotalCost}</c:when><c:otherwise>${currentTotalCost} ${currencySymbol}</c:otherwise></c:choose></c:otherwise></c:choose></span>
					  </td>
				   </tr>
			   </tbody>
			</table>
			<syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}recommendedDataCenterItemComponent">
	            <syswf:param name="relationshipName" value="recommendedDataCenter" />
	            <syswf:param name="artifact" value="${artifact}" />
	            <syswf:param name="artifactTypes" value="dataCenterArtifact" />
	            <syswf:param name="labelUI" value="${msg_recommendedDataCenter}"/>
	            <syswf:param name="readOnly" value="true"/>
	        </syswf:component>
			<div class="Title">
				<h3><span>${msg_deploymentAlternative}</span></h3>
			</div>
			<syswf:component name="/core/layout/shortcuts" prefix="${prefix}_fa_shortcuts">
	          <syswf:param name="artifact" value="${artifact}" />
			  <syswf:param name="filterList" value="nodeToAppCompShortcut" />
			  <syswf:param name="editable" value="false" />
	        </syswf:component>
			
			<div class="help-text ${linkTabId}" style="display: none;">${msg_deploymentAlternativeTable}"</div>
	<c:if test="${fn:length(dataCenters) gt 0}">
			<table class="value-alternatives">
				<thead>
					<tr>
						<td class="title"></td>
					<c:forEach items="${dataCenters}" var="dataCenter" varStatus="stat">
						<td class="val"><a href="../artifact/${dataCenter.uuid}"><c:out value="${dataCenter.name}"/></a> <c:choose><c:when test="${stat.index eq 0 and not empty currentDataCenter and  currentDataCenter._uuid eq dataCenter.uuid}">(${msg_current})</c:when><c:when test="${stat.index eq preferIndex}">(${msg_lowestCost})</c:when></c:choose></td>
					</c:forEach>
					</tr>
				</thead>
				<tbody>
					<jsp:useBean id="fromCostMap" class="java.util.HashMap" scope="request"/>
					<c:forEach items="${servers}" var="candidates">
					<tr>
						<c:set var="cKey">
							<c:out value="${candidates.key}"/>
						</c:set>
						<c:set var="rowNameLength" value="${fn:length(cKey)}"/>
						<c:set var="rowUuid" value="${fn:substring(cKey, rowNameLength - 36, rowNameLength)}"/>
						<td class="title"><c:choose>
								<c:when test="${fn:contains(cKey, 'Default') }">
									Default Server Profile
								</c:when>
								<c:otherwise>
									<a href="../artifact/${rowUuid}">${serverMap[cKey]}</a>
								</c:otherwise>
							</c:choose> <c:if test="${serverCounts[cKey] != -1}"><c:if test="${infraserviceUuid == 'total'}">(<c:out value="${serverCounts[cKey]}"/>)</c:if></c:if></td>
						<c:forEach items="${candidates.value}" var="candidate" varStatus="stat">
						<c:set var="numberClass">
							<c:if test="${stat.index eq preferIndex}">italic</c:if>
						</c:set>
						<c:choose>
								<c:when test="${fn:indexOf(candidate, 'From') >= 0}">
									<td class="val number ${numberClass}">${candidate}</td>
									<c:set var="keyAsString">${stat.index}</c:set>
									<c:set target="${fromCostMap}" property="${keyAsString}" value="true"/>
								</c:when>
								<c:otherwise>
									<td class="val number ${numberClass}"><c:choose><c:when test="${currencySymbol eq '$'}">${currencySymbol}${candidate}</c:when><c:otherwise>${candidate} ${currencySymbol}</c:otherwise></c:choose></td>
								</c:otherwise>
						</c:choose>
	
						</c:forEach>
					</tr>
					</c:forEach>
					<c:forEach items="${nonCostServers}" var="candidate">
					<tr>
						<td class="title">${candidate.name}</td>
						<c:forEach items="${dataCenters}" var="dataCenter">
						<td class="val number"></td>
						</c:forEach>
					</tr>
					</c:forEach>
					<tr>
						<td class="title"><strong>Total</strong></td>
						<c:forEach items="${totalCosts}" var="totalCost" varStatus="stat">
							<c:set var="numberClass">
								<c:if test="${stat.index eq preferIndex}">bold</c:if>
							</c:set>
							<c:set var="keyAsString">${stat.index}</c:set>
							<td class="val number ${numberClass}"><c:if test="${fromCostMap[keyAsString]}">From </c:if><c:choose><c:when test="${currencySymbol eq '$'}">${currencySymbol}${totalCost}</c:when><c:otherwise>${totalCost}${currencySymbol}</c:otherwise></c:choose></td>
						</c:forEach>
					</tr>
				</tbody>
			</table>
	</c:if>
			<div ><c:out value="${btmDescription}" escapeXml="false"/></div>
		</div>
		<div class="UI Block" id="deployment-alternatives-chart">
	<script type="text/javascript">
	//<![CDATA[
	
	           Ext4.onReady(function(){
	        	   
	        	   //set arrow position for component box/border
	           	   layoutManager.setArrowPosition($("div.em-component-arrow"), $("div.em-component-box"), $("div#estimateTypeDropdown"));
	        	   
	        	   var data = [], linkTabId = '${linkTabId}';
                   <c:choose>
                   <c:when test="${currencySymbol eq '$'}">
                   var currencyFormat = Ext4.util.Format.numberRenderer('${currencySymbol}' + '0,0');
                   </c:when>
                   <c:otherwise>
                   var currencyFormat = Ext4.util.Format.numberRenderer( '0,0'+'${currencySymbol}');
                   </c:otherwise>
                   </c:choose>

	        	   <c:if test="${not empty currencyFormat}">
	        	   currencyFormat = ${currencyFormat};
	        	   </c:if>
				   <c:set var="count" value="0" scope="page" />
					<c:forEach items="${dataCenters}" var="dataCenter" varStatus="stat">
						<c:if test="${not empty totalCosts[stat.index] and totalCosts[stat.index] != 'N/A'}">
							data[${count}] = {dataCenter: '${dataCenter.name}', totalCost: ${fn:replace(totalCosts[stat.index], ',', '')}, uuid: '${dataCenter.uuid}'};
							<c:set var="count" value="${count + 1}" scope="page"/>
						</c:if>
					</c:forEach>
	        	   data.sort(function(a,b){ return a.totalCost > b.totalCost ? 1 : -1 });
	        	   var store = Ext4.create('Ext4.data.JsonStore', {
	        		    fields: ['dataCenter', 'totalCost', 'uuid'],
	        		    data:data
	        		});
	        	   var chart = null;
	        	   function createChart() {
						// remove all chart
						$('#deployment-alternatives-chart').empty();
					   //hide empty chart
	        		   if(data.length==0) return;
	        		   
	     			   chart = Ext4.create('Ext4.chart.Chart', {
	               		    renderTo: 'deployment-alternatives-chart',
	               		    width: 400,
	               		    height: 300,
	               		    animate: true,
	               		    store: store,
	               		    axes: [
	               		        {
	               		            type: 'Numeric',
	               		            position: 'left',
	               		            fields: ['totalCost'],
	               		            label: {
	               		                renderer: currencyFormat
	               		            },
	               		            grid: true,
	               		            minimum: 0
	               		        },
	               		        {
	               		            type: 'Category',
	               		            position: 'bottom',
	               		            fields: ['dataCenter'],
	               		    		label: {
									renderer: function(v) {
										if (v != null && v.length > 20){
											v = v.substring(0,20);
										}
										return v;
									},
	               		    	    rotate: {
	               		    	        degrees: -45
	               		    	       }
	               		    		}
	               		        }
	               		    ],
	               		    series: [
	               		        {
	               		            type: 'column',
	               		            axis: 'left',
	               		            width: 100,
	               		            highlight: true,
	               		            label: {
	               		              display: 'insideEnd',
	               		              'text-anchor': 'middle',
	               		                field: 'totalCost',
	               		                renderer: currencyFormat,
	               		                orientation: 'vertical'
	               		            },
	               		            xField: 'dataCenter',
	               		            yField: 'totalCost',
									tips: {
										trackMouse: true,
										width: 200,
										height: 28,
										renderer: function(storeItem, item) {
											var dc = item.value[0];
											if (dc != null && dc.length > 20){
												dc = dc.substring(0,20);
											}
											this.setTitle(dc + ': '+ currencyFormat(item.value[1]));
										}
									},
									listeners: {
										itemclick: function (param) {
											window.open('../artifact/' +param.storeItem.data.uuid, '_self')
										}
									}
									
	               		            
	               		        }
	               		    ]
	               		});
	        	   }
					   
					<%--hide empty chart--%>
	        	   <c:if test="${fn:length(dataCenters) gt 0}">
	        	   <c:choose>
		        	   <c:when test="${isActive}">
						   if(!chart) {
							setTimeout(createChart, 500);
						   }
		        	   </c:when>
		        	   <c:otherwise>
						   $('#' + linkTabId).click(function(){
							   if(!chart) {
								setTimeout(createChart, 500);
							   }else{
									setTimeout(createChart, 500);
							   }
						   })
						   if(!chart) {
							setTimeout(createChart, 500);
						   }
					</c:otherwise>
	        	   </c:choose>
	        	   </c:if>
	        	   // Check and keep the help text
	        	   layoutManager.checkToKeepHelpText('${linkTabId}');
	           });
	//]]>
	</script>
		</div>
	</div>
	<c:if test="${infraserviceUuid == 'total' || infraserviceUuid == 'total_all_deploys'}">
	<div style="padding: 0px 0px 20px 0px;">
		<i>${msg_legend}</i>
	</div>
	</c:if>
	<c:choose>
		<c:when test="${infraserviceUuid == 'total'}">
			<syswf:component name="/widgets/propertyWithEditButton" prefix="${prefix}propertyWithEditButton">
				<syswf:param name="artifact" value="${artifact}" />
				<syswf:param name="propertyName" value="estimatedNumberOfServers" />
				<syswf:param name="tabId" value="${tabId}" />
				<syswf:param name="subTabId" value="${subTabId}" />
				<syswf:param name="showNAIfNull" value="true" />
			</syswf:component>
			<syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}usedOperatingSystemItemComponent">
				<syswf:param name="relationshipName" value="usedOperatingSystem" />
				<syswf:param name="artifact" value="${artifact}" />
				<syswf:param name="artifactTypes" value="operatingSystemArtifact" />
				<syswf:param name="tabId" value="${tabId}" />
				<syswf:param name="subTabId" value="${subTabId}" />
				<syswf:param name="infraserviceUuid" value="${infraserviceUuid}"/>
			</syswf:component>
			<syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}serverClassItemComponent">
				<syswf:param name="relationshipName" value="serverClass" />
				<syswf:param name="artifact" value="${artifact}" />
				<syswf:param name="artifactTypes" value="serverClassArtifact" />
				<syswf:param name="tabId" value="${tabId}" />
				<syswf:param name="subTabId" value="${subTabId}" />
				<syswf:param name="infraserviceUuid" value="${infraserviceUuid}"/>
			</syswf:component>
			<div style="padding: 20px 0px 5px 0px;">
				<i>${msg_legend_basedOnServers_1} <a target="_blank" href="../common/browseArtifact?artifactType=operatingSystemArtifact">${msg_legend_basedOnServers_2}</a> ${msg_legend_basedOnServers_3} <a target="_blank" href="../common/browseArtifact?artifactType=serverClassArtifact">${msg_legend_basedOnServers_4}</a> ${msg_legend_basedOnServers_5}
				</i>
			</div>
		</c:when>
		<c:when test="${infraserviceUuid == 'total_all_deploys'}">
			<syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}usesItemComponent">
				<syswf:param name="relationshipName" value="uses" />
				<syswf:param name="artifact" value="${artifact}" />
				<syswf:param name="label" value="${msg_associatedDeployments}" />
				<syswf:param name="artifactTypes" value="infrastructureServiceArtifact" />
				<syswf:param name="tabId" value="${tabId}" />
				<syswf:param name="subTabId" value="${subTabId}" />
				<syswf:param name="infraserviceUuid" value="${infraserviceUuid}"/>
			</syswf:component>
			<div style="padding: 20px 0px 5px 0px;">
				<i>${msg_legend_basedOnDeployments}</i>
			</div>
		</c:when>
	</c:choose>

</div>