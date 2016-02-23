<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="scComponents"/>
<c:choose>
    <c:when test="${empty align or align eq 'vertical'}">
		<c:choose>
		    <c:when test="${fn:length(visibleTabs)  > 1 or not hideSingleTab}">
		    <div class="flex-container">
		    	<div id="leftcolumn" class="scrollable">
						<ul class="EA-left-tabs">
							<c:forEach var="visibleTab" items="${visibleTabs}">
							<li id="${visibleTab.id}-tab-link">
		                        <c:choose>
		                            <c:when test="${activeTabId ne visibleTab.id}">
		                                <c:choose>
		                                    <c:when test="${not empty visibleTab.paramsMap['browseLocation']}">
		                                        <syswf:control mode="anchor"  targetDepth="0" targetTask="${visibleTab.paramsMap['browseLocation']}" caption="${visibleTab.label}" hint="${visibleTab.description}" wrapper="span" id="${visibleTab.id}">
		                                            <syswf:param name="tabId" value="${visibleTab.id}"/>
		                                            <syswf:param name="artifactType" value="${visibleTab.paramsMap['artifactType']}"/>
		                                        </syswf:control>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <syswf:control mode="anchor" caption="${visibleTab.label}" hint="${visibleTab.description}" action="switchTab" id="${visibleTab.id}">
		                                            <syswf:param name="tabId" value="${visibleTab.id}"/>
		                                        </syswf:control>
		                                    </c:otherwise>
		                                </c:choose>
		                            </c:when>
		                            <c:otherwise>
		                                <c:choose>
		                                    <c:when test="${not empty visibleTab.paramsMap['browseLocation']}">
		                                        <a class="selected" href="${webdataPath}/../../service-catalog${visibleTab.paramsMap['browseLocation']}?artifactType=${visibleTab.paramsMap['artifactType']}&tabId=${visibleTab.id}">${visibleTab.label}</a>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <a class="selected" href="javascript:void(0);">${visibleTab.label}</a>
		                                    </c:otherwise>
		                                </c:choose>
		                            </c:otherwise>
		                        </c:choose>
				            </li>
							</c:forEach>
							
							<c:if test="${not empty moreTabs}">
							<li>
								<a class="show-more" href="javascript:void(0);" onclick="$(this).parent().hide();$('#leftcolumn li.ext-hidden-item').show()">
									<fmt:message key="artifactTabs.more" bundle="${scComponents}"/>
								</a>
							</li>
							
							<c:forEach var="moreTab" items="${moreTabs}">
							<li class="ext-hidden-item" id="${moreTab.id}-tab-link">
		                        <syswf:control mode="anchor" caption="${moreTab.label}" hint="${moreTab.description}" action="switchTab" id="${moreTab.id}">
		                            <syswf:param name="tabId" value="${moreTab.id}"/>
		                        </syswf:control>
		                    </li>
		                	</c:forEach>
							</c:if>
					</ul>
				</div>
					<div id="content" class="fixed-content">
						<div  class="scrollable">
						<c:if test="${not empty activeTab}">
						    <syswf:component prefix="${activeTab.id}" name="${activeTab.componentName}">
						        <syswf:param name="tabId" value="${activeTab.id}"/>
						        <syswf:paramSet value="${activeTab.paramsMap}"/>
						    </syswf:component>
						</c:if>
						</div>
					</div>
				</div>	
		    </c:when>
		    <c:otherwise>
				<c:if test="${not empty activeTab}">
				    <syswf:component prefix="${activeTab.id}" name="${activeTab.componentName}">
				        <syswf:param name="tabId" value="${activeTab.id}"/>
				        <syswf:paramSet value="${activeTab.paramsMap}"/>
				    </syswf:component>
				</c:if>
		    </c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<div class="tabs">
		<div class="panel tabs">
			<div class="panel-heading">
				<div class="panel-control" style="float:left;margin-left:30px">
					<ul class="nav nav-tabs">
					<c:forEach var="visibleTab" items="${visibleTabs}" varStatus="status">
						<c:set var="styleClass">
							<c:if test="${not empty activeTab and visibleTab.id eq activeTab.id}">active</c:if>
						</c:set>
						<li id="link-tab-${visibleTab.id}" class="${styleClass}"><c:choose>
		                            <c:when test="${activeTabId ne visibleTab.id}">
		                                <c:choose>
		                                    <c:when test="${not empty visibleTab.paramsMap['browseLocation']}">
		                                        <syswf:control mode="anchor"  targetDepth="0" targetTask="${visibleTab.paramsMap['browseLocation']}" caption="${visibleTab.label}" hint="${visibleTab.description}" wrapper="span" id="${visibleTab.id}">
		                                            <syswf:param name="tabId" value="${visibleTab.id}"/>
		                                            <syswf:param name="artifactType" value="${visibleTab.paramsMap['artifactType']}"/>
		                                        </syswf:control>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <syswf:control mode="anchor" caption="${visibleTab.label}" hint="${visibleTab.description}" action="switchTab" id="${visibleTab.id}">
		                                            <syswf:param name="tabId" value="${visibleTab.id}"/>
		                                        </syswf:control>
		                                    </c:otherwise>
		                                </c:choose>
		                            </c:when>
		                            <c:otherwise>
		                                <c:choose>
		                                    <c:when test="${not empty visibleTab.paramsMap['browseLocation']}">
		                                        <a class="selected" href="${webdataPath}/../../service-catalog${visibleTab.paramsMap['browseLocation']}?artifactType=${visibleTab.paramsMap['artifactType']}&tabId=${visibleTab.id}">${visibleTab.label}</a>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <a class="selected" href="javascript:void(0);">${visibleTab.label}</a>
		                                    </c:otherwise>
		                                </c:choose>
		                            </c:otherwise>
		                        </c:choose></li>
					</c:forEach>
					</ul>
				</div>
				<h3 class="panel-title">&nbsp;</h3>
			</div>
			<div class="panel-body">
				<div class="tab-content">
					<c:forEach var="visibleTab" items="${visibleTabs}" varStatus="status">
						<c:set var="styleClass">
							<c:if test="${not empty activeTab and visibleTab.id eq activeTab.id}">active in</c:if>
						</c:set>
						<div class="tab-pane fade ${styleClass}" id="tab-${visibleTab.id}">
							<c:if test="${not empty activeTab and visibleTab.id eq activeTab.id}">
						    <syswf:component prefix="${activeTab.id}" name="${activeTab.componentName}">
						        <syswf:param name="tabId" value="${activeTab.id}"/>
						        <syswf:paramSet value="${activeTab.paramsMap}"/>
						    </syswf:component>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	</c:otherwise>
</c:choose>