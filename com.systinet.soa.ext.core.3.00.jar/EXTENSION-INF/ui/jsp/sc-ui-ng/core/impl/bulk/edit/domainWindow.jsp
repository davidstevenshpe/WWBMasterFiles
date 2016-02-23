<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />

<table class="UI Table Properties">
    <colgroup>
        <col class="LabelCol" />
        <col />
    </colgroup>
    <tr>
        <th>
            <label class="UI Label" for="${prefix}domain"><fmt:message bundle="${messages}" key="changeDomain.targetDomain" /></label>
        </th>
        <td>
            <syswf:selectOne id="${prefix}domain" mode="menu" value="${holder}" optionValues="${availableDomains}" optionCaptions="${availableDomainsCaptions}" property="targetDomain" name="targetDomain" />
            <script type="text/javascript">
//<![CDATA[

            Ext.onReady( function() {
                var cmb = new Ext.form.ComboBox({
                    id : '${prefix}domain',
                    transform : '${prefix}domain',
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    listWidth : 300,
                    width : 300,
                    triggerAction : 'all',
                    editable : false
                });
            });
        
//]]>
</script>
        </td>
    </tr>
</table>
<syswf:wrap template="../sc-ui-ng/templates/advancedOptions.jsp">
<syswf:param name="advancedOptionsOpenerHolder" value="${holder}" />
    
        <syswf:selectOne id="${prefix}includeSubartifact" name="includeSubartifact" selectClass="UI Form Checkbox Inline" value="${holder}" property="includeSubartifact" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}includeSubartifact_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
        <br />
        
        <syswf:selectOne id="${prefix}includeDependecies" name="includeDependecies" selectClass="UI Form Checkbox Inline" value="${holder}" property="includeDependecies" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}includeDependecies_0"><fmt:message bundle="${messages}" key="changeDomain.includeDependecies" /></label>
        
        <div class="Offset">
        <table class="UI Table Properties">
            <colgroup>
                <col class="SmallLabelCol" />
                <col class="ShortLabelCol" />
                <col />
            </colgroup>
            <tr>
                <th>
                    <fmt:message bundle="${messages}" key="changeDomain.artifactOwnership" />:
                </th>
                <td>
                    <fmt:message bundle="${messages}" key="changeDomain.artifactOwnershipCaptions" var="captions" />
                    <syswf:selectOne id="${prefix}keepOwner" name="keepOwner" value="${holder}" property="keepOwner" mode="radio" optionValues="true,false" dataType="boolean" optionCaptions=" ${captions}" />
                </td>
                <td style="vertical-align: bottom; padding-bottom: 8px">
                    <syswf:component name="/core/impl/bulk/edit/domainWindowPrincipal" prefix="dwp">
                        <syswf:param name="holder" value="${holder}" />
                    </syswf:component>
                </td>
            </tr>
        </table>
        </div>
</syswf:wrap>