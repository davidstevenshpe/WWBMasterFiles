<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<script type="text/javascript">
//<![CDATA[

${prefix}_comboDestroyer = function(combo) {
    combo.collapse();
    combo.destroy();
    //SPopup.Window.Instance['${myWindowId}'].hide();
    //SPopup.Window.Instance['${myWindowId}'] = undefined;
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
			<syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch">
			    <syswf:param name="customizationId" value="shared.principalSelector.suggestedSearch" />
			    <syswf:param name="cssOfInput" value="LongStr" />
			    <syswf:param name="afterSelectCallback" value="${prefix}_comboDestroyer" />
			    <syswf:param name="suggestDatasource" value="${suggestDatasource}" />
			    <syswf:param name="value" value="${this.searchExpressionWrapper}"/>
			    <syswf:param name="selectionListener" value="${this.listener}"/>
			    <syswf:param name="areaToUpdateOnSelect" value="${areaToUpdateOnSelect}"/>
			    <syswf:param name="width" value="${selectorWidth - 130}" />
			    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}" />
			    <syswf:param name="inputId" value="${prefix}_iid" />
			</syswf:component>
			
			

        </td>
        <td>
			<fmt:message bundle="${messages}" var="search" key="Search" />
			<syswf:control mode="postAnchor" action="search" caption="${search}" affects="." loadingMask="true">
			    <syswf:attribute name="id" value="${prefix}Search" />
			    <syswf:attribute name="class" value="Button" />
			</syswf:control>
        </td>
    </tr>
    <tr>
    	<td colspan="2">
    		<sub><fmt:message bundle="${messages}" key="principalSelector.suggestHint" /></sub>
    	</td>
    </tr>
</table>
<%-- react upon ENTER key when pressed in the input field --%>
<script type="text/javascript">//<![CDATA[
        Ext.onReady(function() {
            if(Ext.get('${prefix}_iid')) {
                var search = new Ext.form.TextField({
                    id: '${prefix}_iid',
                    applyTo: '${prefix}_iid',
                });
                search.on('specialkey', function(input, e) {
                    if (e.getKey() === e.ENTER) {
                        document.getElementById('${prefix}Search').click();
                        e.stopEvent();
                        return false;
                    }
                });
            };
        });
    
//]]>
</script>
<br/><br/>

<c:choose>
	<c:when test="${empty isHiddenTabs}">
		<fmt:message bundle="${messages}" var="addressBookLabel" key="principalSelector.browseBook" />
	
		<syswf:control mode="postAnchor" id="${prefix}BrowseAddressbook" action="search" caption="${addressBookLabel}" affects="." loadingMask="true">
			<syswf:attribute name="class" value="UI Icon AddressBook" />
		</syswf:control> 
	</c:when>
	
	<c:otherwise>
		<c:if test="${not isHiddenTabs}">
			<div class="UI Offset" id="${prefix}addressbook_browser">
				<syswf:component name="/core/impl/principal/addressBook" prefix="t">
					<syswf:param name="tabs" value="${tabs}" />
					<c:if test="${not empty selectedTab}">
						<syswf:param name="optionId" value="${selectedTab}" />
					</c:if>
					<syswf:param name="visible" value="true" />
				</syswf:component>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>