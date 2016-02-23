<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>    

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="duplicatesResolutionTitle" key="duplicatesResolutionTitle" bundle="${importsMessages}"/>
<fmt:message var="duplicatesResolutionDescription" key="duplicatesResolutionDescription" bundle="${importsMessages}"/>
<fmt:message var="duplicatesContinuePublishingTo" key="duplicatesContinuePublishingTo" bundle="${importsMessages}"/>
<fmt:message var="duplicatesChangeLocationTo" key="duplicatesChangeLocationTo" bundle="${importsMessages}"/>
<fmt:message var="duplicatesButtonContinue" key="duplicatesButtonContinue" bundle="${importsMessages}"/>
<fmt:message var="duplicatesButtonCancel" key="duplicatesButtonCancel" bundle="${importsMessages}"/>

<syswf:block className="UI Block Common Publishing">
    <c:if test="${not empty duplicatesResolutionBean}">
        <div class="Title">
            <h3>${duplicatesResolutionTitle}</h3>
        </div>
        <div class="Content">
            <p class="Comment">${duplicatesResolutionDescription}</p>
            <ul class="DuplicateResolution">
                <c:forEach var="value" items="${duplicatesResolutionBean.optionValues}" varStatus="status">
                    <li>
                        <syswf:selectOne id="${prefix}_resolutionOption_${status.index}" merge="true" name="resolutionOptions" mode="radio" optionValues="${value}" optionCaptions="${duplicatesResolutionBean.optionCaptions[status.index]}"
                                         value="${duplicatesResolutionBean}" property="selectedValue" dataType="int">
                            <syswf:attribute name="class" value=""/>
                        </syswf:selectOne>
                        <div class="Description">
                            <c:choose>
                                <c:when test="${status.first}">
                                    ${duplicatesContinuePublishingTo} <a href="${duplicatesResolutionBean.locations[status.index]}" target="_blank">${duplicatesResolutionBean.relativeLocations[status.index]}</a>
                                </c:when>
                                <c:otherwise>
                                    ${duplicatesChangeLocationTo} <a href="${duplicatesResolutionBean.locations[status.index]}" target="_blank">${duplicatesResolutionBean.relativeLocations[status.index]}</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
</syswf:block>
            
<syswf:block className="UI Block Common Green">
    <div class="UI Form Controls">
        <syswf:control action="confirm" mode="postAnchor" caption="${duplicatesButtonContinue}" id="${prefix}Continue" wrapper="span">
            <syswf:attribute name="class" value="btn btn-primary"/>
        </syswf:control>
        <syswf:control action="cancel" mode="postAnchor" caption="${duplicatesButtonCancel}" id="${prefix}Cancel" wrapper="span">
            <syswf:attribute name="class" value="btn btn-gray"/>
        </syswf:control>
    </div>
</syswf:block>