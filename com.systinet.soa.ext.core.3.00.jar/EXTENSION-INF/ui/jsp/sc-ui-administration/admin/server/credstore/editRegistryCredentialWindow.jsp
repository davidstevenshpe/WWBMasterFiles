<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage"
    var="serverMsg" />

<c:if test="${not empty validationResult['credential']}">
<div class="UI SystemMessage Error">
    <span class="Text">${validationResult['credential']}</span> 
</div>  
</c:if>

<table class="UI Table Properties">
    <col class="LabelCol"/>
    <col/>
    <tbody>
        
           
        <tr>    
            <th>
                <label class="UI Label Inline"><fmt:message key="registryServer.dialog.username_field.label"  bundle="${serverMsg}"/>:</label>
            </th>
            <td>
                 <syswf:input id ="${prefix}_userName" name="userName" value="${regCredentialBean}" property ="userName">
                        <syswf:attribute name="class" value="UI Form Text String"></syswf:attribute>
                        <syswf:attribute name="autocomplete" value="off"/>
                 </syswf:input>
            </td>
        </tr>
           <c:if test="${not empty validationResult['username']}">
               <tr>
                   <td></td>
                   <td>
                       <em class="x-form-invalid-msg UI Invalid">
                           <span class="Comment">${validationResult['username']}</span>
                       </em>
                   </td>
               </tr>
           </c:if>
        <tr>    
            <th>
                <label class="UI Label Inline"><fmt:message key="registryServer.dialog.password_field.label"  bundle="${serverMsg}"/>:</label>
            </th>
            <td>
                <syswf:input id ="${prefix}_Password" name="password" value="${regCredentialBean}" property ="password" mode="password">
                        <syswf:attribute name="class" value="UI Form Text String"></syswf:attribute>
                        <syswf:attribute name="autocomplete" value="off"/>
                </syswf:input>
            </td>
        </tr>
        
        <c:if test="${not empty validationResult['password']}">
               <tr>
                   <td></td>
                   <td>
                       <em class="x-form-invalid-msg UI Invalid">
                           <span class="Comment">${validationResult['password']}</span>
                       </em>
                   </td>
               </tr>
           </c:if>
        
        <tr>    
            <th>
                <label class="UI Label Inline"><fmt:message key="registryServer.dialog.operation_field.label"  bundle="${serverMsg}"/>:</label>
            </th>
            <td>
                <syswf:selectOne id="${prefix}_registryOperation" name="operationValue" value="${regCredentialBean}" 
                        property="operationValue" mode="radio" optionValues="${operations}" optionValuesProperty="val"
                        optionCaptions="${operations}" optionCaptionsProperty="name"
                        displayAsRow="true" >
                        <syswf:attribute name="class" value="UI Form Checkbox" />	    
                </syswf:selectOne>
            </td>
        </tr>
    </tbody>
</table>