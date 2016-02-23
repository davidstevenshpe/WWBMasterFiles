<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="sendMessage" key="contactActions.sendMessage" bundle="${contactmessages}"/>

<div class="flex-container">
        <div class="UI Middle">
            <c:forEach var="useType" items="${this.useTypeValueNameMap}" varStatus="status">
                <c:choose>
                    <c:when test="${status.last}">
                        <c:set var="blockClassName" value="UI Block Common Last"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="blockClassName" value="UI Block Common"/>
                    </c:otherwise>
                </c:choose>
                <syswf:block className="${blockClassName}">
                    <div class="Title">
                        <h3><span><syswf:out value="${useType.value}" context="HtmlBody"/></span></h3>
                    </div>
                    <div class="Content">
                        <syswf:component prefix="contacts.${status.index}" name="/core/relations/genericRelationshipComponent">
                            <syswf:param name="tableDefinitionId" value="${viewId}.contacts.table"/>
                            <syswf:param name="relation" value="providedBy"/>
                            <syswf:param name="useType" value="${useType.key}"/>
                            <syswf:param name="artifact" value="${this.artifact}"/>
                        </syswf:component>
                    </div>
                </syswf:block>
            </c:forEach>
        </div>
        <div class="UI Right">
            <syswf:block className="EA-right-panel">
                <div class="Content">
                    <syswf:control mode="anchor" caption="${sendMessage}" targetTask="/common/pushnotification/notificationEditor">
                        <syswf:param name="notificationDescriptorId" value="artifactNotification"/>
                        <syswf:param name="notificationData" value="${this.artifact}"/>
                        <syswf:attribute name="class" value="UI PageAction SendMessage"/>
                    </syswf:control>
                </div>
            </syswf:block>
        </div>
</div>