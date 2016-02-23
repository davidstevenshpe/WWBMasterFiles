<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage"
    var="serverMsg" />
<c:if test="${isEnable}">
    <table class="UI Table Properties">
	    <col class="LabelCol">
	    <col>
	    <tr>
	        <th></th>
	        <td>
	            <syswf:selectOne  id="saveCredential" name="saveCredential" value="${serverBean}" 
	                   property="saveCredential" mode="checkbox" optionValues="true" 
	                   dataType="boolean" optionCaptions="">
	                   <syswf:attribute name="class" value="UI Form Checkbox" />
               </syswf:selectOne>&nbsp;<fmt:message key="server.save_credential.label"  bundle="${serverMsg}"/>
	        </td>
	    </tr>
    </table>
</c:if>
