<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="title" key="removeArtifactType.title" bundle="${bundle}"/>
<fmt:message var="deleteConfirmText" key="removeArtifactType.delete.confirm" bundle="${bundle}"/>
<fmt:message var="deleteTitle" key="removeArtifactType.delete.title" bundle="${bundle}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<syswf:block className="UI Block Common">
    <div class="UI Text Description"><fmt:message key="removeArtifactType.desc" bundle="${bundle}"/></div>
    
    <syswf:component name="/core/util/artifactTree" prefix="artifactTree">
        <syswf:param name="multipleHolder" value="${selectMany}"/>
        <syswf:param name="funcGetChecked" value="funcGetChecked"/>
        <syswf:param name="includedArtifacts" value="${include}"/>
        <syswf:param name="excludedArtifacts" value="${exclude}"/>      
        <syswf:param name="autoHeight" value="true"/>  
    </syswf:component>
</syswf:block>


<syswf:control mode="script" action="removeArtifactTypes" caption="${prefix}_remove" />
<syswf:input id="${prefix}_to_delete_ids" name="${prefix}_to_delete_ids" property="toDelete" value="${removeArtifactWrapper}" mode="hidden" />
<script type="text/javascript">
//<![CDATA[

function ${prefix}_submit_delete() {
    var element = Ext.get('${prefix}_to_delete_ids');
    element.dom.value = funcGetChecked();
    ${prefix}_remove();
}

//]]>
</script>

<syswf:block className="UI Block Green">
    <syswf:component name="/core/util/confirmPopUp" prefix="deletePopUp">
        <syswf:param name="winOpenFunctionName" value="${prefix}openDeleteConfirmPopUp" />
        <syswf:param name="winOkAction" value="${prefix}_submit_delete" />
        <syswf:param name="confirmMessage" value="${deleteConfirmText}" />
        <syswf:param name="title" value="${deleteTitle}" />
    </syswf:component>

    <a href="javascript:${prefix}openDeleteConfirmPopUp()" class="btn btn-primary" id="${prefix}_button_open_popup">
        <span><span><span><fmt:message key="removeArtifactType.delete.buttonCaption" bundle="${bundle}"/></span></span></span>
    </a>
</syswf:block>