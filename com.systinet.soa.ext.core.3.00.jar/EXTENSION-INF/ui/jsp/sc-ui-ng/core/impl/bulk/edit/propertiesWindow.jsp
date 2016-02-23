<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<div class="UI Offset">

<syswf:component name="/core/layout/dropdowns" prefix="d">
    <syswf:param name="customizationId" value="shared.bulk.properties.tabs" />
    <syswf:param name="propertiesHolder" value="${propertiesHolder}" />
    <syswf:param name="settings" value="${propertiesSettings}" />
    <syswf:param name="style" value="margin: 10px 0 10px 0px" />
    <syswf:param name="isAddPrefixText" value="true" /><%-- add "Select from:" text in front of Dropdown --%>
    <syswf:param name="widthDropdown" value="200" /><%-- set width for dropdown menu manually --%>
</syswf:component>
    
    <syswf:wrap template="/templates/advancedOptions.jsp">
            <syswf:selectOne name="edit_properties_ao1" selectClass="UI Form Checkbox Inline" value="${propertiesSettings}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
            <label class="UI Label Inline" for="${prefix}_edit_properties_ao1_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
            <br/>
            <syswf:selectOne id="${prefix}_edit_properties_ao2" name="${prefix}_edit_properties_ao2" selectClass="UI Form Checkbox Inline" value="${propertiesSettings}" property="removeExistingCategories" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
            <label class="UI Label Inline" for="${prefix}_edit_properties_ao2_0"><fmt:message bundle="${messages}" key="changeProperties.removeExistingCategories" />
            <em id="${prefix}_categories_notice" class="Important" style="display:none;"><fmt:message bundle="${messages}" key="changeProperties.categoriesRemovalNotification" /></em></label>
            <br/>
            <syswf:selectOne id="${prefix}_edit_properties_ao3" name="${prefix}_edit_properties_ao3" selectClass="UI Form Checkbox Inline" value="${propertiesSettings}" property="removeExistingKeywords" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
            <label class="UI Label Inline" for="${prefix}_edit_properties_ao3_0"><fmt:message bundle="${messages}" key="changeProperties.removeExistingKeywords" />
            <em id="${prefix}_keywords_notice" class="Important" style="display:none;"><fmt:message bundle="${messages}" key="changeProperties.keywordsRemovalNotification" /></em></label>

            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    Ext.get('${prefix}_edit_properties_ao2_0').on('click', function() {
                        this.dom.checked ? Ext.get('${prefix}_categories_notice').show() : Ext.get('${prefix}_categories_notice').hide();
                    });
                    Ext.get('${prefix}_edit_properties_ao3_0').on('click', function() {
                        this.dom.checked ? Ext.get('${prefix}_keywords_notice').show() : Ext.get('${prefix}_keywords_notice').hide();
                    });
                    Ext.get('${prefix}_edit_properties_ao2_0').dom.checked ? Ext.get('${prefix}_categories_notice').show() : Ext.get('${prefix}_categories_notice').hide();
                    Ext.get('${prefix}_edit_properties_ao3_0').dom.checked ? Ext.get('${prefix}_keywords_notice').show() : Ext.get('${prefix}_keywords_notice').hide();
                });    
            
//]]>
</script>
    </syswf:wrap>
    
</div>