<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages"
	var="viewProfile_Messages" />
<fmt:message var="primaryGroupLabel" key="viewProfile.default_security.primary_group.label" bundle="${viewProfile_Messages}" />
<fmt:message var="defaultDomainLabel" key="viewProfile.default_security.default_domain.label" bundle="${viewProfile_Messages}" />
<fmt:message var="defaultDomainChangeLink" key="viewProfile.default_security.default_domain.change_link" bundle="${viewProfile_Messages}" />

<fmt:message key="editUsers.setUserDefaultDomain_title" bundle="${viewProfile_Messages}" var="select_title"/>
<fmt:message key="viewProfile.access_security.title" bundle="${viewProfile_Messages}" var="access_security_title"/>

<c:if test="${isAccount}">
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3>
                <span><syswf:out value="${access_security_title}" context="HtmlBody"/></span>
            </h3>
        </div>

    	<syswf:component name="/admin/common/domainSelector" prefix="defaultDomain">
        	<syswf:param name="artifact" value="${artifact}" />
        	<syswf:param name="windowTitle" value="${select_title}" />
        	<syswf:param name="jsOpenFunction" value="${prefix}openDomainWindow" />
        	<syswf:param name="holder" value="${changeDefaultDomainHolder}" />
        	<syswf:param name="actionMode" value="script" />
    	</syswf:component>
    	<table>
    	    <tbody>
    	        <tr>
    	        	<th class="media-middle"><label class="UI Label Inline"><syswf:out value="${primaryGroupLabel}" context="HtmlBody"/>:</label></th>
    	        	<td>
    		            <syswf:component name="/admin/user/security/primaryGroup" prefix="primaryGroup">
    		                <syswf:param name="artifact" value="${artifact}" />
    		                <syswf:param name="isReadOnly" value="${isReadOnly}" />
    		            </syswf:component>
    	            </td>
    	        </tr>
    	        <tr>
    	            <th><label class="UI Label Inline"><syswf:out value="${defaultDomainLabel}" context="HtmlBody"/>:</label></th>
    				<td>
    					<c:if test="${not empty defaultDomain}">
	   					<span class="IconAlign">
	    	                <syswf:component name="/admin/common/domainLink" prefix="defaultDomainLink" wrap="false">
	    	                	<syswf:param name="domain" value="${defaultDomain}" />
	    	                </syswf:component>
	    	            </span>
    					</c:if>
    	                <c:if test="${not isReadOnly}">
    	                   <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}_changeDefaultDomain">${defaultDomainChangeLink}</a>
                           <script type="text/javascript">
                           //<![CDATA[

                                Ext.onReady(function(){
                                    attachOn('${prefix}_changeDefaultDomain','click',function() {
                                        ${prefix}openDomainWindow();
                                    });
                                });
                            
                           //]]>
                           </script>
                        </c:if>
    	            </td>
    	        </tr>
    	    </tbody>
    	</table>
    
    
    </syswf:block>
</c:if>