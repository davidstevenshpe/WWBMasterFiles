<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage" var="serverMsg" />

<div class="EA-right-panel">
             <h3 style="font-size:16px"><fmt:message key="registryServer.title"  bundle="${serverMsg}"/></h3>

<table style="margin-left:auto; margin-right:0px;">
      <c:choose>
          <c:when test="${hasCredential}">
              <tr>
                  <th class="UI Label Inline" ><fmt:message key="registryServer.view.user_field.label" bundle="${serverMsg}"/>:</th>
                  <td ><c:out value="${regCredentialBean.userName}"/></td>
              </tr>  
              <c:if test="${not empty regCredentialBean.operationName}">
                  <tr>
                      <th class="UI Label Inline"><fmt:message key="registryServer.view.operation_field.label" bundle="${serverMsg}"/>:</th>
                      <td><c:out value="${regCredentialBean.operationName}"/></td>
                  </tr>  
              </c:if>
              <tr>
                  <td >
                       <syswf:component name="/admin/server/editRegistryCredential" prefix="editRegistryCredentialPrefix">
                            <syswf:param name="artifact" value="${artifact}"/>
                            <syswf:param name="styleClass">UI PageAction Edit</syswf:param>
                            <syswf:param name="winTitle"><fmt:message key="registryServer.edit.dialog.title" bundle="${serverMsg}"/></syswf:param>
                            <syswf:param name="label"><fmt:message key="registryServer.edit.label" bundle="${serverMsg}"/></syswf:param>
                       </syswf:component>
                  </td>
                  <td>
                       <syswf:component name="/admin/server/removeRegistryCredential" prefix="removeRegistryCredentialPrefix">
                            <syswf:param name="artifact" value="${artifact}"/>
                       </syswf:component>
                  </td>
              </tr>
             
          </c:when>
          <c:otherwise>
             <tr>    
	            <td colspan="2">
	                <div class="UI SystemMessage Info">
	                    <div class ="Offset">
	                        <label class ="UI Icon Info"><fmt:message key="registryServer.create.info" bundle="${serverMsg}"/></label>
	                    </div>
	                </div>
	            </td>
	        </tr>
                 <tr>    
                     <td colspan="2">
                         <syswf:component name="/admin/server/editRegistryCredential" prefix="createRegistryCredentialPrefix">
                               <syswf:param name="artifact" value="${artifact}"/>
                               <syswf:param name="styleClass">UI Icon Add</syswf:param>
                               <syswf:param name="label"><fmt:message key="registryServer.create.label" bundle="${serverMsg}"/></syswf:param>
                               <syswf:param name="winTitle"><fmt:message key="registryServer.create.dialog.title" bundle="${serverMsg}"/></syswf:param>
                         </syswf:component>
                     </td>
                 </tr>
                </c:otherwise>
      </c:choose>
</table>
</div>  
