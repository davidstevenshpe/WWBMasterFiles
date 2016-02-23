<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.assertion.AssertionMessages" var="messages" />

<c:if test="${not empty applicableTo}">
	<c:if test="${mode=='text'}">
		<syswf:out value="${applicableTo}" context="HtmlBody"/>
	</c:if>
	
	<c:if test="${mode=='table'}">
	    <table class="UI Table Properties">
	       <col class="LabelCol"/>
	       <col/>
	       <tbody>
	        <tr>
	            <th>
	                <label class="UI Label Inline"><fmt:message key="assertion.applicable_to" bundle="${messages}"/></label>
	            </th> 
	            <td>
	                <span class="IconAlign"><syswf:out value="${applicableTo}" context="HtmlBody"/></span>
	            </td>
	        </tr>
	       </tbody>
	   </table>
	</c:if>
</c:if>