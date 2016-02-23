<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.contract.contractmessages" var="messages"/>
<fmt:message key="contracts.menu.left.more" var="more" bundle="${messages}"/>
<fmt:message key="contracts.menu.left.caption" var="caption" bundle="${messages}"/>

<c:if test="${not empty contracts}">
<syswf:block className="UI Block Common">
    <div class="Content">
        <div class="Title">
            <h3>${caption}</h3>
        </div>
        <ul class="UI Bullets">
            <c:forEach items="${contracts}" var="contract" varStatus="status">
                <li>
                    <syswf:component prefix="artifact_link${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                        <syswf:param name="uuid" value="${contract['c_uuid']}"/>
                        <syswf:param name="caption" value="${contract['c_name']}"/>
                    </syswf:component>
                </li>
            </c:forEach>
        </ul>
            <div class="Footer">
                <syswf:control id="linkToContractsTask" mode="anchor" caption="${more}" hint=""
                               targetTask="/common/artifact/contracts">
                    <syswf:attribute name="class" value="UI"/>
                    <syswf:param name="artifact" value="${artifact}"/>
                    <syswf:param name="loginName" value="${loginName}"/>
                </syswf:control>
            </div>
    </div>
</syswf:block>
</c:if>