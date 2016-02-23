<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:localizedFileName fileName="${deploymentUrl}/${productBuildId}/flash/AC_OETags.js" var="jsOETags"/>
<syswf:localizedFileName fileName="${deploymentUrl}/${productBuildId}/flash/playerProductInstall" var="playerInstallFileWoExtension"/>
<syswf:localizedFileName fileName="${deploymentUrl}/${productBuildId}/navigator/main" var="navigatorFlashFileWoExtension"/>
<c:set var="navigatorFlashFile" value="${navigatorFlashFileWoExtension}.swf"/>
<c:set var="graphOptions"><c:choose><%--
	--%><c:when test="${uiPerspective=='partner'}"><c:out value="artifacts:ui-perspective:partner,"/></c:when><%--
	--%><c:when test="${uiPerspective=='analyst'}"><c:out value="artifacts:ui-perspective:analyst,"/></c:when><%--
	--%></c:choose>artifacts:contract-handling:on</c:set>
<c:url var="flashVars" value="">
    <c:param name="uuid" value="${navigatorUuid}" />
    <c:param name="validDomain" value="${validDomain}" />
    <c:param name="navigatorWsApiUrl" value="${deploymentUrl}/../remote/navigator/navigatorWSApi" />
    <c:param name="highlight" value="${highlight}" />
    <c:param name="bookmarkId" value="${bookmarkId}" />
    <c:param name="options" value="${graphOptions}"></c:param>
	<c:param name="navigatorLayoutId" value="${navigatorLayoutId}"></c:param>
	<c:param name="navigatorModeId" value="${navigatorModeId}"></c:param>
	<c:param name="historyMax" value="${historyMax}"></c:param>
</c:url>
<c:set var="flashVars">
    <c:out value="${fn:replace(fn:substring(flashVars, 1, fn:length(flashVars)), '%2c', ',')}" escapeXml="false"/>
</c:set>
<%-- !!! html variables parts (contentType, title, icons) copied from designV3Layout.jsp !!! --%>
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>
<fmt:message key="rebranding.productName" var="varSystinet2" bundle="${rebranding_Messages}"/>

<html>
	<head>
		<c:choose>
			<c:when test="${fn:contains(header['User-Agent'],'MSIE')}">
				<c:set var="httpEquiv" value="X-UA-Compatible"/>
				<c:set var="contentType" value="IE=edge"/>
				<c:set var="wmode" value="opaque"/>
			</c:when>
			<c:otherwise>
				<c:set var="httpEquiv" value="Content-Type"/>
			</c:otherwise>
		</c:choose>
		<meta http-equiv="<c:out value="${httpEquiv}"/>" content="<c:out value="${contentType}"/>" />
	<title>
	    <c:choose>
	        <c:when test="${not empty browserPageTitle}">
	            <c:out value="${browserPageTitle} - ${varSystinet2}"/>
	        </c:when>
	        <c:when test="${not empty taskCaption}">
	            <c:out value="${taskCaption} - ${varSystinet2}"/>
	        </c:when>
	        <c:otherwise>
	            <c:out value="${varSystinet2}"/>
	        </c:otherwise>
	    </c:choose>
	</title>
	<link rel="icon" href="<c:out value='${webResourcePath}'/>/skin/img/default/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="<c:out value='${webResourcePath}'/>/skin/img/default/favicon.ico" type="image/x-icon" />
	<style type="text/css">
	
		html {
			height: 100%;
			width:100%;
			margin: 0;
			padding: 0;
			overflow: hidden;
		}
	
		#flashcontent {
			height: 100%;
			width:100%;
			margin: 0;
			padding: 0;
	
		}
	
		body {
			height: 100%;
			width:100%;
			margin: 0;
			padding: 0;
			background-color: white;
		}
	
	    form#ContentForm { margin: 0; padding: 0 }
	
	</style>
	</head>
<body>
<div id="flashcontent">
<script src='<c:out value="${jsOETags}"/>' language="javascript"></script>
<syswf:localizedFileName fileName="${webContext}/${productBuildId}/js/ajax.js" var="ajax"/>
<script src="<c:out value="${ajax}"/>" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
//<![CDATA[
<!--
function viewArtifactInCatalog(uuid, revision) {
    window.top.location = '<c:out value="${baseUrl}"/>/artifact/' + uuid + '?revision=' + revision;
}
function goToCatalog() {
    window.top.location = '<c:out value="${baseUrl}"/>';
}
function setFlashFocus() {
    var flex = getFlexApp('flash-navigator');
    flex.focus();
}
function isMSIE() {
	return (navigator.appVersion.indexOf("MSIE") != -1);
}
function openScreenshot(screenshotGetUrl) {
	var imgUrl = '<c:out value="${deploymentUrl}"/>/../remote' + screenshotGetUrl;
	if (isMSIE()) {
		window.open(imgUrl);
	} else {
		window.location = imgUrl + "&download=1";
	}
}

function getFlexApp(appName) {
    if (navigator.appName.indexOf ('Microsoft') !=-1)
    {
        return window[appName];
    } else {
        return document[appName];
    }
}

// -----------------------------------------------------------------------------
// Globals
// Major version of Flash required
var requiredMajorVersion = 9; // ToDo: change major version to 10
// Minor version of Flash required
var requiredMinorVersion = 0;
// Minor version of Flash required
var requiredRevision = 28;
// -----------------------------------------------------------------------------

// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
var hasProductInstall = DetectFlashVer(6, 0, 65);

// Version check based upon the values defined in globals
var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);

if ( hasProductInstall && !hasRequestedVersion ) {
    // DO NOT MODIFY THE FOLLOWING FOUR LINES
    // Location visited after installation is complete if installation is required
    var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
    var MMredirectURL = window.location;
    document.title = document.title.slice(0, 47) + " - Flash Player Installation";
    var MMdoctitle = document.title;

    AC_FL_RunContent(
        "src", "<c:out value="${playerInstallFileWoExtension}"/>",
        "FlashVars", "MMredirectURL="+MMredirectURL+'&MMplayerType='+MMPlayerType+'&MMdoctitle='+MMdoctitle+"",
        "width", "100%",
        "height", "100%",
        "align", "middle",
        "id", "flash-navigator", // real file name, without swf extension
        "quality", "high",
        "bgcolor", "#ffffff",
        "name", "flash-navigator",
        "allowScriptAccess","sameDomain",
        "allowFullScreen","true",
        "type", "application/x-shockwave-flash",
        "pluginspage", "http://www.adobe.com/go/getflashplayer",
        "wmode","<c:out value="${wmode}"/>"
    ); 
} else if (hasRequestedVersion) {
    // if we've detected an acceptable version
    // embed the Flash Content SWF when all tests are passed
    AC_FL_RunContent(
            "src", "<c:out value="${navigatorFlashFileWoExtension}"/>",
            "width", "100%",
            "height", "100%",
            "align", "middle",
            "id", "flash-navigator", // real file name, without swf extension
            "quality", "high",
            "bgcolor", "#ffffff",
            "name", "flash-navigator",
            "allowScriptAccess","sameDomain",
            "allowFullScreen","true",
            "type", "application/x-shockwave-flash",
            "pluginspage", "http://www.adobe.com/go/getflashplayer",
            "FlashVars","${flashVars}",
            "wmode","<c:out value="${wmode}"/>"
    );
  } else {  // flash is too old or we can't detect the plugin
    var alternateContent = 'Alternate HTML content should be placed here. '
      + 'This content requires the Adobe Flash Player. '
       + '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
    document.write(alternateContent);  // insert non-flash content
  }
//]]>
// -->
</script>
<noscript>
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" allowFullScreen="true"
            id="flash-navigator" width="100%" height="100%"
            codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
            <param name="movie" value="<c:out value="${navigatorFlashFile}"/>" />
            <param name="quality" value="high" />
            <param name="bgcolor" value="#ffffff" />
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="allowFullScreen" value="true" />
            <param name="FlashVars" value="${flashVars}" />
            <param name="wmode" value="${wmode}" />
            <embed src="<c:out value="${navigatorFlashFile}"/>" quality="high" bgcolor="#ffffff"
                width="100%" height="100%" name="main" align="middle" allowFullScreen="true"
                play="true"
                loop="false"
                quality="high"
                allowScriptAccess="sameDomain"
                type="application/x-shockwave-flash"
                pluginspage="http://www.adobe.com/go/getflashplayer"
                FlashVars="${flashVars}">
            </embed>
    </object>
</noscript>
<script language="JavaScript">
    //<![CDATA[
    window.onbeforeunload = clean_up;

    function clean_up()
    {
        var flex = getFlexApp('flash-navigator');
        flex.saveLastState();

    }
    
    /** called from inside Flex to update the recently updated central artifact */
    function onChangeCentralArtifact(uuid) {
    	top.changedCentralArtifactUuid = uuid;
    }
    
    //]]>
</script>
</div></body></html>
