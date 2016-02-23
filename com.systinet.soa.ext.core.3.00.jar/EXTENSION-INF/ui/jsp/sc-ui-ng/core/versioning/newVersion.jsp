<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.versioning.versioning" var="versionMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uiScComponent"/>

<table class="UI Layout">
    <tr>
        <td class="UI Middle">
        
            <syswf:component name="/core/layout/header" prefix="header" wrap="false" />
            
            <syswf:block className="UI Block Common">

                <c:set var="labelClass">UI Label Inline</c:set>
                
                <table class="UI Table Properties">
                    <col class="LabelCol"/>
                    <col/>
                    <tr>
                        <th><label class="${labelClass}">
                            <fmt:message key="newVersion_artifact" bundle="${versionMessages}"/>
                        </label></th>
                        <td><span class="IconAlign">
                            <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="artifactLink" wrap="false">
                                <syswf:param name="uuid" value="${artifact._uuid}" />
                                <syswf:param name="caption" value="${artifact.name}" />
                            </syswf:component>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th><label class="${labelClass}">
                            <fmt:message key="newVersion_currentVersion" bundle="${versionMessages}"/>
                        </label></th>
                        <td>
                        	<span class="IconAlign">
                            <c:out value="${holder.currentVersion}"/>
                        	</span>
                        </td>
                    </tr>
                    <tr>
                        <th><label class="${labelClass}">
                            <fmt:message key="newVersion_newVersion" bundle="${versionMessages}"/>
                        </label></th>
                        <td>
                            <syswf:input name="newVersion" value="${holder}" property="newVersion" mode="text"/>
                            <script type='text/javascript'>
                            //<![CDATA[
                                Ext.onReady(function() {
                                    new Ext.form.TextField({
                                        applyTo: '${prefix}_newVersion',
                                        width: 50
                                    });                                                                                                                                                                     
                                }); 
                            
//]]>
</script>                           
                        </td>
                    </tr>
                </table>
                
                <c:set var="advancedOptions">
                    <ul class="Options">
                        <li>
                            <syswf:selectOne name="createBlank" value="${holder}" property="createBlank"
                                             mode="checkbox"
                                             optionCaptions=" " optionValues="true" dataType="boolean">
                            </syswf:selectOne>
                            <label for="${prefix}_createBlank_0">
                                <fmt:message key="newVersion_createBlank_caption" bundle="${versionMessages}"/>
                            </label>
                            <div class="Description">
                                <fmt:message key="newVersion_createBlank_description" bundle="${versionMessages}"/>
                            </div>
                        </li>
                        <c:if test="${showNotification}">
                            <li>
                                <syswf:selectOne name="notifyContractors" value="${holder}" property="notifyContractors"
                                                 mode="checkbox"
                                                 optionCaptions=" " optionValues="true" dataType="boolean">
                                </syswf:selectOne>
                                <label for="${prefix}_notifyContractors_0">
                                    <fmt:message key="newVersion_notifyContractors_caption" bundle="${versionMessages}"/>
                                </label>
                                <div class="Description">
                                    <fmt:message key="newVersion_notifyContractors_description" bundle="${versionMessages}"/>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                    <table class="UI Table Properties">
                        <col class="LabelCol"/>
                        <col/>
                        <tr>
                            <th><label class="${labelClass}">
                                <fmt:message key="newVersion_chooseGovernanceProcess" bundle="${versionMessages}"/>
                            </label></th>
                            <td>
                                <syswf:component name="/newUi/lc/common/widget/chooseGPCombo" prefix="chooseGovernanceProcess">
                                    <syswf:param name="artifactSdmName" value="${artifact._artifactSdmName}" />
                                    <syswf:param name="selectedProcessId" value="${holder}" property="selectedProcessId" />
                                </syswf:component>
                            </td>
                        </tr>
                    </table>
                </c:set>
                
                <c:if test="${not empty advancedOptions}">
                <c:set var="advancedOptionsStatus" value="${holder.advancedOptionsOpen ? 'Open' : 'Closed'}" />
                <div class="UI AdvancedOptions Labeled ${advancedOptionsStatus}">
                    <div class="OptionsOpener">
                        <fmt:message var="advancedOptions_title" key="newVersion_advancedOptions_title" bundle="${versionMessages}" />
                        <syswf:control mode="ajax" action="dialogToggle" caption="openClose" />
                        <a onclick="openClose(); AdvancedOptions.Switch(this);" href="javascript:void(0);">            
                            <span>${advancedOptions_title}</span>
                        </a>
                    </div>
                    <div class="Content">
                        <c:out value="${advancedOptions}" escapeXml="false" />
                    </div>
                </div>
                </c:if>

            </syswf:block>

            <syswf:block className="UI Block Green">
                <div class="Content">
                    <div class="UI Form Controls">
                        <fmt:message key="Save" var="saveButton" bundle="${uiScComponent}"/>
                        <fmt:message key="newVersion_saveButtonHint" var="saveButtonHint" bundle="${versionMessages}"/>
                        <syswf:control mode="button" caption="${saveButton}" hint="${saveButtonHint}" action="create">
                            <syswf:attribute name="class" value="btn btn-primary"/>
                        </syswf:control>
                        <fmt:message key="Cancel" var="cancelButton" bundle="${uiScComponent}"/>
                        <fmt:message key="Cancel" var="cancelButtonHint" bundle="${uiScComponent}"/>
                        <syswf:control mode="button" action="rollback" caption="${cancelButton}" hint="${cancelButtonHint}"
                                       targetDepth="${sessionStack.currentDepth-1}">
                            <syswf:attribute name="class" value="btn btn-gray"/>
                        </syswf:control>
                    </div>
                </div>
            </syswf:block>
        </td>
    </tr>
</table>
