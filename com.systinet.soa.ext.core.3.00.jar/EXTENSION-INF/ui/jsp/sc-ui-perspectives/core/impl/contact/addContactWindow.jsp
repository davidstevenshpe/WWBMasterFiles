<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="addContactDialogSuggestSearchLegend" key="addContactDialogSuggestSearchLegend" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewContactLinkLabel" key="addContactDialogCreateNewContactLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewUserProfileLinkLabel" key="addContactDialogCreateNewUserProfileLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewOrgUnitLinkLabel" key="addContactDialogCreateNewOrgUnitLinkLabel" bundle="${contactmessages}"/>

<syswf:component name="/core/search/suggestedSearch" prefix="${useType}_suggestedSearch">
    <syswf:param name="customizationId" value="${customizationId}"/>
    <syswf:param name="value" value="${searchExpressionWrapper}"/>
    <syswf:param name="selectionListener" value="${listener}"/>
    <syswf:param name="cssOfInput" value="LongStr" />
</syswf:component>       
<sub>${addContactDialogSuggestSearchLegend}</sub>       
<hr/>
            
<div class="x-hidden flyout-menu UI Dropdown" id="${prefix}create_contact_content">
    <div class="DropdownContent">
        <syswf:control id="createNewOrganizationalUnit" mode="anchor" caption="${addContactDialogCreateNewOrgUnitLinkLabel}" hint="" targetTask="/${viewId}/newArtifact">
            <syswf:attribute name="class" value="UI Icon New"/>
            <syswf:param name="sdmName" value="organizationUnitArtifact"/>
            <syswf:param name="creationListener" value="${listener}"/>
        </syswf:control>
        <br/>
        <syswf:control id="createNewUserProfile" mode="anchor" caption="${addContactDialogCreateNewUserProfileLinkLabel}" hint="" targetTask="/${viewId}/newArtifact">
            <syswf:attribute name="class" value="UI Icon New"/>
            <syswf:param name="sdmName" value="personArtifact"/>
            <syswf:param name="creationListener" value="${listener}"/>
        </syswf:control>                                        
    </div>
</div>
                                  
<a href="javascript:void(0)" id="${prefix}createNewContact" class="UI Dropdown Right">
    <span>${addContactDialogCreateNewContactLinkLabel}</span>
</a>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){ 
        Dropdown.init('${prefix}createNewContact','${prefix}create_contact_content',{align:'tl-tr?'}); 
    });

//]]>
</script>
