<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="canDisplayComponent" type="boolean"--%>
<c:if test="${canDisplayComponent}">

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="processEditor.cancelButton" var="cancelButton" bundle="${messages}"/>
<fmt:message key="processEditor.saveButton" var="saveButton" bundle="${messages}"/>
<fmt:message key="processEditor.createProcessTitle" var="createProcessTitle" bundle="${messages}"/>
<fmt:message key="processEditor.subtitle" var="subtitle" bundle="${messages}"/>
<fmt:message key="processEditor.name" var="name" bundle="${messages}"/>
<fmt:message key="processEditor.description" var="description" bundle="${messages}"/>
<fmt:message key="processEditor.validationRootArtifactTypeNotNull" var="validationRootArtifactTypeNotNull"
             bundle="${messages}"/>
<fmt:message key="processEditor.rootArtifactTypeLabel" var="rootArtifactTypeLabel" bundle="${messages}"/>
<fmt:message key="processEditor.goalLifecycleStageLabel" var="goalLifecycleStageLabel" bundle="${messages}"/>
<fmt:message key="processEditor.subArtifactTypesLabel" var="subArtifactTypeLabel" bundle="${messages}"/>
<fmt:message key="processEditor.applicableToTitle" var="applicableToTitle" bundle="${messages}"/>
<fmt:message key="processEditor.automaticProcessLabel" var="automaticProcessLabel" bundle="${messages}"/>
<fmt:message key="processEditor.positiveCategoriesLabel" var="positiveCategoriesLabel" bundle="${messages}"/>
<fmt:message key="processEditor.inDomainsLabel" var="inDomainsLabel" bundle="${messages}"/>
<fmt:message key="processEditor.negativeCategoriesLabel" var="negativeCategoriesLabel" bundle="${messages}"/>
<fmt:message key="processEditor.automaticProcessMessage" var="automaticProcessMessage" bundle="${messages}"/>
<fmt:message key="processEditor.traverseArchimateRelationshipsMessage" var="traverseArchimateRelationshipsMessage" bundle="${messages}"/>
<fmt:message key="processEditor.traverseComposeOfonlyMessage" var="traverseComposeOfonlyMessage" bundle="${messages}"/>
<fmt:message key="processEditor.positiveCategoriesMessageText" var="positiveCategoriesMessageText" bundle="${messages}"/>
<fmt:message key="processEditor.domainsMessageText" var="domainsMessageText" bundle="${messages}"/>
<fmt:message key="processEditor.negativeCategoriesMessageText" var="negativeCategoriesMessageText" bundle="${messages}"/>
<fmt:message key="processEditor.traverseArchimateRelationships" var="traverseArchimateRelationships" bundle="${messages}"/>
<fmt:message key="processEditor.traverseComposeOfonly" var="traverseComposeOfonly" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<%--@elvariable id="processBean" type="com.hp.systinet.lifecycle.ui.admin.process.ProcessBean"--%>
<%--@elvariable id="sessionStack" type="com.systinet.webfw.CarryBag"--%>
<%--@elvariable id="nameError" type="java.lang.Boolean"--%>
<%--@elvariable id="nameErrorMessage" type="java.lang.String"--%>
<%--@elvariable id="rootArtifactError" type="java.lang.Boolean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="artifactCaptions" type="java.util.List"--%>
<%--@elvariable id="artifactValues" type="java.util.List"--%>
<%--@elvariable id="inCategoriesWidgetModel" type="com.hp.systinet.lifecycle.ui.common.CategoryBagWidgetModel"--%>
<%--@elvariable id="notInCategoriesWidgetModel" type="com.hp.systinet.lifecycle.ui.common.CategoryBagWidgetModel"--%>
<%--@elvariable id="inDomainsModel" type="com.hp.systinet.lifecycle.ui.common.DomainBagWidgetModel"--%>

<c:set var="title">
    <c:if test="${processBean.mode eq 'NEW'}">
        <c:out value="${createProcessTitle}"/>
    </c:if>
    <c:if test="${processBean.mode eq 'EDIT'}">
        <c:out value="${lifecycleLabel}"/>
    </c:if>
</c:set>

<table class="UI Layout">
<tr>
<td class="UI Middle">
<div class="UI PageIdentity">
    <h1><c:out value="${title}" escapeXml="false"/></h1>
</div>

<syswf:block className="UI Block Common">
    <div class="Content">
        <table class="UI Table Properties" summary="">
            <colgroup>
                <col class="MidLabelCol"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th>
                    <label class="UI Label Required Full" for="${prefix}_nameId"><c:out value="${name}"/></label>
                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                </th>
                <td>
                    <syswf:input id="${prefix}_nameId" name="nameInput" value="${processBean.process}" property="name">
                        <c:choose>
                            <c:when test="${not nameError}">
                                <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
                            </c:when>
                            <c:otherwise>
                                <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
                            </c:otherwise>
                        </c:choose>
                    </syswf:input>
                    <c:if test="${nameError}">
                        <em class="x-form-invalid-msg UI Invalid">
                            <span>${nameErrorMessage}</span>
                        </em>
                    </c:if>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            new Ext.HP.Input({
                                applyTo : '<c:out value="${prefix}_nameId" />'
                            });
                        });                  
//]]>
                    </script>
                </td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline"><c:out value="${description}"/></label>
                </th>
                <td>
                    <syswf:textArea id="${prefix}_description_richTextArea" name="descriptionRichTextArea"
                                    value="${processBean.process}" property="description">
                    </syswf:textArea>
                    <syswf:component name="/core/impl/edit/richTextEditor" prefix="${prefix}_description_richText"
                                     wrap="false">
                        <syswf:param name="textAreaId" value="${prefix}_description_richTextArea"/>
                        <syswf:param name="height" value="120"/>
                    </syswf:component>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</syswf:block>


<syswf:block className="UI Block Common">
	<c:if test="${processBean.mode eq 'EDIT'}">
		<table class="UI Table Properties" summary="">
            <colgroup>
                <col class="MidLabelCol"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th>
                    <label class="UI Label Required Full"><c:out value="${goalLifecycleStageLabel}"/></label>
                </th>
                <td>
                    <syswf:selectOne id="${prefix}_goalLifeCycleProcessId" name="goalLifeCycleProcessNameSelect" mode="menu"
                                     optionValues="${defaultStateCaptions}"
                                     optionCaptions="${defaultStateCaptions}"
                                     value="${processBean}" property="defaultProcessState"/>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var var_${prefix}_goalLifeCycleProcessId = new Ext.HP.ComboBox({
                                id: '${prefix}_goalLifeCycleProcessId',
                                transform: '${prefix}_goalLifeCycleProcessId',
                                forceSelection: true,
                                typeAhead: false,
                                disableKeyFilter: false,
                                editable: false,
                                listWidth : 300,
                                width : 300
                            });
                        });
                    
//]]>
                    </script>
                </td>
            </tr>
          </tbody>
        </table>
	</c:if>
    <div class="Title">
        <h3><span><c:out value="${applicableToTitle}"/></span></h3>
    </div>
    <div class="Content">
        <table class="UI Table Properties" summary="">
            <colgroup>
                <col class="MidLabelCol"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th>
                    <label class="UI Label Required Full"><c:out value="${rootArtifactTypeLabel}"/></label>
                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                </th>
                <td>
                    <syswf:selectOne id="${prefix}_rootArtifactId" name="rootArtifactNameSelect" mode="menu"
                                     optionValues="${artifactValues}"
                                     optionCaptions="${artifactCaptions}"
                                     value="${processBean}" property="rootArtifactValue"/>
                    <c:if test="${rootArtifactError}">
                        <em class="x-form-invalid-msg UI Invalid">
                            <span>${validationRootArtifactTypeNotNull}</span>
                        </em>
                    </c:if>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var var_${prefix}_rootArtifactId = new Ext.HP.ComboBox({
                                id: '${prefix}_rootArtifactId',
                                transform: '${prefix}_rootArtifactId',
                                forceSelection: true,
                                typeAhead: false,
                                disableKeyFilter: false,
                                editable: true,
                                listWidth : 300,
                                width : 300,
            					listeners:{
            						scope: this,
            						afterRender: function (comp) {
            							var item = comp.getStore().data.items[0];
            							comp.emptyText = item.data.text;
            						},
									change: function (comp, value) {
										if (comp.getRawValue() == null || comp.getRawValue() == '') {
											var item0 = comp.getStore().data.items[0];
											comp.setValue(item0.data.value);
										}
									}
            					}
                            });
                        });
                    
//]]>
                    </script>
                </td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline"><c:out value="${subArtifactTypeLabel}"/></label>
                </th>
                <td>
                    <syswf:component prefix="typeSelector"
                                     name="/newUi/lc/admin/process/subartifactTypeSelector">
                        <syswf:param name="processBean" value="${processBean}"/>
                    </syswf:component>
                </td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline">
                        <c:out value="${traverseArchimateRelationships}"/>
                    </label>
                    <a href="javascript:void(0)" class="UI Icon Info" id="traverseArchimateRelationshipsMessage"><span></span></a>
                </th>
                <td>
                    <syswf:selectOne id="${prefix}_traverseArchimateRelationships" name="traverseArchimateRelationshipsSelect"
                                     value="${processBean.process}" property="traverseArchimateRels"
                                     dataType="boolean" optionValues="true" optionCaptions=""
                                     mode="checkbox"/>
                </td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline">
                        <c:out value="${traverseComposeOfonly}"/>
                    </label>
                    <a href="javascript:void(0)" class="UI Icon Info" id="traverseComposeOfonlyMessage"><span></span></a>
                </th>
                <td>
                    <syswf:selectOne id="${prefix}_traverseComposeOfonly" name="traverseComposeOfonlySelect"
                                     value="${processBean.process}" property="traverseComposeOfRel"
                                     dataType="boolean" optionValues="true" optionCaptions=""
                                     mode="checkbox"/>
                </td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline" for="${prefix}_automaticProcessId_0">
                        <c:out value="${automaticProcessLabel}"/>
                    </label>
                    <a href="javascript:void(0)" class="UI Icon Info" id="automaticProcessMessage"><span></span></a>
                </th>
                <td>
                    <syswf:selectOne id="${prefix}_automaticProcessId" name="automaticProcessSelect"
                                     value="${processBean.process}" property="defaultProcess"
                                     dataType="boolean" optionValues="true" optionCaptions=""
                                     mode="checkbox"/>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="x-hidden flyout-menu UI Dropdown" id="automaticProcessMessage_content">
            <div class="DropdownContent">
                <p class="Comment">${automaticProcessMessage}</p>
            </div>
        </div>
        
        <div class="x-hidden flyout-menu UI Dropdown" id="traverseComposeOfonlyMessage_content">
            <div class="DropdownContent">
                <p class="Comment" style="width:280px">${traverseComposeOfonlyMessage}</p>
            </div>
        </div>

		<div class="x-hidden flyout-menu UI Dropdown" id="traverseArchimateRelationshipsMessage_content">
            <div class="DropdownContent">
                <p class="Comment" style="width:260px">${traverseArchimateRelationshipsMessage}</p>
            </div>
        </div>

        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Dropdown.init('automaticProcessMessage', 'automaticProcessMessage_content', { align: 'tl-tr?', alignOffset: [0,0] });
                Dropdown.init('traverseComposeOfonlyMessage', 'traverseComposeOfonlyMessage_content', { align: 'tl-tr?', alignOffset: [0,0] });
                Dropdown.init('traverseArchimateRelationshipsMessage', 'traverseArchimateRelationshipsMessage_content', { align: 'tl-tr?', alignOffset: [0,0] });
				if (!Ext.get('${prefix}_traverseArchimateRelationships_0').dom.checked)
                {
					Ext.get('${prefix}_traverseComposeOfonly_0').dom.disabled = true;
                }
                Ext.get('${prefix}_traverseArchimateRelationships_0').on('click',
                        function() {
                            if (Ext.get('${prefix}_traverseArchimateRelationships_0').dom.checked)
                            {
                            	Ext.get('${prefix}_traverseComposeOfonly_0').dom.disabled = false;
                            } else {
                            	Ext.get('${prefix}_traverseComposeOfonly_0').dom.disabled = true;
                            	Ext.get('${prefix}_traverseComposeOfonly_0').dom.checked = false;
                            }

               });
            });

            Ext.get('${prefix}_automaticProcessId_0').on('click',
                    function() {
                        if (Ext.get('${prefix}_automaticProcessId_0').dom.checked)
                        {
                            AdvancedOptions.Form.Switch('advancedoptions_contents', 'advancedoptions_contents_categorized');
                        } else {
                            AdvancedOptions.Form.Switch('advancedoptions_contents', 'advancedoptions_contents_empty');
                        }
                    });
            

        
//]]>
        </script>

        <div id="advancedoptions_contents" class="UI OptionAreas">
            <c:choose>
                <c:when test="${processBean.process.defaultProcess}">
                    <c:set var="emptyClass" value="UI OptionArea x-hidden"/>
                    <c:set var="categorizedClass" value="UI OptionArea"/>
                </c:when>
                <c:otherwise>
                    <c:set var="emptyClass" value="UI OptionArea"/>
                    <c:set var="categorizedClass" value="UI OptionArea x-hidden"/>
                </c:otherwise>
            </c:choose>

            <div id="advancedoptions_contents_empty" class="${emptyClass}">
            </div>
            <div id="advancedoptions_contents_categorized" class="${categorizedClass}">
                <div class="UI Border">
                    <table class="UI Table Properties" summary="">
                        <colgroup>
                            <col class="MidLabelCol"/>
                            <col/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>
                                <label class="UI Label Inline">${positiveCategoriesLabel}</label>
                                <a href="javascript:void(0)" class="UI Icon Info"
                                   id="positiveCategoriesMessage"><span></span></a>
                            </th>
                            <td>
                                <syswf:component prefix="inCategories" name="/core/impl/widget/categoryBagWidget" ajax="true">
                                    <syswf:param name="model" value="${inCategoriesWidgetModel}"/>
                                    <syswf:param name="mode" value="edit"/>
                                    <syswf:param name="title" value="${positiveCategoriesLabel}"/>
                                    <syswf:param name="doNotWrap" value="true"/>
                                </syswf:component>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <label class="UI Label Inline">${negativeCategoriesLabel}</label>
                                <a href="javascript:void(0)" class="UI Icon Info"
                                   id="negativeCategoriesMessage"><span></span></a>
                            </th>
                            <td>
                                <syswf:component prefix="notInCategories" name="/core/impl/widget/categoryBagWidget" ajax="true">
                                    <syswf:param name="model" value="${notInCategoriesWidgetModel}"/>
                                    <syswf:param name="mode" value="edit"/>
                                    <syswf:param name="title" value="${negativeCategoriesLabel}"/>
                                    <syswf:param name="doNotWrap" value="true"/>
                                </syswf:component>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <label class="UI Label Inline">${inDomainsLabel}</label>
                                <a href="javascript:void(0)" class="UI Icon Info"
                                   id="domainsMessage"><span></span></a>
                            </th>
                            <td>
                                <syswf:component prefix="inDomains" name="/core/category/domainBag" ajax="true">
                                    <syswf:param name="model" value="${inDomainsModel}"/>
                                    <syswf:param name="mode" value="edit"/>
                                    <syswf:param name="title" value="${inDomainsLabel}"/>
                                    <syswf:param name="doNotWrap" value="true"/>
                                    <syswf:param name="forceAllForEmpty" value="true"/>
                                </syswf:component>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="x-hidden flyout-menu UI Dropdown" id="positiveCategoriesMessage_content">
                        <div class="DropdownContent">
                            <p class="Comment">${positiveCategoriesMessageText}</p>
                        </div>
                    </div>

                    <div class="x-hidden flyout-menu UI Dropdown" id="negativeCategoriesMessage_content">
                        <div class="DropdownContent">
                            <p class="Comment">${negativeCategoriesMessageText}</p>
                        </div>
                    </div>

                    <div class="x-hidden flyout-menu UI Dropdown" id="domainsMessage_content">
                        <div class="DropdownContent">
                            <p class="Comment">${domainsMessageText}</p>
                        </div>
                    </div>

                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            Dropdown.init('positiveCategoriesMessage', 'positiveCategoriesMessage_content', { align: 'tl-tr?', alignOffset: [0,0] });
                        });
                        Ext.onReady(function() {
                            Dropdown.init('negativeCategoriesMessage', 'negativeCategoriesMessage_content', { align: 'tl-tr?', alignOffset: [0,0] });
                        });
                        Ext.onReady(function() {
                            Dropdown.init('domainsMessage', 'domainsMessage_content', { align: 'tl-tr?', alignOffset: [0,0] });
                        });
                    
//]]>
                    </script>
                </div>
            </div>
        </div>
    </div>
</syswf:block>

<syswf:block className="UI Block Green">
    <div class="Content">
        <div class="UI Form Controls">
            <syswf:control mode="postAnchor" action="save" caption="${saveButton}">
                <syswf:attribute name="class" value="btn btn-primary"/>
            </syswf:control>
            <syswf:control mode="postAnchor" action="cancel" caption="${cancelButton}"
                           targetDepth="${sessionStack.currentDepth-1}">
                <syswf:attribute name="class" value="btn btn-gray"/>
            </syswf:control>
        </div>
    </div>
</syswf:block>
</td>
</tr>
</table>
</c:if>