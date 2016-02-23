<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="checkingStatus" key="uddi.integrationSection.checkingStatus" bundle="${l10n}"/>
<fmt:message var="refreshLink" key="uddi.integrationSection.refreshLink" bundle="${l10n}"/>
<fmt:message var="technicalDetail_link" key="technicalDetail" bundle="${l10n}"/>
<fmt:message var="technicalDetail_title" key="technicalDetail" bundle="${l10n}"/>
<fmt:message var="ok_label" key="technicalDetail_ok_label" bundle="${l10n}"/>

<syswf:control mode="script" action="refreshStatus" formName="ContentForm" caption="reload${prefix}" affects="." />

<c:choose>
    <c:when test="${uddiIntegrationSectionBean.statusIcon eq null}">
        <div id="divreload${prefix}">
                <%-- do AJAX call --%>
            <script type="text/javascript">
			//<![CDATA[
			
			                manageInterval('reload${prefix}');
			            
			//]]>
			</script>
      <span class="UI Icon Working">
            <syswf:out value="${checkingStatus}" context="HtmlBody"/>
      </span>
        </div>
    </c:when>
    <c:otherwise>
        <div>
            <h4 class="Subheader">
                <syswf:component name="/integration2/uddi/common/uddiServerLinker" prefix="serverLinker" wrap="false">
		           <syswf:param name="serverName" value="${uddiIntegrationSectionBean.uddiServer.name}"/>
		           <syswf:param name="serverUUID" value="${uddiIntegrationSectionBean.uddiServer._uuid}"/>
		        </syswf:component>           
            </h4>
            <label>Status:</label>

            <span class="${uddiIntegrationSectionBean.statusIcon}" >
            	<syswf:out value="${uddiIntegrationSectionBean.statusText}" context="HtmlBody"/>				
			</span>			

			<c:if test="${not empty uddiIntegrationSectionBean.errorHint}"> 
				(<a id="${prefix}_uilink_techdetails" href="javascript:void(0);">${technicalDetail_link}</a>)
			
				<script type="text/javascript">
				//<![CDATA[
				
				    Ext.onReady(function() {
				    	SPopup.Window.Instance['${prefix}_techdetails-win'] = undefined;
				        Ext.get('${prefix}_uilink_techdetails').on('click', function() {
				            SPopup.Window.forceOpen('${prefix}_techdetails-win', '${prefix}_technical_details_content', {
				                id: '${prefix}_techdetails-win',
				                width: 640,
				                height: 320,
				                autoScroll: true,
				                resizable: true,
				                wrap: true,
				                plain: false,
				                cls: 'hp-stacktrace-window',
				                centerOnScreen: true,
				                buttonAlign: 'center',
				                buttons: [{
				                    text: '${ok_label}',
				                    handler: function() {
				                        SPopup.Window.Instance['${prefix}_techdetails-win'].hide();
				                    }
				                }
				            ]});
				        });
				    });
					            
				//]]>
				</script>
	                 
	            <div class="webfw-Window" id="${prefix}-webfw-Window">      
				<div id="${prefix}_technical_details_content" class="x-hidden">
				    <div class="x-window-header"><syswf:out value="${technicalDetail_title}" context="HtmlBody"/></div>
				    <div class="x-window-body">
				        <div class="UI Offset">
				            <pre><c:out value="${uddiIntegrationSectionBean.errorHint}" escapeXml="true"/></pre>
				        </div>
				    </div>
	            </div>
	            </div>
			</c:if>
            
            <c:choose>
                <c:when test="${uddiIntegrationSectionBean.statusText eq 'Offline'}">
                	<syswf:control id="refresh" mode="anchor" action="refresh" caption="${refreshLink}" affects="." />
                </c:when>
                <c:otherwise>
                    <syswf:component name="/integration2/uddi/artifact/actions/uddiIntegrationArtifactDetailAction" prefix="${prefix}_detailActions">
                        <syswf:param name="dataIntegration" value="${dataIntegration}" />
                    </syswf:component>
                </c:otherwise>            
             </c:choose>
        </div>
    </c:otherwise>
</c:choose> 
