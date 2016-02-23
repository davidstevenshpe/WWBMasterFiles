<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
input parameters:
required:
 - table - customization Table
 - sdmName or sdmNameList - for property selector component, sdm name or list of sdm names of artifacts
 
optionally:
 - eventsListener - optionaly - events listener
 - title - title
 - showCreateSection - show link create section
 - showAddProperty - show link add property
--%>

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
                                <c:if test="${showCreateSection}">
                                    <syswf:component name="/core/util/newValuePopupEditor" prefix="newValuePopupEditor" wrap="true">
                                        <syswf:param name="linkClass" value="UI Icon Add"/>
                                        <syswf:param name="holder" value="${listEditorHiearchicalEventListener}"/>
                                        <syswf:param name="caption" value="${addSection}"/>
                                    </syswf:component>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${showAddProperty}">
                                    <syswf:component name="/core/artifact/propertySelectorPopUp" prefix="propertySelector" wrap="true">
                                        <syswf:param name="sdmName" value="${sdmName}"/>
                                        <syswf:param name="sdmNameList" value="${sdmNameList}"/>
                                        <syswf:param name="propertyListSelectionListener" value="${listEditorHiearchicalEventListener}"/>
                                        <syswf:param name="sections" value="${sectionHolders}"/>
                                        <syswf:param name="showRelated" value="false"/>
                                        <syswf:param name="forTable" value="true"/>
                                        <syswf:param name="usedProperties" value="${usedProperties}"/>
                                        <%-- show add to section only if creation sections is allowed - otherwise is nonsense --%>
                                        <syswf:param name="showAddToSection" value="${showCreateSection}"/>
                                    </syswf:component>
                                </c:if>
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
        <c:choose>
            <c:when test="${showCreateSection}">
                <c:set var="sortable" value="nestedSortable" />
            </c:when>
            <c:otherwise>
                <c:set var="sortable" value="sortable" />    
            </c:otherwise>
        </c:choose>
        <syswf:component name="/core/util/sortableEditor" prefix="editorHiearchical">
            <%-- list for tree --%>
            <syswf:param name="listWrapper" value="${listWrapper}" />
            <syswf:param name="listEditorListener" value="${listEditorHiearchicalEventListener}" />
            <syswf:param name="showToggleVisibility" value="true" />
            <syswf:param name="sortable" value="${sortable}" />
            <syswf:param name="selectable" value="false" />
            <syswf:param name="emptyTableTitle" value="${emptyTableTitle}" />
            <syswf:param name="affects" value="${prefix}"/>
        </syswf:component>
    </td>
    </tr>
</table>

