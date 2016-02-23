<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="title" key="addArtifactType.defineViewPage.title" bundle="${bundle}">
	<fmt:param>${wizardController.wizardContext.artifactLabel.string}</fmt:param>
</fmt:message>
<fmt:message var="addTab" key="addArtifactType.defineViewPage.addTab" bundle="${bundle}"/>
<fmt:message var="editorTitle" key="addArtifactType.defineViewPage.editorTitle" bundle="${bundle}"/>
<fmt:message var="emptyTableTitle" key="addArtifactType.defineViewPage.emptyTable" bundle="${bundle}"/>
<%--
<fmt:message var="deleteConfirmText" key="tabsCustomizationEditor.delete.confirm" bundle="${bundle}"/>
<fmt:message var="deleteTitle" key="tabsCustomizationEditor.delete.title" bundle="${bundle}"/>
--%>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<table class="UI Table ExpressionBuilder Plain">
    <col />
    <col />
    <tr>
        <td>
            <div class="UI Text Description"><fmt:message key="addArtifactType.defineViewPage.desc" bundle="${bundle}"/></div>
        </td>
        <td>
            <div class="UI Align">
                <div class="Right">
                    <syswf:selectOne value="${wizardController.wizardContext}" property="createEditPage"
                                     name="createEditPageCheckBox" mode="checkbox"
                                     optionValues="true" optionCaptions="" />
                    <label for="${prefix}_createEditPageCheckBox"><fmt:message key="addArtifactType.defineViewPage.createEditPage" bundle="${bundle}"/></label>
                    <syswf:selectOne value="${wizardController.wizardContext}" property="createNewPage"
                                     name="createNewPageCheckBox" mode="checkbox"
                                     optionValues="true" optionCaptions="" />
                     <label for="${prefix}_createNewPageCheckBox"><fmt:message key="addArtifactType.defineViewPage.createNewPage" bundle="${bundle}"/></label>
                </div>
            </div>
        </td>
    </tr>
</table>

<syswf:block className="UI Block Common">

    <table class="UI Table ExpressionBuilder Plain">
        <col class="MediumCol" />
        <col class="SeparatorCol" />
        <tr>
            <td>
                <table class="UI Table ExpressionBuilder Plain">
                    <tr>
                        <td>
                            <div class="UI Align">
                                <div class="Right">
                                    <syswf:component name="/core/util/newValuePopupEditor" prefix="newTabPopupEditor" wrap="true">
                                            <syswf:param name="linkClass" value="UI Icon Add"/>
                                            <syswf:param name="holder" value="${wizardController.wizardContext}"/>
                                            <syswf:param name="defaultValues" value="${predefinedTabs}"/>
                                            <syswf:param name="caption" value="${addTab}"/>
                                    </syswf:component>
                                </div>
                                <div class="Left">
                                    <label><fmt:message key="addArtifactType.defineViewPage.artifactTabs" bundle="${bundle}"/></label>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="SeparatorRow">
                        <td></td>
                    </tr>

                    <tr>
                        <td>
                          <div>
                            <syswf:component name="/core/util/sortableEditor" prefix="tabEditor">
                                <%-- list for tree --%>
                                <syswf:param name="listWrapper" value="${wizardController.wizardContext.viewPageTabs}" />
                                <syswf:param name="listEditorListener" value="${wizardController.wizardContext}" />
                                <syswf:param name="showToggleVisibility" value="false" />
                                <syswf:param name="sortable" value="sortable" />
                                <syswf:param name="selectable" value="true" />
                                <%--
                                <syswf:param name="confirmDelete" value="true" />
                                <syswf:param name="deleteConfirmText" value="${deleteConfirmText}" />
                                <syswf:param name="deleteTitle" value="${deleteTitle}" />
                                --%>
                                <%--
                                <syswf:param name="affects" value="${prefix}_tabEditor" />
                                --%>
                            </syswf:component>
                          </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td></td>
            <td>
                <c:choose>
                    <c:when test="${wizardController.wizardContext.selectedTabType eq 'predefined' or wizardController.wizardContext.selectedTabType eq 'documentation'}"> <%--for possible types see AddArtifactWizardContext.TAB_* --%>
                        <div class="UI SystemMessage Info">
                            <div class="MessageContainer">
                                <div class="Text">
                                    <fmt:message key="addArtifactType.defineViewPage.prdefinedTab.desc" bundle="${bundle}"/>
                                </div>
                                <div class="x-clear"></div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${wizardController.wizardContext.selectedTabType eq 'categories'}">
                        <syswf:component name="/core/customization/categories/manageCategories" prefix="categories">
                            <syswf:param name="holder" value="${wizardController.wizardContext.viewPageCategories}"/>
                            <syswf:param name="limitTaxonomiesToViewId" value="${wizardController.wizardContext.viewId}"/>
                        </syswf:component>
                    </c:when>
                    <c:when test="${wizardController.wizardContext.selectedTabType eq 'properties'}">
                        <syswf:component prefix="propertiesEditor${wizardController.wizardContext.viewPageEditedTab}" name="/core/impl/customization/editors/artifactPropertiesCustomizationEditor">
                            <syswf:param name="title" value="${editorTitle}"/>
                            <syswf:param name="content" value="${wizardController.wizardContext.currentTabContent}"/>
                            <syswf:param name="sdmName" value="${wizardController.wizardContext.artifactDescriptor.sdmName}"/>
                            <syswf:param name="emptyTableTitle" value="${emptyTableTitle}" />
                            <syswf:param name="viewId" value="${wizardController.wizardContext.viewId}"/>
                        </syswf:component>
                    </c:when>
                    <c:otherwise>
                    <!--  -->
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
</syswf:block>