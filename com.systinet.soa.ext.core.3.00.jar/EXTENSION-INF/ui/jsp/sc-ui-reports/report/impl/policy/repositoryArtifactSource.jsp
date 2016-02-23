<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="globalSession" type="java.util.Map"--%>
<%--@elvariable id="this" type="com.hp.systinet.report.ui.impl.policy.RepositoryArtifactSourceComponent"--%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<br/>
<syswf:component prefix="edit" name="/core/search/util/searchEditor">
    <syswf:param name="editedValue" value="${this.editedValue}"/>
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
    <syswf:param name="editorBean" value="${this.searchEditorBean}"/>
    <syswf:param name="criteriaCustomizationId" value="reports.policy.artifact.search.criteria"/>
    <syswf:param name="tableCustomizationId" value="reports.policy.artifact.search.results"/>
</syswf:component>
