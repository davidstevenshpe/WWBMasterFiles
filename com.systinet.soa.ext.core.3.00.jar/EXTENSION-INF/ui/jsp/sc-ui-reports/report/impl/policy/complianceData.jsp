<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="UI Layout">
    <tbody>
        <tr>
            <syswf:component prefix="${prefix}_complianceChart"
               name="/reports/policy/complianceChart">
               <syswf:param name="artifact" value="${artifact}" />
           </syswf:component>
           <syswf:component prefix="${prefix}_compliantArtifacts"
               name="/reports/policy/compliantArtifacts">
               <syswf:param name="artifact" value="${artifact}" />
           </syswf:component>
        </tr>
    </tbody>
</table>

