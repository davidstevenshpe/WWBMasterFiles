<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<table class="UI Table ExpressionBuilder Plain">
    <col class="MediumCol" />
    <col class="SeparatorCol" />
    <col />
    <tr>
        <td>
            <label><fmt:message key="relationRenderersCustomizationEditor.relations.tableTitle" bundle="${bundle}"/></label>
            <syswf:component name="/core/util/itemSelector" prefix="relationSelector">
                <syswf:param name="list" value="${relationsList}" />
                <syswf:param name="itemSelectorListener" value="${itemSelectorListener}" />
                <syswf:param name="selectedId" value="${itemSelectorListener.relationPropertyName}" />
            </syswf:component>
        
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            <syswf:component name="/core/impl/customization/editors/renderersCustomizationEditor" prefix="${itemSelectorListener.relationPropertyName}_manageRenderers">
                <syswf:param name="relationPropertyName" value="${itemSelectorListener.relationPropertyName}" />
            </syswf:component>
        </td>
    </tr>
</table>