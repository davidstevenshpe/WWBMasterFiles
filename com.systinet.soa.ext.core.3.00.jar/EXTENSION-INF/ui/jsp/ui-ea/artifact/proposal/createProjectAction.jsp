<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>
<c:if test="${projectAction eq true}">
<fmt:message var="createProject" key="proposal.architecture.project.createAction" bundle="${uisccomponentsmessages}"/>
<fmt:message var="createProjectHint" key="proposal.architecture.project.createDesc" bundle="${uisccomponentsmessages}"/>
<fmt:message var="windowHint" key="proposal.architecture.project.window.createDesc" bundle="${uisccomponentsmessages}"/>
<fmt:message var="createProjectWinTitle" key="proposal.architecture.projectCreateTitle" bundle="${uisccomponentsmessages}">
	<fmt:param value="${artifact.name}"/>
</fmt:message>
<fmt:message var="createLabel" key="proposal.architecture.action.create" bundle="${uisccomponentsmessages}"/>
<fmt:message var="cancelLabel" key="proposal.architecture.action.cancel" bundle="${uisccomponentsmessages}"/>
<fmt:message var="startDateLabel" key="proposal.architecture.project.startDate" bundle="${uisccomponentsmessages}"/>
<fmt:message var="endDateLabel" key="proposal.architecture.project.endDate" bundle="${uisccomponentsmessages}"/>
<c:set var="caption" value="${createProject}" />
<c:set var="hint" value="${createProjectHint}" />

<syswf:control mode="script" caption="${prefix}_createProject" action="createProject" affects="."/>
<a id="${prefix}_link" href="javascript:void(0);" title="${hint}">${caption}</a>
<br/>
<br/>
<script type="text/javascript">
//<![CDATA[

    Ext4.onReady(function() {
        var plateaus = ${plateaus}, domainId = '${domainId}';
	$('#${prefix}_link').click(function() {
			var win = Ext4.create('Ext.window.Window', {
				title : '<syswf:out value="${createProjectWinTitle}" context="HtmlJSText"/>',
				height : 240,
				width : 500,
				layout : 'fit',
				items : {
					xtype : 'panel',
					border : false,
					padding : '10 0 5 20',
					items : [ 
					{
						xtype : 'label',
						style: 'font-style: italic;',
						text : '<syswf:out value="${windowHint}" context="HtmlJSText"/>'
					}, {
						padding: '20 0 0 0',
						id : '${prefix}_name',
						fieldLabel : 'Name',
						xtype : 'textfield',
						width : 440,
						validator: function(value) {
							var isEmpty = (value.trim() == '');
							Ext4.getCmp('${prefix}_createBtn').setDisabled(isEmpty);
							return !isEmpty;
						}
					}, {
						fieldLabel : '${startDateLabel}',
						id : '${prefix}_start',
						xtype : 'datefield'
					}, {
						fieldLabel : '${endDateLabel}',
						id : '${prefix}_end',
						xtype : 'datefield'
					} ],
					buttons : [ {
						text : '${createLabel}',
						id: '${prefix}_createBtn',
						disabled: true,
						handler : function() {
							win.mask('...');
							var startDate = Ext4.getCmp('${prefix}_start').getValue(), endDate = Ext4.getCmp('${prefix}_end').getValue();
							
							${prefix}_createProject({
								projectName: Ext4.getCmp('${prefix}_name').value.trim(),
								projectStartDate: startDate != null ? startDate.getTime() : '',
								projectEndDate: endDate != null ? endDate.getTime() : '',
								plateauUuids: plateaus,
								domainId: domainId,
								callback: function () {
									window.location.reload();
								}
							});
						}
					}, {
						text : '${cancelLabel}',
						handler : function() {
							win.close();
						}
					} ]
				}
			})
			win.show();
		});
	});

	//]]>
</script>
</c:if>
