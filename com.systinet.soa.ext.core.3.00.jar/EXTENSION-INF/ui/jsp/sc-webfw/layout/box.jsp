<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.systinet.webfw.ui.layout.LayoutMessages" var="layout_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="hide" var="hide" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="moveUp" var="moveUp" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="moveDown" var="moveDown" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="moveLeft" var="moveLeft" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="moveRight" var="moveRight" bundle="${webFrameworkUI_Messages}"/>



<c:if test="${(empty customizeLayoutSwitch) or (customizeLayoutSwitch eq 'true')}">
  <c:choose>
    <c:when test="${((layoutParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true')) and box.configurable}">
      <div class="">
        <c:forEach var="area" items="${box.assignedAreas}">
            <div class="GUIArea <c:out value="${area.name}"/><fmt:message key="box_AreaCustomizable" bundle="${layout_Messages}"/> <c:out value="${area.className}"/>" id="<c:out value="${area.name}"/>">
                  <div class="GUIAreaControls">
                    <syswf:control action="layoutHide" mode="postAnchor" caption="${hide}">
                      <syswf:attribute name="class" value="Control CloseControl"/>
                      <syswf:param name="areaName" value="${area.name}"/>
                    </syswf:control>
                    <span class="MoveControls">
                    <c:choose>
                        <c:when test="${box.style eq 'vertical'}">
                            <syswf:control action="layoutMoveUp" mode="postAnchor" caption="${moveUp}">
                              <syswf:attribute name="class" value="Control MoveUpControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                            <syswf:control mode="postanchor" action="layoutMoveDown" caption="${moveDown}">
                              <syswf:attribute name="class" value="Control MoveDownControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                            <syswf:control action="layoutMoveLeft" mode="postAnchor" caption="${moveLeft}">
                              <syswf:attribute name="class" value="Control MoveLeftControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                            <syswf:control mode="postanchor" action="layoutMoveRight" caption="${moveRight}">
                                <syswf:attribute name="class" value="Control MoveRightControl"/>
                                <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                        </c:when>
                        <c:otherwise>
                            <syswf:control action="layoutMoveLeft" mode="postAnchor" caption="${moveUp}">
                              <syswf:attribute name="class" value="Control MoveUpControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                            <syswf:control mode="postanchor" action="layoutMoveRight" caption="${moveDown}">
                              <syswf:attribute name="class" value="Control MoveDownControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                            <syswf:control action="layoutMoveUp" mode="postAnchor" caption="${moveLeft}">
                              <syswf:attribute name="class" value="Control MoveLeftControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                            <syswf:control action="layoutMoveDown" mode="postAnchor" caption="${moveRight}">
                              <syswf:attribute name="class" value="Control MoveRightControl"/>
                              <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                        </c:otherwise>
                    </c:choose>
                    </span>
                  </div>
                  <span class="GUIAreaName"><c:out value="${area.caption}" /></span>
                  <div class="GUIAreaBody">
                  <%--<div class="GUIAreaBody" onmouseover="makeDraggable(this);">--%>
                  <c:out value="${area.code}" escapeXml="false"/>
                  </div>
            </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
        <c:forEach var="area" items="${box.assignedAreas}">
          <div class="GUIArea <c:out value="${area.name}"/><fmt:message key="area" bundle="${webFrameworkUI_Messages}"/> <c:out value="${area.className}"/>">
            <div class="GUIAreaBody">
            <c:out value="${area.code}" escapeXml="false"/>
            </div>
          </div>
        </c:forEach>
    </c:otherwise>
  </c:choose>
</c:if>
