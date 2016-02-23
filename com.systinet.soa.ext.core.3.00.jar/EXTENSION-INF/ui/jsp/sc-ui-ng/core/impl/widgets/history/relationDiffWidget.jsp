<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<table class="RevisionDetails">
    <tr>
    <c:choose>
        <c:when test="${empty this.diff.artifact}">
            <td class="empty">&nbsp;</td>
        </c:when>
        <c:otherwise>
            <c:set var="class">
                <c:choose>
                    <c:when test="${this.diff.diffType eq 'CHANGED'}">changed</c:when>
                    <c:when test="${this.diff.diffType eq 'ADDED'}">added</c:when>
                    <c:when test="${this.diff.diffType eq 'REMOVED'}">removed</c:when>
                    <c:otherwise>
                        nochange
                    </c:otherwise>
                </c:choose>
            </c:set>
            <c:choose>
                <c:when test="${this.diff.diffType eq 'CHANGED'}"><c:set var="opClass">Changed</c:set></c:when>
                <c:when test="${this.diff.diffType eq 'REMOVED'}"><c:set var="opClass">Removed</c:set></c:when>
                <c:when test="${this.diff.diffType eq 'ADDED'}"><c:set var="opClass">Added</c:set></c:when>
            </c:choose>
            <c:choose>
                <c:when test="${this.diff.diffType eq 'CHANGED'}"><c:set var="opLabel">Changed</c:set></c:when>
                <c:when test="${this.diff.diffType eq 'REMOVED'}"><c:set var="opLabel">Removed</c:set></c:when>
                <c:when test="${this.diff.diffType eq 'ADDED'}"><c:set var="opLabel">Added</c:set></c:when>
            </c:choose>
            <td<c:if test="${not empty class}"> class="${class}"</c:if>>
                <table class="ArtifactProperties">
                    <colgroup><col /><col class="PropOperation" /></colgroup>
                    <tr><td class="Title">
                    <h2 style="background-image:url(${deploymentUrl}/artifactIcon?type=${this.diff.artifact._artifactSdmName}&amp;format=small);"><syswf:out value="${this.diff.artifact.name}" context="HtmlBody"/></h2>
                    </td>
                    <td class="Relationship">${this.diff.relationNameLabel}</td></tr>
                    <tr><td class="Description" colspan="2"><syswf:out value="${this.diff.strippedDescription}" context="HtmlBody"/></td></tr>
                    <c:if test="${not empty opClass}">
                    <tr><td></td><td class="Operation ${opClass}"><syswf:out value="${opLabel}" context="HtmlBody"/></td></tr>
                    </c:if>
                </table>
            </td>
        </c:otherwise>
    </c:choose>
    </tr>
</table>