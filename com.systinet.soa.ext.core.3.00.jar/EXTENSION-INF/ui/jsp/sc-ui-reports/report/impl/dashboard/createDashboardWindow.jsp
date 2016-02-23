<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="reportMessage"/>
<fmt:message bundle="${reportMessage}" key="dashboard.create.window.input.name" var="inputName" />
<fmt:message bundle="${reportMessage}" key="dashboard.create.window.select.folder" var="selectFolder" />
<fmt:message bundle="${reportMessage}" key="dashboard.create.window.select.layout" var="selectLayout" />
<fmt:message bundle="${reportMessage}" key="dashboard.create.window.invalid.name" var="invalidName" />


<div style="padding:0 10px">
	<div class="cell-container">
		<div style="width:100px">
			${inputName}
			<sup class="Required" title="Required">*</sup>
		</div>
		<div>
			<syswf:input id="dashboardInputName" name="dashboardInputName" value="${holder}" property="name"/>
		</div>		
	</div>
	
	<div class="cell-container">
		<div style="width:100px; height: 20px;"></div>
		<div id="createDashboardWinInvalidNameMsg" style="display: none">
			<em class="x-form-invalid-msg UI Invalid">
				<span>${invalidName}</span>
			</em>
		</div>
	</div>	
	
	<div class="cell-container">
		<div style="width:100px">${selectFolder}</div>
		<div>
			<syswf:selectOne id="dashboardFolderSelector" name="dashboardFolderSelector" mode="menu" 
				value="${holder}" property="id" 
				optionValues="${dashboardFolders}" optionValuesProperty="id" 
				optionCaptions="${dashboardFolders}" optionCaptionsProperty="folderName"/>
		</div>
	</div>
	<br>
	<div>${selectLayout}</div>
	<br>
	<div id="create-dashboard-layout-selector">
		<div class="cell-container"></div>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
	Ext.onReady(function() {
		 moveWindow('${moveId}','popupWindows');
		
		 var dashboardInputName = new Ext.form.TextField({
	         id: 'dashboardInputName',
	         emptyText: '',
	         applyTo: 'dashboardInputName',
	         stateful: false,
	         width: 198,
	         listeners: {
	             focus: function(field){
	            	 Ext.apply(field, {allowBlank: true}, {});
	             },
	             blur: function(field){
	            	 if(field.getValue().trim().length == 0){
	            		 field.markInvalid('');
	            		 Ext.get('createDashboardWinInvalidNameMsg').setStyle('display', 'block');
	            	 }else{
	            		 Ext.get('createDashboardWinInvalidNameMsg').setStyle('display', 'none');
	            	 }
            	}
             }
	     });
		 
		 var dashboardFolderSelector = new Ext.HP.ComboBox({
	         id: 'dashboardFolderSelector',
	         transform: 'dashboardFolderSelector',
	         forceSelection: false,
	         typeAhead: true,
	         disableKeyFilter: false,
	         editable: true,
	         width: 200
	     });
	 

	 
		var dashboardConfig = ${dashboardLayouts};
		var layouts = dashboardConfig.layouts;
		
		var parseRow = function(config, numRows) {
			var height = (100 - 4*(numRows - 1))/numRows;
			var row = '<div class="row cell-container" style="height:' + height + '%">';

			if(config.columns instanceof Array) {
				for(var i=0; i<config.columns.length; i++) {
					var width = (100 - 4*(config.columns.length - 1))/config.columns.length;
					row +='<div class="column" style="width:' + width + '%"></div>';
					
					if(i<config.columns.length-1) {
						row += '<div class="sep"></div>';
					}
				}
			}else{
				row +='<div class="column" style="width:100%"></div>';
			}	
			return row + '</div>';
		}
		var content = '';
		
		for(var i=0; i < layouts.length; i++) {
			content +='<div name="layout-' + i + '" class="layout' + (i==0?' selected':'') + '">';
			var layout = layouts[i];
			if(layout instanceof Array) {
				for(var j=0; j<layout.length; j++) {
					content += parseRow(layout[j], layout.length);
					if(j<layout.length-1) {
						content += '<div class="sep"></div>';
					}
				}
				
			}else{
				content += parseRow(layout, 1);
			}
			content +='</div><div class="sep"></div>';
			if(i == layouts.length-1) {
				content += '<div class="sep"></div>';
			}
		}
		var layoutSelector = $('#create-dashboard-layout-selector');

		$('> .cell-container', layoutSelector).html(content).width(layouts.length*200);
		
		$('#dashboardSelectedLayout').attr('value', JSON.stringify(layouts[0]));
		
		$('.layout', layoutSelector).click(function() {
			$('.layout.selected', layoutSelector).removeClass('selected');
			$(this).addClass('selected');
			var index = parseInt($(this).attr('name').replace('layout-', ''));
			$('#dashboardSelectedLayout').attr('value', JSON.stringify(layouts[index]));
		});
	});
//]]>
</script>
