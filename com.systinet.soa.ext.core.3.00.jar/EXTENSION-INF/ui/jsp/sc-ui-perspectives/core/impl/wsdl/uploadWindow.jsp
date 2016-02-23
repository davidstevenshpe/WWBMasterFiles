<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages2"/>
<fmt:message var="requiredAuthenticationLabel" key="requiredAuthenticationLabel" bundle="${importsMessages2}"/>
<fmt:message var="authUserNameLabel" key="authUserNameLabel" bundle="${importsMessages2}"/>
<fmt:message var="authPasswordLabel" key="authPasswordLabel" bundle="${importsMessages2}"/>
<fmt:message var="authUsernameHint" key="authUsernameHint" bundle="${importsMessages2}"/>
<fmt:message var="authPasswordHint" key="authPasswordHint" bundle="${importsMessages2}"/>
<fmt:message var="remember_credential" key="credential.remember" bundle="${importsMessages2}"/>
<fmt:message var="synchronizationLabel" key="synchronizationLabel" bundle="${importsMessages2}"/>
<fmt:message var="syncPolicy_automatic" key="syncPolicy.automatic" bundle="${importsMessages2}"/>
<fmt:message var="syncPolicy_manual" key="syncPolicy.manual" bundle="${importsMessages2}"/>
<fmt:message var="syncPolicy_disabled" key="syncPolicy.disabled" bundle="${importsMessages2}"/>

<syswf:control mode="ajax" id="${prefix}Change" caption="${prefix}Change"/>

<table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol" />
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th><label class="UI Label"><fmt:message bundle="${importsMessages}" key="wsdlSource" /></label></th>
            <td>
                <fmt:message bundle="${importsMessages}" key="importFile.localTab" var="loc1" />
                <fmt:message bundle="${importsMessages}" key="importFile.remoteTab" var="loc2" />
                <fmt:message bundle="${importsMessages}" key="importFile.repositoryTab" var="loc3" />
                <c:set var="selectCaption" value=" ${loc1}, ${loc2}, ${loc3}" />
                <syswf:selectOne mode="radio" value="${importFileBean}" id="importType" property="importType" optionValues="${locationValues}" name="importType" dataType="enum" optionCaptions="${selectCaption}" displayAsRow="true">
                    <syswf:attribute name="onClick">
                        ${prefix}Change();
                    </syswf:attribute>
                </syswf:selectOne>
            </td>
        </tr>
        </tbody>
    </table>
<c:choose>
    <c:when test="${importFileBean.importType == 'LOCAL'}">
        <div id="${prefix}fileHolder">
            <syswf:component name="/core/impl/imports/file/locationOptions" prefix="localOptions">
                <syswf:param name="importFileBean" value="${importFileBean}"/>
                <syswf:param name="importType" value="local"/>
            </syswf:component>
        </div>
    </c:when>
    <c:when test="${importFileBean.importType == 'REMOTE'}">
        <div id="${prefix}urlHolder">
        <syswf:component name="/core/impl/imports/file/locationOptions" prefix="remoteOptions">
            <syswf:param name="importFileBean" value="${importFileBean}"/>
            <syswf:param name="importType" value="remote"/>
        </syswf:component>
        <table class="UI Table Properties">
                <colgroup>
                    <col class="MidLabelCol" />
                    <col />
                </colgroup>
                <tbody>
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
                                <syswf:selectOne name="synchronizationPolicy" value="${importFileBean}" property="synchronizationPolicy" mode="radio" optionValues="${syncPolicyValues}" dataType="enum" optionCaptions="${syncPolicy_automatic},${syncPolicy_manual},${syncPolicy_disabled}" displayAsRow="true">                        
                                    <syswf:attribute name="class" value="UI Form Radio Inline"/>
                                </syswf:selectOne>
                            </td>
                        </tr>
                    </tbody>
            </table>
        </div>
    </c:when>
    <c:otherwise>
        <div id="${prefix}repoHolder">
            <syswf:input id="${prefix}_repoLocation" name="repoLocation" mode="hidden" value="${importFileBean}" property="repositoryLocation"/>
            <syswf:component name="/core/impl/util/artifactSelectorWindow" prefix="artifactWsdlSelector">
                <syswf:param name="selectFunctionName" value="repoSearch_selectFunction"/>
                <syswf:param name="jsSelectFunction" value="${jsSelectFunction}"/>
                <syswf:param name="artifactType" value="wsdlArtifact"/>
                <syswf:param name="showDataBeforeSearch" value="false"/>
                <syswf:param name="selectorCustomizationId" value="shared.artifactSelector.wsdlArtifact"/>

                <syswf:param name="refreshAfterExecution" value="${true}"/>
                <syswf:param name="refreshAfterExecution_changedAreaId" value="${prefix}_artifactWsdlSelector"/>
                <syswf:param name="hideClearButton" value="${true}"/>
            </syswf:component>
    <!-- Select WSDL artifact end -->
        </div>
    </c:otherwise>
</c:choose>

<script type="text/javascript">
//<![CDATA[

    function repoSearch_selectFunction(location, uuid) {
       Ext.get('${prefix}_repoLocation').dom.value = location;
       // alert('selected: '+location);
    }
    
    
//]]>
</script>