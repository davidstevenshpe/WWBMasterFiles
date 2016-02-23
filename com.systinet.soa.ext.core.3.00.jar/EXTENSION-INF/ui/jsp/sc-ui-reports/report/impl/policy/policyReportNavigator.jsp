<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${enablePolicyManagement}">
<c:set var="generateUITextLinksClosingTag" value="false"/>
<c:forEach var="group" items="${internalNavigation.groups}">
      <c:forEach var="item" items="${group.elements}">
          <c:choose>
              <c:when test="${itemType[item] == 3}">
                <hr />
              </c:when>
              <c:when test="${itemType[item] == 1}">
                  <c:if test="${not generateUITextLinksClosingTag}">                              
                    <div class="UI Text Links">                                
                    <c:set var="generateUITextLinksClosingTag" value="true"/>  
                  </c:if>
                  <syswf:control mode="anchor" caption="${item.label}" hint="${item.description}" targetTask="${item.taskLocation}" targetDepth="0" id="${item.id}">
                      <syswf:paramSet value="${item.paramsMap}"/>
                      <c:if test="${not empty item.styleClass}">
                            <syswf:attribute name="class" value="${item.styleClass}"/>
                      </c:if>
                  </syswf:control>
              </c:when>
              <c:when test="${itemType[item] == 2}">
                  <c:if test="${generateUITextLinksClosingTag}">
                    </div>
                    <c:set var="generateUITextLinksClosingTag" value="false"/>  
                  </c:if>
                  <syswf:component name="${item.componentName}" prefix="${item.id}">
                      <syswf:paramSet value="${item.paramsMap}"/>
                  </syswf:component>
              </c:when>
              <c:when test="${itemType[item] == -2}">   
                <c:if test="${generateUITextLinksClosingTag}">
                    </div>
                    <c:set var="generateUITextLinksClosingTag" value="false"/>  
                </c:if>                         
                <div class="UI SystemMessage Error">
                <div class="MessageContainer">
                    <div class="Text"><c:out escapeXml="true" value="${invalidComponentLabel} ${item.componentName}"/>></div>
                </div>
                </div>
              </c:when>
          </c:choose>
      </c:forEach>
      <c:if test="${generateUITextLinksClosingTag}">
         </div>
         <c:set var="generateUITextLinksClosingTag" value="false"/>
      </c:if>
</c:forEach>
</c:if>