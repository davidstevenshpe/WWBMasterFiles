<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message key="typeMap.invalidComponentLabel" var="invalidComponentLabel" bundle="${widgetMessages}"/>
<c:set var="flexContainerClass">
     <c:choose>
         <c:when test="${not empty internalColumns.layout and fn:contains(internalColumns.layout,'-container')}">${internalColumns.layout}</c:when>
         <c:otherwise>flex-container</c:otherwise>
     </c:choose>
</c:set>
<div class="${flexContainerClass}">		
	<c:forEach var="column" items="${internalColumns.elements}" varStatus="stat">
		<c:set var="flex">
             <c:choose>
                 <c:when test="${not empty column.flex}">${column.flex}</c:when>
                 <c:otherwise>1</c:otherwise>
             </c:choose>
		</c:set>
		<c:set var="colClass">
            <c:choose>
            	<c:when test="${fn:contains(flexContainerClass,'center')}">${column.styleClass}</c:when>
                <c:when test="${not empty column.styleClass}">${column.styleClass}</c:when>
                <c:when test="${stat.first}">UI Middle</c:when>
                <c:otherwise>UI Right</c:otherwise>
            </c:choose>
 		</c:set>
 		<div style="flex-grow:${flex};" class="${colClass}" col-index="${stat.count}">
		<c:forEach var="element" items="${column.elements}" varStatus="status">
	    <c:choose>
	        <c:when test="${itemType[element] == 0}">
	            <%-- it is a group --%>
	            <c:set var="group" value="${element}" />
	            <c:choose>
	                <c:when test="${status.last}"><c:set var="blockClass" value="UI Block Last" /></c:when>
	                <c:otherwise><c:set var="blockClass" value="UI Block" /></c:otherwise>
	            </c:choose>
	            <syswf:block className="${blockClass}">
	                <c:if test="${not empty group.label}">
	                    <div class="Title">
	                        <h3><span><c:out value="${group.label}" /></span></h3>
	                    </div>
	                </c:if>
	                <div class="Content">
	                    <c:forEach var="groupElement" items="${group.elements}" varStatus="groupStatus">
	                    <c:choose>
	                        <c:when test="${itemType[groupElement] == 1}">
	                            <c:choose>
	                                <c:when test="${not empty groupElement.styleClass}">
	                                    <div class="${groupElement.styleClass}">
	                                        <syswf:control mode="anchor" caption="${groupElement.label}" targetTask="${groupElement.taskLocation}" targetDepth="0" id="${groupElement.id}">
	                                            <syswf:paramSet value="${groupElement.paramsMap}"/>
	                                        </syswf:control>
	                                    </div>
	                                </c:when>
	                                <c:otherwise>
	                                    <syswf:control mode="anchor" caption="${groupElement.label}" targetTask="${groupElement.taskLocation}" targetDepth="0" id="${groupElement.id}">
	                                        <syswf:paramSet value="${groupElement.paramsMap}"/>
	                                    </syswf:control>
	                                </c:otherwise>
	                            </c:choose>
	                        </c:when>
	                        <c:when test="${itemType[groupElement] == 2}">
	                            <%-- it is a component --%>
	                            <c:set var="component" value="${groupElement}" />
	                            <%-- todo: check visibility --%>
	                            <syswf:component name="${component.componentName}" prefix="${component.id}" wrap="false">
	                                <syswf:paramSet value="${component.paramsMap}"/>
	                                <syswf:param name="syswfLastBlock" value="${groupStatus.last}" />
	                            </syswf:component>
	                        </c:when>
	                    </c:choose>
	                    </c:forEach>
	                </div>
	            </syswf:block>
	        </c:when>
	        <c:when test="${itemType[element] == 6}">
	            <c:if test="${not empty element.parameters}">
	               <script>
	                       //<![CDATA[
	                            <c:out value="${element.id}=${element.parametersAsJSON}" escapeXml="false"/>;
	//]]>
	</script>
	                    </c:if>
	            <c:out value="${element.contentAsString}" escapeXml="false"/>
	        </c:when>
	        <c:when test="${itemType[element] == 5}">
	            <syswf:component name="/data/js" prefix="${element.id}">
	                <syswf:param name="sourceId" value="${element.id}" />
	                <syswf:param name="code"><c:out value="${element.content}" escapeXml="false"/></syswf:param>
	            </syswf:component>
	        </c:when>                
	        <c:when test="${itemType[element] == 2}">
	            <%-- it is a component --%>
	            <c:set var="component" value="${element}" /> 
	            <%-- todo: check visibility --%>
	            <c:choose>
	                <c:when test="${not empty artifactTabId && component.componentName=='/core/layout/tabs'}">
	                    <syswf:component name="/core/artifact/artifactTabs" prefix="${component.id}">
	                        <syswf:paramSet value="${component.paramsMap}"/>
	                        <syswf:param name="syswfLastBlock" value="${status.last}" />
	                    </syswf:component>
	                </c:when>
	                <c:otherwise>
	                    <syswf:component name="${component.componentName}" prefix="${component.id}">
	                        <syswf:paramSet value="${component.paramsMap}"/>
	                        <syswf:param name="syswfLastBlock" value="${status.last}" />
	                    </syswf:component>
	                </c:otherwise>
	            </c:choose>
	        </c:when>
	        <c:when test="${itemType[element] == -2}">
	            <div class="UI SystemMessage Error">
	            <div class="MessageContainer">
	                <div class="Text">${invalidComponentLabel} <c:out value="${element.componentName}"/></div>
	                <div class="clear"></div>
	            </div>
	            </div>
	        </c:when>
	        <c:when test="${itemType[element] == 1}">
	            <c:choose>
	                <c:when test="${not empty element.styleClass}">
	                    <div class="${element.styleClass}">
	                        <syswf:control mode="anchor" caption="${element.label}" targetTask="${element.taskLocation}" targetDepth="0" id="${element.id}">
	                            <syswf:paramSet value="${element.paramsMap}"/>
	                        </syswf:control>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <syswf:control mode="anchor" caption="${element.label}" targetTask="${element.taskLocation}" targetDepth="0" id="${element.id}">
	                        <syswf:paramSet value="${element.paramsMap}"/>
	                    </syswf:control>
	                </c:otherwise>
	            </c:choose>
	        </c:when>
	    </c:choose>
		</c:forEach>
		</div>
	</c:forEach>
</div>
   