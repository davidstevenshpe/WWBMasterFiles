<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="messages"/>
<fmt:message var="dialogDesc" key="WEBDAV_OPENINOFFICE_DIALOG_DESC" bundle="${messages}"/>
<fmt:message var="dialogTitle" key="WEBDAV_OPENINOFFICE_DIALOG_TITLE" bundle="${messages}"/>
<fmt:message var="dialogUnSupportPlatform" key="WEBDAV_OPENINOFFICE_DIALOG_UnSupportPlatform" bundle="${messages}"/>
<fmt:message var="dialogUnSupportBrowsers" key="WEBDAV_OPENINOFFICE_DIALOG_UnSupportBrowsers" bundle="${messages}"/>
<fmt:message var="dialogNotFoundPlugins" key="WEBDAV_OPENINOFFICE_DIALOG_NotFoundPlugins" bundle="${messages}"/>
<fmt:message var="dialogDownload" key="WEBDAV_OPENINOFFICE_DIALOG_DOWNLOAD_LABEL" bundle="${messages}"/>
<fmt:message var="dialogOK" key="WEBDAV_OPENINOFFICE_DIALOG_OK_LABEL" bundle="${messages}"/>
<fmt:message var="disabledPlugins" key="WEBDAV_OPENINOFFICE_DisabledPlugin" bundle="${messages}"/>

<c:if test="${empty label}" >
    <fmt:message var="label" key="WEBDAV_OPENINOFFICE_LABEL" bundle="${messages}"/>
</c:if>

<c:if test="${not common}"><%-- for compatibility with legacy versions --%>
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction OpenOffice</c:set>
  <c:set var="linkText" value="${label}"/>
</c:if>
<c:if test="${common}"><%-- context buttons displayed at top content --%>
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button OpenOffice</c:set>
  <c:set var="linkText">&#160;</c:set>
</c:if>

<c:if test="${empty styleClass}" >
    <c:set var="styleClass" value="${linkClassName}" />
</c:if>

<c:if test="${not empty officeLinkClass}" >
    <c:set var="blockClassName" value="${officeLinkClass}" />
</c:if>

<div id="${prefix}openInOfficePlugin" style="width: 0px; height: 0px">
</div>

<div id="${prefix}msgbox_source" class="x-hidden">
    <div class="x-window-header">
    	<div  id="${prefix}msgbox_info"></div>
    </div>
    <div class="x-window-body">
    	<div class="UI ClientMessage Warning">
			<div class="MessageContainer Icon Warning" title="MessageContainer Icon Warning">
				<div class="Text">
					<div style="padding-left: 15px">
						${dialogDesc}		
					</div>
		        </div>
			</div>
		</div>    
    </div>
</div>
                
<script type="text/javascript">
//<![CDATA[
		function ${prefix}msgWindowOpen(infoMsg) {
			document.getElementById('${prefix}msgbox_info').innerHTML='${dialogTitle} - ' + infoMsg;
            SPopup.Window.forceOpen('${prefix}msgbox','${prefix}msgbox_source',{
                autoScroll: true,
                width: 425,
                height: 225,
                resizable:true,
                centerOnScreen:true,
                plain:false,
                buttonAlign:'center',
                closable:false,
                buttons:[{
                    text:'${dialogOK}',
                    handler:function(){SPopup.Window.Instance['${prefix}msgbox'].hide();}
                }
                ]});
		};       
//]]>
</script>
<c:choose>
	<c:when test="${this.permissions.write && this.openWithOffice}">
	<div class="${blockClassName}" id="${prefix}_linkWrapper">
		<a id="${prefix}locationUrl" href="javascript:void(0);" title="${label}">${linkText}
		<script type="text/javascript">
	      //<![CDATA[
                 	var isPlatformSupport = false;
                 	var installedPlugin = false;
               	 	if (Ext.isWindows) {
                		if (Ext.isIE) {
							if(Ext.isIE7) {
	                    		 document.getElementById('${prefix}locationUrl').setAttribute('className','${styleClass}');
	                    	 } else {
	                    		 document.getElementById('${prefix}locationUrl').setAttribute('class','${styleClass}');
	                    	 }
	                    	 isPlatformSupport = true;
	                	 } else if (Ext.isGecko || Ext.isChrome) {
	                		 document.getElementById('${prefix}locationUrl').setAttribute('class','${styleClass}');
	                		 L = navigator.plugins.length;
	                		 for(var i=0; i<L; i++) {
	                			 if (navigator.plugins[i].filename == '${this.pluginFilename}') {
	                				 installedPlugin = true;
	                				 document.getElementById('${prefix}openInOfficePlugin').innerHTML='<object id="${prefix}officePlugin" type="application/x-sharepoint" width="0" height="0" style="visibility: hidden;"></object>';
	                				 break;
	                			 }
	                		 }
	                		 isPlatformSupport = true;
	                	 } else {
	                		 document.getElementById('${prefix}locationUrl').setAttribute('class','${styleClass}');
	                	 }
	                 } else {
	                	 document.getElementById('${prefix}locationUrl').setAttribute('class','${styleClass}');                	 
	                 }
	                 //]]>
	                 </script> </a>
	</div>
		<script type="text/javascript">
	      //<![CDATA[
	                 Ext.onReady(function() {
	                	 moveWindow("${prefix}msgbox_source", "popupWindows");
	                     Ext.get('${prefix}locationUrl').on('click', function() {
	                    	 if (isPlatformSupport) {
	                        	 OfficePlugin = 0;
	                        	 if (Ext.isIE) {
	                        		 try {
	                        			 OfficePlugin = new ActiveXObject('${this.activeXId}');
	                        		 } catch (e) {
	                        			 OfficePlugin = 0;
	                        			 ${prefix}msgWindowOpen('${dialogNotFoundPlugins}');
	                        		 }
	                        	 } else if (Ext.isGecko || Ext.isChrome) {
	                        		 if (installedPlugin) {
	                        			 OfficePlugin = document.getElementById('${prefix}officePlugin');
	                        		 } else {
	                        			 ${prefix}msgWindowOpen('${dialogNotFoundPlugins}');                     			 
	                        		 }
	                        	 }
	                             if (OfficePlugin) { 
	                            	if (Ext.isIE) {
	                            		editorExists = OfficePlugin.EditDocument('${this.locationUrl}', '${this.editorId}');
	                            	} else {
	                            	 if (OfficePlugin.EditDocument) {
 	                            		 editorExists = OfficePlugin.EditDocument('${this.locationUrl}', '${this.editorId}');
	                            	  } else {
	                            		  Ext.Msg.show({
	                                          msg: '${disabledPlugins}',
	                                          modal: true,
	                                          icon: Ext.Msg.WARNING,
	                                          buttons: Ext.Msg.OK
	                                      });
	                            	  }
	                            	}
	                             }                    		 
	                    	  } else {
	                    		  ${prefix}msgWindowOpen('${dialogUnSupportPlatform}');     		  
	                    	  }
	                    	 return false;
	                     });
	                 });                 
	      //]]>
        </script>
	</c:when>
	<c:when
		test="${not this.permissions.write && not empty clickToDownloadLink}">
		<c:out value="${clickToDownloadLink}" escapeXml="false" />
	</c:when>
</c:choose>