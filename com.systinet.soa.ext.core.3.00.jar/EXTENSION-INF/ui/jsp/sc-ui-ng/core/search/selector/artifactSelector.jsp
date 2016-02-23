<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<%--
PARAMETERS:
    jsOpenFunction   - Javascript function name to be called for opening the dialog
    jsSelectFunction - (optional!) Javascript callback function name which will be called if some artifact is selected
    selectorListener - (optional!) Server-side callback interface which will be called on server if some artifact is
                       selected. This component can work in 2 modes: In client-side mode the jsSelectFunction is called,
                       in server-side mode the selectorListener is called
    artifactType     - (optional) Search only artifacts of the given artifact type. If not set, all available artifact
                       types of the current view will be allowed in search
    windowTitle      - (optional) window title
    showDataBeforeSearch - show data before search
    customButtons    - (optional) Custom buttons
    selectorCustomizationId - (optional) Customization ID for the search criteria and visible results in the selector. 
                                The criteria ID will be ${selectorCustomizationId}.criteria and results ${selectorCustomizationId}.results. 
                                The default value is "shared.artifactSelector".
--%>
<%--@elvariable id="jsOpenFunction" type="java.lang.String"--%>
<%--@elvariable id="jsSelectFunction" type="java.lang.String"--%>
<%--@elvariable id="selectorListener" type="com.hp.systinet.sc.ui.search.selector.ArtifactSelectorListener"--%>
<%--@elvariable id="artifactType" type="java.lang.String"--%>
<%--@elvariable id="windowTitle" type="java.lang.String"--%>
<%--@elvariable id="showDataBeforeSearch" type="java.lang.String"--%>
<%--@elvariable id="customButtons" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>
<fmt:message var="cancelCaption" bundle="${messages}" key="Cancel"/>
<fmt:message var="selectCaption" bundle="${messages}" key="Select"/>

<c:set var="resultTableId" value="${prefix}_asTableId"/>
<c:set var="windowId" value="${prefix}_asWindow"/>
<c:set var="selectorWindowPrefix" value="artifactSelectorWindow"/>
<c:if test="${empty windowTitle}">
    <c:set var="windowTitle"><fmt:message bundle="${messages}" key="artifactSelector.defaultTitle"/></c:set>
</c:if>


<c:if test="${not empty selectorListener}">
    <%-- Server mode --%>
    <syswf:control id="actionSelectArtifact" mode="script" caption="${prefix}actionSelectArtifact" action="select" affects="." loadingMask="true" />
    <c:set var="jsSelectFunction" value="${prefix}_onSelect"/>
    <script type="text/javascript">
//<![CDATA[

        ${jsSelectFunction} = function(name, uuid) {
            ${prefix}actionSelectArtifact();
        }
    
//]]>
</script>
</c:if>

<syswf:input id="${prefix}_name" name="name" value="" mode="hidden"/>
<syswf:input id="${prefix}_uuid" name="uuid" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

function ${prefix}_selectFunction(name, uuid) {
    Ext.get('${prefix}_name').dom.value = name;
    Ext.get('${prefix}_uuid').dom.value = uuid;
}

//]]>
</script>

<div class="webfw-Window" id="${prefix}-webfw-Window">
<div id="${windowId}" class="x-hidden">
<div class="x-window-header"><c:out value="${windowTitle}"/></div>
<div class="x-window-body">
<div class="UI Offset">

<syswf:component name="/core/impl/window" prefix="${selectorWindowPrefix}">
    <syswf:param name="component" value="/core/impl/util/artifactSelectorWindow"/>
    <syswf:param name="windowControlName" value="${prefix}_${selectorWindowPrefix}_render" />
    <syswf:param name="selectFunctionName" value="${prefix}_selectFunction"/>
    <syswf:param name="resultTableId" value="${resultTableId}"/>
    <syswf:param name="popupWindowId" value="${windowId}"/>
    <syswf:param name="artifactType" value="${artifactType}"/>
    <syswf:param name="dqlCondition" value="${dqlCondition}"/>
    <syswf:param name="showDataBeforeSearch" value="${showDataBeforeSearch}"/>
    <syswf:param name="selectorCustomizationId" value="${selectorCustomizationId}"/>
</syswf:component>

</div>
</div>
</div>
</div>

<%-- Default buttons --%>
<c:if test="${empty customButtons}">
    <c:set var="customButtons">
        [{
            text     : '${selectCaption}',
            disabled : false,
            handler  : function() {
                SPopup.Window.Instance['${windowId}'].hide();
                ${prefix}setSelected();
                var name = Ext.get('${prefix}_name').dom.value;
                var uuid = Ext.get('${prefix}_uuid').dom.value;
                ${jsSelectFunction}(name, uuid);
            },
            id: '${prefix}_okButton'
        },{
            text     : '${cancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['${windowId}'].hide();
                return false;
            },
            id: '${prefix}_cancelButton'
        }]
    </c:set>
</c:if>

<script type="text/javascript">
//<![CDATA[


function ${prefix}setSelected(){
    var checkedRadio = $('DIV.x-grid3-cell-inner.x-grid3-col-_selection INPUT.UI.Form.Checkbox').filter(':radio:checked');
    
    if (checkedRadio != null){
        $('#${prefix}_uuid').val(checkedRadio.val());
        var parent = checkedRadio.parents().filter('td.x-grid3-col');
        var nameColumn = parent.siblings().filter('td.x-grid3-td-name');
        var link = nameColumn.find('a');
        $('#${prefix}_name').val(link.text());
    }
}

${jsOpenFunction} = function() {
    ${prefix}_${selectorWindowPrefix}_render();

    SPopup.Window.forceOpen('${windowId}','${windowId}',{
        plain:false,
        autoHeight:true,
        buttons:<c:out value="${customButtons}" escapeXml="false"/>,
        width:800,
        centerOnScreen:true
    });

    SPopup.Window.Instance['${windowId}'].on('resize', function() {
        var cmp = Ext.getCmp('${resultTableId}');
        if (cmp) {
            cmp.getEl().setStyle({width: '100%'});
            cmp.getGridEl().setStyle({width: '100%'});
            cmp.syncSize();
        }
    });

    var cmp = Ext.getCmp('${resultTableId}');
    if (cmp) {
        cmp.getEl().setStyle({width: '100%'});
        cmp.getGridEl().setStyle({width: '100%'});
        cmp.syncSize();
    }

    // TODO: need to attach on the radio buttons a fucntion that enables the OK button
};
<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
    SPopup.Window.Instance['${windowId}'] = undefined;
});

//]]>
</script>
