<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="UI Middle">
</div>
<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
    			<syswf:component name="/core/table" prefix="resultTable" >
					<syswf:param name="customizationId" value="${customizationId}" />
					<c:if test="${not empty wrapCaption}">
						<syswf:param name="wrapCaption" value="${caption}" />
					</c:if>
					<c:if test="${not empty storeTableCmpId}">
						<syswf:param name="storeTableCmpId" value="${storeTableCmpId}" />
					</c:if>
				</syswf:component>
            </td>
        </tr>
    </tbody>
</table>