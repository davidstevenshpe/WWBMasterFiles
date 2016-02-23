<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages"
	var="common_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages"
	var="system_Messages" />
<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}confirm_window" class="x-hidden">
        <div class="x-window-header"><syswf:out value="${dialog_title}" context="HtmlBody"/></div>
        <div class="x-window-body">
            <div class="UI Offset">
            	<table class="UI Table Properties FileUpload">
				    <colgroup>
				        <col class="LabelCol" />
				        <col />
				    </colgroup>
				    <tbody>
				    	
				    	<tr>
				        	<th>
				                <label class="UI Label Inline"><fmt:message key="systemsettings.properties.domain.label" bundle="${system_Messages}"/>:</label>
				            </th>
				        	<td>
								<syswf:component name="/admin/configuration/system/action/selectDomainLinker" prefix="selectDomainLinkerPrefix">
				            		<syswf:param name="holder" value="${domainHolder}"/>
				            		<syswf:param name="propertyBean" value="${propertyBean}"/>
				            	</syswf:component>
				            </td>
				        </tr>
				        <tr>
				        	<th>
				                <label class="UI Label Inline"><fmt:message key="systemsettings.properties.name.label" bundle="${system_Messages}"/>:</label>
				            </th>
				            <td>
				            	<syswf:input id ="${prefix}_name_input" name="name" value="${propertyBean}" property="name" mode ="text">
				            		<syswf:attribute name="size" value="49"/>
				            		<syswf:attribute name="class" value="UI Form Text String"/>
				            	</syswf:input>
				            	
				            </td>
				        </tr>
				        <c:choose>
				        	<c:when test="${type eq 'file'}">
				        	     <syswf:input id="${prefix}_propertyType" name="type" mode="hidden" value="${type}" />
				        		 <tr>
						             <th>
						                 <label class="UI Label Inline" for="uploadFileName"><fmt:message key="systemsettings.properties.file.label" bundle="${system_Messages}"/>:</label>
						             </th>
						             <td>
						                 <syswf:input id="${prefix}_localFile" name="uploadFileName" mode="file" value="${propertyBean}" property="value"  hint="">
						                       <syswf:attribute name="size" value="35"/>
						                       <syswf:attribute name="class" value="UI Form FileInput"/>
					                     </syswf:input>
						             </td>
						         </tr>
				        	</c:when>
				        	<c:otherwise>
				        		<tr>
						        	<th>
						                <label class="UI Label Inline"><fmt:message key="systemsettings.properties.value.label" bundle="${system_Messages}"/>:</label>
						            </th>
						        	<td>
						            	<syswf:textArea id ="${prefix}_value_input" name="value" value="${propertyBean}" property="value">
						            	</syswf:textArea>
						            	<script type="text/javascript">
						            	//<![CDATA[

						                    var editorContent = new Ext.BoxComponent(
						                        {
						                            autoShow: true,
						                            applyTo: '<c:out value="${prefix}_value_input"/>',
						                            width: 278,
						                            height: 100
						                        }
						                    );
                                        
							            //]]>
						            	</script>
						            </td>
				        		</tr>
				        	</c:otherwise>
				        </c:choose>
				    </tbody>
				</table> 
            </div>
        </div>
    </div>
</div>
<c:if test ="${empty customButtons}">
	<c:set var="customButtons">
	    [{
	        text     : '<fmt:message key="OK" bundle="${common_Messages}"/>',
	        disabled : false,
	        handler  : function() {
	            SPopup.Window.Instance['${prefix}confirm_window'].hide();
	            ${prefix}add();
	        },
	        id: '${prefix}_okButton'
	    },{
	        text     : '<fmt:message key="Cancel" bundle="${common_Messages}"/>',
	        handler  : function(){
	            SPopup.Window.Instance['${prefix}confirm_window'].hide();
	            return false;
	        },
	        id: '${prefix}_cancelButton'
	    }]
	</c:set>
</c:if>


<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="add" caption="${prefix}add" />

<script type="text/javascript">
//<![CDATA[

	var ${controlName} = function() {
		SPopup.Window.forceOpen('${prefix}confirm_window','${prefix}confirm_window',{
	        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
	        buttonAlign: 'right', width: 430, resizable: false, centerOnScreen: true
	    });
	}
	
	Ext.onReady(function() {
	    SPopup.Window.Instance['${prefix}confirm_window'] = undefined;
	})

//]]>
</script>
