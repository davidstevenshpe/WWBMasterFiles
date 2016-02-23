<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uiMessage"/>
<fmt:message var="csaServiceDesignsLabel" key="cloudMigration.csaServiceDesigns.label" bundle="${uiMessage}"/>

<fmt:setBundle basename="com.hp.systinet.ea.ui.cloudmigration" var="cloudMessages"/>
<fmt:message var="createNewTabLabel" key="cloud.transformation.deployment.model.tab.create.new" bundle="${cloudMessages}"/>
<fmt:message var="associateExistingTabLabel" key="cloud.transformation.deployment.model.tab.associate.existing" bundle="${cloudMessages}"/>
<fmt:message var="associateExistingButtonLabel" key="cloud.transformation.deployment.model.button.associate.existing" bundle="${cloudMessages}"/>
<fmt:message var="tableMappingDesc" key="cloud.transformation.deployment.model.table.mapping.desc" bundle="${cloudMessages}"/>
<fmt:message var="associateExistingDesc" key="cloud.transformation.deployment.model.tab.associate.existing.desc" bundle="${cloudMessages}"/>
<fmt:message var="applicationModelHeader" key="cloud.transformation.deployment.model.column.group.application.model" bundle="${cloudMessages}"/>
<fmt:message var="csaTopologyHeader" key="cloud.transformation.deployment.model.column.group.csa.topology" bundle="${cloudMessages}"/>
<fmt:message var="noDeploymentSpecText" key="cloud.transformation.deployment.model.table.no.deployment.spec.text" bundle="${cloudMessages}"/>
<fmt:message var="noDeploymentSpecDesc" key="cloud.transformation.deployment.model.table.no.deployment.spec.desc" bundle="${cloudMessages}"/>
<fmt:message var="deploymentSpecMising" key="cloud.transformation.deployment.model.table.no.deployment.spec.missing" bundle="${cloudMessages}"/>
<fmt:message var="deploymentSpecSelect" key="cloud.transformation.deployment.model.table.no.deployment.spec.select" bundle="${cloudMessages}"/>
<fmt:message var="csaServiceDesignProp" key="cloud.transformation.deployment.model.help.text.csa.service.design.prop" bundle="${cloudMessages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="title" bundle="${relationshipmessages}" key="confirm.window.title"/>
<fmt:message var="message" bundle="${relationshipmessages}" key="confirm.window.message.table"/>
<fmt:message var="unlinkText" bundle="${relationshipmessages}" key="unlink.text"/>
<fmt:message var="openInCatalog" bundle="${relationshipmessages}" key="open.in.catalog"/>
<fmt:message var="btnLink" bundle="${relationshipmessages}" key="confirm.window.btn.link"/>
<fmt:message var="btnCancel" bundle="${relationshipmessages}" key="confirm.window.btn.cancel"/>


<div class="em-component-box">	
	<div class="em-component-arrow"></div>	
	
	<%-- Infrastructure Service name --%>
	<div class="Title">
		<h3>
			<span><syswf:out value="${artifact.name}" context="HtmlBody"/></span>
		</h3>
	</div>
	
	<%-- Infrastructure Service properties --%>
	<syswf:component name="/detail/viewArtifactProperties" prefix="deploymentModelProperties" wrap="false">
		<syswf:param name="artifact" value="${artifact}"/>
		<syswf:param name="customizationId" value="catalog.viewArtifact.infrastructureServiceArtifact.cloudMigration.csa.deploymentModels.properties"/>
	</syswf:component>
	
	<%-- Hide available CSA Service Designs in case non-reference app comp and selected infra service from Reference Domain  --%>
	<c:if test="${not (not isAppCompFromReferenceDomain and isInfraServiceFromReferenceDomain)}">
		<%-- Available CSA Service Designs --%>
		<div style="margin-top: -12px;">
			<table class="UI Table Properties">
			   <colgroup>
			      <col class="LabelCol">
			      <col>
			   </colgroup>
				<tbody>
					<tr>
						<td colspan="2">
							<div class="help-text">${csaServiceDesignProp}</div>
						</td>
					</tr>
					<tr>
						<th>
							<label class="UI Label Inline"> 
								<c:out value="${csaServiceDesignsLabel}" />:
							</label>
						</th>
						<td>
							<c:forEach items="${serviceDesigns}" var="pair" varStatus="status">
							    <syswf:control mode="anchor" caption="${pair.second}" targetTask="/artifact/${pair.first}" targetDepth="0">
							    	<syswf:attribute name="target" value="_blank"/>
							    </syswf:control>
								<c:if test="${!status.last}" >,</c:if>
							</c:forEach>
							<c:if test="${fn:length(serviceDesigns) == 0}" >N/A</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</c:if>
	
	<%-- Tab --%>
	<div id="page-content" class="tabs">
		<div class="panel em tabs">
			<div class="panel-heading" id="${prefix}deploymentModelTabs">
				<div class="panel-control" style="float:left;">
					<ul class="nav nav-tabs">
						<li id="link-tab-create-new-service-design" class="active">
							<a data-toggle="tab" href="#content-create-new-service-design">${createNewTabLabel}</a>
						</li>
						<li id="link-tab-associate-existing-service-design">
							<a data-toggle="tab" href="#content-associate-existing-service-design">${associateExistingTabLabel}</a>
						</li>
					</ul>
				</div>
				<h3 class="panel-title">&nbsp;</h3>
			</div>
			<div class="pad-ver">
				<div class="tab-content">
					<div class="tab-pane fade active in" id="content-create-new-service-design">
						<div><i>${tableMappingDesc}</i></div>
						<%-- preview table --%>
						<br/>
						<div id="${prefix}-csaServiceDesignPreviewTable"></div>
						<syswf:component name="/cloud/migration/csa/publishButtonComponent" prefix="publishModel" wrap="false">
			            	<syswf:param name="artifact" value="${this.currentApplication}"/><%-- current application component --%>
			            	<syswf:param name="infraserviceUuid" value="${artifact._uuid}"/>
		            	</syswf:component>
					</div>
					<div class="tab-pane fade" id="content-associate-existing-service-design">
						<div><i>${associateExistingDesc}</i></div>
						<%--TODO: filter: CSA Domain, not create using HP EM Publishing --%>
						<syswf:component name="/core/layout/relationshipButtonComponent" prefix="associateExistingDeploymentModel" wrap="false">
			            	<syswf:param name="artifact" value="${artifact}"/>
			            	<syswf:param name="relationshipName" value="specializedBy"/>
			            	<syswf:param name="artifactTypes" value="infrastructureServiceArtifact"/>
			            	<syswf:param name="label" value="${associateExistingButtonLabel}"/>
			            	<syswf:param name="icon" value="fa-link"/>
			            	<syswf:param name="type" value="linkExisting"/>
			            	<syswf:param name="relationWinTitle" value="Select Service Designs"/>
			            	<%-- only filter from CSA domain --%>
			            	<syswf:param name="domainIdsParam" value="csaServiceDesignsDomain"/>
			            	<syswf:param name="domainNamesParam" value="CSA Service Designs"/>
							<syswf:param name="multipleRels" value="true"/>
							<syswf:param name="relationshipNames" value="specializedBy,uses"/>
							<syswf:param name="sourceArtifactUuids" value="${artifact._uuid},${this.currentApplication._uuid}"/>
			            </syswf:component>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">
//<![CDATA[
           
    Ext4.onReady(function(){
    	
    	//set arrow position for component box/border
    	layoutManager.setArrowPosition($("div.em-component-arrow"), $("div.em-component-box"), $("div#deploymentModelsDropdown"));
    	
		var isAppCompFromReferenceDomain = ${isAppCompFromReferenceDomain};
 	   	if(isAppCompFromReferenceDomain===true){
 		   	//referential app comp does not need tab
 		   	$('div#${prefix}deploymentModelTabs.panel-heading').hide();
 	   	}
 	   
	   	var artifactTable = Ext4.create('EA.model.table.proposal.ArtifactListingDatasourceTable', {
	   		
			renderTo: '${prefix}-csaServiceDesignPreviewTable',
 	        width: '100%',
 	        remoteSort: true,
 	        dataSourceLocation: '/scripts/CSAServiceDesignPublishing.xml',
 	        extraParamsDataSource: {
 	        	isaUuid: '${artifact._uuid}'
 	        },
 	        pageResults: true,
 	        pageSize: 10,
 	        sorters:[{"property":"name","direction":"ASC"}],
 	        columns:[
			{
				text: '${applicationModelHeader}',
				style: 'text-align: left',
            	columns:  [
   	           	{
                    header:'Name',
                    dataIndex:'name',
                   	renderer:function (v,m,record) {
                   		return artifactTable.getArtifactLinkRender(record.data._uuid, record.data.name, record.data._sdmName);
                    }, 
                    width:250,
                    sortable:true
                },{
                    header:'Version',
                    dataIndex:'version',
                    width:100,
                    sortable:true
                },{
                    header:'Type',
                    dataIndex:'sdmName',
                    width:200,
                    sortable:true
                }]
			},
			{
				text: '${csaTopologyHeader}',
				style: 'text-align: left',
	            columns:  [
                {
                    header:'Name',
                    dataIndex:'deploymentSpec',
                    renderer:function (v,m,record) {
                    	/*consider as an array of json object
                    	e.g:
	                    	"deploymentSpec" : [{
									"name" : "ASAC Web",
									"_uuid" : "fb741548-1f43-47fa-9be8-170b8e46b26a",
									"version" : "1.0"
								}
							]
                    	*/
                    	if(record.data._sdmName == 'serverArtifact'){
							return '<span style=\'color: #667\' title=\'${noDeploymentSpecDesc}\'>${noDeploymentSpecText}</span>';
                    	}
                    	
                    	var element = '';
                    	if(v){
                    		var deploymentSpec = v[0];
                    		element += artifactTable.renderMenu(record.data._uuid, deploymentSpec._uuid, deploymentSpec.name, 'deploymentSpecification');
                    	} else{
                    		element += '<span style=\'color:#E15960\'>${deploymentSpecMising}</span>';
                    	}
                    	
                    	var relationWinTitle = '${deploymentSpecSelect}';
                    	
                    	var customColumn = '[{header:\'Type\', dataIndex:\'sdmName\',width:150,hidden:true,sortable:true}, ' + 
                    	                    '{header:\'Version\', dataIndex:\'version\', width:150, sortable:true, renderer:function (v) {if (v == null || v == \'\') return \'N/A\'; else return v;}}, '+
                    	                    '{header:\'Stage\', dataIndex:\'currentStage\', width:100, hidden:true, sortable:true, renderer:function (v) {if (v == null) return \'\'; else return v;}}, '+
                    	                    '{header:\'Owner\', dataIndex:\'owner\', hidden:true, width:150, sortable:true}, ' +
                    	                    '{header:\'Domain\', dataIndex:\'domain\', hidden:true, width:150, sortable:true}]';
                    	
						/* custom dql for query 'link existing' artifacts */
                    	var customDql = 'select a._uuid as uuid, a.name as name, a._artifactTypeName as sdmName, a._sdmName as type, a._ownerName as owner, a.version as version, a._currentStage.name as currentStage,a.description as description, da.name as domain ' +
                    					'from hpsoaDomainArtifact da, deploymentSpecification a ' +
                    					'where da.r_localId=a._domainId and (upper(a.name) like :query or upper(a._artifactTypeName) like :query or upper(a.version) like :query) and ' +
                    						  'a.deploymentSpecificationType.val = \\\'CSA Component\\\'';
                    	
                    	//save timestamp to useType in order to get the latest deployement spec linked to app comp
                    	element += '<img onclick=\"showSelectionArtifact(\''+ relationWinTitle + '\', \'' + 
                    													record.data._uuid + 
                    													'\', \'realizedBy\', \'' + 
                    													'null, ' + 
                    													'\', [{type: \'deploymentSpecification\'}], ' + 
                    													'null, ' +
                    													'{callbackFn: null, '+
                    													'selectionMode: \'SINGLE\', ' +
                    													'domainIdsParam: \'csaServiceDesignsDomain\', domainNamesParam: \'CSA Service Designs\', ' + 
                    													'customColumns: ' + customColumn + ', ' + 
                    													'onlyLinkLatest: \'true\', ' +                    													
                    													'customDql: \'' + customDql + '\'});\" ' + 
										' style=\"padding-left:4px;width:16px;height:13px;vertical-align:middle\" src=\"${baseUrl}/../design/base/skin410/img/viewArtifact/menu_launcher_small.png\"/>';
                    	
                   		return element;
                    }, 
                    width:250,
                    sortable:false
               	},{
                    header:'Version',
                    dataIndex:'deploymentSpec',
                    renderer:function (v,m,record) {
                    	/*consider as an array of json object
                    	e.g:
	                    	"deploymentSpec" : [{
									"name" : "ASAC Web",
									"_uuid" : "fb741548-1f43-47fa-9be8-170b8e46b26a",
									"version" : "1.0"
								}
							]
                    	*/
                    	if(record.data._sdmName == 'serverArtifact'){
							return '';
                    	}
                    	
                    	var element = '';
                    	if(v){
                    		var deploymentSpec = v[0];
                    		element += '<span>' + deploymentSpec.version + '</span>';
                    	}
                   		return element;
                    },
                    width:'100%',
                    sortable:false
                }]
			}],
			renderMenu: function (sourceUuid, targetUuid, name, type) {
				if(type) {
		    		icon = ' style="background-image:url(' + SERVER_URI + '../../../artifactIcon?type=' + type +'&format=small);padding-left:20px;background-repeat:no-repeat;" ';
		    	}
		    	return '<a ' + icon + ' href="javascript:void(0)" onclick="Ext4.ComponentManager.get(\'' +  this.getId() + '\').openArtifactMenu(\'' + sourceUuid + '\',\'' + targetUuid + '\',\'' + type + '\', \'' + name + '\', this)">' + name + '</a>';
		    },
		    openArtifactMenu:function(sourceUuid, uuid, type, name, element) {		        
		        var menuItems = [{
		            cls: 'context-menu-item',
		            text: '${openInCatalog}',
		            listeners:{ 'click':function () {
		                	showArtifact(uuid);
		            	}
		            }
		        }];
		        menuItems.push({
		            cls: 'context-menu-item',
		            text: '${unlinkText}',
		            listeners:{ 'click':function () {
		            	var message = 'You are about to remove link of this artifact to <b>' + name + '</b>. Are you sure?';
		            	
		            	Ext4.MessageBox.show({
		    	            title: '${title}',
		    	            msg: message,
		    	            buttons: Ext4.MessageBox.YESNO,
		    	            buttonText:{ 
		    	                yes: '${btnLink}', 
		    	                no: '${btnCancel}' 
		    	            },
		    	            icon: Ext4.MessageBox.QUESTION,
		    	            fn: function(btn){
		    	            	if(btn == 'yes'){
		    	            		removeRelatedArtifact(sourceUuid, 'realizedBy', [uuid], null, null, function(result){
		    	            			if(result=='true'){
		    	            				window.location.reload();
		    	            			}
		    	            		});
		    	            	}
		    	            }
		    	        });
		            	}
		            }
		        });
		        var menu=Ext4.create("Ext4.menu.Menu",{
		            bodyCls: 'context-menu',
		            items: menuItems
		        });
		        menu.showBy(element);
		    }
 	    });
    });
    
//]]>
</script>