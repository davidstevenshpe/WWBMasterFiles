<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>



<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="componentsmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>


<fmt:message bundle="${componentsmessages}" key="Select" var="selectLabel" />
<fmt:message bundle="${componentsmessages}" key="Add" var="addLabel" />
<fmt:message bundle="${componentsmessages}" key="Cancel" var="cancelLabel" />



<c:choose>
    <c:when test="${incoming}" >
        <fmt:message bundle="${relationshipmessages}" key="addIncomingRelationship" var="winTitle" />
    </c:when>
    <c:otherwise>
        <fmt:message bundle="${relationshipmessages}" key="addOutgoingRelationship" var="winTitle" />
    </c:otherwise>
</c:choose>

<c:if test="${hasWritePermission}">

    <c:set var="buttons">
        [{
            text     : '${selectLabel}',
            handler  : function() {
                ${prefix}Select();
            },
            id: '${prefix}SelectButtonId'
        },
        {
            text     : '${addLabel}',
            handler  : function() {
                ${prefix}Add();
            },
            id: '${prefix}AddButtonId',
            hidden: true
        },{
            text     : '${cancelLabel}',
            handler  : function() {
                ${prefix}HideWin();
                ${prefix}Cancel();
            }
        }]
    </c:set>
	
 <script type="text/javascript">
//<![CDATA[
        
    function ${prefix}repositionBrowse(){
		SPopup.Window.reposition('${prefix}addRelationshipsWindow');
	}
	
	Ext.onReady(function() {
		moveWindow('${prefix}addRelationshipsWindow','popupWindows');
	});
	
//]]>
</script>

    <syswf:component name="/core/window" prefix="addRelationshipsWindow">
        <syswf:param name="winId">${prefix}addRelationshipsWindow</syswf:param>
		<syswf:param name="popupId" value="${prefix}addRelationshipsWindow"/>
        <syswf:param name="winTitle">${winTitle}</syswf:param>
        <syswf:param name="winComponent" value="/core/relations/addRelationshipsInternalComponent"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}open" />
        <syswf:param name="winCustomButtons" value="${buttons}" />
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="winWidth" value="800" />
        <syswf:param name="winResizable" value="${true}" />
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="relation" value="${relation}"/>
        <syswf:param name="holder" value="${holder}"/>
        <syswf:param name="selectButtonId" value="${prefix}SelectButtonId" />
        <syswf:param name="addButtonId" value="${prefix}AddButtonId" />
        <syswf:param name="selectAction" value="${prefix}Select" />
        <syswf:param name="cancelAction" value="${prefix}Cancel" />
        <syswf:param name="modalWinId" value="${prefix}addRelationshipsWindow" />
        <syswf:param name="targetTableId" value="${targetTableId}" />
		<syswf:param name="winOnRenderCallback" value="${prefix}repositionBrowse" />
    </syswf:component>
    
    <syswf:control mode="script" caption="${prefix}AddAction" action="add"/>

    <script type="text/javascript">
//<![CDATA[

        var ${controlName} = function() {
        	${prefix}open();
        };

        var ${prefix}HideWin = function() {
        	SPopup.Window.Instance['${prefix}addRelationshipsWindow'].hide();
        	Ext.getCmp('${prefix}SelectButtonId').show();
        	Ext.getCmp('${prefix}AddButtonId').hide();
        };


        var ${prefix}Add = function() {
            Ext.getCmp('${prefix}AddButtonId').setDisabled(true);
            ${prefix}AddAction();
        }
        
//]]>
</script>
    
</c:if>