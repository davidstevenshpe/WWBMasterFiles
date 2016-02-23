<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>
<fmt:message var="warningMessage" key="editSurveyManagementScriptWarning" bundle="${bundle}"/>

<syswf:control mode="script" action="checkUsingSurveyDefinitionInEdit" caption="checkUsingSurveyDefinitionInEdit" affects=".">
   <syswf:param name="artifact" value="${artifact}" />
</syswf:control>

<syswf:component name="/core/window" prefix="dw">
    <syswf:param name="winComponent" value="/core/impl/bulk/warningWindow" />
    <syswf:param name="winTitle" value="Confirm Script Editing"/>
    <syswf:param name="winOpenFunctionName" value="showWarningDialog" />
    <syswf:param name="warningMessage" value="${warningMessage}" />                 
    <syswf:param name="winOkAction" value="openScriptEditor" />
    <syswf:param name="winWidth">500</syswf:param>          
    <syswf:param name="winButtonAlign">center</syswf:param>         
</syswf:component>               

<c:choose>
<c:when test="${contextAction}">
    <c:if test="${deleted eq false}">
        <div class="EA-right-panel">
            <a title="" class="UI PageAction Edit" onclick="checkUsingSurveyDefinitionInEdit()" href="#">Edit Script</a>
            
            <script>
            //<![CDATA[
              <c:if test="${checkedEdit}">
                  <c:choose>
                        <c:when test="${showWarningEdit}">                  
                           showWarningDialog();
                        </c:when>           
                        <c:otherwise>
                            openScriptEditor();
                        </c:otherwise>
                    </c:choose>  
                </c:if>
        
            
            //]]>
            </script>
        </div>
    </c:if>
</c:when>
<c:otherwise>
<div style="display:none">
 <syswf:control mode="script" action="updateScript" caption="${prefix}saveScript">
 </syswf:control>
 <syswf:textArea name="${prefix}textEditorContent" value="${this}" property="script" id="${prefix}Content" escapeXml="false"/>
</div>
<pre id="viewerArea" class="code-editor">
<c:out value="${this.script}"></c:out>
</pre>
<script>
//<![CDATA[

$('#viewerArea').css('font-size', '13px');
$('#viewerArea').css('min-height', '250px');
var contentArea = $('#content .UI.Block.Common');
var contentAreaHeight = 160;
if(contentArea !== null) {
    contentAreaHeight = contentArea.height();
}
$('#viewerArea').height($(window).height() - (contentAreaHeight + 380));
$(window).resize(function() {
    $('#viewerArea').height($(window).height() - (contentAreaHeight + 380));
});

var langMode = 'ace/mode/';
<c:choose>
  <c:when test="${artifact.r_scriptLanguage.val eq 'Javascript' and artifact.r_scriptExecuteOn.val eq 'report'}">
   langMode += 'javascript'
  </c:when>
  <c:when test="${artifact.r_scriptLanguage.val eq 'Javascript'}">
   langMode += 'typescript'
  </c:when>
  <c:when test="${artifact.r_scriptLanguage.val eq 'XML'}">
    langMode += 'xml'
  </c:when>
  <c:otherwise>
    langMode += 'html'
  </c:otherwise>
</c:choose>
viewer = ace.edit('viewerArea');
viewer.setTheme('ace/theme/chrome');
viewer.getSession().setMode(langMode);
viewer.setReadOnly(true);

//]]>
</script>

<script>
//<![CDATA[
     

  openScriptEditor=function() {
      console.log(layoutManager.localStorage.get('ace/theme/'));
      var win = new Ext4.Window({
        title: 'Edit script',
        layout: 'fit',
        height: 600,
        modal:true,
        maximizable: true,
        width: 800,
        html:'<pre id="${prefix}customizationSource" style="font-size: 15px;" class="code-editor"></pre>',
        buttons: ['Theme: ', {
            xtype : 'combo',
            width : 100,
            store : ['chrome','terminal','monokai','solarized_dark'],
            value: layoutManager.localStorage.get('ace/theme/') ? layoutManager.localStorage.get('ace/theme/') : 'chrome',
            listeners: {
                select: function(self) {
                    editor.setTheme('ace/theme/' + self.value);
                    layoutManager.localStorage.set('ace/theme/', self.value);
                }
            }

        },'->',{
            text: 'Save',
            handler: function() {
               Ext.get('${prefix}Content').dom.value=editor.getValue();
               win.destroy();
               ${prefix}saveScript();
            }
        },{
            text: 'Cancel',
            handler: function() {
                win.destroy();
            }
        }]
    });
    win.show();
    var editor = ace.edit('${prefix}customizationSource');
    editor.setValue(viewer.getValue() , -1);
    editor.setTheme('ace/theme/' + (layoutManager.localStorage.get('ace/theme/') ? layoutManager.localStorage.get('ace/theme/') : 'chrome'));
    editor.getSession().setMode(langMode);
    var resize=function() {
        $('#${prefix}customizationSource').height(win.getHeight() - 100);
        editor.resize();
    };
    win.on('resize',resize);
    resize();
  }
         
//]]>
</script>
  </c:otherwise>
</c:choose>