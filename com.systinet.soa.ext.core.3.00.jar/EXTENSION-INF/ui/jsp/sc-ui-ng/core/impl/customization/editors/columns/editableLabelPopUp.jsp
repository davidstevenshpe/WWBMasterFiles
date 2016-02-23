<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<c:if test="${column.editableLabel}">
<a href="javascript:void(0);" id="${prefix}link" class="${linkClass}">${value.label}</a>

<div id="${prefix}content" class="x-hidden">
    <div class="UI Align x-tip-body">
        <div class="Left">
        <syswf:input value="${value}" property="label" name="text" id="${prefix}input" />
        </div>
        <div class="Right">
          <%--
          <syswf:control mode="button" caption="Save" action="update" affects="." id="${prefix}_save1"/>
          --%>
          
          <%-- it has to be like this because binded script stops event propagation (if row is selectable) by returning false --%>
          <%-- otherwise each click (in popup window - it doesn't matter where) causes row selection --%>
          <syswf:control mode="script" caption="${prefix}_save" action="update" affects="../.." id="${prefix}_save2" loadingMask="true"/>
          <a href="javascript:void(0);" class="btn btn-primary" id="${prefix}_btn_save">Save</a>
          <script type="text/javascript">
//<![CDATA[

            $('#${prefix}_btn_save').bind('click',function(){
                ${prefix}_save();
                return false;
            });
          
//]]>
</script>
          
        </div>
        <div class="clear"></div>
    </div>
</div>

<c:if test="${empty popupWidth}">
    <c:set var="popupWidth" value="215" />
</c:if>
<c:if test="${empty inputWidth}">
    <c:set var="inputWidth" value="${popupWidth - 65}" />
</c:if>

<%-- stops row selection - if selectable - stops event propagation --%>
<%-- I dont want to select row when click anywhere in pop up window --%>
<script type="text/javascript">
//<![CDATA[

$('#${prefix}content').bind('click',function(){
    return false;
});

new Ext.HP.Input({
    width: ${inputWidth},
    applyTo : '${prefix}input'
});

Ext.onReady(function() {
    
    var tip = new Ext.ToolTip({
        id: '${prefix}content',
        target: '${prefix}link',
        anchor: 'top',
        <c:choose>
        <c:when test="${not empty info}">title: '<syswf:addSlashes>${info}</syswf:addSlashes>',header: true,</c:when>
        <c:otherwise>header: false,</c:otherwise>
        </c:choose>
        html: null,
        width: ${popupWidth},
        autoHide: false,
        closable: true,
        applyTo: '${prefix}content',
        listeners: {
            beforeshow: function() {
                Ext.get("${prefix}input").focus();
            }
        }  
    });
});

//]]>
</script>
</c:if>

<c:if test="${not column.editableLabel}">
    <c:out value="${column.label}"/>
</c:if>