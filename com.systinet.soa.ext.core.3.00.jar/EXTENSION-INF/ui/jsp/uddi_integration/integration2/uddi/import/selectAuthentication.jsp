<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="hint" key="uddi.import.userHint" bundle="${l10n}"/>

<div class="Offset">
	<syswf:control mode="script" action="changeUsername" caption="${prefix}changeUsername"  loadingMask="true" affects=".">
		<syswf:param name="credentialBean" value="${credentialsBean}" />		
	</syswf:control>
	
	<table class="UI Table Properties">
		<col class="LabelCol">
		<col>
		<tBody>
			<tr>
				<td><label class="UI Label Inline"><fmt:message key="uddi.import.credentials.username" bundle="${l10n}"/></label></td>
	            <td>
	            	<span class="Comment">
		            	<syswf:selectOne mode="menu" name="username" value="${credentialsBean}" property="username" optionValues="${credentialsBean.credentialList}" optionValuesProperty="userName" optionCaptions="${credentialsBean.credentialList}" 
											optionCaptionsProperty="userName">
							<syswf:attribute name="style" value="width:100%"></syswf:attribute>											
						</syswf:selectOne>	                
		                <script type="text/javascript">
//<![CDATA[

		                    Ext.onReady(function(){
		                        var cmb = new Ext.form.ComboBox({
		                        id : 'username',
		                        transform : '${prefix}_username',
		                        listWidth : 245,
		                        width : 245,
		                        emptyText:'${hint}',
		                        disableKeyFilter : true,
		                        mode : 'local',
		                        autoHeight : true,
		                        resizable : true,
		                        triggerAction : 'all',
		                        onKeyUp : function(e) {
				                  this.assertValue();  
				                }
		                      });

		                        cmb.on('select', function() {
		                        	${prefix}changeUsername();
		                        });
		                    });
		            
		                
//]]>
</script>			                
		            </span>
 				</td>
			</tr>

			<tr>
				<td><label class="UI Label Inline"><fmt:message key="uddi.import.credentials.password" bundle="${l10n}"/></label></td>
				<td>
					<syswf:input name="password" mode="password" value="${credentialsBean}" property="uiPassword">
						<syswf:attribute name="class" value="UI Form Text String"></syswf:attribute>
                        <syswf:attribute name="autocomplete" value="off"/>
					</syswf:input>
				</td>							
			</tr>
			<c:if test="${not hideSaveCredentialOption}">
				<tr>
					<td><label class="UI Label Inline"></label></td>
					<td>
						<syswf:selectOne  id="saveCredential" name="saveCredential" value="${credentialsBean}" 
								property="saveCredential" mode="checkbox" optionValues="true" 
								dataType="boolean" optionCaptions="Save Credentials"/>   <fmt:message key="uddi.import.credentials.saveCredentials" bundle="${l10n}"/>
					</td>							
				</tr>
			</c:if>
		</tBody>
	</table>
</div>
