<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />

<c:choose>
    <c:when test="${serverNotExist}">
        <div class="ErrorDetails"><span class="UI Icon Error">${message}</span></div>
    </c:when>
    <c:when test="${empty keyRefs and not hasError}">
        <div>${message}</div>
    </c:when>
    <c:otherwise>
        <table class="UI Table Layout">
            <tr>
                <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.import.serverName" bundle="${l10n}"/></label></td>
                <td><label class="UI Label Inline"><syswf:out value="${registryBean.name}" context="HtmlBody"/></label></td>
            </tr>
            <tr>
                <td width="30%"><label class="UI Label Inline"><fmt:message key="uddi.import.authentication" bundle="${l10n}"/></label></td>
                <td><label class="UI Label Inline"><syswf:out value="${credentialsBean.username}" context="HtmlBody"/></label><a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}change_authentication"><fmt:message key="uddi.import.changeAuthentication" bundle="${l10n}"/></a></td>
            </tr>
        </table>
		<syswf:control mode="script" action="changeCredential" caption="${prefix}changeCredential" loadingMask="true" affects="."/>
		<syswf:component name="/core/window" prefix="selectCredential">
		    <syswf:param name="winTitle" value="Select Credential" />
		    <syswf:param name="winComponent" value="/integration2/uddi/import/selectAuthentication"/>
		    <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenAuthentication" />
		    <syswf:param name="credentialsBean" value="${credentialsBean}" />
		    <syswf:param name="winOkAction" value="${prefix}changeCredential" />
		    <syswf:param name="winOkLabel" value="OK" />
		    <syswf:param name="winWidth" value="400" />
		    <syswf:param name="winButtonAlign" value="right" />
		</syswf:component>
		
		<script type="text/javascript">
		//<![CDATA[
		
				Ext.onReady(function() {
				    attachOn('${prefix}change_authentication','click',function() {
				        ${prefix}jsOpenAuthentication();
				    });
				});
				
		//]]>
		</script>
		<c:choose>
		    <c:when test="${hasError}">
		        <div class="ErrorDetails"><span class="UI Icon Error">${message}</span></div>
		    </c:when>
		    <c:otherwise>
                <div id="${prefix}addressbook_browser" class="TabPanel Simple">
                    <h4><div class="UI Align">
                            <div class="Left">${message}:</div>
                            <div class="x-clear"></div>
                    </div></h4>
                </div>
                <ul class="UI Bullets">
                <c:forEach items="${keyRefs}" var="keyRef">
                    <li><c:out value="${keyRef}" escapeXml="true"/></li>
                </c:forEach>
                </ul>
		    </c:otherwise>
		</c:choose>
    </c:otherwise>
</c:choose>
