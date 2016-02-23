<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.security.securitymessages" var="securitymessages"/>

<fmt:message var="share_shareWarning" key="share.shareWarning" bundle="${securitymessages}"/>
<fmt:message var="share_unshareWarning" key="share.unshareWarning" bundle="${securitymessages}"/>
<fmt:message var="share_actionShareLink" key="share.actionShareLink" bundle="${securitymessages}"/>
<fmt:message var="share_actionUnshareLink" key="share.actionUnshareLink" bundle="${securitymessages}"/>


<c:choose>
    <c:when test="${shared}">
        <c:set var="actionCaption" value="${share_actionUnshareLink}"/>
        <c:set var="warning" value="${share_unshareWarning}"/>
    </c:when>
    <c:otherwise>
        <c:set var="actionCaption" value="${share_actionShareLink}"/>
        <c:set var="warning" value="${share_shareWarning}"/>
    </c:otherwise>
</c:choose>

<div class="webfw-Window" id="${prefix}-webfw-Window">
    <div id="${prefix}window" class="x-hidden">
        <div class="x-window-header">${actionCaption}</div>
        <div class="x-window-body">
            <div class="UI Offset">
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
            </div>    
        </div>
    </div>
</div>

<syswf:control mode="script" caption="${prefix}switchShare" action="switchSharingBulk"/>

<script type="text/javascript">
//<![CDATA[

    var ${prefix}buttons = [
        {text: '${actionCaption}', handler: function(){ ${prefix}switchShare(); SPopup.Window.Instance['${prefix}window'].hide();}},
        {text: '<fmt:message bundle="${labels}" key="Cancel" />', handler: function(){ SPopup.Window.Instance['${prefix}window'].hide(); return false;}}
    ];
    var ${controlName} = function() {
        SPopup.Window.forceOpen('${prefix}window','${prefix}window',{
            autoHeight: true, plain: true, buttons: ${prefix}buttons, width: 300, resizable: false, centerOnScreen:true, buttonAlign: 'center'
        });
    };

//]]>
</script> 