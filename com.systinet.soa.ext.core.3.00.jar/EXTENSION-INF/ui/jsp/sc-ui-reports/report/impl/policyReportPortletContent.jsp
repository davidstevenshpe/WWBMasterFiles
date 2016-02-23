<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${not empty artifact}">
<table class="UI Layout">
    <tbody>
        <tr>
            <syswf:component prefix="${id}_complianceChart"
               name="/reports/policy/complianceChart">
               <syswf:param name="artifact" value="${artifact}" />
           </syswf:component>
           <syswf:component prefix="${id}_compliantArtifacts"
               name="/reports/policy/compliantArtifacts">
               <syswf:param name="artifact" value="${artifact}" />
           </syswf:component>
        </tr>
    </tbody>
</table>
</c:if>
<c:if test="${not empty nodataMessage}">
<div class="UI SystemMessage Warning"><div class="MessageContainer Icon Error"><div class="Text">${nodataMessage}</div></div></div>

</c:if>
