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
                    <syswf:selectOne name="roleTypeValue" mode="radio" optionValues="Contact" optionCaptions=" "
                        value="${this}" property="selectedValue" merge="true" />
                </td>
                <td>
                    <fmt:message key="PERSON_TYPE_CONTACT" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
            <tr>
                <td>
                    <syswf:selectOne name="roleTypeValue" mode="radio" optionValues="User" optionCaptions=" "
                        value="${this}" property="selectedValue" merge="true" />
                </td>
                <td>
                    <fmt:message key="PERSON_TYPE_USER" bundle="${uisccomponents_Message}"/>
                </td>
            </tr>
        </tbody>
    </table>

    <syswf:control mode="script" action="applyFilter" caption="${applyFilterControlName}" affects="."/>

</div>