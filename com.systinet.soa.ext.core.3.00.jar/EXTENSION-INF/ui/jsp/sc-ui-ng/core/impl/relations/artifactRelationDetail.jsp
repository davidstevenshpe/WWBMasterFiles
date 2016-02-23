<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<fmt:message var="andLabel" bundle="${relationshipmessages}" key="and"/>
<fmt:message var="moreLabel" bundle="${relationshipmessages}" key="more"/>
<fmt:message var="detailsLabel" bundle="${relationshipmessages}" key="Details"/>

<c:if test="${not empty data}" >
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><span>${localizedRelation}:</span></h3>
        </div>
        <div>
            <div class="Content">
                <table class="UI Table Properties IconLabel">
                    <colgroup>
                        <col class="LabelCol"/>
                        <col />
                    </colgroup>
                    <c:forEach var="holdersItem" items="${data}" varStatus="status1">
                        <c:set var="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${holdersItem.value[0].sdmName}&amp;format=small)"/>
                        <tr>
                            <th><label class="UI Icon"  style="${style}">${holdersItem.key}: </label></th>
                            <td>
                                <c:set var="moreCount" value="${0}" />
                                <c:forEach var="linkHolder" items="${holdersItem.value}" varStatus="status2">
                                    <c:choose>
                                        <c:when test="${showAll or status2.index < count}">
                                            <c:choose>
                                                <c:when test="${not status2.last}">
                                                       <c:set var="suffix" value=", "/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="suffix" value=""/>
                                                </c:otherwise>
                                            </c:choose>
                                            <syswf:component prefix="l${status1.index}_${status2.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                                <syswf:param name="uuid" value="${linkHolder.uuid}"/>
                                                <syswf:param name="caption" value="${linkHolder.name}"/>
                                                <syswf:param name="sdmName" value="${linkHolder.sdmName}"/>
                                                <syswf:param name="timeSlice" value="${linkHolder.timeSlice}" />
                                                <syswf:param name="suffix" value="${suffix}" />
                                            </syswf:component>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="moreCount" value="${moreCount + 1}" />
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${moreCount > 0}" >
                                    <%-- TODO REVIEW (Svata, 25/06/2010): Translate through bundle with parameters, number can have different positioning in other languagees --%>
                                    ${andLabel} <syswf:control mode="anchor" action="showAll" affects="." caption="${moreCount} ${moreLabel}..." />
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="Footer">
                <syswf:control id="linkToDetailsTask" mode="anchor" caption="${detailsLabel}" hint="" targetTask="/artifact/${artifact._uuid}">
                    <syswf:param name="artifactTabId" value="details"/>
                </syswf:control>
            </div>
        </div>
    </syswf:block>
</c:if>