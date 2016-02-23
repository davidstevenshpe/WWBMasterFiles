<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="display:none">
    <syswf:control mode="script" action="updateScript" caption="${prefix}saveScript">
    </syswf:control>
    <syswf:textArea name="${prefix}textEditorContent" value="${this}" property="script" id="${prefix}Content"
                    escapeXml="false"/>
    <syswf:input name="${prefix}uuid" value="${this}" property="uuid" id="${prefix}Uuid"/>
</div>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>
<fmt:message var="warningMessage" key="editSurveyManagementScriptWarning" bundle="${bundle}"/>

<syswf:component name="/core/window" prefix="dw">
	<syswf:param name="winComponent" value="/core/impl/bulk/warningWindow" />
	<syswf:param name="winTitle" value="Confirm Script Editing"/>
	<syswf:param name="winOpenFunctionName" value="showWarningDialog" />
	<syswf:param name="warningMessage" value="${warningMessage}" />					
	<syswf:param name="winOkAction" value="OkClick" />
	<syswf:param name="winWidth">500</syswf:param>			
	<syswf:param name="winButtonAlign">center</syswf:param>			
</syswf:component>		

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="checkEditSurveyDefinition"/>
  <syswf:param name="code">
    function checkEditSurveyDefinition(uuid) {
        return Packages.com.hp.systinet.sc.impl.customization.ScriptEditorComponent.getInstance().checkEditSurveyDefinition(uuid);
    }
  </syswf:param>
</syswf:component>

<script>
    //<![CDATA[
	 var tmpScriptLocation, tmpScriptLanguage, tmpUuid;
	 openScriptEditorWithWarning=function(scriptLocation, scriptLanguage, uuid) {
        tmpScriptLocation = scriptLocation;
		tmpScriptLanguage = scriptLanguage;
		tmpUuid = uuid;	 
        checkEditSurveyDefinition(uuid,function(result){
			if(result ==  'true'){
				showWarningDialog();
			}else{
				openScriptEditor(tmpScriptLocation, tmpScriptLanguage, tmpUuid);
			}
		});	
	 };		 

    OkClick = function() {	
		openScriptEditor(tmpScriptLocation, tmpScriptLanguage, tmpUuid);
	};

    openScriptEditor = function (scriptLocation, scriptLanguage, uuid) {
    	var lang = (scriptLanguage ? scriptLanguage.toLowerCase() : 'html');
    	if(lang == 'javascript') {
    		lang = 'typescript';
    		//TODO javascript/typescript check
    	}
    	var langMode = 'ace/mode/' + lang;
	
	    var win = new Ext4.Window({
	          title: 'Edit script',
	          layout: 'fit',
	          height: 600,
	          modal: true,
	          maximizable: true,
	          width: 800,
	          html:'<pre id="${prefix}customizationSource" style="font-size: 13px" class="code-editor"></pre>',
	          buttons: [{
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
	 	}]});
		var editor;
        var isUsingNewJQuery = $.fn.jquery > "2";
        var jsOrXmlType = scriptLocation!=null && (scriptLocation.indexOf(".js") > -1 || scriptLocation.indexOf(".xml") > -1);
        var ajaxRequest = $.ajax({
            url: SERVER_URI + '/../../../platform/rest/location' + scriptLocation,
            dataType: (isUsingNewJQuery || !jsOrXmlType)? "text": null,
            success: function (store) {
                Ext.get('${prefix}Content').dom.value = store;
                Ext.get('${prefix}Uuid').dom.value = uuid;
                win.show();
			    editor = ace.edit('${prefix}customizationSource');
			    editor.setValue(Ext.get('${prefix}Content').dom.value , -1);
				editor.setTheme('ace/theme/' + (layoutManager.localStorage.get('ace/theme/') ? layoutManager.localStorage.get('ace/theme/') : 'chrome'));
				editor.getSession().setMode(langMode);
				var resize=function() {
			    	$('#${prefix}customizationSource').height(win.getHeight() - 100);
			    	editor.resize();
			    };
			    resize();
			    win.on('resize',resize);
            },
            error: function (e) {
                console.log((!!e.stack)? e.stack : e);
            }
        });
        //ajaxRequest.fail(function(jqXHR, textStatus) { console.log("Request failed: " + textStatus); });
    }
    //]]>
</script>

