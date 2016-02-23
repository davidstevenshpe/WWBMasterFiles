<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.layout.LayoutMessages" var="layout_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="dashboard.layoutAddControl_loginToAddComponentToDashBoard" var="loginToAddComponentToDashBoard" bundle="${layout_Messages}"/>

<c:if test="${showAddPageComponent}">
  <c:if test="${not empty layoutParameters.addValues}">
      <c:forEach var="addValue" items="${layoutParameters.addValues}">
          <c:choose>
              <c:when test="${not empty logged}">
              	  <fmt:message key="dashboard.layoutAddControl_addToDashBoard" var="addToDashBoard" bundle="${layout_Messages}">
                  	<fmt:param value="${addValue.value}"/>
				  </fmt:message>     	  
                  <syswf:control mode="postAnchor" action="layoutAddComponentStoreChanges" id="layoutAddComponentStoreChanges${addValue.key}" caption="${addValue.value}" hint="${addToDashBoard}">
                      <syswf:param name="addedArea" value="${addValue.key}"/>
                  </syswf:control>
              </c:when>
              <c:otherwise>
                  <syswf:control mode="postAnchor" targetTask="/login" caption="${addValue.value}" hint="${loginToAddComponentToDashBoard}"/>
              </c:otherwise>
          </c:choose>
      </c:forEach>
  </c:if>
</c:if>
