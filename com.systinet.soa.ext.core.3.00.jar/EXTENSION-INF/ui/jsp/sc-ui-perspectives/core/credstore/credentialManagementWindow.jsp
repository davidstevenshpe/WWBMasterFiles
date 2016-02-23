<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.credstore.credstoremessages" var="credstore_Messages"/>
<fmt:message var="winTitle" key="credstore.edit_credential.dialog.title" bundle="${credstore_Messages}" />

<table class="UI Table Properties">
    <tbody>
    	<tr>
            <td>
            	<div class ="MessageContainer">
            		<label class="UI Icon Info"><fmt:message key="credstore.saved_passwords.dialog.messagehelper" bundle="${credstore_Messages}" /></label>
            	</div>
            </td>
        </tr>
        <tr>
            <td>
                <syswf:component name="/core/credstore/editCredential" prefix="editCredentialPrefix">
				    <syswf:param name="openDialogFunction" value="${prefix}openDialogFunction" /> 
                    <syswf:param name="winTitle" value="${winTitle}" />
				</syswf:component>
                
            	<syswf:component name="/core/table" prefix="browseUserCredentials" wrap="true">
			        <syswf:param name="customizationId" value="credstore.tableUserCredentials" />
			        <syswf:param name="openDialogFunction" value="${prefix}openDialogFunction" />
			    </syswf:component>
            </td>
        </tr>
    </tbody>
</table> 
