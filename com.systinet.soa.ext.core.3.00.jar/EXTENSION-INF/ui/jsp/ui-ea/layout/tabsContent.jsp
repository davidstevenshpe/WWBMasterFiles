<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<div id="content-container">
	<c:if test="${not empty description}"><i><c:out value="${description}" escapeXml="false"/></i></c:if>
	<div id="page-content" class="tabs">
		<div class="panel tabs">
			<div class="panel-heading">
				<div class="panel-control" style="float:left;margin-left:30px">
					<ul class="nav nav-tabs">
					<c:forEach var="subTab" items="${tabs.tabs}" varStatus="status">
                        <c:set var="styleClass">
                            <c:if test="${not empty activeSubTab and subTab.id eq activeSubTab.id}">active</c:if>
                        </c:set>
                        <li id="link-tab-${subTab.id}" class="${styleClass}">
                            <c:choose>
                                <c:when test="${activeSubTabId ne subTab.id}">
                                    <syswf:control mode="anchor" caption="${subTab.label}" hint="" targetTask="${url}" id="${subTab.id}">
										<syswf:taskParam name="tabId">${tabId}</syswf:taskParam>
										<syswf:taskParam name="subTabId">${subTab.id}</syswf:taskParam>
                                    </syswf:control>
                                </c:when>
                                <c:otherwise>
                                    <a class="selected" href="javascript:void(0);">${subTab.label}</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
					</c:forEach>
					</ul>
				</div>
				<h3 class="panel-title">&nbsp;</h3>
			</div>
			<div class="panel-body">
				<div class="tab-content">
					<c:forEach var="subTab" items="${tabs.tabs}" varStatus="status">
                        <c:set var="styleClass">
                            <c:if test="${not empty activeSubTab and subTab.id eq activeSubTab.id}">active in</c:if>
                        </c:set>
                        <div class="tab-pane fade ${styleClass}" id="tab-${subTab.id}">
                            <c:if test="${not empty activeSubTab and subTab.id eq activeSubTab.id}">
                                <syswf:component prefix="${activeSubTab.id}" name="${activeSubTab.componentName}">
                                    <syswf:paramSet value="${activeSubTab.paramsMap}"/>
                                    <syswf:param name="linkTabId" value="link-tab-${activeSubTab.id}"/>
                                    <syswf:param name="isActive" value="true"/>
                                </syswf:component>
                            </c:if>
                        </div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>