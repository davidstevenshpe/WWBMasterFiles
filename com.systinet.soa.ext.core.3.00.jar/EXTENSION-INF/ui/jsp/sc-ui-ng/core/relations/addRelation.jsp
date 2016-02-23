<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<c:if test="${hasWritePermission}">

<fmt:message bundle="${relationshipmessages}" key="ADD_RELATION_CAPTION" var="defaultWindowTitle" />

<div class="webfw-Window" id="${prefix}-webfw-Window">    
<div id="${prefix}add_relation_window" class="x-hidden">
<div class="x-window-header"><c:out value="${windowTitle}" default="${defaultWindowTitle}" /></div>
<div class="x-window-body">
<div class="UI Offset">

<c:set var="relationTableId" value="${prefix}_addRelationTableId"/>
<c:if test="${empty addRelationWindowComponent}">
<c:set var="addRelationWindowComponent" value="/core/impl/relations/addRelationWindow"/>
</c:if>
<syswf:component name="/core/impl/window" prefix="addRelationWindow">
    <syswf:param name="component" value="${addRelationWindowComponent}"/>
    <syswf:param name="relation" value="${relation}"/>
    <syswf:param name="useType" value="${useType}"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="resultTableId" value="${relationTableId}"/>
    <syswf:param name="popupWindowId" value="${prefix}add_relation_window"/>    
    <syswf:param name="hiddenArtifacts " value="${hiddenArtifacts}"/>
</syswf:component>

</div>
</div>
</div>
</div>

<%-- action control - fires action after user presses Add Relation --%>
<syswf:control mode="script" action="${controlAction}" caption="${prefix}addRelation" />

<%-- Default buttons --%>
<c:if test="${empty customButtons}">
    <c:set var="customButtons">
        [{
            text     : '<fmt:message bundle="${relationshipmessages}" key="ADD_RELATION_OK"/>',
            disabled : false,
            handler  : function() {
                SPopup.Window.Instance['${prefix}add_relation_window'].hide();
                ${prefix}addRelation();
            },
            id: '${prefix}_okButton'
        },{
            text     : '<fmt:message bundle="${relationshipmessages}" key="ADD_RELATION_CANCEL"/>',
            handler  : function(){
                SPopup.Window.Instance['${prefix}add_relation_window'].hide();
                return false;
            },
            id: '${prefix}_cancelButton'
        }]
    </c:set>
</c:if>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
${prefix}_addRelationWindow_render();

SPopup.Window.forceOpen('${prefix}add_relation_window','${prefix}add_relation_window',{
    plain:false,
    autoHeight:true,
    buttons:<c:out value="${customButtons}" escapeXml="false"/>,
    width:910,
    centerOnScreen:true
    });

    SPopup.Window.Instance['${prefix}add_relation_window'].on('resize', function() {
        var cmp = Ext.getCmp('${relationTableId}');
        if (cmp) {
            cmp.getEl().setStyle({width: '100%'});
            cmp.getGridEl().setStyle({width: '100%'});
            cmp.syncSize();
        }
    });

    var cmp = Ext.getCmp('${relationTableId}');
    if (cmp) {
        cmp.getEl().setStyle({width: '100%'});
        cmp.getGridEl().setStyle({width: '100%'});
        cmp.syncSize();
    }
};
<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
SPopup.Window.Instance['${prefix}add_relation_window'] = undefined;
})

//]]>
</script>
</c:if>