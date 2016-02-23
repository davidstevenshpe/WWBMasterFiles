<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<fmt:message var="lifecycleStatusApproved" key="lifecycleStatus.APPROVED" bundle="${messages}"/>
<fmt:message var="lifecycleStatusRejected" key="lifecycleStatus.REJECTED" bundle="${messages}"/>
<fmt:message var="lifecycleStatusFailed" key="lifecycleStatus.FAILED" bundle="${messages}"/>
<fmt:message var="lifecycleStatusVoting" key="lifecycleStatus.VOTING" bundle="${messages}"/>
<fmt:message var="lifecycleStatusInProgress" key="lifecycleStatus.INPROGRESS" bundle="${messages}"/>
<fmt:message var="lifecycleStatusChanged" key="lifecycleStatus.CHANGED" bundle="${messages}"/>
<fmt:message key="startGov_buttonLabel" var="startGov_buttonLabel" bundle="${messages}"/>
<fmt:message key="startGov_dialogTitle" var="startGov_dialogTitle" bundle="${messages}"/>
<fmt:message key="startGov_dialogText" var="startGov_dialogText" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="OK" var="OK" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

<syswf:block className="Block UI Plain">
	<div class="Title">
		<h3>
			<span class="IconAlign"><c:out value="Lifecycle" escapeXml="false"/></span>
		</h3>
	</div>
</syswf:block>

<br/>

<syswf:block className="UI Block Plain">
<div style="padding-left:20px;">
<c:choose>
	<c:when test="${not empty this.stageName}">		
        <c:choose>
              <c:when test="${this.lifecycleStatus eq 'APPROVED'}">
                  <c:set var="statusIcon" value="EventApproved"/>
                  <c:set var="statusText" value="${lifecycleStatusApproved}"/>
              </c:when>
              <c:when test="${this.lifecycleStatus eq 'REJECTED'}">
                  <c:set var="statusIcon" value="EventRejected"/>
                  <c:set var="statusText" value="${lifecycleStatusRejected}"/>
              </c:when>
              <c:when test="${this.lifecycleStatus eq 'FAILED'}">
                  <c:set var="statusIcon" value="EventFailed"/>
                  <c:set var="statusText" value="${lifecycleStatusFailed}"/>
              </c:when>                
              <c:when test="${this.lifecycleStatus eq 'VOTING'}">
                  <c:set var="statusIcon" value="EventVoted"/>
                  <c:set var="statusText" value="${lifecycleStatusVoting}"/>
              </c:when>
              <c:when test="${this.lifecycleStatus eq 'INPROGRESS'}">
                  <c:set var="statusIcon" value="EventUserActionPending"/>
                  <c:set var="statusText" value="${lifecycleStatusInProgress}"/>
              </c:when>
              <c:when test="${this.lifecycleStatus eq 'CHANGED'}">
                  <c:set var="statusIcon" value="EventApproved"/>
                  <c:set var="statusText" value="${lifecycleStatusChanged}"/>
              </c:when>
        </c:choose>
        <span class="UI Icon ${statusIcon}">${statusText}</span>
        	<c:choose>
        		<c:when test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:accepted' and proxyMgmtEnabled and statusModel.allowDeployment}">
		           	<fmt:message key="lifecycleStatus.messageWithDeployMessage" bundle="${messages}">
		                <fmt:param>
		                    <syswf:component prefix="link" name="/core/impl/util/artifactLinkRenderer" wrap="false">
		                        <syswf:param name="uuid" value="${this.uuid}"/>
		                        <syswf:param name="artifactTabId" value="lifecycle"/>
		                        <syswf:param name="caption">
		                            <fmt:message key="lifecycleStatus.linkCaption" bundle="${messages}"/>
		                        </syswf:param>
		                        <syswf:param name="style" value="color:green;"/>
		                    </syswf:component>
		                </fmt:param>
		                <c:set var="deployMessage" value=""/>
		                <c:choose>                			
                			<c:when test="${statusModel.deployed}">
                				<c:set var="deployMessage"><fmt:message key="lifecycleStatus.undeployMessage" bundle="${messages}"/></c:set>
                			</c:when>
                			<c:otherwise>
                				<c:set var="deployMessage"><fmt:message key="lifecycleStatus.deployMessage" bundle="${messages}"/></c:set>                				
                			</c:otherwise>		                	
		                </c:choose>
			             <fmt:param>
			                    <syswf:component name="/contract/actions/deployUndeployContract" prefix="deployUndeploy" wrap="false">
			                    	<syswf:param name="statusModel" value="${statusModel }"/>
			                    	<syswf:param name="deployMessage" value="${deployMessage }"/>
			                    	<syswf:param name="artifact" value="${artifact }"/>
			                    </syswf:component>
			                </fmt:param>
			            </fmt:message>
			            <c:if test="${not statusModel.deployed}">
			            	<syswf:component name="/provision/createProxyWindow" prefix="create" wrap="false"/>
			            </c:if>           
        		</c:when>
        		<c:otherwise>
       				<fmt:message key="lifecycleStatus.message" bundle="${messages}">
		                <fmt:param>
		                    <syswf:component prefix="link" name="/core/impl/util/artifactLinkRenderer" wrap="false">
		                        <syswf:param name="uuid" value="${this.uuid}"/>
		                        <syswf:param name="artifactTabId" value="lifecycle"/>
		                        <syswf:param name="caption">
		                            <fmt:message key="lifecycleStatus.linkCaption" bundle="${messages}"/>
		                        </syswf:param>
		                        <syswf:param name="style" value="color:green;"/>
		                    </syswf:component>
		                </fmt:param>
		         	</fmt:message>
		         	<div style="margin-top:15px"/>
        		</c:otherwise>
        	</c:choose>        	
	</c:when>
	<c:otherwise>
		<syswf:control mode="script" caption="startDefaultGovernancePost" action="startDefaultGovernanceAction"/>
		<c:set var="icon">Ext.MessageBox.INFO</c:set>
	    <c:set var="startGovernanceButtons">
	        [{
	            text     : '${OK}',
	            disabled : true,
	            handler  : function() {
	                startGovernancePost();
	                SPopup.Window.Instance['startGovernancePopup_win'].hide();
	            },
	            id: 'startGovernance_okButton'
	        },{
	            text     : '${Cancel}',
	            handler  : function(){
	                SPopup.Window.Instance['startGovernancePopup_win'].hide();
	                return false;
	            },
	            id: 'startGovernance_cancelButton'
	        }]
	    </c:set>
	    <syswf:component name="/core/window" prefix="catMgm">
	        <syswf:param name="winId" value="startGovernancePopup_win" />
	        <syswf:param name="winTitle">${startGov_dialogTitle}</syswf:param>
	        <syswf:param name="winComponent" value="/newUi/lc/catalog/button/startGovernance"/>
	        <syswf:param name="winCustomButtons" value="${startGovernanceButtons}" />
	        <syswf:param name="winOpenFunctionName" value="StartGovernance_open" />
	        <syswf:param name="winWidth" value="400" />
	        <syswf:param name="artifactUuid" value="${this.uuid}" />
			<syswf:param name="hasDefaultProcess" value="${this.hasDefaultProcess}" />
	        <syswf:param name="winRenderContents" value="true" />
	        <syswf:param name="winForceRefresh" value="false" />
	    </syswf:component>
	    <%-- Show info message with link to start governance --%>
        <fmt:message var="infoMsgLink" key="lftab_info_startGovernance_link" bundle="${messages}"/>
        <fmt:message var="infoMsg" key="lftab_info_startGovernance_msg" bundle="${messages}"/>
        <c:if test="${this.canStartGovernance}">
            <fmt:message var="infoMsg2" key="lftab_info_startGovernance_msg_link" bundle="${messages}">
                <fmt:param>
                    <a id="infoMsgStartGovLink" href="javascript:void(0);" style="color:green;"><c:out value="${infoMsgLink}"/></a>
                </fmt:param>
            </fmt:message>
        </c:if>
           <c:out value="${infoMsg}" escapeXml="false" />
            <c:if test="${this.canStartGovernance}">
            	<c:out value=" ${infoMsg2}" escapeXml="false" />
            </c:if>
            <c:if test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:accepted' and proxyMgmtEnabled and statusModel.allowDeployment}">
            	<c:choose>
            		<c:when test="${statusModel.deployed}">
            			<c:set var="deployMessage"><fmt:message key="lifecycleStatus.undeployMessage" bundle="${messages}"/></c:set>
            			<c:set var="deployUndeployWithoutLifecycleMessageKey" value="lifecycleStatus.undeployWithoutLifecycle"/>
            		</c:when>
            		<c:otherwise>
            			<c:set var="deployMessage"><fmt:message key="lifecycleStatus.deployMessage" bundle="${messages}"/></c:set>
            			<c:set var="deployUndeployWithoutLifecycleMessageKey" value="lifecycleStatus.deployWithoutLifecycle"/>
            		</c:otherwise>
            	</c:choose>
            	<fmt:message key="${deployUndeployWithoutLifecycleMessageKey }"  bundle="${messages}">
           			<fmt:param>
           				<syswf:component name="/contract/actions/deployUndeployContract" prefix="deployUndeploy" wrap="false">
		                	<syswf:param name="statusModel" value="${statusModel }"/>
		                	<syswf:param name="deployMessage" value="${deployMessage }"/>
		                	<syswf:param name="artifact" value="${artifact }"/>
		            	</syswf:component>
           			</fmt:param>
           		</fmt:message>
           		<c:if test="${not statusModel.deployed}">
			    	<syswf:component name="/provision/createProxyWindow" prefix="create" wrap="false"/>
			    </c:if>
            </c:if>
           <c:if test="${this.canStartGovernance}">
           		<script type="text/javascript">
				//<![CDATA[
	                attachOn('infoMsgStartGovLink','click',function() {
	                    <c:if test="${not this.hasDefaultProcess}">
	                        StartGovernance_open();
	                        StartGovernance_enableOk();
	                    </c:if>
	                    <c:if test="${this.hasDefaultProcess}">
	                        startDefaultGovernancePost();
	                    </c:if>
	                });
				//]]>
				</script>
            </c:if>
            <div style="margin-top:15px"/>
	</c:otherwise>
</c:choose>
</div>
</syswf:block>