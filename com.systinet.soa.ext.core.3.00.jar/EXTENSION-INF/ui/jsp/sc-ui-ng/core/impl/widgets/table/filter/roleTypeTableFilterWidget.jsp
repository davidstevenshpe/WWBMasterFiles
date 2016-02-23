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
                    <syswf:selectOne name="roleTypeValue" mode="radio" optionValues="All" optionCaptions=" "
                        value="${this}" property="selectedValue" merge="true" />
                </td>
                <td>
                    <fmt:message key="All" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
            <tr>
                <td>
                    <syswf:selectOne name="roleTypeValue" mode="radio" optionValues="Yes" optionCaptions=" "
                        value="${this}" property="selectedValue" merge="true" />
                </td>
                <td>
                    <fmt:message key="Yes" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
            <tr>
                <td>
                    <syswf:selectOne name="roleTypeValue" mode="radio" optionValues="No" optionCaptions=" "
                        value="${this}" property="selectedValue" merge="true" />
                </td>
                <td>
                    <fmt:message key="No" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
        </tbody>
    </table>

    <syswf:control mode="script" action="applyFilter" caption="${applyFilterControlName}" affects="."/>

</div>