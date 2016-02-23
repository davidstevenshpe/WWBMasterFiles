<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages" />
<fmt:message var="requiredAuthenticationLabel" key="requiredAuthenticationLabel" bundle="${importsMessages}" />
<fmt:message var="authUserNameLabel" key="authUserNameLabel" bundle="${importsMessages}" />
<fmt:message var="authPasswordLabel" key="authPasswordLabel" bundle="${importsMessages}" />
<fmt:message var="authUsernameHint" key="authUsernameHint" bundle="${importsMessages}" />
<fmt:message var="authPasswordHint" key="authPasswordHint" bundle="${importsMessages}" />
<fmt:message var="remember_credential" key="credential.remember" bundle="${importsMessages}" />
<fmt:message var="dropRelationsHint" key="import.csv.dropRelationsHint" bundle="${exportmessages}" />
<fmt:message var="artifactTypeHint" key="import.csv.artifactTypeHint" bundle="${exportmessages}" />
<fmt:message var="ignoreUnknownHint" key="import.csv.ignoreUnknownHint" bundle="${exportmessages}" />
<fmt:message var="tokenHint" key="import.csv.tokenHint" bundle="${exportmessages}" />
<fmt:message var="separatorHint" key="import.csv.separatorHint" bundle="${exportmessages}" />
<fmt:message var="modeInsertHint" key="import.csv.modeInsertHint" bundle="${exportmessages}" />
<fmt:message var="modeUpdateHint" key="import.csv.modeUpdateHint" bundle="${exportmessages}" />
<fmt:message var="modeIgnoreHint" key="import.csv.modeIgnoreHint" bundle="${exportmessages}" />
<fmt:message var="dateFormatHint" key="import.csv.dateFormatHint" bundle="${exportmessages}" />
<fmt:message var="updateEmptyFieldsHint" key="import.csv.updateEmptyFieldsHint" bundle="${exportmessages}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
	<syswf:param name="title">Microsoft Excel & CSV File Import</syswf:param>
</syswf:component>

<syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
	<syswf:param name="message">You can prepare the data in Microsoft Excel and import them into HP EM later on. 
You can also export data from other systems and import them into EM in CSV file format.</syswf:param>
</syswf:component>
<br />


<syswf:block className="UI Block Common">
	<table class="UI Table Properties">
		<colgroup>
			<col class="MidLabelCol" />
			<col />
		</colgroup>
		<tbody>
			<tr>
                    <th>
                        <label class="UI Label Long" id="artifactTypeMessage"><fmt:message bundle="${exportmessages}" key="import.csv.artifactType" /></label>
                    </th>
                    <td><syswf:selectOne id="${prefix}_artifactType" name="artifactType" mode="menu" optionValues="${bean.artifactValues}"
                            optionCaptions="${bean.artifactCaptions}" value="${bean}" property="artifactType" />
                            <fmt:message bundle="${exportmessages}" key="Import" var="import" />
                    </td>
                    <td>
                    <c:if test="${empty firstTemplateDataLocation}">No template available for the selected type.
                    </c:if>
                    <c:if test="${not empty firstTemplateDataLocation}">
	                    <syswf:control mode="anchor" targetTask="../../../platform/rest/location${firstTemplateDataLocation}" targetDepth="0" caption="Download Template to Get Started" hint="Download content" id="${prefix}_downloadContent">
	                      <syswf:attribute name="class" value="btn btn-primary btn-labeled fa fa-download ng-touched" />
	                    </syswf:control>
                    </c:if>
                    </td>
                </tr>
		</tbody>
	</table>

	<script type="text/javascript">

	Ext.onReady(function() {
		var var_${prefix}_artifactType = new Ext.HP.ComboBox({
			id: '${prefix}_artifactType',
			transform: '${prefix}_artifactType',
			forceSelection: true,
			typeAhead: false,
			disableKeyFilter: false,
			editable: true,
			listWidth : 250,
			width : 250,
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
	
    </script>
	<%-- Advance Options--%>
	<syswf:wrap template="/templates/advancedOptions.jsp">
		<syswf:param name="advancedOptionsOpenerHolder" value="${bean}" />
		<table class="UI Table Properties">
			<colgroup>
				<col class="MidLabelCol" />
				<col />
			</colgroup>
			<tbody>
				
				<tr>
					<th>
						<label class="UI Label Long" id="ignoreUnknownMessage"><fmt:message bundle="${exportmessages}" key="import.csv.ignoreUnknown" /></label>
					</th>
					<td><syswf:selectOne mode="checkbox" value="${bean}" id="${prefix}_ignoreUnknown" property="ignoreUnknown" optionValues="true" name="ignoreUnknown"
							dataType="boolean" optionCaptions=" " hint="">
							<syswf:attribute name="class" value="UI Form Checkbox" />
						</syswf:selectOne></td>
				</tr>
			</tbody>
		</table>

	</syswf:wrap>
	<%-- End Advance Options--%>

    <c:if test="${not empty templateUuids}"><c:out value="Found template artifacts with UUID:"/><br/><br/>
        <c:forEach var="templateUuid" items="${templateUuids}" varStatus="status">
          <b><c:out value="${templateUuid}"/></b> (<a href="../../artifact/${templateUuid}">Go to template</a>, 
          <syswf:control mode="anchor" targetTask="/common/downloadContent" caption="Download content" hint="Download content" id="${prefix}_downloadContent_${status.count}">
            <syswf:param name="uuidStr" value="${templateUuid}" />
          </syswf:control>
          )<br/><br/>
        </c:forEach>
    </c:if>
</syswf:block>


<syswf:block className="UI Block Green">
	<div class="Content">
		<div class="UI Form Controls">
			<fmt:message bundle="${exportmessages}" key="Import" var="import" />
			<syswf:control id="${prefix}Check" mode="postAnchor" caption="Check Templates" action="checkExistingTemplate" wrapper="span">
				<syswf:attribute name="class" value="btn btn-primary" />
				<syswf:param name="selectedArtifactType"></syswf:param>
			</syswf:control>
			<fmt:message bundle="${messages}" key="Cancel" var="cancel" />
			<syswf:control id="${prefix}Cancel" mode="postAnchor" caption="${cancel}" action="cancel" wrapper="span" targetDepth="${sessionStack.currentDepth - 1}"/>
		</div>
	</div>
</syswf:block>
