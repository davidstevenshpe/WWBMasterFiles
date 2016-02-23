<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.security.securitymessages" var="securitymessages"/>
<fmt:message var="share_actionShareLink" key="share.actionShareLink" bundle="${securitymessages}"/>
<fmt:message var="share_actionUnshareLink" key="share.actionUnshareLink" bundle="${securitymessages}"/>
<fmt:message var="share_shareWarning" key="share.shareWarning" bundle="${securitymessages}"/>
<fmt:message var="share_unshareWarning" key="share.unshareWarning" bundle="${securitymessages}"/>
 
<c:if test="${isActionPermitted}">

    <c:choose>
        <c:when test="${shared}">
            <c:set var="actionCaption" value="${share_actionUnshareLink}"/>
            <c:set var="warning" value="${share_unshareWarning}"/>
            <c:set var="linkClass" value="Unshare"/>
        </c:when>
        <c:otherwise>
            <c:set var="actionCaption" value="${share_actionShareLink}"/>
            <c:set var="warning" value="${share_shareWarning}"/>
            <c:set var="linkClass" value="Share"/>
        </c:otherwise>
    </c:choose>
<div class="EA-right-panel">    
    <a href="javascript:void(0);" class="UI PageAction ${linkClass}" id="${prefix}share">${actionCaption}</a>
</div>        
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
                Ext.get('${prefix}share').on('click', ${prefix}openConfirmationDialog);
        });
    
//]]>
</script>
    
    <syswf:component name="/core/window" prefix="switchShare">
        <syswf:param name="winTitle">${actionCaption}</syswf:param>
        <syswf:param name="winOpenFunctionName" value="${prefix}openConfirmationDialog"/>
        <syswf:param name="winOkLabel" value="${actionCaption}"/>
        <syswf:param name="winOkAction" value="${prefix}switchShare"/>
        <syswf:param name="winWidth" value="300"/>
        <syswf:param name="winButtonAlign" value="center"/>
        <syswf:param name="winRenderContents" value="true"/>
        <syswf:param name="winContents">
            <p class="Warning">${warning}</p>
            <div class="UI AdvancedOptions Labeled Closed">
                <div class="OptionsOpener">
                    <a href="javascript:void(0);" id="${prefix}opener"><span><fmt:message bundle="${messages}" key="general.advancedOptions" /></span></a>
                </div>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function(){
                        attachOn('${prefix}opener','click',function() {
                            AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
                        });
                    });
                
//]]>
</script>
                <div class="Content">
                    <syswf:selectOne id="${prefix}includeSubArtifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${optionsHolder}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true"/>
                    <label class="UI Label Inline" for="${prefix}includeSubArtifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
                </div>
            </div>
        </syswf:param>
    </syswf:component>

    <syswf:control mode="script" caption="${prefix}switchShare" action="switchSharingBulk"/>

</c:if>