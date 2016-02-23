<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="contractProviderPropertyLabel" key="contractProviderPropertyLabel" bundle="${contactmessages}"/>
<fmt:message var="contractProviderComponentError" key="contractProviderComponentError" bundle="${contactmessages}">
    <fmt:param value="${artifact._artifactSdmName}"/>    
</fmt:message>

<table class="UI Table Properties" summary="">
    <colgroup>
        <col class="LabelCol" />
        <col />
    </colgroup>
    <tbody>
        <tr>
            <th>
                <label class="UI Label Inline"><syswf:out value="${contractProviderPropertyLabel}" context="HtmlBody"/></label>                
            </th>
            <td>
                <c:choose>
                    <c:when test="${artifactTypeNotSupported}">
                        <div class="UI SystemMessage Error">
                            <div class="MessageContainer">
                                <div class="Text">${contractProviderComponentError}</div>
                                <div class="x-clear"></div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty this.artifactLinkHolders}">
                            <c:forEach items="${this.artifactLinkHolders}" var="linkHolder">
                                <c:choose>
                                    <c:when test="${empty linkHolder.url}">
                                        <syswf:out value="${linkHolder.name}" context="HtmlBody"/>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${linkHolder.url}">
		                                    <span><c:out value="${linkHolder.name}"/></span>
		                                </a>
                                    </c:otherwise>
                                </c:choose>
                                <br/>
                            </c:forEach>                            
                        </c:if>
                    </c:otherwise>
                </c:choose>                              
            </td>
        </tr>
    </tbody>
</table>


