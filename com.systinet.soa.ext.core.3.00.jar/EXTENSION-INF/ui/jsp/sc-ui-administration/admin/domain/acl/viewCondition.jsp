<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table>
	<c:forEach var="condition" items="${conditionView}">
		<tr>
			<td>
				<c:out value="${condition}"/>	
			</td>
		</tr>
	</c:forEach>
</table>