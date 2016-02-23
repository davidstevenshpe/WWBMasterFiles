<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages"
	var="common_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages"
	var="system_Messages" />
	
<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}importPropertyWindow" class="x-hidden">
        <div class="x-window-header"><fmt:message key="systemsettings.listProperties.action.import.dialog.header" bundle="${system_Messages}"/></div>
        <div class="x-window-body">
          	<table class="UI Table Properties FileUpload">
			    <colgroup>
			        <col width="15%"/>
			        <col />
			    </colgroup>
			    <tbody>
			         <tr>
			             <th>
			                 <label class="UI Label Inline"><fmt:message key="systemsettings.listProperties.action.import.dialog.file_field" bundle="${system_Messages}"/>:</label>
			             </th>
			             <td>
			                 <syswf:input id="${prefix}_localFile" name="uploadFileName" mode="file" value=""  hint="" >
			                       <syswf:attribute name="size" value="45"/>
	                               <syswf:attribute name="class" value="UI Form FileInput"/>
			                 </syswf:input>
				         </td>
			         </tr>
			    </tbody>
			</table>
        </div>
    </div>
</div>
<c:if test="${empty customButtons}">
	<c:set var="customButtons">
	    [{
	        text     : '<fmt:message key="OK" bundle="${common_Messages}"/>',
	        disabled : false,
	        handler  : function() {
	            SPopup.Window.Instance['${prefix}importPropertyWindow'].hide();
	            ${prefix}importZip();
	        },
	        id: '${prefix}_saveButton'
	    },
	    {
	        text     : '<fmt:message key="Cancel" bundle="${common_Messages}"/>',
	        handler  : function(){
	            SPopup.Window.Instance['${prefix}importPropertyWindow'].hide();
	            return false;
	        },
	        id: '${prefix}_cancelButton'
	    }]
	</c:set>
</c:if>


<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="importZip" caption="${prefix}importZip" />


<script type="text/javascript">
//<![CDATA[


<%-- Popup window needs to be reinitialized on AJAX update --%>
var ${controlName} = function() {
	SPopup.Window.forceOpen('${prefix}importPropertyWindow','${prefix}importPropertyWindow',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 430, resizable: false, centerOnScreen: true
    });
}


//]]>
</script>
