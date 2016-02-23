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
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="rootLayout_upToTOC" var="upToTOC" bundle="${layout_Messages}"/>
<fmt:message key="rootLayout_jumpUpToTOC" var="jumpUpToTOC" bundle="${layout_Messages}"/>
<fmt:message key="rootLayout_enterSearchPhrase" var="enterSearchPhrase" bundle="${layout_Messages}"/>
<fmt:message key="rebranding.productName" var="productName" bundle="${rebranding_Messages}"/>



<!DOCTYPE HTML>
<c:set var="loggedIn" value="${not empty globalSession['userName']}"/>
<html>
  <head>
    <title><c:out value="${productName}"/></title>
    <meta http-equiv="content-type" content="<c:out value="${contentType}"/>" />
    <meta http-equiv="pics-label" content="(pics-1.1 'http://www.icra.org/ratingsv02.html' l gen true for 'browse_root.html' r (nz 1 vz 1 lz 1 oz 1 cz 1))" />
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="cache-control" content="no-store">
    <meta http-equiv="expires" content="-1">
    <meta http-equiv="pragma" content="no-cache">
    <!-- Content values of following meta tags should be discussed -->
    <meta name="description" content="<fmt:message key="systinetResgistryDescription" bundle="${webFrameworkUI_Messages}"/>" />
    <meta name="keywords" content="<fmt:message key="systinetResgistryKeywords" bundle="${webFrameworkUI_Messages}"/>" />
    <link rel="icon" href="/systinet/platform/webdata/gfx/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="/systinet/platform/webdata/gfx/favicon.ico" type="image/x-icon" />
    <link href="/systinet/platform/webdata/gui/screen/css/index.css" rel="stylesheet" type="text/css" media="screen,projection" />
    <link href="/systinet/platform/webdata/gui/print/css/index.css" rel="stylesheet" type="text/css" media="print" />
    <link href="/systinet/platform/webdata/gui/screen/css/<c:out value="${skin}"/>/colorscheme.css" rel="stylesheet" type="text/css" media="screen,projection" />
    <c:if test="${rssLinkHolder != null}">
    <link id="<c:out value="${rssLinkHolder.id}"/>" href="<c:out value="${rssLinkHolder.href}"/>" rel="alternate" type="<c:out value="${rssLinkHolder.type}"/>" title="<c:out value="${rssLinkHolder.title}"/>"/>
    </c:if>
      <link href="/systinet/platform/webdata/gui/screen/css/noscript.css" rel="stylesheet" type="text/css" media="screen,projection" />
    <%--DEBUG:script src="output.js" type="text/javascript"></script--%>
	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/ArrayExtends.js" var="jsArrayExtends"/>
    <script src="<c:out value="${jsArrayExtends}"/>" type="text/javascript"></script>
	
	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/Cookies.js" var="jsCookies"/>
    <script src="<c:out value="${jsCookies}"/>" type="text/javascript"></script>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/DomEssentials.js" var="jsDomEssentials"/>
    <script src="<c:out value="${jsDomEssentials}"/>" type="text/javascript"></script>
    <%--script src="/systinet/platform/webdata/webdata/gui/screen/js/Functions.js" type="text/javascript"></script--%>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/Ajax.js" var="jsAjax"/>
    <script src="<c:out value="${jsAjax}"/>" type="text/javascript"></script>

    <%--script src="/systinet/platform/webdata/gui/screen/js/TableColumnsControl.js" type="text/javascript"></script--%>
    <%--script src="/systinet/platform/webdata/gui/screen/js/TabbedGroups.js" type="text/javascript"></script--%>
    <%--script src="/systinet/platform/webdata/gui/screen/js/GlossaryAddOn.js" type="text/javascript"></script--%>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/DatePicker.js" var="jsDatePicker"/>
    <script src="<c:out value="${jsDatePicker}"/>" type="text/javascript"></script>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/FeedReader.js" var="jsFeedReader"/>
    <script src="<c:out value="${jsFeedReader}"/>" type="text/javascript"></script>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/Widgets.js" var="jsWidgets"/>
    <script src="<c:out value="${jsWidgets}"/>" type="text/javascript"></script>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/AreaDragger.js" var="jsAreaDragger"/>
    <script src="<c:out value="${jsAreaDragger}"/>" type="text/javascript"></script>

	<syswf:localizedFileName fileName="/systinet/platform/webdata/gui/screen/js/initialization.js" var="jsInitialization"/>
    <script src="<c:out value="${jsInitialization}"/>" type="text/javascript"></script>

    <script type="text/javascript">
//<![CDATA[

    skin='<c:out value="${skin}"/>';
    baseUrl='<c:out value="${baseUrl}"/>';
    function addScriptCSS(){
      var links=document.getElementsByTagName('LINK');
      var style=links[links.length-1];
      var href=style.href.split('/');
      href[href.length-1]='script.css';
      style.href=href.join('/');
    }
    addScriptCSS();
    //]]>
    </script>
    <noscript></noscript>
  </head>
<body class="<c:out value="${bodyClass}"/>">
<!-- TASK=<c:out value="${taskName}"/> -->
  <a name="Top"></a>
  <div id="Identity">
    <div class="GUIHelper"><div class="GUIHelper"><div class="GUIHelper">
      <h1 title="<fmt:message key="systinet2Platform" bundle="${webFrameworkUI_Messages}"><fmt:param value="${productName}"/></fmt:message>"><a href="<c:out value="${baseUrl}"/>" title="<fmt:message key="rootLayout_gotoHomePageHint" bundle="${layout_Messages}"/>"><span class="Vendor"><c:out value="${productName}"/></span> <span class="Product"></span></a></h1>
    </div></div></div>
  </div>
  <div id="TOC" title="<fmt:message key="rootLayout_tocTitle" bundle="${layout_Messages}"/>">
    <a class="AreaAnchor" name="TOCArea"></a>
    <h2><fmt:message key="rootLayout_pageTOC" bundle="${layout_Messages}"/></h2>
    <ul>
      <li><a href="#ContentArea" title="<fmt:message key="rootLayout_jumpToMainPageContent" bundle="${layout_Messages}"/>"><span><fmt:message key="rootLayout_pageMainContent" bundle="${layout_Messages}"/>
      <li><a href="#SituationArea" title="<fmt:message key="rootLayout_currentUserOrRoleSituation" bundle="${layout_Messages}"/>"><span><fmt:message key="rootLayout_currentSituation" bundle="${layout_Messages}"/></span></a></li>
      <li><a href="#MenuArea" title="<fmt:message key="rootLayout_jumpToSiteNavigationMenu" bundle="${layout_Messages}"/>"><span><fmt:message key="rootLayout_navigationMenu" bundle="${layout_Messages}"/></span></a></li>
      <li><a href="#NoticesArea" title="<fmt:message key="rootLayout_jumpToAdditionPageNotices" bundle="${layout_Messages}"/>"><span><fmt:message key="notices" bundle="${webFrameworkUI_Messages}"/></span></a></li>
    </ul>
  </div>
  <hr />
  <div id="Content">
    <a class="AreaAnchor" name="ContentArea"></a>
    <div class="GUIHelper"><div class="GUIHelper"><div class="GUIHelper"><div class="GUIHelper">
      <div class="ContentGUI">
        <div class="GUIHelper"><div class="GUIHelper"><div class="GUIHelper"><div class="GUIHelper">
          <table border="0" cellspacing="0" width="100%">
            <tr>
              <!-- <td id="LeftPane" valign="top">
                <h2>Additional Navigation Menu</h2>
              </td> -->
              <td id="Body" valign="top">
                <a name="ContentAreaContent"></a>
                <c:if test="${not(noPageTitle eq 'true')}">
                  <c:out value="${panel.areas['history'].code}" escapeXml="false"/>
                  <!-- MAIN CONTENT PANEL -->
                  <!-- title -->
                  <c:out value="${panel.areas['title'].code}" escapeXml="false"/>
                </c:if>
                <!-- title -->
                <syswf:form id="ContentForm" enctype="multipart/form-data">
                  <c:choose>
                    <c:when test="${contentTabbingMode eq 'custom'}">
                      <%-- start div tag is rendered by inner component --%>
                      <%-- not any more --%>
                      <!-- <div class="SingleGroupSet"> -->
                      <div>
                    </c:when>
                    <c:when test="${contentTabbingMode eq 'multi'}">
                      <div class="GroupSet" id="groupSet2">
                    </c:when>
                    <c:otherwise>
                      <!-- <div class="SingleGroupSet"> -->
                      <!-- <div> -->
                      <div class="GroupSet" id="groupSet2">
                    </c:otherwise>
                  </c:choose>
                  <c:out value="${panel.areas['content'].code}" escapeXml="false" />
                  <!-- content -->
                  <!-- content -->
                      </div>
                </syswf:form>
                <!-- / MAIN CONTENT PANEL -->
              </td>
            </tr>
          </table>
        </div></div></div></div>
      </div>
    </div></div></div></div>
    <a href="#TOCArea" title="<c:out value="${jumpUpToTOC}"/>" class="TOCLink"><span><c:out value="${upToTOC}"/></span></a>
  </div>
  <div id="Sidebar" class="SidebarClosed">
    <div class="Open">
      <div id="SidebarTrigger" class="Trigger"><a href="javascript:triggerSidebar();" class="Control TriggerControl"><span><fmt:message key="close" bundle="${webFrameworkUI_Messages}"/></span></a></div>
      <!-- <div id="SidebarTrigger" class="Trigger" onmouseover="if (getID('Sidebar').className=='SidebarClosed') triggerSidebar();"><a href="javascript:triggerSidebar();" class="Control TriggerControl"><span>Close</span></a></div> -->
      <div id="SidebarPanel" class="Panel">
        <div class="TriggerLink"><a href="javascript:triggerSidebar();" class="Control TriggerControl" title="<fmt:message key="rootLayout_closeSidebarHint" bundle="${layout_Messages}"/>"><span><fmt:message key="rootLayout_closeSidebar" bundle="${layout_Messages}"/></span></a></div>
        <div class="SidebarPanelContent" id="SidebarPanelIn">
        </div>
      </div>
    </div>
  </div>
  <hr />
  <div id="SidebarContent">
    <syswf:form id="SidebarForm" enctype="multipart/form-data">
    <!-- Don't get fooled by above HTML, the actul sidebar inner content goes in here, not disrectly into the sidebar above -->
      <syswf:component prefix="sidebarftsearch" name="/search/fullTextSearchComponent">
         <syswf:param name="label" value="${enterSearchPhrase}:"/>
         <syswf:param name="pagerStep" value="2"/>
         <syswf:param name="maxPagesPerPager" value="2"/>
         <syswf:param name="collection" value="/*"/>
      </syswf:component>
    <hr/>
      <syswf:component prefix="collectionBrowser" name="/collections/collectionBrowser">
      </syswf:component>
    <hr/>
      <!-- <span>Recent Documents</span> -->
      <syswf:component prefix="recentlyUsedArtifacts" name="/browse/recentlyUsedArtifacts">
      </syswf:component>
    </syswf:form>
  </div>
  <hr />
  <hr />
  <div id="Menu">
    <div id="MenuGUI">
      <div id="Navigation">
        <div title="<fmt:message key="rootLayout_nagigationMenu" bundle="${layout_Messages}"/>">
          <a class="AreaAnchor" name="MenuArea"></a>
          <h2><fmt:message key="rootLayout_mainNavigationMenu" bundle="${layout_Messages}"/></h2>
          <c:out value="${panel.areas['navigation'].code}" escapeXml="false"/>
        </div>
      </div>
      <a href="#TOCArea" title="<c:out value="${jumpUpToTOC}"/>" class="TOCLink"><span><c:out value="${upToTOC}"/></span></a>
    </div>
  </div>
  <hr />
  <c:out value="${panel.areas['status'].code}" escapeXml="false"/>
  <hr />
  <c:out value="${panel.areas['notices'].code}" escapeXml="false"/>
  <hr />
  <div id="ToTop" title="<fmt:message key="rootLayout_toTopTitle" bundle="${layout_Messages}"/>">
    <div class="Link"><a href="#Top" title="<fmt:message key="rootLayout_jumpUpToTopTitle" bundle="${layout_Messages}"/>" class="TopLink"><span><c:out value="${upToTOC}"/></span></a></div>
  </div>
  <div id="ScriptHelper" title="<fmt:message key="rootLayout_emptyBlockTitle" bundle="${layout_Messages}"/>"></div>
  <script type="text/javascript">
//<![CDATA[

  initialization=function(){
    <c:out value="${initCode}" escapeXml="false"/>
  }
  //]]>
  </script>
  <noscript><p class="NoJavaScriptNotice"><fmt:message key="rootLayout_noJavaSriptNote" bundle="${layout_Messages}"/></p></noscript>
</body>
</html>
