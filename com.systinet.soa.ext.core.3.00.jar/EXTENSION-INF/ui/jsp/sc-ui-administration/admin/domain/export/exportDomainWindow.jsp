<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages"/>

<div class="UI Offset">

<table class="UI Table Properties">
    <colgroup>
        <col class="LabelCol" />
        <col />
    </colgroup>
    <tr>
        <th>
            <label for="${prefix}filename"><fmt:message bundle="${exportmessages}" key="export.archiveName" />:</label>
        </th>
        <td>
            <syswf:input name="filename" id="${prefix}filename" value="${holder}" property="filename" mode="text">
                <syswf:attribute name="class" value="x-form-text x-form-field hp-export-archive-name" />
            </syswf:input>
            <span><fmt:message bundle="${exportmessages}" key="export.dotZip" /></span>
        </td>
    </tr>
</table>

<syswf:wrap template="../sc-ui-ng/templates/advancedOptions.jsp">
        <c:if test="${not empty childDomains}">
            <ul class="Choices">
                <li>
                <syswf:selectOne id="${prefix}includeSubdomains" name="includeSubdomains" selectClass="UI Form Checkbox Inline" value="${holder}" property="includeSubdomains" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                <label class="UI Label Inline" for="${prefix}includeSubdomains_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.includeSubdomains" /></label>
                </li>
            </ul>
            <div class="Message Info" id="${prefix}warn">
                <div class="MessageContainer">
                    <div class="Icon"><span>&nbsp;</span></div>
                    <div class="Content">
                        <fmt:message bundle="${exportmessages}" key="export.domainRelatedInfo" />
                        <ul>
                        <c:forEach items="${childDomains}" var="domain" varStatus="status">
                            <li><syswf:control mode="anchor" caption="${domain.name}" targetTask="/artifact/${domain.uuid}" id="view${status.index}" /></li>
                        </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        
        <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
        	Ext.get('${prefix}warn').enableDisplayMode();
        	Ext.get('${prefix}warn').hide();
            attachOn('${prefix}includeSubdomains_0','click',function() {
                if (!Ext.get('${prefix}includeSubdomains_0').dom.checked) {
                    Ext.get('${prefix}warn').show();
                } else {
                	Ext.get('${prefix}warn').hide();
                }
            });
        });
        
//]]>
</script>
        
        </c:if>
                
        <h3><fmt:message bundle="${exportmessages}" key="export.domainIncludes" />:</h3>
        <ul class="Choices">
            <li>
                <syswf:selectOne id="${prefix}data" name="data" selectClass="UI Form Checkbox Inline" value="${holder}" property="data" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
                <label class="UI Label Inline" for="${prefix}data_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.data" /></label>
            </li>
            <li>
            <input type="checkbox" id="${prefix}configuration" name="${prefix}configuration" />
            <label for="${prefix}configuration" class="UI Label Inline"><fmt:message bundle="${exportmessages}" key="export.domainOption.configuration" /></label>
            <script type="text/javascript">
//<![CDATA[

            function syncConfCheckbox() {
                inp = Ext.get('${prefix}configuration');
                inps = inp.up('li').select('li li input');
                allChecked = true;
                inps.each(function(el) {
                    if (!el.dom.checked) {
                        inp.dom.checked = false;
                        allChecked = false;
                    }
                });
                if (allChecked) {
                	inp.dom.checked = true;
                }
            }
            Ext.onReady(function() {
                attachOn('${prefix}configuration','click',function() {
                    inp = Ext.get('${prefix}configuration');
                    inps = inp.up('li').select('li input');
                    inps.each(function(el) {
                        el.dom.checked = inp.dom.checked;
                    });
                });
                syncConfCheckbox();
            });
            
//]]>
</script>
        <ul class="Choices">
        <c:if test="${not empty childDomains}">
            <%--TaxonomiesTaxonomies and Lifecycle Processes options are only applicable when the Administrative Domain is exported --%>
            <li>
            <syswf:selectOne id="${prefix}taxonomies" name="taxonomies" selectClass="UI Form Checkbox Inline" value="${holder}" property="taxonomies" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
            <label class="UI Label Inline" for="${prefix}taxonomies_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.taxonomies" /></label>
            </li><li>
            <syswf:selectOne id="${prefix}processes" name="processes" selectClass="UI Form Checkbox Inline" value="${holder}" property="processes" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
            <label class="UI Label Inline" for="${prefix}processes_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.processes" /></label>
            </li>
        </c:if>
        <li>
        <syswf:selectOne id="${prefix}policies" name="policies" selectClass="UI Form Checkbox Inline" value="${holder}" property="policies" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}policies_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.policies" /></label>
        </li><li>
        <c:if test="${topLevel}">
        <syswf:selectOne id="${prefix}roles" name="roles" selectClass="UI Form Checkbox Inline" value="${holder}" property="roles" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}roles_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.roles" /></label>
        </li><li>
        <syswf:selectOne id="${prefix}users" name="users" selectClass="UI Form Checkbox Inline" value="${holder}" property="users" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}users_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.users" /></label>
        </li><li>
        </c:if>
        <syswf:selectOne id="${prefix}acls" name="acls" selectClass="UI Form Checkbox Inline" value="${holder}" property="acls" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}acls_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.acls" /></label>
        </li><li>
        <syswf:selectOne id="${prefix}servers" name="servers" selectClass="UI Form Checkbox Inline" value="${holder}" property="servers" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}servers_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.servers" /></label>
        </li><li>
        <syswf:selectOne id="${prefix}domain" name="domain" selectClass="UI Form Checkbox Inline" value="${holder}" property="domain" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}domain_0"><fmt:message bundle="${exportmessages}" key="export.domainOption.domain" /></label>
        </li>
        </ul>
        </li></ul>
        <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
        	<c:if test="${not empty childDomains}">
            attachOn('${prefix}taxonomies_0','click',syncConfCheckbox);
            attachOn('${prefix}processes_0','click',syncConfCheckbox);
            </c:if>
            attachOn('${prefix}policies_0','click',syncConfCheckbox);
            <c:if test="${topLevel}">
            attachOn('${prefix}roles_0','click',syncConfCheckbox);
            attachOn('${prefix}users_0','click',syncConfCheckbox);
            </c:if>
            attachOn('${prefix}acls_0','click',syncConfCheckbox);
            attachOn('${prefix}servers_0','click',syncConfCheckbox);
            attachOn('${prefix}domain_0','click',syncConfCheckbox);
        });
        
//]]>
</script>
</syswf:wrap>

</div>