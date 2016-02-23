<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cust_Message"/>

<%-- Get Message --%>
<fmt:message key="save_caption" var="save_caption" bundle="${cust_Message}"/>
<fmt:message key="cancel_caption" var="cancel_caption" bundle="${cust_Message}"/>
<fmt:message key="customization_states" var="cust_states_caption" bundle="${cust_Message}"/>
<fmt:message key="customization_history" var="cust_history_caption" bundle="${cust_Message}"/>

<fmt:message key="import_button" var="import_caption" bundle="${cust_Message}"/>
<fmt:message key="release_customizations" var="release_caption" bundle="${cust_Message}"/>
<fmt:message key="delete_customizations" var="delete_caption" bundle="${cust_Message}"/>

<syswf:component prefix="pageTitle" name="/core/layout/header"/>

<syswf:component prefix="manageCustomizations" name="/core/table">
    <syswf:param name="datasource" value="${manageCustomizationsDataSource}"/>
    <syswf:param name="customizationId" value="shared.manageCustomizations"/>
    <syswf:param name="selectionBag" value="${customizationSelectionBag}"/>
    <syswf:param name="dontCustomize" value="true"/>
    <syswf:param name="wrapCaption" value="${cust_states_caption}"/>
</syswf:component>

<div style="margin-left: 14px">
	<c:if test="${viewCustomizationIsData}">
	    <syswf:control caption="${prefix}_release" mode="script" action="release" />
	
	    <fmt:message key="customizations.release.confirm" var="releaseConfirmText" bundle="${cust_Message}" />
	    <fmt:message key="customizations.release.title" var="releaseConfirmTitle" bundle="${cust_Message}" />
	    <syswf:component name="/core/util/confirmPopUp" prefix="releaseConfirmPopUp">
	        <syswf:param name="winOpenFunctionName" value="${prefix}_openReleaseConfirmPopUp" />
	        <syswf:param name="winOkAction" value="${prefix}_release" />
	        <syswf:param name="confirmMessage" value="${releaseConfirmText}" />
	        <syswf:param name="title" value="${releaseConfirmTitle}" />
	    </syswf:component>
	
	    <fmt:message key="customizations.delete.confirm" var="deleteConfirmText" bundle="${cust_Message}" />
	    <fmt:message key="customizations.delete.title" var="deleteConfirmTitle" bundle="${cust_Message}" />
	    <syswf:component name="/core/util/confirmPopUp" prefix="deleteConfirmPopUp">
	        <syswf:param name="winOpenFunctionName" value="${prefix}_openDeleteConfirmPopUp" />
	        <syswf:param name="winOkAction" value="${prefix}_delete" />
	        <syswf:param name="confirmMessage" value="${deleteConfirmText}" />
	        <syswf:param name="title" value="${deleteConfirmTitle}" />
	    </syswf:component>
	
	    <syswf:input name="releaseName" value="${releaseNameHolder}" property="releaseName">
	        <c:choose>
	            <c:when test="${emptyReleaseName}">
	                <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
	            </c:when>
	            <c:otherwise>
	                <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
	            </c:otherwise>
	        </c:choose>
	    </syswf:input>
	    
	    <a href="javascript: ${prefix}_openReleaseConfirmPopUp();" class="UI Icon Edit">${release_caption}</a>
	    
	    <%--
	    <syswf:control caption="${release_caption}" mode="postAnchor" action="release">
	        <syswf:attribute name="class" value="UI Icon Edit"/>
	    </syswf:control>
	    --%>
	</c:if>
	
	
	<a href="javascript:void(0);" id="import_customizations" class="UI Icon Upload">
	    <span>${import_caption}</span>
	</a>
	
	
	<c:if test="${viewCustomizationIsData}">
	    <syswf:control caption="${prefix}_delete" mode="script" action="delete" />
	    <a href="javascript: ${prefix}_openDeleteConfirmPopUp();" class="UI Icon Delete">${delete_caption}</a>
	
	    <%--
	    <syswf:control caption="${delete_caption}" mode="postAnchor" action="delete">
	        <syswf:attribute name="class" value="UI Icon Delete"/>
	    </syswf:control>
	    --%>
	</c:if>
	
	<div id="import_customizations_content" class="x-hidden">
	    <div class="x-window-header"><fmt:message key="import_customizations" bundle="${cust_Message}"/></div>
	    <div class="x-window-body">
	        <table class="UI Table Properties">
	            <colgroup>
	                <col class="MidLabelCol"/>
	                <col/>
	            </colgroup>
	            <tbody>
	                <tr>
	                    <th>
	                        <label for="${prefix}uploadedArchive" class="UI Label"><fmt:message key="customizations.import.label" bundle="${cust_Message}"/></label>
	                    </th>
	                    <td>                        
	                        <syswf:input id="${prefix}uploadedArchive" name="uploadedArchive" value="" hint=""/>                        
	                        <script type="text/javascript">
	//<![CDATA[
	
	                            Ext.onReady(function() {
	                                var uploadedArchive = new Ext.ux.form.FileUploadField({
	                                    id: '${prefix}uploadedArchive',
	                                    applyTo: '${prefix}uploadedArchive',
	                                    transform: '${prefix}uploadedArchive',
	                                    width: 400
	                                });
	                            });
	//]]>
	                        </script>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	    </div>
	</div>
</div>

<syswf:control mode="script" action="uploadCustomizations" caption="${prefix}import"/>

<c:if test="${empty customButtons}">
    <c:set var="customButtons">
        [{
            text    : '${import_caption}',
            handler  : function(){
                ${prefix}import();
                return false;
            },
            id       :  '${prefix}_importButton'
        },{
            text     : '<fmt:message key="cancel_import" bundle="${cust_Message}"/>',
            handler  : function(){
                SPopup.Window.Instance['import_customizations'].hide();
                return false;
            },
            id       :  '${prefix}_cancelButton'
        }
        ]
    </c:set>
</c:if>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        SPopup.Window.init('import_customizations','import_customizations_content',{autoHeight:true, buttons:<c:out value="${customButtons}" escapeXml="false"/>, width:590, resizable:false, centerOnScreen:true});
    });
//]]>    
</script>

<%-- div causes that pop-up confirmation window from table actions doesn't destroy table look --%>
<div class="webfw-Window">
<syswf:component prefix="customizationSnapshots" name="/core/table">
    <syswf:param name="customizationId" value="shared.customizationSnapshots"/>
    <syswf:param name="dontCustomize" value="true"/>
    <syswf:param name="wrapCaption" value="${cust_history_caption}"/>
</syswf:component>
</div>

<%--hr>
WARNING: Legacy content bellow this line!

<fmt:message key="tab_customization" var="tab_cust_caption" bundle="${cust_Message}"/>
<fmt:message key="new_tab_add_label" var="new_tab_add" bundle="${cust_Message}"/>
<fmt:message key="new_tab_add_section" var="new_tab_section" bundle="${cust_Message}"/>
<fmt:message key="new_tab_remove_label" var="new_tab_remove" bundle="${cust_Message}"/>
<fmt:message key="new_tab_slider" var="new_tab_slider" bundle="${cust_Message}"/>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span>${tab_cust_caption}</span></h3>
    </div>
    <div class="Content">
        <table>
        <c:forEach var="viewCustId" items="${viewCustomizationIds}" varStatus="status">
            <tr>
                <td>
            <syswf:component name="/core/impl/edit/popupTextEditor" prefix="view${status.index}" wrap="false">
		    	<syswf:param name="bean" value="${viewCustomizationXmls[viewCustId]}" />
		    	<syswf:param name="openPopupButtonLabel" value="${viewCustomizationStates[viewCustId].label}" />
                <syswf:param name="openPopupButtonHint" value="${viewCustomizationStates[viewCustId].typeLabel}" />
                <syswf:param name="openPopupButtonClass" value="UI Customize Icon" />
		    	<syswf:param name="saveButtonLabel" value="${save_caption}" />
		    	<syswf:param name="cancelButtonLabel" value="${cancel_caption}" />
                <syswf:param name="windowWidth" value="900"/>
                <syswf:param name="windowHeight" value="600"/>
                <syswf:param name="windowTitle" value="${viewCustomizationStates[viewCustId].label}"/>
            </syswf:component>
            <c:if test="${not empty viewCustomizationErrors[viewCustId]}">
                <div class="UI SystemMessage Error">
                    <div class="MessageContainer">
                        <div class="Text">${viewCustomizationErrors[viewCustId]}</div>
                        <div class="x-clear"></div>
                    </div>
                </div>
            </c:if>
                </td>
                <td>
            <c:if test="${viewCustId != 'analyst.uiconfig' && viewCustId != 'partner.uiconfig'}">
                <syswf:control mode="postAnchor" caption="${new_tab_remove}" action="removeTab" id="${viewCustId}">
                    <syswf:param name="customizationIdToRemove" value="${viewCustId}"/>
                    <syswf:attribute name="class">UI Icon Close</syswf:attribute>                    
                </syswf:control>
            </c:if>
                </td>
            </tr>
        </c:forEach>
        </table>

        <div class="UI AdvancedOptions Labeled ${advancedOptionsStatus}">
        <div class="OptionsOpener">
            <syswf:control mode="postAnchor" action="dialogToggle" caption="${new_tab_slider}" id="${prefix}_sliderLink"/>
        </div>
        <div class="Content">
            <div>
                <span class="Comment">${new_tab_section}</span>
            </div>
            <hr/>

            <table class="UI Table Properties" summary="">
                <colgroup>
                    <col class="LabelCol"/>
                    <col/>
                </colgroup>
                <tbody>
                    <tr>
                    <th><label><fmt:message key="new_tab_id" bundle="${cust_Message}"/></label></th>
                    <td>
                        <syswf:input name="newTabId" value="">
                            <syswf:attribute name="class">UI Input</syswf:attribute>
                        </syswf:input>
                    </td>
                </tr>
                <tr>
                    <th><label class="UI Label Inline"><fmt:message key="new_tab_label" bundle="${cust_Message}"/></label></th>
                    <td>
                        <syswf:input name="newTabLabel" value="">
                            <syswf:attribute name="class">UI Input</syswf:attribute>
                        </syswf:input>
                    </td>
                </tr>
                <tr>
                    <th><label class="UI Label Inline"><fmt:message key="new_tab_perspective" bundle="${cust_Message}"/></label></th>
                    <td>
                        <syswf:selectOne name="newTabPerspective" value="" optionValues="${availablePerspectives}" optionValuesProperty="id"
                                         optionCaptions="${availablePerspectives}" optionCaptionsProperty="label" mode="menu">
                            <syswf:attribute name="class">UI</syswf:attribute>
                        </syswf:selectOne--%>
                        <%--syswf:input name="newTabPerspective" value="">
                            <syswf:attribute name="class">UI Input</syswf:attribute>
                        </syswf:input--%>
                    <%--/td>
                </tr>
            </table>

            <div class="UI Form Controls">
                <syswf:control mode="postAnchor" caption="${new_tab_add}" action="addTab">
                    <syswf:attribute name="class" value="Button Confirm"/>
                    <syswf:attribute name="type" value="button"/>
                </syswf:control>
            </div>

        </div>
    </div>

    </div>
</syswf:block>

<syswf:component prefix="generator" name="/core/impl/customization/customizationGenerator"/--%>
