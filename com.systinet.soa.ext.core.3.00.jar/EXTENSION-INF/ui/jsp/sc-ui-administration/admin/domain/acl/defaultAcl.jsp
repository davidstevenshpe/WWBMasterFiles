<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<div class="flex-container">
    <div style="flex-grow:1;" class="UI Middle">
        <table class="UI Layout">
            <tbody>
                <tr>
                    <td class="UI Middle">
                        <syswf:component name="/admin/domain/acl/browseRule" prefix="creationRule">
                             <syswf:param name="ruleType">Create</syswf:param>                                          
                             <syswf:param name="domainId">${domainId}</syswf:param>
                        </syswf:component>
                        <syswf:component name="/admin/domain/acl/browseRule" prefix="accessRule">
                             <syswf:param name="ruleType">Access</syswf:param>
                             <syswf:param name="domainId">${domainId}</syswf:param>                             
                        </syswf:component>              
                    </td>
                </tr>
            </tbody>
        </table>    
    </div>
</div>

