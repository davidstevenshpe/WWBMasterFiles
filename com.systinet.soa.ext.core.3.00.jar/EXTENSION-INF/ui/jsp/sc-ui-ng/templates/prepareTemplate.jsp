<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:if test="${not empty scriptLocation and not empty artifact and empty artifact.repositoryPackage}">
<div id="${prefix}-prepare-template-container" class="ContextAction">
</div>
<c:set var="proposalAutoTemplateMessage">
<c:choose>
    <c:when test="${not empty message}">
        ${message}
    </c:when>
    <c:otherwise>
        <fmt:message bundle="${messages}" key="proposal.template.prepare.message" />
    </c:otherwise>
</c:choose>
</c:set>
<c:set var="proposal_template_prepare">
<fmt:message bundle="${messages}" key="proposal.template.prepare" />
</c:set>
<c:set var="proposal_package_create_label">
<fmt:message bundle="${messages}" key="proposal.package.create.label" />
</c:set>
<c:set var="proposal_package_create_input">
<fmt:message bundle="${messages}" key="proposal.package.create.input" />
</c:set>
<c:set var="proposal_package_create_input_empty">
<fmt:message bundle="${messages}" key="proposal.package.create.input.empty" />
</c:set>
<script type="text/javascript">
//<![CDATA[
Ext4.onReady(function() {
    var prepareTemplateLoader = Ext4.create('EA.model.PrepareTemplateLoader', {
        renderTo: '${prefix}-prepare-template-container',
        config:{
            message: '${proposalAutoTemplateMessage}',
            scriptLocation: '${scriptLocation}',
            scriptMethodName: '${scriptMethodName}'
        },
        bbar: {
            style: 'border:0;background-color:#fcf7e2;color:#000;padding-right:16px',
            items:[
              { 
                    xtype: 'component',
                    html:'<div style="padding-bottom:6px">${proposal_package_create_label}</div><input type="text" placeHolder="${proposal_package_create_input}" id="${prefix}-prepare-template-package-input"/><span id="${prefix}-prepare-template-package-warn" class="x-form-invalid-msg" style="display:none" title="must not be empty">&nbsp;</span>',
                    flex: 1
               },
               {
                    xtype: 'button', 
                    text: '${proposal_template_prepare}',
                    listeners: {
                     click: function() {
                         var packageField = $('#${prefix}-prepare-template-package-input');
                         var packageFieldVal = packageField.val();
                         if(packageFieldVal != '') {
                             packageFieldVal = packageFieldVal.trim();
                             packageFieldVal = packageFieldVal.replace(/\s{2,}/g, ' ');
                             packageField.removeClass('x-form-invalid');
                             $('#${prefix}-prepare-template-package-warn').hide();
                             prepareTemplateLoader.prepare({
                                artifactUuid: '${artifact._uuid}',
                                artifactName: escape('<syswf:out value="${artifact.name}" context="HtmlJSText"/>'),
                                packageName: escape(packageFieldVal)
                            });
                         } else {
                             packageField.addClass('x-form-invalid');
                             $('#${prefix}-prepare-template-package-warn').html('').show();
                         }
                     }
                 }
               }
            ]
        },
        listeners: {
            failedExecution: function(error) {
                $('#${prefix}-prepare-template-package-warn').html(error).show();
            },
            passedExecution: function() {
                $('#${prefix}-prepare-template-package-warn').html('${proposal_package_create_input_empty}').hide();
            }
        }
    });
});
//]]>
</script>
</c:if>
