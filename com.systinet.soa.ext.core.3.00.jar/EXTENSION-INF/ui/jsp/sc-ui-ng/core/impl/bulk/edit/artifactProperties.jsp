<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tui_Message"/>

<div class="Offset">
<table class="UI Table Properties">
    <colgroup>
        <col class="LabelCol"/>
        <col/>
        <col style="width:30px;" />
    </colgroup>
    <c:forEach items="${holders}" var="holder">
    <tr>
        <td>
            <label class="UI Label Inline" for="">
                <syswf:out value="${holder.value.propertyHolder.label.string}" context="HtmlBody"/>
            </label>
        </td>
        <td>
            <syswf:component name="${holder.value.display.component}" prefix="${holder.value.sdmName}">
                <syswf:param name="model" value="${holder.value.widgetModel}"/>
                <syswf:param name="error" value="${holder.value.widgetModel.errorMessage}"/>
                <syswf:param name="mode" value="edit"/>
                <syswf:paramSet value="${holder.value.display.paramsMap}"/>
            </syswf:component>
            <c:if test="${not empty holder.value.widgetModel.errorMessage}">
                <em class="x-form-invalid-msg UI Invalid">
                    <span>
                    	<c:set var="dataType" value="${holder.value.propertyHolder.property.propertyTypeDescriptor.name}"/>
                    	<c:choose>
                    		<c:when test="${not empty dataType and dataType eq 'nameUrlPair'}"><syswf:out context="HtmlBody" value="${holder.value.widgetModel.errorMessage}"/></c:when>
                    		<c:otherwise>${holder.value.widgetModel.errorMessage}</c:otherwise>
                    	</c:choose>
                	</span>
                </em>
            </c:if>
        </td>
        <td>
            <syswf:control mode="anchor" caption="&nbsp;" action="removeProperty" affects="." id="remove${holder.key}">
                <syswf:param name="sdmName" value="${holder.key}" />
                <syswf:attribute name="class" value="UI Icon Delete" />
                <syswf:attribute name="style" value="text-decoration: none" />
            </syswf:control>
        </td>
    </tr>
    </c:forEach>
</table>

<syswf:control mode="script" action="addProperty" caption="${prefix}prop" affects="." />

<c:set var="items">
[
<c:forEach items="${properties}" var="property" varStatus="status">
    <c:if test="${not status.first}">,</c:if>
    ['${property.property.sdmName}', '${property.label}', '${property.description}']
</c:forEach>
]
</c:set>

<syswf:input name="property" id="${prefix}property" value="" />
<syswf:input name="sdmName" id="${prefix}sdmName" value="" mode="hidden" />

<script type="text/javascript">
//<![CDATA[

function ${prefix}_actionOnSelect(record) {
    Ext.get('${prefix}sdmName').dom.value = record.data['sdmName'];
	${prefix}prop();
    ${prefix}add_property.collapse();
	${prefix}add_property.destroy();
};
var ${prefix}_resultTpl = new Ext.XTemplate(
        '<tpl for="."><div class="UI Offset InteractiveSearch"><div class="search-item">',
            '<span class="SearchField Name"><span class="Value">{label}</span></span>',
            '<span class="SearchField Description"><span class="Value">{description}</span></span>',
        '</div></div><hr/></tpl>'
    );
    Ext.onReady(function() {
        ${prefix}add_property = new Ext.form.ComboBox({
            typeAhead: true,
            lazyRender: true,
            mode: 'local',
            displayField:'label',
            itemSelector: 'div.search-item',
            valueField: 'sdmName',
            tpl: ${prefix}_resultTpl,
            applyTo: '${prefix}property',
            minListWidth: 300,
            emptyText:'Add property...',
            onSelect: ${prefix}_actionOnSelect,
            store: new Ext.data.SimpleStore({
                fields: ['sdmName', 'label', 'description'],
                data : ${items}
            })
        });
    });

//]]>
</script>
</div>
