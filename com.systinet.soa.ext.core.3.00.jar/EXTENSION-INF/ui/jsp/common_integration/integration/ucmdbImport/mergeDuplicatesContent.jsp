<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="matchingStatus" type="int"--%>
<%--@elvariable id="uuid" type="java.lang.String"--%>
<%--@elvariable id="mergeDuplicatesBean" type="com.hp.systinet.integration.ucmdbImport.MergeDuplicates.MergeDuplicatesBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="integrationMessages"/>
<fmt:message key="mergeDuplicatesContent_selectArtifactToMerge" bundle="${integrationMessages}">
    <fmt:param value="<strong>${mergeDuplicatesBean.sourceArtifact.name}</strong>"/>
</fmt:message>:<br/><br/>
<fmt:message key="mergeDuplicatesContent_detail" bundle="${integrationMessages}" var="detailLabel"/>
<fmt:message key="mergeDuplicatesContent_comparison" bundle="${integrationMessages}" var="comparisonLabel"/>

<c:forEach var="value" items="${mergeDuplicatesBean.matchingArtifacts}" varStatus="status">
    <c:choose>
        <c:when test="${empty value.uuid}">
            <li>
                <fmt:message key="mergeDuplicatesContent_noMatchLabel" bundle="${integrationMessages}" var="noMatchLabel"/>
                <syswf:selectOne merge="true" name="possibleMatches" mode="radio" optionValues="0"
                                 optionCaptions=" ${noMatchLabel}" value="${mergeDuplicatesBean}" property="selectedMatch">
                    <%--<syswf:attribute name="class" value=""/>--%>
                </syswf:selectOne>
            </li>
        </c:when>
        <c:otherwise>
            <li>
                <syswf:selectOne merge="true" name="possibleMatches" mode="radio" optionValues="${value.uuid}"
                                 optionCaptions=" ${value.name}" value="${mergeDuplicatesBean}" property="selectedMatch">
                    <%--<syswf:attribute name="class" value=""/>--%>
                </syswf:selectOne>
                (<syswf:component name="/core/impl/util/artifactLinkRenderer"
                                  prefix="${prefix}_${value.uuid}_possibleMatchLink" trim="true" wrap="flase">
                <syswf:param name="uuid" value="${value.uuid}"/>
                <syswf:param name="caption" value="${detailLabel}"/>
                <syswf:param name="target" value="_blank"/>
            </syswf:component>,
                <syswf:control mode="anchor" targetTask="/common/diff" caption="${comparisonLabel}" id="${prefix}comparsion${status.index}">
                    <syswf:param name="uuid" value="${uuid}"/>
                    <syswf:param name="uuid2" value="${value.uuid}"/>
                    <syswf:attribute name="target" value="_blank"/>
                </syswf:control>)
                <div class="Description">
                    <c:forEach var="diffValue" items="${value.artifactDifferences}" varStatus="diffStatus">
                        <label class="UI Label Inline">${diffValue.name}:</label>${diffValue.value}<c:if test="${not diffStatus.last}">, </c:if>
                    </c:forEach>
                </div>
            </li>
        </c:otherwise>
    </c:choose>
</c:forEach>
