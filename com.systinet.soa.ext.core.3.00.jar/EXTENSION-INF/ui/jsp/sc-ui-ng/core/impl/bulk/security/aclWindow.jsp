<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<syswf:control mode="script" caption="${prefix}SaveState" action="saveState" affects="." />

<div>
    <div class="Message Info"><div class="MessageContainer"><fmt:message bundle="${messages}" key="changeAcl.instructions" /></div></div>
    <div class="Offset" >
        <hr/>
        <syswf:component name="/core/impl/bulk/security/aclTable" prefix="acls">
           	<syswf:param name="holder" value="${holder}" />
           	<syswf:param name="tablePrefix" value="${prefix}" />
            <syswf:param name="saveStateFce" value="${prefix}SaveState" />
            <syswf:param name="winOnRenderCallback" value="${winOnRenderCallback}" />
        </syswf:component>
        
        <hr/>
        
        <div class="UI AdvancedOptions Labeled Closed">
            <div class="OptionsOpener">
                <a id="${prefix}SwitchOptions" href="javascript:void(0);" onclick="AdvancedOptions.Switch(this);" title="<fmt:message bundle="${messages}" key="changeAcl.customSearchCriteria" />"><span><fmt:message bundle="${messages}" key="general.advancedOptions" /></span></a>
            </div>
            <div class="Content" id="edit_accessrights_content_ao_content">
                <syswf:selectOne name="edit_accessrights_ao1" selectClass="UI Form Checkbox Inline" value="${aclSettings}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                <label class="UI Label Inline" for="edit_accessrights_ao1"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
                <syswf:selectOne id="${prefix}_edit_accessrights_ao2" name="edit_accessrights_ao2" selectClass="UI Form Checkbox Inline" value="${aclSettings}" property="replace" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                <label class="UI Label Inline" for="edit_accessrights_ao2"><fmt:message bundle="${messages}" key="changeAcl.removeExistingRights" />
                	<em id="${prefix}_remove_existing_acl_notice" class="Important" style="display:none;"><fmt:message bundle="${messages}" key="changeAcl.removeExistingRightsNotice" /></em>
                </label>

                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        Ext.get('${prefix}_edit_accessrights_ao2_0').on('click', function() {
                            Ext.get('${prefix}_remove_existing_acl_notice').toggle();
                            toggleRemoveColumn(Ext.getCmp('bulk_accessrights'));
                        });

                        attachOn('${prefix}SwitchOptions','click',function() {
                            AdvancedOptions.Switch(Ext.get('${prefix}SwitchOptions').dom);
                        });
                    });	
                
//]]>
</script>
            </div>
        </div>
</div>
</div>