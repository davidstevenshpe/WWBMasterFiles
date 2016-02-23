<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.credstore.credstoremessages" var="credstore_Messages"/>
<table class="UI Table Properties">
     <col class="LabelCol" />
     <col />
     <tbody>
         <tr>
             <td colspan="2">
                 <div class="Left">
                     <fmt:message key="credstore.edit_credential.resourceAddress" bundle="${credstore_Messages}"/>
                     <a href="javascript:void(0);" class="UI Icon Info" id="explain_resource_address"></a>
                 </div>
                 <!-- DROPDOWN MENU -->
				<div class="x-hidden flyout-menu UI Dropdown" id="explain_resource_address_content" style="position: absolute; z-index: 1000; visibility: hidden; left: -10000px; top: -10000px;">
				    <div class="DropdownContent">
				        <p class="Comment"><fmt:message key="credstore.edit_credential.dialog.messagehelper" bundle="${credstore_Messages}" /></p>
				    </div>
				</div>
				<script type="text/javascript">
//<![CDATA[

				    Ext.onReady(function(){
				        Dropdown.init('explain_resource_address', 'explain_resource_address_content',{
				            align: 'tl-tr', forceRefresh:true, alignOffset:[0,4]
				        });
				    }); 
				
//]]>
</script>  
             </td>
         </tr>
         <c:if test="${not empty validationResult['resources']}">
              <tr>
                    <td colspan="2">
                        <em class="x-form-invalid-msg UI Invalid">
                            <span class="Comment"><syswf:out value="${validationResult['resources']}" context="HtmlBody"/></span>
                        </em>
                    </td>
              </tr>
         </c:if>
         <tr>
             <td colspan="2">
                 <syswf:input id ="${prefix}_urlPattern" name="newUrlPattern" value="${resourceCredential}" property ="newUrlPattern">
                        <syswf:attribute name="class" value="UI Form Text String"></syswf:attribute>
                 </syswf:input>
             </td>
         </tr>
         <tr>
            <td colspan="2">
		         <syswf:component name="/core/credstore/resourceAddress" prefix="urlPatternPrefix">
		             <syswf:param name="resourceCredential" value="${resourceCredential}"/>
		         </syswf:component>
            </td>
         </tr>
         <tr>
             <th>
                 <label class="UI Label Inline"> <fmt:message key="credstore.edit_credential.username" bundle="${credstore_Messages}"/>:</label>
             </th>
             <td>
                  
                  <syswf:input id ="${prefix}_username" name="userName" value="${resourceCredential}" property="userName" mode ="text" >
                         <syswf:attribute name="class" value="UI Form Text String"/>
                         <syswf:attribute name="size" value="50"/>
                         <syswf:attribute name="autocomplete" value="off"/>
                  </syswf:input>
             </td>
         </tr>
         <c:if test="${not empty validationResult['username']}">
               <tr>
                   <td></td>
                   <td>
                       <em class="x-form-invalid-msg UI Invalid">
                          <span class="Comment"><syswf:out value="${validationResult['username']}" context="HtmlBody"/></span>
                       </em>
                   </td>
               </tr>
         </c:if>
         
         <tr>
             <th>
                 <label class="UI Label Inline"><fmt:message key="credstore.edit_credential.password" bundle="${credstore_Messages}"/>:</label>
             </th>
             <td>
                 <syswf:input id="${prefix}_password" name="uiPassword" mode ="password" value="${resourceCredential}" property="uiPassword" >
                        <syswf:attribute name="class" value="UI Form Text String"/>
                        <syswf:attribute name="size" value="50"/>
                        <syswf:attribute name="autocomplete" value="off"/>
                 </syswf:input>
             </td>
         </tr>
         <c:if test="${not empty validationResult['password']}">
               <tr>
                   <td></td>
                   <td>
                       <em class="x-form-invalid-msg UI Invalid">
                           <span class="Comment"><syswf:out value="${validationResult['password']}" context="HtmlBody"/></span>
                       </em>
                   </td>
               </tr>
         </c:if>
     </tbody>
 </table> 
