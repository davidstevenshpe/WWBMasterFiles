<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<fmt:message var="inProgress_label" key="status.inProgress_label" bundle="${report_Message}"/>
<fmt:message var="complete_label" key="status.complete" bundle="${report_Message}"/>
<fmt:message var="completeError_label" key="status.completeError_label" bundle="${report_Message}"/>
<fmt:message var="completeWarning_label" key="status.completeWarning_label" bundle="${report_Message}"/>
<fmt:message var="technicalDetail_link" key="status.technicalDetail_link" bundle="${report_Message}"/>
<fmt:message var="technicalDetail_title" key="status.technicalDetail_title" bundle="${report_Message}"/>
<fmt:message var="ok_label" key="status.ok_label" bundle="${report_Message}"/>

<div class="UI SystemMessage <c:choose><c:when test="${executionResult eq 'error'}">Error</c:when><c:when test="${executionResult eq 'warning'}">Warning</c:when><c:otherwise>Done</c:otherwise></c:choose>">
    <div class="MessageContainer Icon <c:choose><c:when test="${executionRunning}">NotCompleted</c:when><c:otherwise>Completed</c:otherwise></c:choose>">
        <c:if test="${executionRunning || forceShowProgress}">
        	    <syswf:component name="/core/impl/widgets/progressBar" prefix="inReport" wrap="false">
			       <syswf:param name="statusGetter" value="${statusGetter}"/>
			       <syswf:param name="isRunning" value="${executionRunning}"/>
			    </syswf:component>
        </c:if>

        <div class="Text">
            <c:choose>
                <c:when test="${executionRunning}">
                    <strong>${inProgress_label}</strong><br/>
		            <span class="UI Icon Comment">${progressMessage}</span>    
                </c:when>
                <c:when test="${not executionRunning and executionResult eq 'error'}">
                    <strong>${completeError_label}</strong><br/>
                    <span class="UI Icon Comment">${completeMessage}</span>
                </c:when>
                <c:when test="${not executionRunning and executionResult eq 'warning'}">
                    <strong>${completeWarning_label}</strong><br/>
                    <span class="UI Icon Comment">${completeMessage}</span>
                </c:when>
                <c:otherwise>
                    <strong>${complete_label}</strong><br/>
                    <span class="UI Icon Comment">${completeMessage}</span>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${executionResult eq 'error' and not empty resultStacktrace}">
            <div class="ErrorDetails">
                <a id="uilink_techdetails" href="javascript:void(0);" class="UI Icon ViewDetails">${technicalDetail_link}</a>

                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        Ext.get('uilink_techdetails').on('click', function() {
                            SPopup.Window.forceOpen('techdetails-win', 'technical_details_content', {
                                id: 'techdetails-win',
                                width: 640,
                                height: 320,
                                autoScroll: true,
                                resizable: true,
                                plain: false,
                                cls: 'hp-stacktrace-window',
                                centerOnScreen: true,
                                buttonAlign: 'center',
                                buttons: [{
                                    text: '${ok_label}',
                                    handler: function() {
                                        // do your code
                                        SPopup.Window.Instance['techdetails-win'].hide();
                                    }
                                }
                            ]});
                        });
                    });
                
//]]>
</script>
           
            
                <div id="technical_details_content" class="x-hidden">
                    <div class="x-window-header">${technicalDetail_title}</div>
                    <div class="x-window-body">
                        <div class="UI Offset">
                            <pre><c:out value="${resultStacktrace}" escapeXml="true"/></pre>
                        </div>
                    </div>
                </div>
            </div>

        </c:if>
        </div>
    <div class="x-clear"></div>   
            
</div>