<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="title" type="String"--%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.edit.EditMessages" var="editMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:set var="titleVar">
    <c:choose>
        <c:when test="${empty title}">
            <fmt:message key="categoryBag.title" bundle="${widgetMessages}"/>
        </c:when>
        <c:otherwise>
            <c:out value="${title}"/>
        </c:otherwise>
    </c:choose>
</c:set>

<div class="Content">
<table class="UI Table Properties">
    <col class="LabelCol"/>
    <col/>
    <tbody>
    <c:forEach items="${this.categories}" var="item">
        <tr>
            <th class="UI Label Inline"><c:out value="${item.taxonomyName}" />: </th>
            <td>
                <c:forEach items="${item.values}" var="category" varStatus="stat">
                    <%-- settings as variable to ensure there is no space before comma --%>
                    <c:set var="itemValue">
                        <c:out value="${category.name}" />

                        <c:if test="${mode eq 'edit'}">
                            <syswf:control id="remove${category.val}" mode="anchor" action="remove" caption="Delete" wrapper="span">
                                <syswf:param name="taxonomyUri" value="${item.taxonomyUri}"/>
                                <syswf:param name="categoryVal" value="${category.val}"/>
                                <syswf:attribute name="class" value="UI Icon Delete Context"/>
                            </syswf:control>
                        </c:if>
                    </c:set>

                    <c:out value="${itemValue}" escapeXml="false"/><c:if test="${not stat.last}">;</c:if>
                </c:forEach>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div class="Title">
<c:if test="${mode eq 'edit'}">

<syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="button">
    <syswf:param name="selectedCategories" value="${this.selectedCategories}"></syswf:param>
    <syswf:param name="taxonomyBrowserListener" value="${this}"></syswf:param>
</syswf:component>

</c:if>
</div>
