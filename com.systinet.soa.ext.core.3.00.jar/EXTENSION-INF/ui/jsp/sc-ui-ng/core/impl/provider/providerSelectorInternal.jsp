
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
    holder - 
    creationListener -
    allowCreation - flag, which says if in selector should be allowed creation of contact. 
-->

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.provider.providerMessages" var="providerMessages"/>
    
    
<fmt:message var="searchLabel" key="Search" bundle="${messages}"/>
<fmt:message var="browseAddressbookLabel" key="providerSelector.browseAddressbook" bundle="${providerMessages}"/>
<fmt:message var="searchScopeLabel" key="providerSelector.searchScope" bundle="${providerMessages}"/>
<fmt:message var="createNewContactLinkLabel" key="providerSelector.createNewContactLinkLabel" bundle="${providerMessages}"/>

<script type="text/javascript">
//<![CDATA[

    ${prefix}_comboDestroyer = function(combo) {
        combo.collapse();
    }

//]]>
</script>

<table class="UI Layout">
    <colgroup>
        <col style="width:120px"/>
        <col/>
        <col class="SearchFormButton"/>
    </colgroup>
    <tr>
     <td>
        <c:if test="${allowCreation}" >

		    <syswf:control mode="script" caption="${prefix}CreateOrgUnit" id="${prefix}CreateOrgUnit" hint="" targetTask="/${viewId}/newArtifact">
		        <syswf:param name="sdmName" value="organizationUnitArtifact"/>
		        <syswf:param name="creationListener" value="${providerSelectorCreationListener}"/>
		    </syswf:control>
		    <syswf:control mode="script" id="${prefix}CreatePerson" caption="${prefix}CreatePerson" hint="" targetTask="/${viewId}/newArtifact">
		        <syswf:param name="sdmName" value="personArtifact"/>
		        <syswf:param name="creationListener" value="${providerSelectorCreationListener}"/>
		    </syswf:control>
		    <script type="text/javascript" >
		    //<![CDATA[
		        var ${prefix}CreateOrgUnit2 = function() {
		        	<c:choose>
			        	<c:when test="${not empty beforeCreationFce}">
			                ${beforeCreationFce}({
			                	callback: function() {
			                		//fix for Firefox browser, we need to wait beforeCreationFce finish then call next one
			    		        	${prefix}CreateOrgUnit();
			                	}
			                });
		            	</c:when>
		            	<c:otherwise>
		            		${prefix}CreateOrgUnit();
		            	</c:otherwise>
		        	</c:choose>		            
		        }
		    
		        var ${prefix}CreatePerson2 = function() {
		        	<c:choose>
			        	<c:when test="${not empty beforeCreationFce}">
			                ${beforeCreationFce}({
			                	callback: function() {
			                		//fix for Firefox browser, we need to wait beforeCreationFce finish then call next one
			                		${prefix}CreatePerson();
			                	}
			                });
		            	</c:when>
		            	<c:otherwise>
		            	${prefix}CreatePerson();
		            	</c:otherwise>
		        	</c:choose>
		        }
		//]]>
		</script>
		    
		    <div id="${prefix}Create" class="MenuButton"></div>
		        <script type="text/javascript">
		//<![CDATA[
		
		            new Ext4.Button({
		                renderTo: '${prefix}Create',
		                arrowAlign: 'right',              
		                menu: {
		                	bodyCls: 'context-menu',
		                	items: [
		                        {
		                        	cls:'context-menu-item',
		                            text: '${orgUnitLabel}',
		                            handler: ${prefix}CreateOrgUnit2
		                        },
		                        {
		                        	cls:'context-menu-item',
		                            text: '${userProfileLabel}',
		                            handler: ${prefix}CreatePerson2
		                        }
		                    ]},
		                    
		                split: true,
		                text: '${createNewContactLinkLabel}'
		            }); 
		//]]>
		</script>
		        
		</c:if>
        </td>
        <td>
            <syswf:control id="${prefix}FixedItemCallback" mode="script" action="search" caption="${fixedItem.value.callback}" affects="." ></syswf:control>

            <syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch">
                <syswf:param name="customizationId" value="shared.providerSelector.suggestedSearch" />
                <syswf:param name="cssOfInput" value="LongStr" />
                <syswf:param name="afterSelectCallback" value="${prefix}_comboDestroyer" />
                <syswf:param name="selectionListener" value="${selectionListener}" />
                <syswf:param name="value" value="${providerSelectorHolder}"/>
                <syswf:param name="fixedItem" value="${fixedItem}" />
                <syswf:param name="afterSelectionFinished" value="${providerSelectAction}" />
                <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}" />
            </syswf:component>
        </td>
        <td>
        	<div id="${prefix}Search"></div>
             <script type="text/javascript">
		//<![CDATA[
		
		            new Ext4.Button({
		                renderTo: '${prefix}Search',
		                handler: ${prefix}FixedItemCallback,
		                text: '${searchLabel}'
		            }); 
		//]]>
		</script>
        </td>
       
    </tr>
</table>
<br/>

<c:choose>
    <c:when test="${providerSelectorHolder.tab eq 'hidden'}">
        <syswf:control mode="postAnchor" id="${prefix}BrowseAddressbook" action="search" caption="${browseAddressbookLabel}" affects=".">
            <syswf:attribute name="class" value="UI Icon AddressBook" />
        </syswf:control>    
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
                        <syswf:selectOne id="${prefix}ChangeScope" name="${prefix}ChangeScope" value="${providerSelectorHolder}" property="tab" mode="radio" optionValues="${scopeValues}" optionCaptions="${scopeCaptions}"  displayAsRow="true">
                            <syswf:attribute name="onClick">
                                ${prefix}ChangeScope();
                            </syswf:attribute>
                        </syswf:selectOne>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <c:choose>
            <c:when test="${providerSelectorHolder.tab eq 'localPersons' or providerSelectorHolder.tab eq 'localOrgUnits' }">
                <syswf:component name="/core/layout/tabs" prefix="localTabs" wrap="false">
                    <syswf:param name="customizationId" value="shared.providerSelector.tabs" />
                    <syswf:param name="align" value="horizontal" />
                    <syswf:param name="providerSelectorHolder" value="${providerSelectorHolder}" />
                </syswf:component>
            </c:when>
            <c:when test="${providerSelectorHolder.tab eq 'global'}">
                <syswf:component name="/core/selector/providerSelectorGlobal" prefix="${prefix}Global">
                    <syswf:param name="providerSelectorHolder" value="${providerSelectorHolder}" />
                </syswf:component>
            </c:when>
        </c:choose>
    
    </c:otherwise>
</c:choose>

<script>
	var currentWin = SPopup.Window.Instance['${prefix}'.replace('_providerSelectorWindow_w_window', '') + 'Win'];
	if ((typeof currentWin) != 'undefined') {
		var pos = currentWin.getPosition();
		currentWin.setPosition(pos[0], $(window).height()/2 - currentWin.getHeight()/2);
	}
</script>
    
    