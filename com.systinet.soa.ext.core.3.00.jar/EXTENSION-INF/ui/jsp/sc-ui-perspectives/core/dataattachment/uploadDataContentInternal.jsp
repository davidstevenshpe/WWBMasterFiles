<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>

<fmt:message var="filePropertyLabel" key="filePropertyLabel" bundle="${importsmessages}"/>
<fmt:message var="sourceLabel" key="sourceLabel" bundle="${importsmessages}"/>

<syswf:control mode="script" id="${prefix}Change" action="tabChange" caption="${prefix}Change" affects="."/>

<c:set var="beforeLocationContent">
    <tr>
        <th>
            <label for="${prefix}ChangeTab" class="UI Label">${sourceLabel}</label>
        </th>
        <td>
            <syswf:selectOne id="${prefix}ChangeTab" name="${prefix}ChangeTab" value="${tabHolder}" property="selectedTab" mode="radio" optionValues="${sourceValues}" optionCaptions="${sourceCaptions}"  displayAsRow="true">
                <syswf:attribute name="onClick">
                    ${prefix}Change();
                </syswf:attribute>
            </syswf:selectOne>
        </td>
    </tr>
</c:set>

<c:choose>
    <c:when test="${hasNoContent}">
        <syswf:component name="/core/impl/imports/file/locationOptions" prefix="localOptions">
            <syswf:param name="importFileBean" value="${documentBean}"/>
            <syswf:param name="importType" value="${tabHolder.selectedTab}"/>
            <syswf:param name="beforeLocationContent" value="${beforeLocationContent}"/>
        </syswf:component>
    </c:when>
    <c:otherwise>

        <c:set var="beforeLocationContent">
            <tr>
                <td colspan="2">
                    <div class="Message Warning">
                        <div class="MessageContainer">
                            <div class="Icon"><span>&nbsp;</span></div>
                            <div class="Content">
                                <fmt:message bundle="${messages}" key="change.dataContent.info" />
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <c:out value="${beforeLocationContent}" escapeXml="false"/>
        </c:set>

        <syswf:component name="/core/impl/imports/file/locationOptions" prefix="localOptions">
            <syswf:param name="importFileBean" value="${documentBean}"/>
            <syswf:param name="importType" value="${tabHolder.selectedTab}"/>
            <syswf:param name="beforeLocationContent" value="${beforeLocationContent}"/>
        </syswf:component>


    </c:otherwise>
</c:choose>



