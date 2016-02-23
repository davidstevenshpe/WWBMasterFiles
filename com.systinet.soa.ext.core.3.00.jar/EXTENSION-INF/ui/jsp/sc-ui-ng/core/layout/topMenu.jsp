<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="menuBundle"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uiBundle"/>

<fmt:message var="menu_bullet" key="menu.bullet" bundle="${menuBundle}"/>
<fmt:message var="menu_separator" key="menu.separator" bundle="${menuBundle}"/>
<fmt:message var="menu_text_create" key="menu.text.create" bundle="${menuBundle}"/>
<fmt:message var="menu_text_import" key="menu.text.import" bundle="${menuBundle}"/>
<fmt:message var="menu_text_contract" key="menu.text.contract" bundle="${menuBundle}"/>
<fmt:message var="menu_text_favorite" key="menu.text.favorite" bundle="${menuBundle}"/>
<fmt:message var="menu_text_recent_doc" key="menu.text.recent.doc" bundle="${menuBundle}"/>
<fmt:message var="csa_home" key="CSA_home" bundle="${uiBundle}"/>

<fmt:setBundle basename="customization.CustomizationMessages" var="customizationMessages"/>
<!--
	Default view: provider, analyst, partner 
 -->

<fmt:message var="artifact_label" key="${defaultView}_leftmenu_${defaultView}_artifacts_label" bundle="${customizationMessages}"/>

<!-- Detect which groups are rendered in left or rihgt menu  -->
<c:set var="SEPARATOR" value="left"/>
<c:set var="separatorText" value="separator"/>

<!-- Left Menu -->
<div id="left-navigation">
	<ul class="dropdown dropdown-horizontal cell-container">
		<!-- Customization -->
		<c:if test="${not empty customizeLinks}">
			<li style="background-color: transparent;padding-right:6px">
	           <c:out value="${customizeLinks}" escapeXml="false"/>
			</li>
		</c:if>
		<c:if test="${context eq 'csa'}">
			<syswf:component name="/cloud/migration/csa/topMenu" prefix="${context}TopMenu">
				<syswf:param name="wrap" value="false"/>
			</syswf:component>
		</c:if>
		<c:forEach var="group" items="${internalNavigation.groups}" varStatus="groupStatus">
			<c:if test="${((group.id == 'admin.contract.deployment' or group.id == 'reports.proxy-mgmt') and proxyMgmtEnabled) or (group.id != 'admin.contract.deployment' and group.id != 'reports.proxy-mgmt')}">
				<c:if test="${fn:toLowerCase(group.id) eq separatorText}">
					<c:set var="SEPARATOR" value="right"/><!-- The rest of groups will be rendered in right side of menu -->
				</c:if>
				<c:if test="${SEPARATOR eq 'left'}">
					<c:if test="${not empty group.description}">
						<li class="systinet-horizontal-menu-text">
							<c:out value="${group.description}"/>
						</li>
					</c:if>
					<c:choose>
						<c:when test="${not empty group.label}">
							<li class="${group.styleClass}">
								<span><c:out value="${group.label}"/></span>
								<span class="dir">&nbsp;</span>
								<ul class="systinet-horizontal-menu-arifacts">
									<c:forEach var="item" items="${group.elements}">
										<syswf:component name="/core/layout/subMenu" prefix="${item.id}Menu">
											<syswf:param name="item" value="${item}"/>
											<syswf:param name="canCustomize" value="${canCustomize}"/>
											<syswf:param name="itemType" value="${itemType}"/>
											<syswf:param name="wrap" value="false"/>
										</syswf:component>
									</c:forEach>
								</ul>																
							</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${group.elements}">
								<c:if test="${context eq 'csa'}">
									<c:set target="${item}" property="label" value="${csa_home}"/>
								</c:if>
								<syswf:component name="/core/layout/subMenu" prefix="${item.id}Menu">
									<syswf:param name="item" value="${item}"/>
									<syswf:param name="canCustomize" value="${canCustomize}"/>
									<syswf:param name="itemType" value="${itemType}"/>
									<syswf:param name="wrap" value="false"/>
								</syswf:component>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:if>
		</c:forEach>
	</ul>	
</div>
<!-- Right Menu -->
<c:set var="SEPARATOR" value="left"/>
<div id="right-navigation">
	<ul class="dropdown dropdown-horizontal cell-container">
		<c:forEach var="group" items="${internalNavigation.groups}" varStatus="groupStatus">				
			<c:if test="${SEPARATOR eq 'right'}">
				<c:if test="${not empty group.description}">
					<li class="systinet-horizontal-menu-text">
						<c:out value="${group.description}"/>
					</li>
				</c:if>
				<c:choose>
					<c:when test="${not empty group.label}">
						<li class="${group.styleClass}" style="position: relative;">
							<span><c:out value="${group.label}"/></span>
							<span class="dir">&nbsp;</span>
							<ul class="systinet-horizontal-menu-arifacts" <c:if test="${groupStatus.last or group.id eq 'report.allReports'}">style="left:auto; right:0px"</c:if>>
								<c:forEach var="item" items="${group.elements}">
									<syswf:component name="/core/layout/subMenu" prefix="${item.id}Menu">
										<syswf:param name="item" value="${item}"/>
										<syswf:param name="canCustomize" value="${canCustomize}"/>
										<syswf:param name="itemType" value="${itemType}"/>
										<syswf:param name="wrap" value="false"/>
									</syswf:component>
								</c:forEach>
							</ul>
						</li>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${group.elements}">
							<syswf:component name="/core/layout/subMenu" prefix="${item.id}Menu">
								<syswf:param name="item" value="${item}"/>
								<syswf:param name="canCustomize" value="${canCustomize}"/>
								<syswf:param name="itemType" value="${itemType}"/>
								<syswf:param name="wrap" value="false"/>
							</syswf:component>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${fn:toLowerCase(group.id) eq separatorText}">
				<c:set var="SEPARATOR" value="right"/><!-- The rest of groups will be rendered in right side of menu -->
			</c:if>				
		</c:forEach>
	</ul>
</div>
