<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>    

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="collisionsResolutionTitle" key="collisionsResolutionTitle" bundle="${importsMessages}"/>
<fmt:message var="collisionsResolutionDescription" key="collisionsResolutionDescription" bundle="${importsMessages}"/>
<fmt:message var="collisionsKeepLocalChangeOption" key="collisionsKeepLocalChangeOption" bundle="${importsMessages}"/>
<fmt:message var="collisionsOverwriteOption" key="collisionsOverwriteOption" bundle="${importsMessages}"/>
<fmt:message var="collisionsButtonContinue" key="collisionsButtonContinue" bundle="${importsMessages}"/>
<fmt:message var="collisionsButtonCancel" key="collisionsButtonCancel" bundle="${importsMessages}"/>

<syswf:block className="UI Block Common Publishing">
    <c:if test="${not empty collisionRequestResponse}">
        <div class="Title">
            <h3>${collisionsResolutionTitle}</h3>
        </div>
        <div class="Content">
            <p class="Comment">${collisionsResolutionDescription}</p>
            <ul class="DuplicateResolution">                
                <li>
                    <syswf:selectOne id="${prefix}_collisionOption_${status.index}" merge="true" name="resolutionOptions" mode="radio" optionValues="false" optionCaptions="${collisionsKeepLocalChangeOption}"
                                     value="${collisionRequestResponse}" property="overwrite" dataType="boolean">
                        <syswf:attribute name="class" value=""/>
                    </syswf:selectOne>
                </li>
                <li>
                    <syswf:selectOne id="${prefix}_collisionOption_${status.index}" merge="true" name="resolutionOptions" mode="radio" optionValues="true" optionCaptions="${collisionsOverwriteOption}"
                                     value="${collisionRequestResponse}" property="overwrite" dataType="boolean">
                        <syswf:attribute name="class" value=""/>
                    </syswf:selectOne>
                </li>
            </ul>
        </div>
    </c:if>
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