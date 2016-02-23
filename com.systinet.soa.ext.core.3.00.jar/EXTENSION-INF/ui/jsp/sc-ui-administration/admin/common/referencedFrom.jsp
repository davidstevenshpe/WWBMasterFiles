<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="messages" />
<fmt:message var="moreLinks" key="referencedFrom_moreLinks" bundle="${messages}" />
<fmt:message var="okButtonLabel" key="referencedFrom_moreLinksWindow_okButtonLabel" bundle="${messages}" />
<fmt:message var="loadingStatus" key="referencedFrom_references_loading" bundle="${messages}" />

<syswf:control mode="script" action="refreshReferences" formName="ContentForm" caption="reload${prefix}" affects="." />

<c:choose>
	<c:when test="${not finishLoadingReferences}">
		<div id="divreload${prefix}">
			<%-- do AJAX call --%> 
			<script	type="text/javascript">
                //<![CDATA[
				manageInterval('reload${prefix}');
                //]]>
	        </script> 
	        <span class="UI Icon Working"><syswf:out value="${loadingStatus}" context="HtmlBody"/></span>
	    </div>
	</c:when>
	<c:otherwise>
		<c:if test="${not empty linkedArtifacts}">
			<syswf:component name="/admin/common/referencedFromMoreLinks" prefix="${prefix}linkedArtifacts">
				<syswf:param name="allLinkedArtifacts" value="${linkedArtifacts}" />
			</syswf:component>
			<c:if test="${showMoreLink}">
				<div class="Footer">
					<span> 
						<a href="javascript:void(0);" id="${prefix}showMore"><syswf:out value="${moreLinks}" context="HtmlBody"/></a>
					</span>
				</div>

				<div class="webfw-Window" id="${prefix}-webfw-Window">
					<div id="${prefix}moreLinkWindow" class="x-hidden">
						<div class="x-window-header"><syswf:out value="${referencedFromTitle}" context="HtmlBody"/></div>
							<div class="x-window-body">
								<div class="UI Offset">
									<syswf:component name="/admin/common/referencedFromMoreLinks" prefix="${prefix}moreLinks">
										<syswf:param name="allLinkedArtifacts" value="${allLinkedArtifacts}" />
									</syswf:component>
								</div>
							</div>
						</div>
					</div>

				<c:set var="winCustomButtons">
			        [{
			            text     : '${okButtonLabel}',
			            handler  : function(){
			                SPopup.Window.Instance['${prefix}moreLinkWindow'].hide();
			                return false;
			            },
			            id: '${winOkButtonId}'
			        }]
			    </c:set>

				<script type="text/javascript">
				//<![CDATA[

					Ext.onReady(function(){
						attachOn('${prefix}showMore','click',function() {		
							SPopup.Window.forceOpen('${prefix}moreLinkWindow','${prefix}moreLinkWindow',{						         
						        buttons: ${winCustomButtons},
						        buttonAlign: 'center', 
						        width: 300, 
						        height: 400,
						        autoScroll: true,
						        resizable: false, 
						        centerOnScreen: true
						    });    
					    });	
					});
				//]]>                    
				</script>
			</c:if>
		</c:if>
		<c:if test="${empty linkedArtifacts}">
			<fmt:message key="referencedFrom_empty" bundle="${messages}" />
		</c:if>
	</c:otherwise>
</c:choose>