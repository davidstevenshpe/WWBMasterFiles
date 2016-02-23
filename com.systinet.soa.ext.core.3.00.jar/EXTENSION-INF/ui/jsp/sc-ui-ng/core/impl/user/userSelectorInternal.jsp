<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
    holder - 
    creationListener - 
-->

<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.user.userMessages" var="userMessages"/>
    
    
<fmt:message var="searchLabel" key="Search" bundle="${messages}"/>
<fmt:message var="browseAddressbookLabel" key="userSelector.browseAddressbook" bundle="${userMessages}"/>
<fmt:message var="searchScopeLabel" key="userSelector.searchScope" bundle="${userMessages}"/>
<fmt:message var="search" key="userSelector.select" bundle="${userMessages}"/>
<fmt:message var="addContactDialogCreateNewContactLinkLabel" key="addContactDialogCreateNewContactLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewUserProfileLinkLabel" key="addContactDialogCreateNewUserProfileLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewOrgUnitLinkLabel" key="addContactDialogCreateNewOrgUnitLinkLabel" bundle="${contactmessages}"/>

<script type="text/javascript">
//<![CDATA[

    ${prefix}_comboDestroyer = function(combo) {
        combo.collapse();
        combo.destroy();
    }

    ${prefix}NameRenderer = function(value, metaData, record, rowIndex, colIndex, store) {
        var iconType = record.get("icon");
        if(iconType == 'personArtifact') {
			return '<span class="UI Icon Contact">'+value+'</span>';
        }

        if(iconType == 'organizationUnitArtifact') {
			return '<span class="UI Icon OrganizationUnit">'+value+'</span>';
        }
    	return value;
    }
    

//]]>
</script>


<table class="UI Layout">
    <colgroup>
        <col />
        <col class="SearchFormButton"/>
    </colgroup>
    <tr>
        <td>
        
        
        
        
             <syswf:control id="${prefix}MoreResults" mode="script" action="search" caption="${prefix}MoreResults" affects="." />
        
            <syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch">
                <syswf:param name="customizationId" value="shared.userSelector.suggestedSearch" />
                <syswf:param name="cssOfInput" value="LongStr" />
                <syswf:param name="afterSelectCallback" value="${prefix}_comboDestroyer" />
                <syswf:param name="selectionListener" value="${selectionListener}" />
                <syswf:param name="value" value="${userSelectorHolder}"/>
                <syswf:param name="fictiveLineControlName" value="${prefix}MoreResults" />
                <syswf:param name="fictiveLineListener" value="${fictiveLineListener}"/>
                <syswf:param name="fictiveLineColumnName" value="name"/>
                <syswf:param name="nameRenderer" value="${prefix}NameRenderer"/>
            </syswf:component>
        </td>
        <td>
            <syswf:control mode="postAnchor" action="search" caption="${searchLabel}" affects=".">
                <syswf:attribute name="class" value="Button" />
            </syswf:control>
            
            
        </td>
    </tr>
</table>
<br/>
<br/>

<c:choose>
    <c:when test="${userSelectorHolder.tab eq 'hidden'}">
        <syswf:control mode="postAnchor" id="${prefix}BrowseAddressbook" action="search" caption="${browseAddressbookLabel}" affects="."/>    
    </c:when>

    <c:otherwise>
        <syswf:control mode="ajax" id="${prefix}ChangeScope" action="changeTab" caption="${prefix}ChangeScope"/>
        <table class="UI Table Properties">
            <colgroup>
                <col class="MidLabelCol"/>
                <col/>
            </colgroup>
            <tbody>
                <tr>
                    <th>
                        <label for="${prefix}ChangeScope" class="UI Label">${searchScopeLabel}</label>
                    </th>
                    <td>                        
                        <syswf:selectOne id="${prefix}ChangeScope" name="${prefix}ChangeScope" value="${userSelectorHolder}" property="tab" mode="radio" optionValues="${scopeValues}" optionCaptions="${scopeCaptions}"  displayAsRow="true">
                            <syswf:attribute name="onClick">
                                ${prefix}ChangeScope();
                            </syswf:attribute>
                        </syswf:selectOne>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <c:choose>
            <c:when test="${userSelectorHolder.tab eq 'localPersons' or userSelectorHolder.tab eq 'localOrgUnits' }">
                <syswf:component name="/core/selector/userSelectorLocal" prefix="${prefix}Local">
                    <syswf:param name="userSelectorHolder" value="${userSelectorHolder}" />
                </syswf:component>
            </c:when>
            <c:when test="${userSelectorHolder.tab eq 'global'}">
                <syswf:component name="/core/selector/userSelectorGlobal" prefix="${prefix}Global">
                    <syswf:param name="userSelectorHolder" value="${userSelectorHolder}" />
                </syswf:component>
            </c:when>
        </c:choose>
    
    </c:otherwise>
</c:choose>

<br/>
<br/>
            
<div class="x-hidden flyout-menu UI Dropdown" id="${prefix}create_contact_content">
    <div class="DropdownContent">
        <syswf:control id="createNewOrganizationalUnit" mode="anchor" caption="${addContactDialogCreateNewOrgUnitLinkLabel}" hint="" targetTask="/${viewId}/newArtifact">
            <syswf:attribute name="class" value="UI Icon New"/>
            <syswf:param name="sdmName" value="organizationUnitArtifact"/>
            <syswf:param name="creationListener" value="${creationListener}"/>
        </syswf:control>
        <br/>
        <syswf:control id="createNewUserProfile" mode="anchor" caption="${addContactDialogCreateNewUserProfileLinkLabel}" hint="" targetTask="/${viewId}/newArtifact">
            <syswf:attribute name="class" value="UI Icon New"/>
            <syswf:param name="sdmName" value="personArtifact"/>
            <syswf:param name="creationListener" value="${creationListener}"/>
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