<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<jsp:useBean id="timeBean" class="com.hp.systinet.shared.TimeBean"/>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.platform.ui.layouts.LayoutsMessages" var="layouts_Message"/>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messagess"/>
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="newui_Messages"/>
<fmt:setBundle basename="com.hp.systinet.platform.ui.person.PersonMessages" var="person_messages"/>
<fmt:setBundle basename="shared.aboutBox" var="aboutBox_Messages"/>

<fmt:message key="designV3.designV3Main_rootLayout" var="varRootLayout" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_status" var="varStatus" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_content" var="varContent" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_navigation" var="varNavigation" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_notices" var="varNotices" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_leftMenu" var="varLeftMenu" bundle="${layouts_Message}"/>

<fmt:message var="poweredBy" key="rebranding.poweredByFooter" bundle="${rebranding_Messages}"/>
<fmt:message var="coCopyrightBefore" key="rebranding.coCopyright.before" bundle="${rebranding_Messages}"/>
<fmt:message var="coCopyrightAfter" key="rebranding.coCopyright.after" bundle="${rebranding_Messages}"/>

<fmt:message key="rebranding.logoProductName" var="productName" bundle="${rebranding_Messages}"/>
<fmt:message var="productInformation" key="PRODUCT_INFO_TASK_CAPTION" bundle="${aboutBox_Messages}"/>

<fmt:message key="productText" var="productText" bundle="${webFrameworkUI_Messages}"/>
<c:set var="context">
<c:choose>
<c:when test="${empty sessionScope.csaContext}">em</c:when>
<c:otherwise>${sessionScope.csaContext}</c:otherwise>
</c:choose>
</c:set>
<syswf:panel name="main" wrap="false">

  <syswf:layout name="/core/impl/layout/newUiLayout">
	<syswf:box name="main" caption="${varRootLayout}"/>
	<syswf:param name="context" value="${context}"/>
  </syswf:layout>

	<syswf:area caption="header" name="header" defaultBox="header">
		<c:set var="eventCfgOpenFn" value="${prefix}eventCfgFn"/>
		<c:set var="headerClick">
			<c:if test="${context ne 'csa'}">onclick="javascript:window.location='<c:out value="${webdataPath}"/>/../../..'"</c:if>
		</c:set>
		<div id="systinet-application-header-left" ${headerClick}>
			<h1 class="Logo"><c:choose><c:when test="${context eq 'em'}">${productName}</c:when><c:otherwise><fmt:message key="CSA_productName" bundle="${newui_Messages}"/></c:otherwise></c:choose></h1>
		</div>	
		<div id="systinet-application-header-customization">
			<syswf:component name="core/layout/headerCustomizationBox" prefix="headerCustomizationBox">
				<syswf:param name="wrap" value="false"/>
				<c:if test="${not empty param.customizationModeSwitch and param.customizationModeSwitch eq 'true'}"><%-- get key/value from query string --%>
					<syswf:param name="customizationModeSwitch" value="true"/>
				</c:if>
			</syswf:component>
		</div>
	</syswf:area>
	<syswf:area caption="domainselection" name="domainselection" defaultBox="domainselection">
		<div id="systinet-application-header-domain">
			<syswf:component name="/core/impl/layout/domainSelection" prefix="domainselection">				
				<syswf:param name="activeTab" value="${activeTab}"/>	
				<syswf:param name="context" value="${context}"/>
				<syswf:param name="composite" value="${composite}"/>
			</syswf:component>			
		</div>
	</syswf:area>
	<syswf:area caption="userevent" name="userevent" defaultBox="userevent">
		<div id="systinet-application-header-right">
			<syswf:component name="/core/impl/layout/userControls" prefix="userControls">
				<syswf:param name="eventCfgOpenFn" value="${eventCfgOpenFn}"/>
				<syswf:param name="defaultView" value="${defaultView}"/>
				<syswf:param name="wrap" value="false"/>
				<syswf:param name="context" value="${context}"/>
			</syswf:component>
			<%--@elvariable id="newEventNotificationConfigType" type="com.hp.systinet.sc.userevent.config.ConfigurationType"--%>
		    <%--@elvariable id="unsupportedSources" type="java.lang.String"--%>
		    <syswf:component name="/core/impl/userevent/eventConfigDialog" prefix="dialog">
			    <syswf:param name="configType" value="${newEventNotificationConfigType}"/>
			    <syswf:param name="openFunctionName" value="${eventCfgOpenFn}"/>
		    </syswf:component>
		</div>
	</syswf:area>
<c:if test="${context ne 'csa'}">
	<syswf:area caption="${varNavigation}" name="navigation" defaultBox="navigation" >
	<syswf:component name="/core/impl/layout/tabs" prefix="tabs" wrap="false">
        <syswf:param name="activeTab" value="${activeTab}"/>
		<syswf:param name="wrap" value="false"/>
	</syswf:component>
 	 </syswf:area>
  	<syswf:area caption="search" name="search" defaultBox="search">
		<div id="systinet-application-header-search">
		<syswf:component name="/core/search/headerSearch" prefix="headerSearch">
			<syswf:param name="defaultView" value="${defaultView}"/>
			<syswf:param name="wrap" value="false"/>
		</syswf:component>
		</div>
	</syswf:area>
</c:if>
	<syswf:area caption="menu" name="menu" defaultBox="menu">
		<syswf:component name="/core/layout/menu" prefix="topCatalogMenu" wrap="false">
			<syswf:param name="customizedComponent" value="/core/layout/topMenu"/>
	  		<syswf:param name="customizationId" value="${navigationId}"/>
	  		<syswf:param name="defaultView" value="${defaultView}"/>
	  		<syswf:param name="rendersCustomizeLinks" value="true"/>
			<syswf:param name="wrap" value="false"/>
			<syswf:param name="context" value="${context}"/>
			<syswf:param name="activeTabLabel" value="${activeTabLabel}"/>
	  	</syswf:component>
	</syswf:area>
  <syswf:area caption="${varContent}" name="content" defaultBox="content" placementPriority="1">
    <syswf:component name="${contentArea}" prefix="content" params="${contentParameters}">
    	<syswf:param name="uiContext">${sessionScope.csaContext}</syswf:param>
    </syswf:component>
  </syswf:area>

  <syswf:area caption="${varNotices}" name="notices" defaultBox="notices">
	<div class="Copyright">		
		<div id="product_about_source" class="x-hidden">
			<div class="x-window-header"><fmt:message key="Aboutbox_heading" bundle="${newui_Messages}">
                <fmt:param><c:out value="${productName}"/></fmt:param>
            </fmt:message>
			</div>
			<div class="x-window-body">
				<div class="UI AboutBox">
					<div class="ProductName"><span><c:out value="${productName}"/></span></div>
					<div class="ProductVersion"><span>
                        <fmt:message key="Aboutbox_productVersion" bundle="${aboutBox_Messages}">
                            <fmt:param value="${about.buildVersion}"/>
                            <fmt:param value="${about.buildId}"/>
                        </fmt:message>
                    </span></div>
					<div class="ProductCopyright"><span><fmt:message key="copyright" bundle="${aboutBox_Messages}"/></span></div>
                    <div class="ProductExtensions"><syswf:control mode="anchor" targetTask="/common/productInformation" caption="${productInformation}"/></div>
					<div class="ProductBuildtime"><span>
                        <fmt:message key="Aboutbox_productBuild" bundle="${aboutBox_Messages}">
                            <fmt:param value="${about.buildId}"/>
                        </fmt:message>
                    </span></div>
				</div>
			</div>
		</div>
        <c:choose>
            <c:when test="${not welcome.licenseAccepted}">
                <div id="product_license_source" class="x-hidden">
                    <div class="x-window-header"><fmt:message key="designV3.designV3Main_LicenseAgreement_P1" bundle="${layouts_Message}">
                        <fmt:param><c:out value="${productName}"/></fmt:param>
                    </fmt:message></div>
                    <div class="x-window-body">
                        <div class="UI WelcomeBox">
                            <pre>
                            ${welcome.license}
                            </pre>
                        </div>
                    </div>
                </div>
                <syswf:control mode="script" targetTask="/logout" caption="declineProductLicense"/>
                <syswf:control mode="script" caption="acceptProductLicense" action="acceptLicense"/>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function(){ SPopup.Window.forceOpen('product_license','product_license_source',{
                        autoScroll: true,
                        width:950,
                        height:600,
                        resizable:true,
                        centerOnScreen:true,
                        plain:false,
                        buttonAlign:'center',
                        closable:false,
                        buttons:[{
                            text:'<fmt:message key="designV3.designV3Main_Accept" bundle="${layouts_Message}"/>',
                            handler:function(){acceptProductLicense();}
                        },{
                            text:'<fmt:message key="designV3.designV3Main_Decline" bundle="${layouts_Message}"/>',
                            handler:function(){declineProductLicense();}
                        }]});
                    });
                
//]]>
</script>
            </c:when>
            <c:when test="${welcome.firstLogin}">
                <div id="product_welcome_source" class="x-hidden">
                    <div class="x-window-header"><fmt:message key="welcomeHead.title2" bundle="${person_messages}">
                        <fmt:param><c:out value="${productName}"/></fmt:param>
                    </fmt:message></div>
                    <div class="x-window-body">
                        <c:if test="${welcome.emptyEmail}">
                        <p class="Message Warning">
                            <strong><fmt:message key="welcomeBody.email.note" bundle="${person_messages}"/></strong> <fmt:message key="welcomeBody.emailNotice" bundle="${person_messages}"/> <strong><a href="<c:out value="${welcome.editTask}"/>"><span><fmt:message key="welcomeBody.linkToEmailFill" bundle="${person_messages}"/></span></a></strong>.
                        </p>
                        </c:if>
                        <div class="UI WelcomeBox">

                            <h2><fmt:message key="welcomeBody.title" bundle="${person_messages}"/></h2>
                            
                            <%-- base url is <server>/soa/web/service-catalog --%>                            
                            <img src="<c:out value="${welcome.baseUrl}"/>/../design/base/skin/img/com_spopup/welcomescreen_illustration.png" />
                            
                            <p>
                                <fmt:message key="welcomeBody.accountInfo" bundle="${person_messages}">
                               </fmt:message>
                            </p>

                            <h2><fmt:message key="welcomeBody.fav.title" bundle="${person_messages}"/></h2>
                            
                            <%-- base url is <server>/soa/web/service-catalog --%>
                            <img src="<c:out value="${welcome.baseUrl}"/>/../design/base/skin/img/com_spopup/welcome_screen_navigator.jpg" align="left"/>
                            
                            <p>
                               <fmt:message key="welcomeBody.fav.text1" bundle="${person_messages}"/>
                            </p>
                            <p>
                                <fmt:message key="welcomeBody.fav.text2" bundle="${person_messages}"/> <a class="UI Icon AddFavorite"><span><fmt:message key="welcomeBody.fav.text3" bundle="${person_messages}"/></span></a>.<fmt:message key="welcomeBody.fav.text4" bundle="${person_messages}"/>
                            </p>
                            <p>
                                <fmt:message key="welcomeBody.nav.text1" bundle="${person_messages}"/> <a class="UI Icon Navigator"><span><fmt:message key="welcomeBody.nav.text2" bundle="${person_messages}"/></span></a> <fmt:message key="welcomeBody.nav.text3" bundle="${person_messages}"/>
                            </p>
                            <p><fmt:message key="welcomeBody.nav.text4" bundle="${person_messages}"/></p>


                            <br clear="all" />

                            <h2><fmt:message key="welcomeBody.helpTitle" bundle="${person_messages}"/></h2>
                            <p>
                                <fmt:message key="welcomeBody.helpInfo" bundle="${person_messages}"/>
                            </p>
                            <br/>

                        </div>
                    </div>
                </div>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function(){
						SPopup.Window.forceOpen('product_welcome','product_welcome_source',{width:625,autoHeight:true,resizable:false,centerOnScreen:true,plain:false,buttonAlign:'center',buttons:[{text:'<fmt:message key="welcomeHead.button" bundle="${person_messages}"/>',handler:function(){SPopup.Window.Instance['product_welcome'].hide();}}]});
					});
                
//]]>
</script>
            </c:when>
        </c:choose>
		<div>
			<div class="product-name">
				${productName}
			</div>
			<div class="about-and-date">
			<c:if test="${showDevelLink}">
                <syswf:control mode="anchor" targetTask="/admin/util/devel" caption="Devel Tools" ><syswf:attribute name="class" value="gray-link"/></syswf:control>&nbsp; | &nbsp;
            </c:if>
            <a href="javascript:void(0)" id="product_about" class="gray-link">
            	<span>
                	<fmt:message key="Aboutbox_label" bundle="${newui_Messages}">
                    	<fmt:param>
                   		</fmt:param>
                	</fmt:message>            
               	</span>
          	</a> &nbsp; | &nbsp;
<%--
            <a class="gray-link" href="${baseUrl}/../../../hp-em-doc/index.html">Documentation
            </a> &nbsp; | &nbsp;
--%>
			<span>
				<fmt:message key="currentDate" bundle="${webFrameworkUI_Messages}"/> ${timeBean.time}
			</span> &nbsp; | &nbsp;
			<span>
				<fmt:message key="lastLogin" bundle="${webFrameworkUI_Messages}"/> ${lastLoginTime}
			</span>
			
			<script type="text/javascript">
//<![CDATA[

                Ext.onReady(function(){
					SPopup.AboutBox.init('product_about','product_about_source'); 
					moveWindow('product_about_source','popupWindows');
				});
			
//]]>
			</script>
			</div>
			<c:if test="${not empty coCopyrightBefore}">
			    <c:out value="${coCopyrightBefore}"/>
			    <br/>
			</c:if>
			<fmt:message key="copyright" bundle="${webFrameworkUI_Messages}"/>
			<c:if test="${not empty coCopyrightAfter}">
			    <br/>
			    <c:out value="${coCopyrightAfter}"/>
			</c:if>
			
		</div>		
		
	</div>
  </syswf:area>

</syswf:panel>
<script type="text/javascript">
	Ext.onReady(function(){
		/* refresh currency symbol */
		layoutManager.currencySymbol = '${currencySymbol}';
        layoutManager.formatCurrency=function(val) {
            if(val==0) return 0;
            return Ext4.util.Format.currency(val, ' ${currencySymbol}', '0.0','${currencySymbol}'!=='$');
        };
        layoutManager.currencyRender = function (v,m,record) {
            if(isNaN(v)) return v;
            else{
                return layoutManager.formatCurrency(v);
            }
        };
    });
</script>