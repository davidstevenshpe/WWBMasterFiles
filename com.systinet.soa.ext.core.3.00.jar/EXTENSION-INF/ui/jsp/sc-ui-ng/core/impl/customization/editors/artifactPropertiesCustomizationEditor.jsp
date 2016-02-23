<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="addSection" key="tableCustomizationEditor.addSection" bundle="${bundle}"/>

<table class="UI Table ExpressionBuilder Plain">
    <col class="LabelCol"/>
    <col />
    <tr>
        <td><label class="IconAlign">${title}</label></td>
        <td>
            <div class="UI Align">
                <div class="Right">
                    <table>
                        <tr>
                            <td>
                                <syswf:component name="/core/util/newValuePopupEditor" prefix="newValuePopupEditor" wrap="true">
                                    <syswf:param name="linkClass" value="UI Icon Add"/>
                                    <syswf:param name="holder" value="${listEditorHiearchicalEventListener}"/>
                                    <syswf:param name="caption" value="${addSection}"/>
                                </syswf:component>
                            </td>
                            <td>
                                <syswf:component name="/core/artifact/propertySelectorPopUp" prefix="propertySelector" wrap="true">
                                    <syswf:param name="sdmName" value="${sdmName}"/>
                                    <syswf:param name="propertyListSelectionListener" value="${listEditorHiearchicalEventListener}"/>
                                    <syswf:param name="sections" value="${sectionHolders}"/>
                                    <syswf:param name="showRelated" value="true"/>
                                    <syswf:param name="usedProperties" value="${usedProperties}"/>
                                    <syswf:param name="showAddToSection" value="true"/>
                                </syswf:component>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="x-clear"></div>
        </td>
    </tr>
    <tr class="SeparatorRow">
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2">
            <syswf:component name="/core/util/sortableEditor" prefix="editorHiearchical">
                <syswf:param name="listWrapper" value="${listWrapper}" />
                <syswf:param name="listEditorListener" value="${listEditorHiearchicalEventListener}" />
                <syswf:param name="sortable" value="nestedSortable" />
                <syswf:param name="selectable" value="false" />
                <syswf:param name="showRenderer" value="true" />
                <syswf:param name="emptyTableTitle" value="${emptyTableTitle}" />
                <syswf:param name="affects" value="${prefix}"/>
            </syswf:component>
        </td>
    </tr>
</table>