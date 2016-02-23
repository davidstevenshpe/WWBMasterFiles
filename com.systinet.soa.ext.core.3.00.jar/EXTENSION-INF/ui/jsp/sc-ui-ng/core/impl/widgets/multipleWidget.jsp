<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${mode eq 'view'}">
    <c:forEach items="${this.descriptors}" var="desc" varStatus="i">
        <c:set var="output">
        <syswf:component name="${desc.component}" prefix="${desc.id}" wrap="false">
            <syswf:param name="model" value="${desc.model}" />
            <syswf:param name="mode" value="${desc.type}" />
            <c:forEach var="param" items="${desc.params}">
                <syswf:param name="${param.key}" value="${param.value}" />
            </c:forEach>
        </syswf:component>
        </c:set>
        <c:out value="${output}" escapeXml="false"/><c:if test="${not i.last}">; </c:if>
        <%-- maybe get the separator as parameter --%>
        
    </c:forEach>
</c:if>

<c:if test="${mode eq 'edit'}">
    <table class="UI Properties Table">
    <c:forEach items="${this.descriptors}" var="desc" varStatus="i">
        <tr>
            <td>
        <syswf:component name="${desc.component}" prefix="${desc.id}" wrap="false">
            <syswf:param name="model" value="${desc.model}" />
            <syswf:param name="mode" value="${desc.type}" />
            <c:forEach var="param" items="${desc.params}">
                <syswf:param name="${param.key}" value="${param.value}" />
            </c:forEach>
        </syswf:component>
            </td>
            <td>
        <c:if test="${fn:length(this.descriptors) > 1}">
        <syswf:control id="remove${desc.id}" mode="postanchor" caption="${removeMsg}" affects="." action="remove" wrapper="span">
            <syswf:param name="desc" value="${desc}" />
            <syswf:attribute name="class" value="UI Icon Delete Context"/>
        </syswf:control>
        </c:if>
            </td>
        </tr>
    </c:forEach>
        <tr>
            <td colspan="2">
    <syswf:control mode="postanchor" affects="." action="addWidget" caption="Add" />
            </td>
        </tr>
    </table>
</c:if>