<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="requiredAuthenticationLabel" key="requiredAuthenticationLabel" bundle="${importsMessages}"/>
<fmt:message var="authUserNameLabel" key="authUserNameLabel" bundle="${importsMessages}"/>
<fmt:message var="authPasswordLabel" key="authPasswordLabel" bundle="${importsMessages}"/>
<fmt:message var="authUsernameHint" key="authUsernameHint" bundle="${importsMessages}"/>
<fmt:message var="authPasswordHint" key="authPasswordHint" bundle="${importsMessages}"/>
<fmt:message var="remember_credential" key="credential.remember" bundle="${importsMessages}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title">
        <fmt:message bundle="${exportmessages}" key="import.header" />
    </syswf:param>
</syswf:component>

<syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
    <syswf:param name="message"><fmt:message bundle="${exportmessages}" key="import.desc" /></syswf:param>
</syswf:component><br/>

<syswf:block className="UI Block Common">
    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol" />
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.importFrom" /></label></th>
            <td>
                <fmt:message bundle="${exportmessages}" key="import.location.1" var="loc1" />
                <fmt:message bundle="${exportmessages}" key="import.location.2" var="loc2" />
                <c:set var="selectCaption" value=" ${loc1}, ${loc2}" />
                <syswf:selectOne mode="radio" value="${bean}" id="location" property="location" optionValues="${values.locationValues}" name="location" dataType="enum" optionCaptions="${selectCaption}" displayAsRow="true" />
            </td>
        </tr>
        </tbody>
    </table>
    <table class="UI Table Properties" id="fileHolder">
        <colgroup>
            <col class="MidLabelCol" />
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.file" /></label></th>
            <td>
                <syswf:input mode="text" name="file" value="${bean}" property="file" />
            </td>
        </tr>
        </tbody>
    </table>
    <table class="UI Table Properties" id="urlHolder">
        <colgroup>
            <col class="MidLabelCol" />
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.url" /></label></th>
            <td>
                <syswf:input name="url" value="${bean}" property="url" />
            </td>
        </tr>
        </tbody>
    </table>
    <script type="text/javascript">
//<![CDATA[


    function onFileClick() {
    	if (Ext.get('location_0').dom.checked) {
            Ext.get('fileHolder').show();
            Ext.get('urlHolder').hide();
            Ext.get('${prefix}auth').hide();
        }
    }

    function onUrlClick() {
    	if (Ext.get('location_1').dom.checked) {
            Ext.get('fileHolder').hide();
            Ext.get('urlHolder').show();
            Ext.get('${prefix}auth').show();
        }
    }
    
    Ext.onReady(function() {

    	new Ext.HP.Input({
            applyTo : '${prefix}_url',
            width: 600
        });
        new Ext.ux.form.FileUploadField({
            id : '${prefix}_file',
            applyTo : '${prefix}_file',
            width: 600
        }); 
        
        	Ext.get('fileHolder').enableDisplayMode();
        	Ext.get('urlHolder').enableDisplayMode();
            Ext.get('${prefix}auth').enableDisplayMode();
            
            attachOn('location_0','click',onFileClick);
            attachOn('location_1','click',onUrlClick);

            if (Ext.get('location_1').dom.checked) {
            	onUrlClick();
            }
            if (Ext.get('location_0').dom.checked) {
            	onFileClick();
            }
        });
    
//]]>
</script>
    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol" />
            <col />
        </colgroup>
        <tbody>
        <tr>
            <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.existingData" /></label></th>
            <td>
                <fmt:message bundle="${exportmessages}" key="import.existingData.1" var="op2" />
                <fmt:message bundle="${exportmessages}" key="import.existingData.2" var="op1" />
                <c:set var="selectCaption" value=" ${op1}, ${op2}" />
                <syswf:selectOne mode="radio" value="${bean}" id="conflict" property="conflict" optionValues="${values.conflictValues}" name="conflict" dataType="enum" optionCaptions="${selectCaption}" />
            </td>
        </tr>
        </tbody>
    </table>

<syswf:wrap template="/templates/advancedOptions.jsp">
    <syswf:param name="advancedOptionsOpenerHolder" value="${bean}" />
            <table class="UI Table Properties" id="${prefix}auth">
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
                            <syswf:selectOne id="${prefix}publishSettings_AuthRequired" name="${prefix}publishSettings_AuthRequired" value="${bean}" property="authRequired" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" hint="">                    
                                <syswf:attribute name="class" value="UI Form Checkbox"/>
                            </syswf:selectOne>
                        </td>
                    </tr>                
                    <tr>
                        <th>
                        </th>
                        <td>                        
                            <div id="${prefix}publishSettings_AuthRequired_Data" class="Form Collection Authentication <c:if test='${not bean.authRequired}'>x-hidden</c:if>">
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
                                                <syswf:input id="${prefix}publishSettings_AuthRequired_LoginName" name="${prefix}publishSettings_AuthRequired_LoginName" value="${bean}" property="authName" mode="text" hint="${authUsernameHint}">
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
                                                <syswf:input id="${prefix}publishSettings_AuthRequired_Password" name="${prefix}publishSettings_AuthRequired_Password" value="${bean}" property="authPassword" mode="password" hint="${authPasswordHint}">
                                                    <syswf:attribute name="class" value="UI Form Text Full"/>
                                                    <syswf:attribute name="autocomplete" value="off"/>
                                                </syswf:input>
                                            </td>
                                        </tr>
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
            </table>
            <table class="UI Table Properties">
                <colgroup>
                    <col class="MidLabelCol" />
                    <col />
                </colgroup>
                <tbody>
                <tr>
                    <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.relConflict" /></label></th>
                    <td>
                        <fmt:message bundle="${exportmessages}" key="import.relConflict.1" var="op1" />
                        <fmt:message bundle="${exportmessages}" key="import.relConflict.2" var="op2" />
                        <c:set var="selectCaption" value=" ${op1}, ${op2}" />
                        <syswf:selectOne mode="radio" value="${bean}" id="conflictRelations" property="conflictRelations" optionValues="${values.relationConflictValues}" name="conflictRelations" dataType="enum" optionCaptions="${selectCaption}" displayAsRow="true" />
                    </td>
                </tr>
                <c:if test="${isAdmin}">
                <tr>
                    <th><label class="UI Label Long" for="${prefix}importAcl_0"><fmt:message bundle="${exportmessages}" key="import.ACL" /></label></th>
                    <td>
                        <syswf:selectOne id="${prefix}importAcl" name="importAcl" selectClass="UI Form Checkbox Inline" value="${bean}" property="importAcl" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                    </td>
                </tr>
                <tr>
                    <th><label class="UI Label Long" for="${prefix}importLfc_0"><fmt:message bundle="${exportmessages}" key="import.Lfc" /></label></th>
                    <td>
                        <syswf:selectOne id="${prefix}importLfc" name="importLfc" selectClass="UI Form Checkbox Inline" value="${bean}" property="importLfc" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                    </td>
                </tr>
                </c:if>
                <tr><td colspan="2">&nbsp;</td></tr>
                
                <tr>
                    <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.destDomain" /></label></th>
                    <td>
                        <fmt:message bundle="${exportmessages}" key="import.destDomain.1" var="op1" />
                        <fmt:message bundle="${exportmessages}" key="import.destDomain.2" var="op2">
                            <fmt:param>${currentDomain}</fmt:param>
                        </fmt:message>
                        <c:set var="selectCaption" value=" ${op1}, ${op2}" />
                        <syswf:selectOne mode="radio" value="${bean}" id="destinationDomain" property="destinationDomain" optionValues="${values.destinationDomainValues}" name="destinationDomain" dataType="enum" optionCaptions="${selectCaption}" displayAsRow="true" />
                    </td>
                </tr>
                <c:if test="${isAdmin}">
                <tr>
                    <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.ownership" /></label></th>
                    <td>
                        <fmt:message bundle="${exportmessages}" key="import.destDomain.1" var="op1" />
                        <fmt:message bundle="${exportmessages}" key="import.destDomain.2" var="op2">
                            <fmt:param>${currentUser}</fmt:param>
                        </fmt:message>
                        <c:set var="selectCaption" value=" ${op1}, ${op2}" />
                        <syswf:selectOne mode="radio" value="${bean}" id="ownership" property="ownership" optionValues="${values.ownershipValues}" name="ownership" dataType="enum" optionCaptions="${selectCaption}" displayAsRow="true" />
                    </td>
                </tr>
                </c:if>
                </tbody>
                </table>
                
                <c:if test="${isAdmin}">
                <table class="UI Table Properties<c:if test="${bean.ownership eq 'RESTORE_ALL'}"> x-hide-display</c:if>" id="appliesTo">
                <colgroup>
                    <col class="MidLabelCol" />
                    <col />
                </colgroup>
                <tbody>
                
                <tr>
                    <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="import.appliesTo" /></label></th>
                    <td>
                        <fmt:message bundle="${exportmessages}" key="import.appliesTo.1" var="op1" />
                        <fmt:message bundle="${exportmessages}" key="import.appliesTo.2" var="op2" />
                        <c:set var="selectCaption" value=" ${op1}, ${op2}" />
                        <syswf:selectOne mode="radio" value="${bean}" id="sameOwnership" property="sameOwnership" optionValues="${values.sameOwnershipValues}" name="sameOwnership" dataType="enum" optionCaptions="${selectCaption}" displayAsRow="true" />
                    </td>
                </tr>
                </tbody>
                </table>
                <script type="text/javascript">
//<![CDATA[

                function showHideAppliesTo() {
                    if (Ext.get('ownership_0').dom.checked) {
                    	Ext.get('appliesTo').addClass('x-hide-display');
                    } else if (Ext.get('ownership_1').dom.checked) {
                        Ext.get('appliesTo').removeClass('x-hide-display');
                    }
                }

                function diableConflict() {
                    if (Ext.get('conflict_0').dom.checked) {
                    	Ext.get('conflictRelations_1').dom.disabled = true;
                    	Ext.get('conflictRelations_0').dom.checked = true;
                    } else {
                    	Ext.get('conflictRelations_1').dom.disabled = false;
                    }
                }
                
                Ext.onReady(function() {
                    Ext.get('appliesTo').enableDisplayMode();
                    attachOn('ownership_0','click',showHideAppliesTo);
                    attachOn('ownership_1','click',showHideAppliesTo);

                    // conflict
                    attachOn('conflict_0','click',diableConflict);
                    attachOn('conflict_1','click',diableConflict);
                    diableConflict();
                });
                
//]]>
</script>
                
                <table class="UI Table Properties">
                <colgroup>
                    <col class="MidLabelCol" />
                    <col />
                </colgroup>
                <tbody>
                
                <tr><td colspan="2">&nbsp;</td></tr>
                
                <tr>
                    <th><label class="UI Label Long"><fmt:message bundle="${exportmessages}" key="export.domainOption.configuration" />:</label></th>
                    <td>
                        <ul>
                        <li>
                        <syswf:selectOne id="${prefix}taxonomies" name="taxonomies" selectClass="UI Form Checkbox Inline" value="${bean}" property="taxonomies" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}taxonomies_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.taxonomies" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}processes" name="processes" selectClass="UI Form Checkbox Inline" value="${bean}" property="processes" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}processes_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.processes" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}policies" name="policies" selectClass="UI Form Checkbox Inline" value="${bean}" property="policies" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}policies_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.policies" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}roles" name="roles" selectClass="UI Form Checkbox Inline" value="${bean}" property="roles" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}roles_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.roles" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}users" name="users" selectClass="UI Form Checkbox Inline" value="${bean}" property="users" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}users_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.users" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}acls" name="acls" selectClass="UI Form Checkbox Inline" value="${bean}" property="acls" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}acls_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.acls" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}servers" name="servers" selectClass="UI Form Checkbox Inline" value="${bean}" property="servers" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}servers_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.servers" /></label>
                        </li><li>
                        <syswf:selectOne id="${prefix}domain" name="domain" selectClass="UI Form Checkbox Inline" value="${bean}" property="domain" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                        <label class="UI Label Inline" for="${prefix}domain_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.domain" /></label>
                        </li>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
            </c:if>
</syswf:wrap>
    
</syswf:block>

<syswf:block className="UI Block Green Last">
    <div class="Content">
        <div class="UI Form Controls">
            <fmt:message bundle="${exportmessages}" key="Import" var="import" />
            <syswf:control id="${prefix}Import" mode="postAnchor" caption="${import}" action="importData" wrapper="span">
                <syswf:attribute name="class" value="btn btn-primary"/>
            </syswf:control>
            <fmt:message bundle="${messages}" key="Cancel" var="cancel" />
            <syswf:control id="${prefix}Cancel" mode="postAnchor" caption="${cancel}" action="cancel" wrapper="span" targetDepth="${sessionStack.currentDepth - 1}">
                <syswf:attribute name="class" value="btn btn-gray"/>
            </syswf:control>            
          </div>
    </div>
</syswf:block>