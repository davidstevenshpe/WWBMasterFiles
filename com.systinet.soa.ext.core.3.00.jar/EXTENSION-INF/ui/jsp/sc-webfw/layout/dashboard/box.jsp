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
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webframeworkUI_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="dashboard.box_closeThisArea" var="closeThisArea" bundle="${layout_Messages}"/>
<fmt:message key="dashboard.box_customizeThisAreaContent" var="customizeThisAreaContent" bundle="${layout_Messages}"/>
<fmt:message key="close" var="close" bundle="${webframeworkUI_Messages}"/>
<fmt:message key="customize" var="customize" bundle="${webframeworkUI_Messages}"/>

<c:forEach var="area" items="${box.assignedAreas}">
    <div class="shrWidget" id="<c:out value="${area.name}"/>">
        <div class="shrWidgetHead">
            <c:if test="${panel.isCustomizable and showAddPageComponent}">
                <c:choose>
                    <c:when test="${not empty logged}">
                        <syswf:control action="layoutHide" mode="postAnchor" caption="${close}" hint="${closeThisArea}" id="close${area.name}">
                            <syswf:attribute name="class" value="shrWidgetBtClose"/>
                            <syswf:param name="areaName" value="${area.name}"/>
                        </syswf:control>
                    </c:when>
                    <c:otherwise>
                        <syswf:control mode="anchor" targetTask="/login" caption="${close}"
                                       hint="${closeThisArea}" wrapper="span" id="close${area.name}">
                            <syswf:param name="userRole" value="uddiUser"/>
                            <syswf:attribute name="class" value="shrWidgetBtClose"/>
                        </syswf:control>
                    </c:otherwise>
                </c:choose>
                <c:if test="${area.customizable and not(area.customized)}">
                    <c:choose>
                        <c:when test="${not empty logged}">
                            <syswf:control action="customize" mode="postAnchor" caption="${customize}"
                                           hint="${customizeThisAreaContent}" id="customize${area.name}">
                                <syswf:attribute name="class" value="shrWidgetBtCustomize"/>
                                <syswf:param name="areaName" value="${area.name}"/>
                            </syswf:control>
                        </c:when>
                        <c:otherwise>
                            <syswf:control mode="anchor" targetTask="/login" caption="${customize}"
                                           hint="${customizeThisAreaContent}" wrapper="span" id="customize${area.name}">
                                <syswf:param name="userRole" value="uddiUser"/>
                                <syswf:attribute name="class" value="shrWidgetBtCustomize"/>
                            </syswf:control>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:if>
<%--
            <a href="#" class="shrWidgetBtRefresh" title="Reload"></a>
--%>
            <div class="shrHandle">
            	<h3><c:out value="${area.caption}"/></h3>
            </div>
            <div class="clear"></div>
        </div>
        <c:out value="${area.code}" escapeXml="false"/>
    </div>
</c:forEach>