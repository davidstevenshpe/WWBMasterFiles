<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--
input params:
required:
 - relationPropertyName - name of relation property
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="addRenderer" key="renderersCustomizationEditor.addRenderer" bundle="${bundle}"/>
<fmt:message var="deleteRenderer" key="renderersCustomizationEditor.deleteRenderer" bundle="${bundle}"/>
<fmt:message var="tableColumns" key="renderersCustomizationEditor.tableColumns" bundle="${bundle}"/>
<fmt:message var="deleteConfirmText" key="renderersCustomizationEditor.delete.confirm" bundle="${bundle}"/>
<fmt:message var="deleteTitle" key="renderersCustomizationEditor.delete.title" bundle="${bundle}"/>
<fmt:message var="emptyTableTitle" key="renderersCustomizationEditor.emptyTable" bundle="${bundle}"/>

<c:if test="${not actualTableWrapper.selectedRendererPredefined}">
<c:choose>
    <c:when test="${empty affects}">
        <syswf:control mode="script" action="delete" caption="${prefix}_deleteRenderer" />
    </c:when>
    <c:otherwise>
        <syswf:control mode="script" action="delete" caption="${prefix}_deleteRenderer" affects="."/>
    </c:otherwise>
</c:choose>
</c:if>

<table class="UI Table ExpressionBuilder Plain">
    <col/>
    
    <tr>
        <td>
            <div class="UI Align">
                <div class="Right">
                    <table>
                        <tr>
                            <td>
                                <syswf:component name="/core/util/newValuePopupEditor" prefix="newRendererPopUp" wrap="true">
                                    <syswf:param name="linkClass" value="UI Icon Add"/>
                                    <syswf:param name="holder" value="${tableCustomizationEditorEventsListener}"/>
                                    <syswf:param name="caption" value="${addRenderer}"/>
                                    <%--
                                    <syswf:param name="affects" value="${prefix}_rendererSelector" />
                                     --%>
                                </syswf:component>
                            </td>
                            <td>
                                <c:if test="${not actualTableWrapper.selectedRendererPredefined}">
                                    <syswf:component name="/core/util/confirmPopUp" prefix="deletePopUp">
                                        <syswf:param name="winOpenFunctionName" value="${prefix}openDeleteConfirmPopUp" />
                                        <syswf:param name="winOkAction" value="${prefix}_deleteRenderer" />
                                        <syswf:param name="confirmMessage" value="${deleteConfirmText}" />
                                        <syswf:param name="title" value="${deleteTitle}" />
                                </syswf:component>
                                <a href="javascript:${prefix}openDeleteConfirmPopUp()" class="UI Icon Delete" id="${prefix}_deleteLink">
                                    <span><span><span>${deleteRenderer}</span></span></span>
                                </a>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="Left">
                    <label><fmt:message key="renderersCustomizationEditor.renderers.tableTitle" bundle="${bundle}"/></label>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <syswf:component name="/core/util/itemSelectorHoriz" prefix="rendererSelector">
                <syswf:param name="list" value="${rendererList}" />
                <syswf:param name="itemSelectorHorizListener" value="${actualTableWrapper}" />
                <syswf:param name="selectedId" value="${actualTableWrapper.selectedId}" />
                <%--
                <syswf:param name="affects" value="${actualTableWrapper.tableId}_tableEditor" />
                --%>
            </syswf:component>
        </td>
    </tr>
    <tr>
        <td>
            <div class="OffsetTop">
            <syswf:component prefix="${actualTableWrapper.tableId}_tableEditor" name="/core/impl/customization/editors/tableCustomizationEditor">
                <syswf:param name="title" value="${tableColumns}"/>
                <syswf:param name="table" value="${actualTableWrapper.table}"/>
                <syswf:param name="showAddProperty" value="true"/>
                <syswf:param name="showCreateSection" value="false"/>
                <syswf:param name="sdmNameList" value="${actualTableWrapper.sdmNames}"/>
                <syswf:param name="eventsListener" value="${tableCustomizationEditorEventsListener}"/>
                <syswf:param name="emptyTableTitle" value="${emptyTableTitle}" />
            </syswf:component>
            </div>
        </td>
    </tr>
</table>