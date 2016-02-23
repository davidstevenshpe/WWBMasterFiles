<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="utilmessages"/>
<fmt:message var="lastEditTitle" key="lastEditTitle" bundle="${utilmessages}"/>
<fmt:message var="lastEditRevisionTitle" key="lastEditRevisionTitle" bundle="${utilmessages}"/>

    <div class="EA-right-panel">
        <c:choose>
            <c:when test="${notLastRevision}">
                ${lastEditRevisionTitle}
            </c:when>
            <c:otherwise>
                ${lastEditTitle}
            </c:otherwise>
        </c:choose>
        <div>
            <c:choose>
                <c:when test="${not empty personArtifact}">
                    <syswf:control mode="anchor" caption="${personArtifact.name}" targetTask="/artifact/${personArtifact._uuid}" id="personArtifact._uuid" targetDepth="0">
                    </syswf:control>
                </c:when>
                <c:otherwise>
                    <span class=""></span>
                    ${revisionCreator}
                </c:otherwise>
            </c:choose> 
        </div>
   </div>       
