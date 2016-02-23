<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="bundle"/>

<fmt:message var="necessarySteps" bundle="${bundle}" key="pageHelp.necessarySteps"/>
<fmt:message var="optionalSteps" bundle="${bundle}" key="pageHelp.optionalSteps"/>
<fmt:message var="moreLink" bundle="${bundle}" key="pageHelp.moreLink"/>

<div class="EA-right-panel">
    <c:set var="list" value="${model.visibleRequiredSteps}"/>
    <c:if test="${not empty list}">
        <h2 class="Title">${necessarySteps}</h2>
        <ul class="Mandatory">
            <c:forEach items="${list}" var="item">
                <c:set var="class"><c:choose>
                    <c:when test="${item.checked}">Complete</c:when>
                    <c:otherwise>Incomplete</c:otherwise>
                </c:choose></c:set>
                <li class="${class}">
                    ${item.label}
                </li>
            </c:forEach>
        </ul>
    </c:if>


    <c:set var="list" value="${model.visibleOptionalSteps}"/>
    <c:if test="${not empty list}">
        <h2 class="Title">${optionalSteps}</h2>
        <ul class="Optional">
            <c:forEach items="${list}" var="item" >
                <c:set var="class"><c:if test="${item.checked}">Complete</c:if></c:set>
                <c:set var="canChangeConsumer" value="${contractModel.contractStructure.canChangeConsumer}"/>
                
                <c:choose>
                    <c:when test="${item.id eq 'selectConsumer'}">
                        <c:if test ="${canChangeConsumer}">
                            <li class="${class}">
			                    ${item.label}
			                </li>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <li class="${class}">
		                    ${item.label}
		                </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </c:if>
                                                      
    <c:if test="${not empty model.helpContents}">
        <h2 class="Title ConsumptionRequests" style="text-align: right;">${model.helpContents.title}</h2>
        <p class="Description">
            <syswf:component name="/core/text/editableRichTextArea" prefix="text">
                <syswf:param name="customizationId" value="${model.contentId}"/>
            </syswf:component>
            <c:if test="${not empty model.helpContents.onlineHelpUri}">
                <a href="${sharedDocUrlBase}/${model.helpContents.onlineHelpUri}" class="MoreLink">${moreLink}</a>
            </c:if>
        </p>
    </c:if>
</div>
