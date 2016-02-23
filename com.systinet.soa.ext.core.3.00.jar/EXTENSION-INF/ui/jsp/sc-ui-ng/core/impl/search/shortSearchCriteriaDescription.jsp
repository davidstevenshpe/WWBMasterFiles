<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="filterValues" type="java.util.List"--%>
<%@ page trimDirectiveWhitespaces="true" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<c:choose>
    <c:when test="${not empty filterDescriptors}">
        <table class="UI Table Properties">
            <colgroup>
                <col class="LabelCol"/>
                <col/>
            </colgroup>
            <tbody>
            <c:forEach var="descriptor" items="${filterDescriptors}">
                <%--@elvariable id="filterValue" type="com.hp.systinet.sc.ui.search.SearchCriteriaDescriptionComponent.FilterDescriptorHolder"--%>
                <tr>
                    <th>
                        <label>${descriptor.label}<c:if test="${not empty descriptor.label}">:</c:if></label>
                    </th>
                    <td>
                        <c:choose>
                            <c:when test="${descriptor.descriptorType eq 'Owner'}">
                                <c:forEach var ="value" items="${descriptor.values}" varStatus="valStatus">
	                                <syswf:component prefix="principal_${valStatus.index}" name="/core/impl/util/principalLinkRenderer" wrap="false">
	                                     <syswf:param name="principal" value="${value}"/>
	                                     <syswf:param name="showIcon" value="${true}"/>
	                                     <syswf:param name="additionalIconCss" value="OwnerIconNoPaddingRight"/>
	                                </syswf:component>
	                                <c:if test="${not valStatus.last}">,&nbsp;</c:if>
                                </c:forEach>
                            </c:when>
                            <c:when test="${descriptor.descriptorType eq 'Provider'}">
                               <c:forEach var ="value" items="${descriptor.values}" varStatus="valStatus">
                                   <syswf:control id="Provider${valStatus.index}" mode="anchor" caption="${value.name}" targetTask="${value.url}" >
                                        <syswf:attribute name="class" value="UI Icon ${value.iconCss}" />
                                   </syswf:control>
                                   <c:if test="${not valStatus.last}">,&nbsp;</c:if>
                               </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <span class="IconAlign">
                                 <c:forEach var ="value" items="${descriptor.values}" varStatus="valStatus">
                                     <c:out value="${value}"/>
                                     <c:if test="${not valStatus.last}">,&nbsp;</c:if>
                                 </c:forEach>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise><fmt:message key="shortSearchCriteriaDescription.noCriteria" bundle="${searchmessages}"/></c:otherwise>
</c:choose>
