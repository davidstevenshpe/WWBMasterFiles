<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="exitCustomizationMode" key="EXIT_CUSTOMIZATION_MODE" bundle="${bundle}"/>
<fmt:message var="exitCustomizationModeHint" key="EXIT_CUSTOMIZATION_MODE_HINT" bundle="${bundle}"/>
<fmt:message var="manageCustomizations" key="MANAGE_CUSTOMIZATIONS" bundle="${bundle}"/>
<fmt:message var="manageCustomizationsHint" key="MANAGE_CUSTOMIZATIONS_HINT" bundle="${bundle}"/>
<fmt:message var="createReportLabel" key="CREATE_ARTIFACT_REPORT_LABEL" bundle="${bundle}"/>
<fmt:message var="createReportHint" key="CREATE_ARTIFACT_REPORT_HINT" bundle="${bundle}"/>
<fmt:message var="showListReportLabel" key="SHOW_LIST_REPORTS_LABEL" bundle="${bundle}"/>
<fmt:message var="showListReportHint" key="SHOW_LIST_REPORTS_HINT" bundle="${bundle}"/>

<fmt:message var="addArtifactType" key="ADD_ARTIFACT_TYPE" bundle="${bundle}"/>
<fmt:message var="addArtifactTypeHint" key="ADD_ARTIFACT_TYPE_HINT" bundle="${bundle}"/>
<fmt:message var="editArtifactType" key="EDIT_ARTIFACT_TYPE" bundle="${bundle}"/>
<fmt:message var="editArtifactTypeHint" key="EDIT_ARTIFACT_TYPE_HINT" bundle="${bundle}"/>
<fmt:message var="removeArtifactType" key="REMOVE_ARTIFACT_TYPE" bundle="${bundle}"/>
<fmt:message var="removeArtifactTypeHint" key="REMOVE_ARTIFACT_TYPE_HINT" bundle="${bundle}"/>
<fmt:message var="manageRenderers" key="MANAGE_RENDERERS" bundle="${bundle}"/>
<fmt:message var="manageRenderersHint" key="MANAGE_RENDERERS_HINT" bundle="${bundle}"/>
<fmt:message var="manageTabs" key="MANAGE_TABS" bundle="${bundle}"/>
<fmt:message var="manageTabsHint" key="MANAGE_TABS_HINT" bundle="${bundle}"/>
<fmt:message var="manageArtifacts" key="MANAGE_ARTIFACTS" bundle="${bundle}"/>
<fmt:message var="manageArtifactsHint" key="MANAGE_ARTIFACTS_HINT" bundle="${bundle}"/>

<fmt:message var="customization" key="CUSTOMIZATION" bundle="${bundle}"/>
<fmt:message var="customizationShow" key="CUSTOMIZATION_SHOW" bundle="${bundle}"/>
<fmt:message var="customizationHide" key="CUSTOMIZATION_HIDE" bundle="${bundle}"/>

<fmt:message var="manageUIRolesHint" key="MANAGE_UIROLES_HINT" bundle="${bundle}"/>
<fmt:message var="manageUIRoles" key="MANAGE_UIROLES" bundle="${bundle}"/>


<c:if test="${canCustomize and customizationModeSwitch.customizationMode}">
	<div id="systinet-customize-popup" class="gradient">
		<div id="systinet-customize-popup-title">
			<h3 class="customizeTitle">
				<c:out value="${customization}"/>
				<a href="javascript:void(0);"
					id="${prefix}_custBox"
					title="Show/Hide Customization Control Panel" class="visibilityLink">
					<c:out value="${customizationHide}"/>
				</a>
			</h3>
		</div>
		<span id="systinet-customize-popup-content" class="hide">
			<div>
				<label for="${prefix}_roleSelect"><fmt:message key="manageUIRoles.selectOne" bundle="${bundle}"/>:</label><br>
				<syswf:selectOne name="selectedUiRole" value="${customizationModeSwitch}" property="selectedUiRole" mode="menu"
                                                 optionValues="${availableUiRoles}" optionValuesProperty="id"
                                                 optionCaptions="${availableUiRoles}" optionCaptionsProperty="name"
                                                 selectClass="uiRoleSelect"
                                                 id="${prefix}_roleSelect"/>
			</div>
			<div>
				<c:choose>
					<c:when test="${tabType == 'catalog'}">
						<h4>
							<fmt:message key="CATALOG" bundle="${bundle}" />
						</h4>
						<div id="systinet-customize-popup-artifact-type">
							<c:if test="${empty viewId}">
								<c:set var="viewId" value="common"/>
							</c:if>
							<c:if test="${enableCustomizeArtifactType}">
								<syswf:control id="manageArtifacts" mode="anchor" targetTask="/${viewId}/manageArtifacts" targetDepth="0" caption="${manageArtifacts}" hint="${manageArtifactsHint}"/>
								<%--
								<syswf:control id="addArtifactType" mode="anchor" targetTask="/${viewId}/addArtifactType" targetDepth="0" caption="${addArtifactType}" hint="${addArtifactTypeHint}">
									<syswf:param name="generate" value="true" />
								</syswf:control>
								<syswf:control id="editArtifactType" mode="anchor" targetTask="/${viewId}/addArtifactType" targetDepth="0" caption="${editArtifactType}" hint="${editArtifactTypeHint}">
									<syswf:param name="generate" value="false" />
								</syswf:control>
								<syswf:control id="removeArtifactType" mode="anchor" targetTask="/${viewId}/removeArtifactType" targetDepth="0" caption="${removeArtifactType}" hint="${removeArtifactTypeHint}" />
								 --%>
							</c:if>
							<%--
							<syswf:control id="manageRenderers" mode="anchor" targetTask="/${viewId}/manageRenderers" targetDepth="0" caption="${manageRenderers}" hint="${manageRenderersHint}" />
							--%>
							<syswf:component name="/core/customization/categories/manageCategoriesLink" prefix="catMgm">
								<syswf:param name="wrap" value="false"/>
							</syswf:component>
						</div>
					</c:when>

					<c:when test="${tabType == 'reports'}">
						<h4>
							<fmt:message key="REPORTS" bundle="${bundle}" />
						</h4>
						<div id="systinet-customize-popup-artifact-report">
							<syswf:control id="createArtifactReport" mode="anchor" targetTask="/reports/artifact/createArtifactReport" targetDepth="0" caption="${createReportLabel}" hint="${createReportHint}">
							</syswf:control>
							<syswf:control id="browseArtifactReport" mode="anchor" targetTask="/reports/artifact/browseArtifactReport" targetDepth="0" caption="${showListReportLabel}" hint="${showListReportHint}">
							</syswf:control>
						</div>
					</c:when>
				</c:choose>
			</div>
			<div>
				<syswf:control id="manageTabs" mode="anchor" targetTask="/${viewId}/manageTabs" targetDepth="0" caption="${manageTabs}" hint="${manageTabsHint}"/>
				<syswf:control id="manageUIRoles" mode="anchor" targetTask="/${viewId}/manageUIRoles" targetDepth="0" caption="${manageUIRoles}" hint="${manageUIRolesHint}"/>
                <syswf:control id="manageCustomizations" mode="anchor" targetTask="/${viewId}/manageCustomizations" targetDepth="0" caption="${manageCustomizations}" hint="${manageCustomizationsHint}"/>
				<hr />
				<syswf:control id="exitCustomizationMode" action="exitCustomizationMode" mode="anchor" caption="${exitCustomizationMode}" hint="${exitCustomizationModeHint}"/>
			</div>
		</span>
	</div>

	 <syswf:control mode="script" caption="${prefix}_roleChanged" action="roleChanged"/>

	  <script type="text/javascript">
 //<![CDATA[
          Ext.onReady(function(){

        	  var browserWidth = window.innerWidth;
        	  if (Ext.isIE6 || Ext.isIE7 || Ext.isIE8) {
        		  browserWidth = document.body.clientWidth;
        	  }

        	  var custBox = Ext.get('systinet-customize-popup');
        	  /*window.innerWidth - a - b
        	  	a: width of customization box
        	  	b: distance between box's right edge and browser's right edge (as same as CSS's right properties)*/
        	  custBox.setLeft(browserWidth - 190 - 20);
        	  custBox.setTop(20);

        	  Float.init(document.getElementById('systinet-customize-popup-title'), document.getElementById('systinet-customize-popup'));

              function openHideDialog(){
              	if (document.getElementById('systinet-customize-popup-content').className=='hide'){
              		document.getElementById('systinet-customize-popup-content').className='';
              		setCookie("isHideCustBox","false",'1');
              		document.getElementById('${prefix}_custBox').innerHTML='${customizationHide}';
           		}else{
           			document.getElementById('systinet-customize-popup-content').className='hide';
           			setCookie("isHideCustBox","true",'1');
           			document.getElementById('${prefix}_custBox').innerHTML='${customizationShow}';
       			}
              }

				attachOn('${prefix}_roleSelect','change',function() {
		   	  		${prefix}_roleChanged();
				});

				attachOn('${prefix}_custBox','click',function() {
					openHideDialog();
				});

				var isHide = getCookie("isHideCustBox");
				if(isHide != undefined){
					if(isHide == 'true'){
						document.getElementById('systinet-customize-popup-content').className='hide';
						document.getElementById('${prefix}_custBox').innerHTML='${customizationShow}';
					}
					if(isHide == 'false'){
						document.getElementById('systinet-customize-popup-content').className='';
						document.getElementById('${prefix}_custBox').innerHTML='${customizationHide}';
					}
				}else{
					document.getElementById('systinet-customize-popup-content').className='';
					document.getElementById('${prefix}_custBox').innerHTML='${customizationHide}';
				}
          });
//]]>
     </script>
</c:if>
