<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="editorTitle" key="addArtifactType.defineBrowsePage.editorTitle" bundle="${bundle}"/>
<fmt:message var="emptyTableTitle" key="addArtifactType.defineBrowsePage.emptyTable" bundle="${bundle}"/>

<fmt:message var="title" key="addArtifactType.defineBrowsePage.title" bundle="${bundle}">
    <fmt:param>${wizardController.wizardContext.artifactLabel.string}</fmt:param>
</fmt:message>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<div class="UI Text Description"><fmt:message key="addArtifactType.defineBrowsePage.desc" bundle="${bundle}"/></div>

<syswf:block className="UI Block Common">
    
    <div class="OffsetTop">
        <table class="UI Table Properties">
            <col class="LabelCol"/>
    
            <col />
            <col class="LabelCol"/>
            <col class="LongLabelCol"/>
            <tr>
                <td><label class="UI Label" for="${prefix}_browsePageMenuLabel"><fmt:message key="addArtifactType.defineBrowsePage.menuLabel" bundle="${bundle}"/></label></td>
                <td>
                    <syswf:input name="browsePageMenuLabel" property="browsePageMenuLabel" value="${wizardController.wizardContext}" id="${prefix}_browsePageMenuLabel">
                        <syswf:attribute name="class" value="UI Form Input Text Full"/>
                    </syswf:input>
                </td>
                <td><label class="UI Label" for="${prefix}_browsePageContentMenuSelector"><fmt:message key="addArtifactType.defineBrowsePage.menuCategory" bundle="${bundle}"/></label></td>
                <td>
                    <syswf:selectOne name="browsePageContentMenuSelector" mode="menu" id="${prefix}_browsePageContentMenuSelector"
                        value="${wizardController.wizardContext}" property="browsePageContentMenuSelectedId"
                        optionValues="${wizardController.wizardContext.browsePageContentMenuIds}"
                        optionCaptions="${wizardController.wizardContext.browsePageContentMenuLabels}">
                    </syswf:selectOne>
                    <script type="text/javascript">
//<![CDATA[

                    /**/
                    Ext.onReady(function(){
                        var cmb_customize_coldef_menucat = new Ext.form.ComboBox({
                            id : '${prefix}_browsePageContentMenuSelector',
                            transform : '${prefix}_browsePageContentMenuSelector',
                            disableKeyFilter : true,
                            mode : 'local',
                            autoHeight : true,
                            editable:false,
                            listWidth:245,
                            width:245,
                            triggerAction : 'all'
                        });
                    }); 
                    /**/
                    
//]]>
</script>
                </td>
            </tr>
            <tr>
                <td><label class="UI Label" for="${prefix}_browsePageMenuLabelPlural"><fmt:message key="addArtifactType.defineBrowsePage.menuLabelPlural" bundle="${bundle}"/></label></td>
                <td>
                    <syswf:input name="browsePageMenuLabelPlural" property="browsePageMenuLabelPlural" value="${wizardController.wizardContext}" id="${prefix}_browsePageMenuLabelPlural">
                        <syswf:attribute name="class" value="UI Form Input Text Full"/>
                    </syswf:input>
                </td>
                <td colspan="2">&nbsp;</td>
            </tr>
    
        </table>
    </div>
    
    <div class="UI SystemMessage Info">
        <div class="MessageContainer">
            <div class="Text"><fmt:message key="addArtifactType.defineBrowsePage.desc.detail" bundle="${bundle}"/></div>
            <div class="x-clear"></div>
        </div>
    </div>
    
    <div class="OffsetTop">
    <syswf:component prefix="tableEditor" name="/core/impl/customization/editors/tableCustomizationEditor">
        <syswf:param name="title" value="${editorTitle}"/>
        <syswf:param name="table" value="${wizardController.wizardContext.browseTable}"/>
        <syswf:param name="sdmName" value="${wizardController.wizardContext.artifactDescriptor.sdmName}"/>
        <syswf:param name="showAddProperty" value="true"/>
        <syswf:param name="showCreateSection" value="true"/>
        <syswf:param name="emptyTableTitle" value="${emptyTableTitle}" />
    </syswf:component>
    </div>

</syswf:block>