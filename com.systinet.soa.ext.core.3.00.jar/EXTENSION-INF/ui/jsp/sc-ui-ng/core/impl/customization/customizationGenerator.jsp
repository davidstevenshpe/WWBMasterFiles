<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cust_Message"/>

<%-- Get Message --%>
<fmt:message key="generate_artifact_ui" var="generate_artifact_caption" bundle="${cust_Message}"/>
<fmt:message key="generate" var="generate_caption" bundle="${cust_Message}"/>
<fmt:message key="generate_artifact_type" var="artifat_type_caption" bundle="${cust_Message}"/>
<fmt:message key="generate_browse" var="browse_caption" bundle="${cust_Message}"/>
<fmt:message key="generate_view" var="view_caption" bundle="${cust_Message}"/>
<fmt:message key="generate_edit" var="edit_caption" bundle="${cust_Message}"/>
<fmt:message key="generate_new" var="new_caption" bundle="${cust_Message}"/>
<fmt:message key="generate_view_type" var="view_caption" bundle="${cust_Message}"/>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span>${generate_artifact_caption}</span></h3>
    </div>
    <div class="Content">

        ${artifat_type_caption}: <syswf:selectOne name="artifactType" value=""
                         optionValues="${availableArtifacts}" optionValuesProperty="sdmName"
                         optionCaptions="${availableArtifacts}" optionCaptionsProperty="label" mode="menu"/>
        ${view_caption}: <syswf:selectOne name="viewType" value=""
                         optionValues="${availableViews}" optionValuesProperty="sdmName"
                         optionCaptions="${availableViews}" optionCaptionsProperty="label" mode="menu"/>

        <syswf:selectMany name="pageType" value="viewPage" optionValues="browsePage,viewPage,editPage,newPage"
                          optionCaptions="${browse_caption},${view_caption},${edit_caption},${new_caption}"
                          mode="checkbox"/>

        <div class="UI Form Controls">
            <syswf:control mode="postAnchor" caption="${generate_caption}" action="generateCustomizations">
                <syswf:attribute name="class" value="Button Confirm"/>
                <syswf:attribute name="type" value="button"/>
            </syswf:control>
            <syswf:control mode="postAnchor" caption="Generate Provider UI" hint="Generates UI for all artifact visible in provider tab. This is feature for DEVELOPMENT only." action="generateAll">
                <syswf:attribute name="class" value="Button Confirm"/>
                <syswf:attribute name="type" value="button"/>
            </syswf:control>
        </div>
    </div>
</syswf:block>