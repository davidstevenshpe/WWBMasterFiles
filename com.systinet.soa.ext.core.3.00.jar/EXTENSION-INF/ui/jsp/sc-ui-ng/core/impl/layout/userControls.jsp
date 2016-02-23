<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>

<fmt:message key="switch" var="switchDomain" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="showEvent" var="showEvent" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="newEvent" var="newEvent" bundle="${webFrameworkUI_Messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="menuBundle"/>

<fmt:message var="menu_arrow_down" key="menu.arrow.down" bundle="${menuBundle}"/>

<c:set var="dropdownClass">
<c:if test="${context ne 'csa'}">
dropdown dropdown-horizontal
</c:if>
</c:set>
<ul id="userevent-navigation" class="${dropdownClass}">

<c:if test="${context eq 'csa'}">
	<li class="em-documnetation-box">
		<a href="<c:out value="${sharedDocUrlBase}"/>/EM/WebHelp/Default.htm" target="SystinetDoc" class="em-documnetation-link">
			<span><fmt:message key="doc" bundle="${webFrameworkUI_Messages}"/></span>
		</a>
	</li>
</c:if>

	<li class="systinet-horizontal-menu-dir systinet-application-system-menu Avatar">
		<em class="fa fa-user"></em>&nbsp;
		<em class="user">		    
			<syswf:component name="/core/impl/util/principalLinkRenderer" prefix="loginNameText" wrap="false" trim="true">
		        <syswf:param name="principal" value="${loginName}" />
		        <syswf:param name="getLoginNameText" value="true" />
		        <syswf:param name="target" value="_top" />
		        <syswf:param name="targetDepth" value="0"/>
				<syswf:param name="wrap" value="false"/>
		    </syswf:component>
		</em>
		<em class="csa-icon down"></em>
		<br />
	
	<c:if test="${context ne 'csa'}">
		<em class="domain" style="font-size:100%">
			<c:choose>
			        <c:when test="${not empty tabDocumentationLink}"><a href="<c:out value="${baseUrl}"/>/../${tabDocumentationLink}" target="SystinetDoc"><span><fmt:message key="doc" bundle="${webFrameworkUI_Messages}"/></span></a></c:when>
			        <c:otherwise><a href="<c:out value="${sharedDocUrlBase}"/>/EM/WebHelp/Default.htm" target="SystinetDoc"><span><fmt:message key="doc" bundle="${webFrameworkUI_Messages}"/></span></a></c:otherwise>
			</c:choose>			
		</em>
	</c:if>
		
		<ul class="userevent-list">
			<li>
				<c:if test="${not hideSwitch}">
					<a href="<syswf:control mode="href" caption="${prefix}_newEvents" targetTask="/common/userevent/eventBrowser"><syswf:param name="view" value="${defaultView}"/></syswf:control>" id="platform_events">
						${showEvent}
						<mark class="gray"> 
							<span id="newEventCountSpan"></span>
							 ${newEvent}
						 </mark>
					</a>
				</c:if>
			</li>
			
			<li>
				<c:if test="${not empty domainLabel}">
				    <c:choose>
						<c:when test="${not isAdmin}">
							<syswf:component prefix="domainLink" name="/core/impl/util/artifactLinkRenderer" wrap="false" trim="true">
								<syswf:param name="uuid" value="${domainUuid}"/>
								<syswf:param name="caption" value="Domain Properties"/>
								<syswf:param name="target" value="_top" />
								<syswf:param name="sdmName" value="hpsoaDomainArtifact" />
								<syswf:param name="depth" value="0" />
								<syswf:param name="view" value="admin" />
								<syswf:param name="wrap" value="false"/>
							</syswf:component>
						</c:when>
						<c:otherwise>
							<syswf:control mode="anchor" targetTask="/admin/homepage" caption="System Administration">								
							</syswf:control>							
						</c:otherwise>
					</c:choose>
			    </c:if>
			</li>
			<li>
				<syswf:component name="/core/impl/util/principalLinkRenderer" prefix="loginNameLink" wrap="false" trim="true">
			        <syswf:param name="principal" value="${loginName}" />
			        <syswf:param name="getLoginNameLink" value="true" />
			        <syswf:param name="target" value="_top" />
			        <syswf:param name="targetDepth" value="0"/>
			        <syswf:param name="view" value="admin" />
					<syswf:param name="wrap" value="false"/>
			    </syswf:component>
			</li>
			<c:if test="${context eq 'csa'}">
			<li>
				<syswf:control mode="anchor" targetTask="/admin/configuration/homepage" caption="Licensing">
					<syswf:param name="tabId" value="licenseOverview" />
				</syswf:control>
			</li>
			</c:if>			
			<li class="systinet-horizontal-menu-separator hover">
				<c:if test="${not SEC_EXTERNAL_AUTHENTICATION or not empty CUSTOM_LOGOUT_URL}">
					<syswf:component prefix="logout" name="logoutLink" wrap="false" trim="true" />
				</c:if>
			</li>
		</ul>
	</li>
</ul>
<c:if test="${context eq 'csa'}">
	<script type="text/javascript">
	//<![CDATA[
	
	        Ext.onReady(function() {
	        	var userEventList = $('#userevent-navigation ul.userevent-list');
	            $('#userevent-navigation em.user').click(function(){
	            	userEventList.toggle();
	            });
	            userEventList.width(160);
	        });
	    
	//]]>
	</script>
</c:if>
<c:if test="${not hideSwitch}">

    <%--@elvariable id="eventCfgOpenFn" type="java.lang.String"--%>     
    <syswf:component prefix="newNotifications" name="/core/impl/userevent/newEventNotification">
        <syswf:param name="eventCfgOpenFn" value="${eventCfgOpenFn}"/>
    </syswf:component>
</c:if>