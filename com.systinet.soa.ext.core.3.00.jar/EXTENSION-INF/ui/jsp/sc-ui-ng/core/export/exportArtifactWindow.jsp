<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages"/>
<div class="Message Info">
    <div class="MessageContainer">
        <div class="Icon"><span>&nbsp;</span></div>
        <div class="Content">
            <c:choose>
                <c:when test="${not empty type and type eq 'gp'}">
                    <fmt:message bundle="${exportmessages}" key="export.GPExportInfo" />
                </c:when>
                <c:otherwise>
                    <fmt:message bundle="${exportmessages}" key="export.artifactExportInfo" />
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<div class="UI Offset">

<table class="UI Table Properties">
    <colgroup>
        <col class="LabelCol" />
        <col />
    </colgroup>

    <tr>
        <th>
            <label class="UI Label Inline" for="${prefix}filename"><fmt:message bundle="${exportmessages}" key="export.archiveName" />:</label>
        </th>
        <td>
            <syswf:input name="filename" id="${prefix}filename" value="${holder}" property="filename" mode="text">
                <syswf:attribute name="class" value="x-form-text x-form-field hp-export-archive-name" />
            </syswf:input>
            <span><fmt:message bundle="${exportmessages}" key="export.dotZip" /></span>
        </td>
    </tr>
</table>
<c:if test="${empty type || type ne 'gp'}">
<syswf:wrap template="/templates/advancedOptions.jsp">
        <ul class="Choices">
            <li>
            <syswf:selectOne id="${prefix}includeDependencies" name="includeDependencies" selectClass="UI Form Checkbox Inline" value="${holder}" property="includeDependencies" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
            <label class="UI Label Inline" for="${prefix}includeDependencies_0"><fmt:message bundle="${exportmessages}" key="export.includeDependencies" /></label>
            </li>
        </ul>
</syswf:wrap>
</c:if>
</div>