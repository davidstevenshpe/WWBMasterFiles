<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="deploymentUrl" type="java.lang.String"--%>
<%--@elvariable id="flashFileNameWoSuffix" type="java.lang.String"--%>
<%--@elvariable id="artifactUuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>
<%--@elvariable id="revision" type="java.lang.Integer"--%>
<%--@elvariable id="processUuid" type="java.lang.String"--%>
<%--@elvariable id="processName" type="java.lang.String"--%>
<%--@elvariable id="editMode" type="java.lang.Boolean"--%>
<%--@elvariable id="interactive" type="java.lang.Boolean"--%>
<%--@elvariable id="showRule" type="java.lang.Boolean"--%>
<%--@elvariable id="visualizerState" type="com.hp.systinet.lifecycle.ui.common.visualization.VisualizerStateBean"--%>
<syswf:localizedFileName fileName="${deploymentUrl}/${productBuildId}/flash/AC_OETags.js" var="jsOETags"/>
<syswf:localizedFileName fileName="${deploymentUrl}/${productBuildId}/flash/playerProductInstall" var="playerInstallFileWoSuffix"/>
<syswf:localizedFileName fileName="${deploymentUrl}/${productBuildId}/lifecycle/${flashFileNameWoSuffix}" var="flashFileUrlWoSuffix"/>
<c:set var="flashFileUrlWithSuffix" value="${flashFileUrlWoSuffix}.swf"/>
<c:url var="flashVars" value="">
    <c:if test="${not empty artifactUuid}">
        <c:param name="uuid" value="${artifactUuid}"/>
    </c:if>
    <c:if test="${not empty revision}">
        <c:param name="revision" value="${revision}"/>    
    </c:if>
    <c:param name="processUuid" value="${processUuid}"/>
    <c:param name="editMode" value="${(not empty editMode and editMode) ? 'true' : ''}"/>
    <%-- whether the visualizer should be interactive (not interactive means not clickable, but scrollable) --%>
    <c:param name="interactive" value="${(empty interactive or interactive) ? 'true' : ''}"/>
    <%-- whether the horizontal rule (leading line) should be shown--%>
    <c:param name="showRule" value="${(empty showRule or showRule) ? 'true' : ''}"/>
    <c:param name="wsApiUrl" value="${deploymentUrl}/../remote/lifecycle/processVisualizationApi"/>
    <c:param name="historyRecordId" value="${visualizerState.historyRecordId}"/>
    <c:param name="stageValue" value="${visualizerState.stageValue}"/>
</c:url>
<c:set var="flashVars">
    <c:out value="${fn:replace(fn:substring(flashVars, 1, fn:length(flashVars)), '%2c', ',')}" escapeXml="false"/>
</c:set>

<div class="LifecycleGraph">
    <c:choose>
        <c:when test="${not empty processName}">
            <h4>
                <syswf:component prefix="process" name="/newUi/lc/common/renderer/processLinkRenderer" wrap="false">
                    <syswf:param name="processUuid" value="${processUuid}"/>
                    <syswf:param name="caption" value="${processName}"/>
                </syswf:component>
            </h4>
        </c:when>
        <c:otherwise><br/></c:otherwise> <%-- break to create spacing --%>
    </c:choose>
    <div id="flashcontent">
        <script src='<c:out value="${jsOETags}"/>' language="javascript"></script>
        <script language="JavaScript" type="text/javascript">
        //<![CDATA[
            <%-- ----------------------------------------------------------------------------- --%>
            <%-- Globals --%>
            <%-- Major version of Flash required --%>
            var requiredMajorVersion = 10;
            <%-- Minor version of Flash required --%>
            var requiredMinorVersion = 0;
            <%-- Minor version of Flash required --%>
            var requiredRevision = 0;
            <%-- ----------------------------------------------------------------------------- --%>

            <%-- Version check for the Flash Player that has the ability to start Player Product Install (6.0r65) --%>
            var hasProductInstall = DetectFlashVer(6, 0, 65);

            <%-- Version check based upon the values defined in globals --%>
            var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);

            if (hasProductInstall && !hasRequestedVersion) {
                <%-- DO NOT MODIFY THE FOLLOWING FOUR LINES --%>
                <%-- Location visited after installation is complete if installation is required --%>
                var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
                var MMredirectURL = window.location;
                document.title = document.title.slice(0, 47) + " - Flash Player Installation";
                var MMdoctitle = document.title;

                AC_FL_RunContent(
                        "src", "<c:out value="${playerInstallFileWoSuffix}"/>",
                        "FlashVars", "MMredirectURL=" + MMredirectURL + '&MMplayerType=' + MMPlayerType + '&MMdoctitle=' + MMdoctitle + "",
                        "width", "100%",
                        "height", "150",
                        "align", "middle",
                        "id", "${flashFileNameWoSuffix}",
                        "quality", "high",
                        "bgcolor", "#869ca7",
                        "name", "${flashFileNameWoSuffix}",
                        "allowScriptAccess", "sameDomain",
                        "type", "application/x-shockwave-flash",
                        "pluginspage", "http://www.adobe.com/go/getflashplayer"
                        );
            } else if (hasRequestedVersion) {
                <%-- if we've detected an acceptable version --%>
                <%-- embed the Flash Content SWF when all tests are passed --%>
                AC_FL_RunContent(
                        "src", "<c:out value="${flashFileUrlWoSuffix}"/>",
                        "width", "100%",
                        "height", "150",
                        "align", "middle",
                        "id", "${flashFileNameWoSuffix}",
                        "quality", "high",
                        "wmode", "transparent",
                        "FlashVars", "${flashVars}",
                        "name", "${flashFileNameWoSuffix}",
                        "allowScriptAccess", "sameDomain",
                        "type", "application/x-shockwave-flash",
                        "pluginspage", "http://www.adobe.com/go/getflashplayer"
                        );
            } else {  <%-- flash is too old or we can't detect the plugin --%>
                var alternateContent = 'Alternate HTML content should be placed here. '
                        + 'This content requires the Adobe Flash Player. '
                        + '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
                document.write(alternateContent);  <%-- insert non-flash content --%>
            }
        //]]>
        </script>
        <noscript>
            <%-- Declaration of Flash object. Attribute "id" is used in JavaScript to access externalized Flex methods. --%>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
                    id="${flashFileNameWoSuffix}" width="100%" height="150"
                    codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
                <param name="movie" value="<c:out value="${flashFileUrlWithSuffix}"/>"/>
                <param name="quality" value="high"/>
                <param name="bgcolor" value="#869ca7"/>
                <param name="allowScriptAccess" value="sameDomain"/>
                <param name="FlashVars" value="${flashVars}"/>
                <embed src="<c:out value="${flashFileUrlWithSuffix}"/>" quality="high" bgcolor="#869ca7"
                       width="100%" height="150" name="${flashFileNameWoSuffix}" align="middle"
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

        <%-- communication flash-html --%>
        <syswf:input id="errorMessage" name="errorMessage" value="" mode="hidden"/>
        <syswf:input id="errorDescription" name="errorDescription" value="" mode="hidden"/>
        <syswf:input id="errorStackTrace" name="errorStackTrace" value="" mode="hidden"/>
        <%-- we should probably use either taskCaption or previousTaskUri --%>
        <syswf:input id="taskCaption" name="taskCaption" value="" mode="hidden"/>
        <syswf:input id="previousTaskUri" name="previousTaskUri" value="" mode="hidden"/>
        <%--control to call error message action--%>
        <syswf:control mode="script" caption="errorMessageFunction" action="errorMessageAction"/>


        <script language="JavaScript" type="text/javascript">
        //<![CDATA[
            function showErrorMessage(errorMessage, errorDescription, errorStackTrace) {
                Ext.get('errorMessage').dom.value = errorMessage;
                Ext.get('errorDescription').dom.value = errorDescription;
                Ext.get('errorStackTrace').dom.value = errorStackTrace;
                errorMessageFunction();
            }

            function geProcessVisualizationFlexApp() {
                return getFlexApp('process-visualization');
            }

			<%-- Find Flex object by its name --%>
    		function getFlexApp(appName) {
        		return document[appName];
    		}

            <%-- This function sets size to the Flash object. Both objects (HTMLObject and HTMLEmbed) must be set! --%>
            <%-- @optional param String/Integer x : New width of the element --%>
            <%-- @optional param String/Integer y : New height of the element --%>
            <%-- # Note: Leaving either of the two parameters empty of undefined will cause the element to retain its current width/height. --%>
            function setFlexSize()
            {
                <%-- Check whether new values are defined --%>
                var x = (typeof(arguments[0]) != 'undefined') ? arguments[0] : false;
                var y = (typeof(arguments[1]) != 'undefined') ? arguments[1] : false;

                <%-- Check if Ext is present --%>
                if (typeof(Ext) != 'undefined')
                {

                    <%-- Retrieve mandatory HTML Objects --%>
                    var myFlex = Ext.get('${flashFileNameWoSuffix}');
                    var myEmbed = myFlex.child('EMBED');

                    <%-- When browser doesn't recognize EMBED --%>
                    if (myEmbed) {

                        <%-- Default to current size, if undefined --%>
                        if (!x) {
                            x = myEmbed.getWidth();
                        }
                        if (!y) {
                            y = myEmbed.getHeight();
                        }

                        <%-- Set new size --%>
                        myFlex.setSize(x, y);
                        myEmbed.setSize(x, y);

                    } else {

                        <%-- Default to current size, if undefined --%>
                        if (!x) {
                            x = myFlex.getWidth();
                        }
                        if (!y) {
                            y = myFlex.getHeight();
                        }

                        if (x == 'undefined') {
                            x = "100%";
                        }

                        <%-- Set new size --%>
                        myFlex.setSize(x, y);
                    }
                }
            }
        //]]>
        </script>
    </div>
</div>
