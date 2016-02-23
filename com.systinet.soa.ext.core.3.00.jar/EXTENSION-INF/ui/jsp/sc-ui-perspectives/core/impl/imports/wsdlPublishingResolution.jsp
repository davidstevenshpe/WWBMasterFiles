<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>    

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="wsdlPublishingRRTitle" key="wsdlPublishingRRTitle" bundle="${importsMessages}"/>
<fmt:message var="wsdlPublishingRRDescription" key="wsdlPublishingRRDescription" bundle="${importsMessages}"/>

<fmt:message var="collisionsButtonContinue" key="collisionsButtonContinue" bundle="${importsMessages}"/>
<fmt:message var="collisionsButtonCancel" key="collisionsButtonCancel" bundle="${importsMessages}"/>

    <c:if test="${not empty wsdlPublishingRequestResponse}">
<syswf:block className="UI Block Common Publishing">
        <div class="Title">
            <h3>${wsdlPublishingRRTitle}</h3>
        </div>
        <div class="Content">
            <p class="Comment">${wsdlPublishingRRDescription}</p>
            <ul class="DuplicateResolution">
                <c:forEach items="${wsdlPublishingRequestResponse.items}" var="item">
                    <li>
                        <syswf:selectOne mode="radio" name="selectedWsdl" id="${item.key}" value="" optionValues="${item.key}" optionCaptions="${item.key}" displayAsRow="true" />
                        <div class="Description">
                            <c:forEach items="${item.value}" var="qname">
                                ${qname.localPart}<br />
                            </c:forEach>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
</syswf:block>
            
<syswf:block className="UI Block Common Green">
    <div class="UI Form Controls">
        <syswf:control action="confirm" mode="postAnchor" caption="${collisionsButtonContinue}" id="${prefix}Continue" wrapper="span">
            <syswf:attribute name="class" value="btn btn-primary"/>
        </syswf:control>
        <syswf:control action="cancel" mode="postAnchor" caption="${collisionsButtonCancel}" id="${prefix}Cancel" wrapper="span">
            <syswf:attribute name="class" value="btn btn-gray"/>
        </syswf:control>
    </div>
</syswf:block>
    </c:if>