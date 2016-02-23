<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.cloudmigration" var="messages"/>
<fmt:message key="csa.publishing.wizard.serviceDesignNameLabel" var="serviceDesignNameLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.selectInfrastructureServiceLabel" var="selectInfrastructureServiceLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.selectTargetDataCenterLabel" var="selectTargetDataCenterLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.selectCSAServerLabel" var="selectCSAServerLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.step1Title" var="step1Title" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.buttonNextLabel" var="buttonNextLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.buttonCancelLabel" var="buttonCancelLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.message" var="boxMessage" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.title" var="boxTitle" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.csaInterations" var="boxCsaInterations" bundle="${messages}"/>

<syswf:control mode="script" caption="${prefix}_nextStep" action="nextStep" targetTask="/cloud/migration/csa/startCSAPublishingFinish">
	<syswf:param name="artifactUuid" value="${artifactUuid}"/>
</syswf:control>
<syswf:control mode="script" caption="${prefix}_nextStepBuiltIn" action="nextStepBuiltIn" targetTask="/cloud/migration/csa/startCSAPublishingBuiltInModel">
	<syswf:param name="artifactUuid" value="${artifactUuid}"/>
	<syswf:param name="bean" value="${bean}"/>
</syswf:control>
<syswf:control mode="script" caption="${prefix}_cancel" action="cancel" targetTask="/artifact/${artifactUuid}">
	<syswf:param name="tabId" value="cloudMigration"/>
	<syswf:param name="subTabId" value="deploymentModels"/>
</syswf:control>
<c:set var="isAdmin">${bean.admin}</c:set>
<c:if test="${not isAdmin}">
	<div class="alert alert-warning" style="display: none;">
		<fmt:message key="csa.publishing.wizard.boxed.warn.csaInterations" bundle="${messages}"/>				
	</div>
</c:if>
<div class="boxed">
	<div id="content-container">
		<div id="page-content" ng-controller="emCommonController">
			<div class="panel">
				<div id="csaPublishing-container" class="eq-height clearfix csaPublishing">
					<div id="csaPublishing-start-wz" class="col-md-5 eq-box-md eq-no-panel ng-isolate-scope">
						<h2>${step1Title}</h2>
						<p class="text-muted"><em></em></p>
						<div class ="csa-property">
							<button class="btn btn-gray btn-labeled em fa fa-info-circle" onclick="return emCommon.toggleHelpText(this, 'csaPublishing-start-wz')" help-text="less">
								<span>Show more information</span>
							</button>
						</div>
						<div class="property">
							<div>${serviceDesignNameLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.serviceDesignName.helpText" bundle="${messages}"/></div>
							<div class ="csa-property" input-text-csa data="serviceDesignName" maxlength="200"></div>
						</div>
						<div class="csa-read-only property">
							<div>${selectInfrastructureServiceLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.selectInfrastructureService.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
                                <syswf:out value="${bean.selectedISAName}" context="HtmlBody"/>
                            </div>
						</div>
						<div class="property">
							<div>${selectTargetDataCenterLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.selectTargetDataCenter.helpText" bundle="${messages}"/></div>
							<div class ="csa-property">
								<syswf:selectOne id="${prefix}_dataCentersId" name="${prefix}_dataCenters" mode="menu"
	                                     optionValues="${bean.dataCenters.first}"
	                                     optionCaptions="${bean.dataCenters.second}"
	                                     value="${bean}" property="selectedDataCenterName"/>
			                    <script type="text/javascript">
								//<![CDATA[
			                        Ext.onReady(function() {
			                        	var disabled = $('#${prefix}_selectedDataCenter').val() === 'No Data Centers Available';
			                            var var_${prefix}_dataCentersId = new Ext4.form.ComboBox({
			                                id: '${prefix}_dataCentersId',
			                                transform: '${prefix}_dataCentersId',
			                                forceSelection: true,
			                                typeAhead: false,
			                                disableKeyFilter: false,
			                                editable: false,
			                                width: 800,
			                                disabled: disabled,
		                                	width: '100%',
			                                listConfig: {
			                                	cls: {'width' : '100%'}
			                                },
			                                formItemCls : 'csa-combobox',
			            					listeners:{
			            						scope: this,
												change: function (comp, value) {
													$('#${prefix}_selectedDataCenterName').val(comp.getRawValue());
													$('#${prefix}_selectedDataCenter').val(value);
												},
												afterRender: function (comp) {
													comp.setValue('${bean.selectedDataCenter}');
												}
			            					}
			                            });
			                            $('.csa-combobox  .x4-form-trigger-wrap').css('width', '100%');
			                            $('#${prefix}_dataCentersId.csa-combobox  .x4-form-trigger-wrap').css('line-height', '28px');
			                        });
								//]]>
			                    </script>
                    		</div>
						</div>						
						<div class="property">
							<div>${selectCSAServerLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.selectCSAServer.helpText" bundle="${messages}"/></div>
							<div class ="csa-property">
								<syswf:selectOne id="${prefix}_csaServersId" name="${prefix}_csaServers" mode="menu"
	                                     optionValues="${bean.csaServers.first}"
	                                     optionCaptions="${bean.csaServers.second}"
	                                     value="${bean}" property="selectedCSAName"/>
			                    <script type="text/javascript">
								//<![CDATA[
			                        Ext.onReady(function() {
			                        	var disabled = $('#${prefix}_selectedCSA').val() === 'No CSA Servers Available';
			                            var var_${prefix}_csaServersId = new Ext4.form.ComboBox({
			                                id: '${prefix}_csaServersId',
			                                transform: '${prefix}_csaServersId',
			                                forceSelection: true,
			                                typeAhead: false,
			                                disableKeyFilter: false,
			                                editable: false,
			                                disabled: disabled,
		                                	width: '100%',
			                                listConfig: {
			                                	cls: {'width' : '100%'}
			                                },
			                                formItemCls : 'csa-combobox',
			            					listeners:{
			            						scope: this,
												change: function (comp, value) {
													$('#${prefix}_selectedCSA').val(value);
													$('#${prefix}_selectedCSAName').val(comp.getRawValue());
												},
												afterRender: function (comp) {
													comp.setValue('${bean.selectedCSA}');
												}
			            					}
			                            });
			                            $('.csa-combobox  .x4-form-trigger-wrap').css('width', '100%');
			                            $('#${prefix}_csaServersId.csa-combobox  .x4-form-trigger-wrap').css('line-height', '28px');
			                        });
								//]]>
			                    </script>
                    		</div>	
						</div>
						<div class="pad-no pad-btm csa-button">						
							<button id="cancel-wz-start-button" type="button" class="cancel btn btn-primary">${buttonCancelLabel}</button>
							<button id="next-wz-start-button" type="button" ng-class='(serviceDesignName.value == null || serviceDesignName.value == "") ? "disabled" : "${bean.disabledNextButton}"' class="next btn btn-primary">${buttonNextLabel}</button>
						</div>
					</div>
					<div id="info-container" class="col-md-5 eq-box-md text-center box-vmiddle-wrap bg-primary">
						<div survey-info="" class="box-vmiddle pad-all ng-isolate-scope" preview-link="true" survey-instance="surveyInstance" theme="surveyDefinition.survey.theme">
							<div class="content definition-name" ng-switch="" on="previewLink">
								<h2 class="text-thin" style="padding-bottom: 30px;">${boxTitle}</h2>
							</div>
							<span class="icon-wrap icon-wrap-lg icon-circle bg-trans-light"> <i class="fa fa-cloud fa-5x text-primary"></i></span>
							<div class="csaPublishing-box-message">${boxMessage}</div>
							<a id="csa-integration-link" target="_blank" class="btn btn-lg btn-primary btn-labeled fa fa-arrow-right"
								href="">${boxCsaInterations}</a>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<syswf:input mode="hidden" name="selectedCSA" value="${bean}" property="selectedCSA" />
<syswf:input mode="hidden" name="selectedCSAName" value="${bean}" property="selectedCSAName" />
<syswf:input mode="hidden" name="selectedDataCenter" value="${bean}" property="selectedDataCenter" />
<syswf:input mode="hidden" name="selectedDataCenterName" value="${bean}" property="selectedDataCenterName" />
<syswf:input mode="hidden" name="serviceDesignName" value="${bean}" property="serviceDesignName" />

<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/skinem/angular/js/angular.min.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/common/controller.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/common/view.js"></script>
<script type="text/javascript">
//<![CDATA[
	emCommonApp.directive("inputTextCsa", function() {
		return {
			scope: {
				data: '='
			},
			template :'<input type="text" class="form-control ng-pristine ng-untouched ng-valid ng-valid-maxlength" ng-model="data.value"/>'
		}
	});
	
	emCommon.dataScope['serviceDesignName'] = {value:'<syswf:out value="${bean.serviceDesignName}" context="HtmlJSText"/>'};

	$('#${prefix}_selectedDataCenter').val('<syswf:out value="${bean.selectedDataCenter}" context="HtmlJSText"/>');
	$('#${prefix}_selectedDataCenterName').val('<syswf:out value="${bean.selectedDataCenterName}" context="HtmlJSText"/>');
	
	$('#${prefix}_selectedCSA').val('<syswf:out value="${bean.selectedCSA}" context="HtmlJSText"/>');
	$('#${prefix}_selectedCSAName').val('<syswf:out value="${bean.selectedCSAName}" context="HtmlJSText"/>');
	
	$(document).ready(function () {
		
    	$("#next-wz-start-button").addClass("${bean.disabledNextButton}");
		if ('${isAdmin}' === 'true') {
		    if('${not empty bean.csaServiceDesignsDomain}') {
		        $("#csa-integration-link").attr('href', SERVER_URI + '/../../service-catalog/artifact/' + '${bean.csaServiceDesignsDomain}' + "?tabId=servers");
		    } else {
		        $("#csa-integration-link").attr('href', SERVER_URI + '/../../service-catalog/artifact/' + '${bean.currentDomain}' + "?tabId=servers");
		    }
		} else {
			$("#csa-integration-link").click(function(){
				$(".alert.alert-warning").show("slow");
			});
		}
	    $('#cancel-wz-start-button').click(function(){
	    	${prefix}_cancel('${bean.artifactUuid}');
	    });   
	    
	    $('#next-wz-start-button').click(function(){
	    	$('#${prefix}_serviceDesignName').val(emCommon.dataScope['serviceDesignName'].value);
	        ${prefix}_nextStep('${bean.artifactUuid}');
	    });
	    layoutManager.loadStyle(['<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/survey.css']);
       	
	});
//]]>
</script>