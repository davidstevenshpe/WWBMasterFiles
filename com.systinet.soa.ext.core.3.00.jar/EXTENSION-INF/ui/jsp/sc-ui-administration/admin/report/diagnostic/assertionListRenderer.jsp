<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="policyUuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>
<%--@elvariable id="failedAssertions" type="ArrayList<com.hp.systinet.sc.impl.report.diagnostic.FailedAssertion>"--%>
<c:if test="${(not empty failedAssertions) and (fn:length(failedAssertions) gt 0)}">
 <div class="Children">
     <c:forEach var="item" items="${failedAssertions}" varStatus="status">
         <c:choose>
             <c:when test="${item.statusText eq 'notCompliant'}">
                 <c:set var="itemClass" value="Child Error"/>
             </c:when>
             <c:when test="${item.statusText eq 'warning'}">
                 <c:set var="itemClass" value="Child Warning"/>
             </c:when>
             <c:otherwise>
                 <c:set var="itemClass" value="Child NotApplicable"/>
             </c:otherwise>
         </c:choose>
         <div class="${itemClass}">
             <div class="ChildLabel">
                 <syswf:component prefix="${prefix}_assertionLink_${item.assertionUuid}_${status.count}"
                                  name="/core/impl/util/artifactLinkRenderer" wrap="false">
                     <syswf:param name="uuid" value="${item.assertionUuid}"/>
                     <syswf:param name="caption" value="${item.assertionName}"/>
                     <syswf:param name="sdmName" value="assertionArtifact"/>
                 </syswf:component>
             </div>
             <div class="ChildBody">
                 <div>
                     <span class="Comment">
                         <c:out value="${not empty item.assertionHint ? item.assertionHint : item.assertionDesc}"/>
                     </span>
                 </div>
             </div>
         </div>
     </c:forEach>
 </div>
</c:if>
