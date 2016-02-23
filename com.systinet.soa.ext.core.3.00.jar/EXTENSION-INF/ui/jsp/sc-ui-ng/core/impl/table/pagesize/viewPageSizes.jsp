<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:if test="${visible}">
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><fmt:message key="tablePageSizes" bundle="${messages}"/></h3>
        </div>
        <div class="Content">
            <table class="UI Table Properties">
                <col class="LabelCol"/>
                <col>
                <tbody>
                    <c:forEach var="pageSizeInfo" items="${pageSizes}" varStatus="status">
                        <tr>
                            <th class="UI Label Inline">${pageSizeInfo.label}:</th>
                            <td>
                                <span class="IconAlign">
                                    ${pageSizeInfo.pageSizeLabel}
                                    <syswf:component prefix="edit${status.index}" name="/core/impl/table/pagesize/editPageSize" wrap="false">
                                        <syswf:param name="showButton" value="true"/>
                                        <syswf:param name="pageSizeInfo" value="${pageSizeInfo}"/>
                                        <syswf:param name="affects" value="${prefix}"/>
                                    </syswf:component>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </syswf:block>
</c:if>