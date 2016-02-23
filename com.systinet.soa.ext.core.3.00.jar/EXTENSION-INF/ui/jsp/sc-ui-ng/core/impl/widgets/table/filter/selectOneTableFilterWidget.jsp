<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uisccomponents_Message"/>

<div id="${filterContentId}" class="x-hidden">
    <div class="x-cmp-separator">
        <table class="x-cmp-holder">
            <colgroup>
                <col/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <td>
                    <input id="${filterContentId}_selectOne" type="radio" name="${prefix}$${filterContentId}_selectOne"
                           value="" <c:if test="${allSelected}">checked="checked"</c:if>/>
                </td>
                <td>
                    <fmt:message key="SelectAll" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
            <c:forEach var="value" items="${this.availableValues}" varStatus="status">
                <tr>
                    <td>
                        <syswf:selectOne name="${filterContentId}_selectOne"
                                         mode="radio" optionValues="${value}" optionCaptions=" "
                                         value="${this}" property="selectedStringValue"
                                         id="${filterContentId}_${status.index}"/>
                    </td>
                    <td>
                        <c:out value="${this.availableValueCaptions[value]}"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <syswf:control mode="script" action="applyFilter" caption="${applyFilterControlName}" affects="."/>

</div>
