<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="UI Layout">
	<tbody>
	<tr>
		<td class="UI Middle">
		<c:if test="${not empty title}">
			<div class="UI Block">
			<div class="Title">
				<h3><c:out value="${title}"></c:out></h3>
			</div>
			</div>
		</c:if>

		<c:forEach var="DSInfo" items="${processData}" varStatus="status">
			<c:choose>
			    <c:when test="${not status.first}">
			        <br />
			    </c:when>
			</c:choose>
			<c:if test="${not empty DSInfo.subtitle}">
				<div class="UI Block">
				<p class="Comment"><c:out value="${DSInfo.subtitle}"></c:out></p>
				</div>
			</c:if>
			
			<syswf:block className="UI Block Common">			
				<syswf:component name="/core/table/tableInternal" prefix="${status.index}" wrap="false">
				    <syswf:param name="table" value="${DSInfo.table}" />
				    <syswf:param name="datasource" value="${DSInfo.dataSource}" />
				    <syswf:param name="actions" value="${DSInfo.actions}" />
				</syswf:component>
									 
			</syswf:block>
		</c:forEach>

		</td>
	</tr>
	</tbody>
</table>

