<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="menuItemShow" value="true"/>

<c:if test="${item.id == 'reports.create.artifact' and canCustomize == false}">
	<c:set var="menuItemShow" value="false"/>
</c:if>

<%-- Group --%>
<c:if test="${itemType[item] == 0}">
	<li class="${item.styleClass} sub-menu">
		<span class="dir"><c:out value="${item.label}"/></span>
		<ul class="systinet-horizontal-arifacts">
			<c:forEach var="subItem" items="${item.elements}">
				<syswf:component name="/core/layout/subMenu" prefix="${subItem.id}SubMenu">
					<syswf:param name="item" value="${subItem}"/>
					<syswf:param name="canCustomize" value="${canCustomize}"/>
					<syswf:param name="itemType" value="${itemType}"/>
					<syswf:param name="wrap" value="false"/>
				</syswf:component>
			</c:forEach>
		</ul>
	</li>
</c:if>

<%-- Task --%>
<c:if test="${itemType[item] == 1}">
	<c:choose>
		<c:when test="${item.id == 'reports.create.artifact'}">
			<c:if test="${menuItemShow}">
				<li class="${item.styleClass}">
					<syswf:control mode="anchor" caption="${item.label}" targetTask="${item.taskLocation}" targetDepth="0" id="${item.id}">
						<syswf:paramSet value="${item.paramsMap}"/>
					</syswf:control>
				</li>
			</c:if>
		</c:when>
		<c:otherwise>
			<li class="${item.styleClass}">
				<syswf:control mode="anchor" caption="${item.label}" targetTask="${item.taskLocation}" targetDepth="0" id="${item.id}">
					<syswf:paramSet value="${item.paramsMap}"/>
					<syswf:param name="taskLabel" value="${item.label}"/>
				</syswf:control>
			</li>
		</c:otherwise>
	</c:choose>
</c:if>

<%-- Component --%>
<c:if test="${itemType[item] == 2}">
	<syswf:component name="${item.componentName}" prefix="${item.id}">
	<syswf:paramSet value="${item.paramsMap}"/>
	<syswf:param name="wrap" value="false"/>
	</syswf:component>
</c:if>