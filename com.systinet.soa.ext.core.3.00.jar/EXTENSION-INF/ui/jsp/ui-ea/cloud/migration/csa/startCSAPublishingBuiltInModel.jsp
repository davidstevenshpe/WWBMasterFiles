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
<fmt:message key="csa.publishingBuiltInModel.wizard.boxed.message" var="boxMessage" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.title" var="boxTitle" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.csaInterations" var="boxCsaInterations" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.buttonPublishLabel" var="buttonPublishLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.buttonPreviousLabel" var="buttonPreviousLabel" bundle="${messages}"/>

<syswf:control mode="script" caption="${prefix}_nextStep" action="nextStep" targetTask="/artifact/${artifactUuid}">
    <syswf:param name="artifactUuid" value="${artifactUuid}"/>
</syswf:control>
<<c:choose>
    <c:when test="${directly}">
        <syswf:control mode="script" caption="${prefix}_previous" action="cancel" targetTask="/artifact/${artifactUuid}">
		    <syswf:param name="tabId" value="cloudMigration"/>
		    <syswf:param name="subTabId" value="deploymentModels"/>
		</syswf:control>
		<c:set var="buttonPreviousLabel" value="${buttonCancelLabel}"></c:set>
    </c:when>
    <c:otherwise>
		<syswf:control mode="script" caption="${prefix}_previous" action="previous" targetTask="/cloud/migration/csa/startCSAPublishing">
		    <syswf:param name="artifactUuid" value="${artifactUuid}"/>
		</syswf:control>
    </c:otherwise>
</c:choose>

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
			                        Ext4.onReady(function() {
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
							<button id="previous-wz-start-button" type="button" class="cancel btn btn-primary">${buttonPreviousLabel}</button>
                            <button id="next-wz-start-button" type="button" ng-class='(serviceDesignName.value == null || serviceDesignName.value == "") ? "disabled" : "${bean.disabledNextButton}"' class="next btn btn-primary">${buttonPublishLabel}</button>
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
	
	$('#${prefix}_selectedCSA').val('<syswf:out value="${bean.selectedCSA}" context="HtmlJSText"/>');
	$('#${prefix}_selectedCSAName').val('<syswf:out value="${bean.selectedCSAName}" context="HtmlJSText"/>');
	
	$(document).ready(function () {
    	$("#next-wz-start-button").addClass("${bean.disabledNextButton}");
    	
    	if ('${isAdmin}' === 'true') {
			$("#csa-integration-link").attr('href', SERVER_URI + '/../../service-catalog/artifact/' + '${bean.currentDomain}' + "?tabId=servers");
		} else {
			$("#csa-integration-link").click(function(){
				$(".alert.alert-warning").show("slow");
			});
		}
    	
		$('#previous-wz-start-button').click(function(){
            ${prefix}_previous('${bean.artifactUuid}');
        });   
        
        $('#next-wz-start-button').click(function(){
        	$('#${prefix}_serviceDesignName').val(emCommon.dataScope['serviceDesignName'].value);
            ${prefix}_nextStep('${bean.artifactUuid}');
        });
	    layoutManager.loadStyle(['<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/survey.css']);
       	
	});
//]]>
</script>