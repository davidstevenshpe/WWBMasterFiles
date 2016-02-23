<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
Parameters:
   + resourceStatus [OPTIONAL] 
   + description [OPTIONAL]
--%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>
<fmt:message var="technicalDetail_link" key="technicalDetail" bundle="${l10n}"/>
<fmt:message var="technicalDetail_title" key="technicalDetail" bundle="${l10n}"/>
<fmt:message var="ok_label" key="technicalDetail_ok_label" bundle="${l10n}"/>

<c:choose>
    <c:when test="${hasError}">
        <div class="ErrorDetails">
            <span class="${resourceStatusIcon}"><span><syswf:out value="${resourceStatusText}" context="HtmlBody"/></span></span> (<a id="${id}_uilink_techdetails" href="javascript:void(0);">${technicalDetail_link}</a>)
            
			<script type="text/javascript">
			//<![CDATA[

			    Ext.onReady(function() {
			    	SPopup.Window.Instance['${id}_techdetails-win'] = undefined;
			        Ext.get('${id}_uilink_techdetails').on('click', function() {
			            SPopup.Window.forceOpen('${id}_techdetails-win', '${id}_technical_details_content', {
			                id: '${id}_techdetails-win',
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
			                        SPopup.Window.Instance['${id}_techdetails-win'].hide();
			                    }
			                }
			            ]});
			        });
			    });
            
			//]]>
			</script>
                 
            <div class="webfw-Window" id="${prefix}-webfw-Window">      
			<div id="${id}_technical_details_content" class="x-hidden">
			    <div class="x-window-header"><syswf:out value="${technicalDetail_title}" context="HtmlBody"/></div>
			    <div class="x-window-body">
			        <div class="UI Offset">
			            <pre><c:out value="${errorHint}" escapeXml="true"/></pre>
			        </div>
			    </div>
            </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <span class="${resourceStatusIcon}"><span><syswf:out value="${resourceStatusText}" context="HtmlBody"/></span></span>
    </c:otherwise>
</c:choose>