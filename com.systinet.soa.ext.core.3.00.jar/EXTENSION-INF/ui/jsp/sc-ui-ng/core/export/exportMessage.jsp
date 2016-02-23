<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages"/>

<fmt:message bundle="${exportmessages}" key="report" var="reportLabel" />

<div class="UI SystemMessage ${class}">
    <div class="MessageContainer">
        <c:if test="${not reportClosed}">
            <syswf:component name="/core/report/reportProgress" prefix="progress">
                <syswf:param name="reportArtifact" value="${reportArtifact}" />
                <syswf:param name="onCompleteCallback" value="${onCompleteCallback}" />
            </syswf:component>
        </c:if>
        <div class="Text">
            <c:set var="reportLink">
                <syswf:control targetTask="/artifact/${reportArtifact._uuid}" caption="${reportLabel}" mode="anchor" id="link3" />
            </c:set>
            <c:choose>
                <c:when test="${not reportClosed}">
                    <fmt:message bundle="${exportmessages}" key="export.inProgress" />
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${reportResultCode eq 'OK'}">
                            <fmt:message bundle="${exportmessages}" key="export.resultOk">
                                <fmt:param value="${restLink}" />
                                <fmt:param value="${reportLink}" />
                            </fmt:message>
                            <c:if test="${justClosed}">
                                <script type="text/javascript">
//<![CDATA[

                                Ext.onReady(function() {
                                window.location.href = '${restLink}';
                                });
                                
//]]>
</script>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <fmt:message bundle="${exportmessages}" key="export.resultError">
                                <fmt:param value="${reportLink}" />
                            </fmt:message> 
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <fmt:message bundle="${exportmessages}" key="export.seeDetails">
                <fmt:param value="${reportLink}" />
            </fmt:message>
        </div>
        <div class="x-clear"></div>
    </div>
</div>