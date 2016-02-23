<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--
Parameters:
   * holder - required; instance of =com.hp.systinet.sc.ui.util.NewValuePopupEditorHolder= listener interface; this listener defines two methods (for setting / selecting value)
   * defaultValues - when set, input is turned into combo box, so user can either set some value or choose one (different events on listener interface - type and click add / select value)
   * buttonCaption - caption of the button, by default "Add"
   * caption - link caption, by default "Add value"
   * info - info text displayed above input
   * popupWidth - popup width, by default 215
   * inputWidth - width of the popup, by default (popuWidth - 65)
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<c:if test="${empty buttonCaption}">
    <fmt:message var="buttonCaption" key="newValuePopUpEditor.buttonCaption" bundle="${bundle}"/>
</c:if>
<c:if test="${empty caption}">
    <fmt:message var="caption" key="newValuePopUpEditor.caption" bundle="${bundle}"/>
</c:if>

<a href="javascript:void(0);" id="${prefix}link" class="${linkClass}">${caption}</a>

<div id="${prefix}holder"></div>

<div id="${prefix}content">
    <div class="UI Align x-tip-body">
        <div class="Left">
        <syswf:input value="${valueHolder}" property="value" name="text" id="${prefix}input" />
        </div>
        <div class="Right">
          <syswf:control mode="button" caption="${buttonCaption}" action="add"/>
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

<c:if test="${not empty defaultValues}">
    <syswf:control mode="script" caption="${prefix}_cb_select" action="select"/>
</c:if>

<script type="text/javascript">
//<![CDATA[

<c:choose>
<c:when test="${not empty defaultValues}">
var values = [
              <c:forEach items="${defaultValues}" var="entry" varStatus="status">
              ['<syswf:addSlashes>${entry.key}</syswf:addSlashes>','<syswf:addSlashes>${entry.value}</syswf:addSlashes>']<c:if test="${not status.last}">,</c:if>
              </c:forEach>
              ];
              
  var combos = {
      init : function(){

        var store = new Ext.data.SimpleStore({
          fields: ['key', 'value'],
          data : values
      });
      var cbsite = new Ext.form.ComboBox({
          store: store,
          displayField: 'value',
          typeAhead: true,
          mode: 'local',
          triggerAction: 'all',
          selectOnFocus:true,
          width: ${inputWidth},
          valueField: 'key',
          applyTo: '${prefix}input',
          getListParent: function() {
              return this.el.up('.x-tip-body');
          }
      });

      cbsite.on('select', function() {
          var element = Ext.get('${prefix}input');
          element.dom.value = cbsite.getValue(); 
          ${prefix}_cb_select();    
      });
  }}

  Ext.onReady(function() {
        combos.init();
  });
  
</c:when>
<c:otherwise>
new Ext.HP.Input({
	width: ${inputWidth},
    applyTo : '${prefix}input'
});
</c:otherwise>
</c:choose>
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
        //renderTo: '${prefix}holder',
        applyTo: '${prefix}content',
        //html: '<syswf:addSlashes>${tipContent}</syswf:addSlashes>',
            listeners: {
            beforeshow: function() {
                Ext.get('${prefix}input').focus();
            }
        }  
    });

});

//]]>
</script>