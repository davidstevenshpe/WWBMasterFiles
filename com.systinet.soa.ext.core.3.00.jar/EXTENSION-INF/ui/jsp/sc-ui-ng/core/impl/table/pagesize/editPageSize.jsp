<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:if test="${empty openFce}">
    <c:set var="openFce" value="${prefix}openWindow" />
</c:if>

<%-- set button id if not set --%>
<c:if test="${empty editButtonId}">
    <c:set var="editButtonId" value="${prefix}_edit_${kind}"/>
</c:if>

<c:if test="${empty showButton or showButton}">
	<a href="javascript:void(0)" id="${editButtonId}" class="UI Icon Edit">
	    <fmt:message key="Change" bundle="${messages}"/>
	</a>
</c:if>

<c:set var="windowId" value="${prefix}_change_size"/>

<div class="webfw-Window" id="${prefix}-webfw-Window">
<div id="${windowId}" class="x-hidden">
<div class="x-window-header"><c:if test="${not empty pageSizeInfo}">${pageSizeInfo.label} - </c:if><fmt:message key="changePageSize" bundle="${messages}"/></div>
<div class="x-window-body">
    <syswf:component name="/core/impl/window" prefix="editPageSize">
        <syswf:param name="component" value="/core/impl/table/pagesize/editPageSizeInternal" />
        <syswf:param name="windowControlName" value="${prefix}render" />
        <syswf:param name="pageSizeInfo" value="${pageSizeInfo}"/>
        <syswf:param name="kind" value="${kind}"/>
        <syswf:param name="contentInfo" value="${contentInfo}"/>
    </syswf:component>
</div>
</div>

<syswf:control mode="script" action="${prefix}_editPageSize_window$onSave" caption="${prefix}save" affects="${affects}">
    <c:if test="${not empty tableId}">
        <syswf:param name="${tableId}_resetPaging" value="true" />
        <syswf:param name="${tableId}_resetFilter" value="true" />
    </c:if>
</syswf:control>

<c:set var="buttons">
[{
    text     : '<fmt:message key="OK" bundle="${messages}"/>',
    disabled : false,
    handler  : function() {
        ${prefix}save();
        SPopup.Window.Instance['${windowId}'].hide();
    },
    id:'${prefix}_addButton'
},{
    text     : '<fmt:message key="Cancel" bundle="${messages}"/>',
    handler  : function(){
        SPopup.Window.Instance['${windowId}'].hide();
    },
    id:'${prefix}_cancelButton'
}]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${openFce} = function() {
	${prefix}render();
        SPopup.Window.forceOpen(
            '${windowId}',
            '${windowId}',
            {
                width:300,
                autoHeight:true,
                border: false,
                autoScroll:true,
                buttons: ${buttons},
                centerOnScreen: true
            }
        );
};

<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
    SPopup.Window.Instance['${windowId}'] = undefined;
    <c:if test="${empty showButton or showButton}">
        Ext.get('${editButtonId}').on('click', ${openFce});
    </c:if>
})

//]]>
</script>

</div>