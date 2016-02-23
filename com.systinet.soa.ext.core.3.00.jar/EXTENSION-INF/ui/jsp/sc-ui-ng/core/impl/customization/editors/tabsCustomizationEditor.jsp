<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
input parameters:
title - title
showCreateSection - show link create section
showAddProperty - show link add property
eventsListener - optionaly - events listener
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="addTab" key="tabsCustomizationEditor.addTab" bundle="${bundle}"/>
<fmt:message var="tabName" key="tabsCustomizationEditor.tabName" bundle="${bundle}"/>
<fmt:message var="tabHint" key="tabsCustomizationEditor.tabHint" bundle="${bundle}"/>
<fmt:message var="deleteConfirmText" key="tabsCustomizationEditor.delete.confirm" bundle="${bundle}"/>
<fmt:message var="deleteTitle" key="tabsCustomizationEditor.delete.title" bundle="${bundle}"/>


<table class="UI Table Properties">
	<col class="">
	<col class="">
	<col class="SpacerCol" style="width: 78px;">
	<tr>
		<td><syswf:out value="${tabName}" context="HtmlBody"/>
		</td>
		<td><syswf:out value="${tabHint}" context="HtmlBody"/>
		</td>
		<td>
			<div class="UI Align">
				<div class="Right">
					<syswf:component name="/core/impl/customization/editors/addtabsCustomization" prefix="newTabPopupEditor" wrap="true">
						<syswf:param name="linkClass" value="UI Icon Add"/>
						<syswf:param name="holder" value="${newTabHolder}"/>
						<%--
						<syswf:param name="affects" value="${prefix}"/>
						 --%>
						<syswf:param name="caption" value="${addTab}"/>
						<syswf:param name="tabName" value="${tabName}"/>
						<syswf:param name="tabHint" value="${tabHint}"/>
					</syswf:component>
					<div class="x-clear"></div>
				</div>
			</div>
		</td>
	</tr>
</table>
<syswf:component name="/core/util/tabSortableEditor" prefix="editorHiearchical">
    <syswf:param name="listWrapper" value="${listWrapper}" />
    <syswf:param name="showSortable" value="true" />
    <syswf:param name="showIcon" value="false" />
    <syswf:param name="sortable" value="sortable" />
    <syswf:param name="listEditorListener" value="${eventListener}" />
	<syswf:param name="hintListener" value="${hintEventListener}" />	
    <syswf:param name="confirmDelete" value="true" />
    <syswf:param name="deleteConfirmText" value="${deleteConfirmText}" />
    <syswf:param name="deleteTitle" value="${deleteTitle}" />
</syswf:component>