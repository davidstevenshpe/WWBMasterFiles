<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
    beforeContent - any content, which should be inside advanced options in the beginning (but still in table of options). 
    hideOverwriteLocalChanges - if true, hides options to overwrite local changes
    hideProcessArchive - if true, hides options to process archive
 -->

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="advancedOptionsSectionLabel" key="advancedOptionsSectionLabel" bundle="${importsMessages}"/>
<fmt:message var="advancedOptionsToggleMessage" key="advancedOptionsToggleMessage" bundle="${importsMessages}"/>
<fmt:message var="keepLocalChangesLabel" key="keepLocalChangesLabel" bundle="${importsMessages}"/>
<fmt:message var="keepLocalChanges_keep" key="keepLocalChanges.keep" bundle="${importsMessages}"/>
<fmt:message var="keepLocalChanges_overwrite" key="keepLocalChanges.overwrite" bundle="${importsMessages}"/>
<fmt:message var="requiredAuthenticationLabel" key="requiredAuthenticationLabel" bundle="${importsMessages}"/>
<fmt:message var="authUserNameLabel" key="authUserNameLabel" bundle="${importsMessages}"/>
<fmt:message var="authPasswordLabel" key="authPasswordLabel" bundle="${importsMessages}"/>
<fmt:message var="authUsernameHint" key="authUsernameHint" bundle="${importsMessages}"/>
<fmt:message var="authPasswordHint" key="authPasswordHint" bundle="${importsMessages}"/>
<fmt:message var="synchronizationLabel" key="synchronizationLabel" bundle="${importsMessages}"/>
<fmt:message var="processArchiveContentLabel" key="processArchiveContentLabel" bundle="${importsMessages}"/>
<fmt:message var="syncPolicy_automatic" key="syncPolicy.automatic" bundle="${importsMessages}"/>
<fmt:message var="syncPolicy_manual" key="syncPolicy.manual" bundle="${importsMessages}"/>
<fmt:message var="syncPolicy_disabled" key="syncPolicy.disabled" bundle="${importsMessages}"/>
<fmt:message var="remember_credential" key="credential.remember" bundle="${importsMessages}"/>


<div class="UI AdvancedOptions Labeled ${advancedOptionsStatus}">
    <div class="OptionsOpener">
        <syswf:control mode="ajax" action="advancedOptionsToggle" caption="${prefix}openClose" /> 
        <a id="${prefix}advancedOptionsToggle" href="javascript:void(0);" onclick="${prefix}openClose(); AdvancedOptions.Switch(this);" title="${advancedOptionsToggleMessage}">
            <span>${advancedOptionsSectionLabel}</span>
        </a>
        <%--
        <c:if test="${not empty publishingSettingsId}" >
            <script type="text/javascript">
//<![CDATA[

            	Ext.onReady(function() {
                    Ext.get('${prefix}advancedOptionsToggle').on('click', function() {
                        var tabbodys = Ext.get('${publishingSettingsId}').select('.x-tab-panel-body .x-panel-body');
                        tabbodys.each(function(tabbody) {
                            tabbody.setStyle('height', '100%');
                        });
                        AdvancedOptions.Switch(this.dom);
                    });
                });
            
//]]>
</script>
        </c:if>
        --%>
    </div>            
    <div class="Content" id="${prefix}myContent">        
        <table class="UI Table Properties">
            <colgroup>
                <col class="MidLabelCol" />
                <col />
            </colgroup>
            <tbody>
                <c:if test="${not empty beforeContent}" >
                    ${beforeContent}
                </c:if>
                <c:if test="${importType eq 'remote'}">                    
                    <tr>
                        <th>
                            <label for="${prefix}publishSettings_AuthRequired_0" class="UI Label Inline">${requiredAuthenticationLabel}</label>    
                        </th>
                        <td>
                            <syswf:selectOne id="${prefix}publishSettings_AuthRequired" name="${prefix}publishSettings_AuthRequired" value="${importFileBean}" property="authRequired" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" hint="">                    
                                <syswf:attribute name="class" value="UI Form Checkbox"/>
                            </syswf:selectOne>
                        </td>
                    </tr>                
                    <tr>
                        <th>
                        </th>
                        <td>                        
                            <div id="${prefix}publishSettings_AuthRequired_Data" class="Form Collection Authentication <c:if test='${not importFileBean.authRequired}'>x-hidden</c:if>">
                                <table class="UI Table Properties">
                                    <colgroup>
                                        <col class="LabelCol" />
                                        <col />
                                    </colgroup>
                                    <tbody>    
                                        <tr>
                                            <th>
                                                <label for="${prefix}publishSettings_AuthRequired_LoginName" class="UI Label Inline">${authUserNameLabel}</label>
                                            </th>
                                            <td>
                                                <syswf:input id="${prefix}publishSettings_AuthRequired_LoginName" name="${prefix}publishSettings_AuthRequired_LoginName" value="${importFileBean}" property="authName" mode="text" hint="${authUsernameHint}">
                                                    <syswf:attribute name="class" value="UI Form Text Full"/>
                                                    <syswf:attribute name="autocomplete" value="off"/>
                                                </syswf:input>
                                            </td>
                                        </tr>    
                                        <tr>
                                            <th>
                                                <label for="${prefix}publishSettings_AuthRequired_Password" class="UI Label Inline">${authPasswordLabel}</label>
                                            </th>
                                            <td>
                                                <syswf:input id="${prefix}publishSettings_AuthRequired_Password" name="${prefix}publishSettings_AuthRequired_Password" value="${importFileBean}" property="authPassword" mode="password" hint="${authPasswordHint}">
                                                    <syswf:attribute name="class" value="UI Form Text Full"/>
                                                    <syswf:attribute name="autocomplete" value="off"/>
                                                </syswf:input>
                                            </td>
                                        </tr>
                                        <c:if test="${enableCrdStore}">
	                                        <tr>
	                                            <th>
	                                            </th>
	                                            <td>
	                                                <syswf:selectOne id="${prefix}publishSettings_AuthRequired_Remember" name="${prefix}publishSettings_AuthRequired_Remember" value="${importFileBean}" property="rememberPassword" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" hint="">                    
						                                <syswf:attribute name="class" value="UI Form Checkbox"/>
						                            </syswf:selectOne> ${remember_credential}
	                                            </td>
	                                        </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <script type="text/javascript">
//<![CDATA[

                                Ext.onReady(function(){
                                    var sourceElm = Ext.get('${prefix}publishSettings_AuthRequired_0');
                                    var targetElm = Ext.get('${prefix}publishSettings_AuthRequired_Data');         
                                    sourceElm.on('click',function(){                                 
                                        if(sourceElm.dom.checked)
                                        {
                                            targetElm.removeClass('x-hidden');
                                        } else {
                                            targetElm.addClass('x-hidden');
                                        }
                                    });
                                });
                            
//]]>
</script>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <label class="UI Label Inline">${synchronizationLabel}</label>
                        </th>
                        <td>
                            <syswf:selectOne name="synchronizationPolicy" value="${importFileBean}" property="synchronizationPolicy" mode="radio" optionValues="${syncPolicyValues}" dataType="enum" optionCaptions="${syncPolicy_automatic},${syncPolicy_manual},${syncPolicy_disabled}" optionClasses="UI Label Inline,UI Label Inline,UI Label Inline" displayAsRow="true">                        
                                <syswf:attribute name="class" value="UI Form Radio Inline"/>
                            </syswf:selectOne>
                        </td>
                    </tr>                
                </c:if>
                <c:if test="${not hideOverwriteLocalChanges}">
                    <tr>
                        <th>
                            <label for="${prefix}publishSettings_overwriteLocalChanges" class="UI Label Inline">${keepLocalChangesLabel}</label>    
                        </th>
                        <td>
                            <syswf:selectOne id="${prefix}publishSettings_overwriteLocalChanges" name="${prefix}publishSettings_overwriteLocalChanges" optionClasses="UI Label Inline,UI Label Inline" value="${importFileBean}" property="keepLocalChanges" mode="radio" optionValues="true,false" dataType="boolean" optionCaptions="${keepLocalChanges_keep},${keepLocalChanges_overwrite}" displayAsRow="true"/>                       
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not hideProcessArchive}">
                    <tr>
                        <th>
                            <label class="UI Label Inline" for="publishingSettings_processArchiveContent_0">${processArchiveContentLabel}</label>
                        </th>
                        <td>
                            <syswf:selectOne id="publishingSettings_processArchiveContent" name="publishingSettings_processArchiveContent" value="${importFileBean}" property="processArchive" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" hint="" >
                                <syswf:attribute name="class" value="UI Form Checkbox"/>
                            </syswf:selectOne>
                            <script type="text/javascript">
//<![CDATA[

                                Ext.onReady(function() {
                                    Ext.get('publishingSettings_processArchiveContent_0').on('click', function() {
                                        // how to retrieve the actual value? Ext.get('publishingSettings_processArchiveContent_0').dom.value gives always true
                                        ${locationOptionsPrefix}forceLocationUpdate({ processArchive : 'invert' });
                                    });
                                });
                            
//]]>
</script>
                        </td>
                    </tr>
                </c:if>
                
                <syswf:component name="/core/impl/imports/options" prefix="options" wrap="false">
                    <syswf:param name="publishingOptions" value="${importFileBean.publishingOptions}"/>
                </syswf:component>
            </tbody>
        </table>
    </div>
</div>
