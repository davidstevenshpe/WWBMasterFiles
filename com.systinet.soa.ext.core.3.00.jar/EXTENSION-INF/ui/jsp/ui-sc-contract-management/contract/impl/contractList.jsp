<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>
<syswf:block className="UI Block Datagrid">
    <%-- Title of the list, as specified in mockup --%>
    <div class="Content" style="margin-top: 10px;">
        <div class="GridControls">
            <div class="Title">
                <h3>
                    <syswf:out value="${title}" context="HtmlBody"/>
                    <span>
                        <fmt:message bundle="${msg}" key="ContractList_CaptionSubtitle">
                            <fmt:param value="${model.acceptedCount}"/>
                            <fmt:param value="${model.pendingCount}"/>
                        </fmt:message>
                    </span>
                </h3>
            </div>
            <div class="x-clear"></div>
            <%-- The contract list itself, incl facets (part of the table configuration) --%>
            <syswf:component name="/core/table" prefix="list">
                <syswf:param name="customizationId" value="${parentCustomizationId}.results"/>
                <syswf:param name="datasource" value="${model.tableSource}"/>
                <syswf:param name="timeSlice" value="${model.timeSlice}"/>
                
                <c:if test="${artifact._deleted}">
                    <syswf:param name="overrideselectionModel" value="none" />
                </c:if>
            </syswf:component>
        </div>
    </div>
</syswf:block>
