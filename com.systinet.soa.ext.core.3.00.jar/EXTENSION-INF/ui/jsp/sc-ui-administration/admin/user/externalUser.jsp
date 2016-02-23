<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="userMessages" />
<c:if test="${isUser}">
    <syswf:block className="UI Block Common">
	    <div class="Content">
	         <table class="UI Table Properties">
	             <col class="LabelCol">
	             <col/>
	             <tbody>
	                 <tr>
	                     <th><label class="UI Label Inline"><fmt:message key="viewUserProfile.external_account" bundle="${userMessages}" /></label></th>
	                     <c:choose>
	                         <c:when test="${external}" >
	                             <td><span class="IconAlign">Yes</span></td>     
	                         </c:when>
	                         <c:otherwise >
	                             <td><span class="IconAlign">No</span></td>
	                         </c:otherwise>
	                     </c:choose>
	                 </tr>
	             </tbody>
	         </table>
	    </div>
    </syswf:block>
</c:if>

            