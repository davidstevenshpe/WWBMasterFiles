<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="mesasges"/>
<div class="Content">
	<table class="UI Table Properties">
	    <colgroup>
	        <col class="ShortLabelCol" />
	        <col />
	    </colgroup>
	    <c:forEach items="${holders}" var="holder" varStatus="status">
		    <tr>
			    <th><label class="UI Label Inline">${holder.widgetModel.label}:</label></th>
			    <td>
				    <syswf:component name="${holder.display.component}" prefix="h${status.index}">
				        <syswf:param name="model" value="${holder.widgetModel}"/>
				        <syswf:param name="error" value="${holder.widgetModel.errorMessage}"/>
				        <syswf:param name="mode" value="edit"/>
				        <syswf:param name="width" value="300" />
				        <syswf:paramSet value="${holder.display.paramsMap}"/>
				    </syswf:component>
				    <c:if test="${not empty holder.widgetModel.errorMessage}">
				        <em class="x-form-invalid-msg UI Invalid">
				            <span>${holder.widgetModel.errorMessage}</span>
				        </em>
				    </c:if>
			    </td>
		    </tr>
		</c:forEach>
	</table>
</div>