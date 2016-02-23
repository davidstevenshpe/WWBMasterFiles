<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uisccomponents_Message"/>

<div id="${filterContentId}" class="x-hidden">
    <table class="x-cmp-holder">
        <colgroup>
            <col />
            <col />
        </colgroup>
        <tbody>
            <tr>
                <td>
                    <syswf:selectOne name="ratingValue" mode="radio" optionValues="0" optionCaptions=" "
                        value="${this}" property="selectedValue" merge="true" dataType="int"/>
                </td>
                <td>
                    <fmt:message key="All" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
            <c:forEach var="counter" begin="1" end="5">
                <tr>
                    <td>
                        <syswf:selectOne name="ratingValue"
                            mode="radio" optionValues="${6-counter}" optionCaptions=" "
                            value="${this}" property="selectedValue" merge="true" dataType="int"/>
                    </td>
                    <td>
                        <div class="minirating-ct">
                            <c:forEach var="starCounter" begin="1" end="5">
                                <div class="ui-stars-star <c:if test="${starCounter <= (6-counter)}">ui-stars-star-on </c:if>ui-stars-star-disabled"><a title="">${starCounter}</a></div>
                            </c:forEach>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <syswf:control mode="script" action="applyFilter" caption="${applyFilterControlName}" affects="."/>

</div>