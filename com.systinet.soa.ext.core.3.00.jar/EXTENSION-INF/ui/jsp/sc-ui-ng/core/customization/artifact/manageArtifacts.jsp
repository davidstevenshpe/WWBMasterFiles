<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="title" key="manageArtifacts.title" bundle="${bundle}"/>
<fmt:message var="uiguide" key="ui.guide" bundle="${bundle}"/>
<fmt:message var="gendisabletip" key="option.generate.disable.tip" bundle="${bundle}"/>
<fmt:message var="genenabletip" key="option.generate.tip" bundle="${bundle}">
	<fmt:param value="tabName"/>
</fmt:message>

<fmt:message var="inforTitle" key="manageArtifacts.infor.title" bundle="${bundle}"/>
<fmt:message var="confirmationTitle" key="manageArtifacts.confirmation.title" bundle="${bundle}"/>
<fmt:message var="overwriteConfirmMsg" key="manageArtifacts.custom.overwrite.confirmMsg" bundle="${bundle}"/>
<fmt:message var="generateSdmConfirmMsg" key="manageArtifacts.generateSdm.confirmMsg" bundle="${bundle}"/>
<fmt:message var="showHiddenArtifactConfirmMsg" key="manageArtifacts.show.hiddenArtifact.confirmMsg" bundle="${bundle}"/>
<fmt:message var="saveCustomConfirmMsg" key="manageArtifacts.custom.save.confirmMsg" bundle="${bundle}"/>
<fmt:message var="refreshGridMsg" key="manageArtifacts.refreshGrid.inforMsg" bundle="${bundle}"/>
<fmt:message var="undoChangeConfirmMsg" key="manageArtifacts.undoChange.confirmMsg" bundle="${bundle}"/>

<fmt:message var="description" key="manageArtifacts.description" bundle="${bundle}"/>
<fmt:message var="description1" key="manageArtifacts.description1" bundle="${bundle}"/>
<fmt:message var="description2" key="manageArtifacts.description2" bundle="${bundle}"/>
<fmt:message var="infoRedirect" key="manageArtifacts.info.redirect" bundle="${bundle}"/>
<fmt:message var="infoCopy" key="manageArtifacts.info.copy" bundle="${bundle}"/>
<fmt:message var="infoGenerate" key="manageArtifacts.info.generate" bundle="${bundle}"/>
<fmt:message var="infoReset" key="manageArtifacts.info.reset" bundle="${bundle}"/>
<fmt:message var="infoRestore" key="manageArtifacts.info.restore" bundle="${bundle}"/>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>
<fmt:message var="showMoreLabel" key="show.more.information" bundle="${uisccomponentsmessages}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<syswf:control mode="script" caption="${prefix}_updateCustomization" action="updateCustomization"/>
<syswf:input id="updateData" name="data" mode="hidden" value="" />

<syswf:input id="checkingHiddenNotBrowseringData" name="artifactsDataToCheckNotBrowsering" mode="hidden" value="" />

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="manageArtifacts"/>
  <syswf:param name="code">
    function getDisplayHiddenNotBroweringArtifacts(dataToCheck)
    {
       return Packages.com.hp.systinet.sc.ui.impl.customization.artifact.ManagerVisibilityArtifacts.getInstance().getDisplayHiddenNotBroweringArtifacts(dataToCheck);
    }
  </syswf:param>
</syswf:component>

<style type="text/css">
    .myGridNoPaddingStyle .x-panel-mc {
		 padding: 0px;
	}
	.myGridNoPaddingStyle .x-panel-tl  {
		 padding: 0px;
	}
	.myGridNoPaddingStyle  .x-panel-ml  {
		 padding: 0px;
	}
	.myGridNoPaddingStyle  .x-panel-mr {
		 padding: 0px;
	}
	.myGridNoPaddingStyle  .x-panel-bc {
		 height: 0px;
	}
	.myGridPaddingLeft{
		margin-left: 16px;
  		margin-right: 10px;
	}
	.btMarginLeft{
		margin-left: 5px;
	}
	.x-combo-list-item-unsel{
		color: #8F8989;
	}
	.x-grid3-cell.custom
	{
		background-color: #ffc;
	}
	.x-grid3-cell.default
	{
		background-color: #5DFF3E;
	}
	.x-grid3-cell.redirect
	{
		background-color: #9fc;
	}
	input.x-form-text.x-form-field.x-trigger-noedit.x-form-focus, .x-small-editor .x-form-field-wrap img.x-form-trigger {
		height: 24px!important;
	}
	
	div.UI.SystemMessage.Info {
		margin: 0 10px 10px 16px;
	}
	
</style>
<div class="UI Text Description" style="padding-left:2px;margin-bottom:0px">
	<p>
		<i style="font-size: 16px;line-height:20px">
			<c:out value="${description}"/><br>
			<c:out value="${description1}"/><br> 
			<c:out value="${description2}"/>
		</i>
	</p>   
	
	<div style="padding-left:10px">
		<div style="display: inline-block;margin-bottom:4px">
			<button class="btn btn-gray btn-em info" help-text="less" onclick="return layoutManager.toggleHelpText(this);">
				<span><c:out value="${showMoreLabel}"/></span>
			</button>
		</div>
		<div class="help-text" style="display: none; line-height: 17px;" >		
			${infoRedirect} <br>
			${infoCopy} <br>
			${infoGenerate}<br>
			${infoReset}<br>
			${infoRestore} 
		 </div>
	</div>
	<div style="padding-left:2px;font-size: 20px;margin-top: 8px;">
		<p id="changes_notification" style="margin-bottom:0px;display:none;">There are 0 changes so far.</p>   
	</div>	
</div>
<c:if test="${not empty messages}">
<div class="UI SystemMessage Info">
	<div class="MessageContainer ">
		<div class="Text">
		<c:forEach var="item" items="${messages}">
			<c:out value="${item}"/><br/>
		</c:forEach>
		</div>
	<div class="x-clear"></div>
	</div>
</div>
</c:if>

<div id="editor-grid" class="myGridPaddingLeft"></div><br />

<div id="btnGroup" style="margin: 0 0 20px 17px;">
</div>

<script type="text/javascript">
//<![CDATA[
var btSaveClick = function(){};
var grid = null;
var rowdblclick = function(grid, rowIndex, event){
	var record = grid.getStore().getAt(rowIndex);
	if (!record.data.isLeaf){
		var level = record.data.level;
		var collapseUrl = '<c:out value="${baseUrl}"/>/../design/base/skin/ext3/resources/images/default/tree/elbow-plus.gif';
		var expandUrl = '<c:out value="${baseUrl}"/>/../design/base/skin/ext3/resources/images/default/tree/elbow-end-minus.gif';
		var imgEl = Ext.get('img_' + record.data.rowId).dom;
		var expanded = imgEl.src.indexOf('elbow-end-minus.gif') > 0;
		for (var rowIdx = rowIndex + 1; rowIdx < grid.getStore().getTotalCount(); rowIdx++){
			var childRow = grid.getStore().getAt(rowIdx);
			if (childRow.data.level > level){
				if (expanded){
					if (childRow.data.level > level + 1){
						childRow.data.visible = grid.getView().getRow(rowIdx).style.display != 'none';
					}
					grid.getView().getRow(rowIdx).style.display = 'none';
					imgEl.src = collapseUrl;

				}else{
					if (childRow.data.level == level + 1){
						grid.getView().getRow(rowIdx).style.display = '';
					}else{
						if (childRow.data.visible != null){
							if (childRow.data.visible){
								grid.getView().getRow(rowIdx).style.display = '';
							}else{
								grid.getView().getRow(rowIdx).style.display = 'none';
							}
						}
					}
					imgEl.src = expandUrl;
				}
			}else{
				break;
			}
		}
	}
};

function fixEmptyCmbName(){
	<c:forEach var="item" items="${tabCols}">
		cmbInput = Ext.get('${item.value}_FieldId');
		if (cmbInput != null && cmbInput.dom != null){
			cmbInput.dom.name = '${item.value}_FieldName';
		}
	</c:forEach>
}

Ext.override(Ext.form.ComboBox, {
    // private
    onViewClick : function(doFocus){
        var index = this.view.getSelectedIndexes()[0];
        var r = this.store.getAt(index);
        var sel = null;
        sel = r.get('selectable');
        if(!sel){
            if(sel == false){
                return;
            }
        }
        if(r){
            this.onSelect(r, index);
        }
        if(doFocus !== false){
            this.el.focus();
        }
    }
}
);

Ext.onReady(function(){

    //$("#changes_notification").hide();

	var spaceCmb = '&nbsp;&nbsp;&nbsp;&nbsp;';
<c:forEach var="tabCol" items="${tabCols}" varStatus="status">
	<c:set var="count" value="1"/>
	var ${tabCol.value}CustomizeOptions = [
	<c:forEach var="item" items="${selectOptions[status.index]}">
		<c:if test="${count gt 1}">,</c:if>['${item.value}','<syswf:addSlashes>${item.name}</syswf:addSlashes>',${item.selectable}, '<syswf:addSlashes>${item.tip}</syswf:addSlashes>' ]
	    <c:set var="count" value="${count + 1}"/>
	</c:forEach>
	];
	var ${tabCol.value}StoreCmb = new Ext.data.ArrayStore({
		storeId : '<c:out value="${tabCol.name}" escapeXml="true"/>',
		fields: ['value', 'name', 'selectable', 'tip'],
		data : ${tabCol.value}CustomizeOptions
	});
</c:forEach>

	var deprecatedSoaArray = [
	<c:forEach var="artifact" items="${deprecatedSoaArtifacts}" varStatus="status">
		'${artifact}',
	</c:forEach>
	];
	<c:set var="count" value="1"/>
	var tabs = [<c:forEach var="tabCol" items="${tabCols}" varStatus="status"><c:if test="${count gt 1}">,</c:if>'${tabCol.value}'
	<c:set var="count" value="${count + 1}"/></c:forEach>];	    
	
	var cmbSelect = function cmbSelect(combo, record, index){
		var comboValue = combo.getValue();
		if (comboValue != null){
			comboValue = comboValue.replace(spaceCmb, '');
		}
		if (comboValue != null && comboValue.indexOf('to') == 0){
			comboValue = 'Redirect ' + comboValue;
		}
		combo.setValue(comboValue);

		var editCol = tabs[combo.gridEditor.col - 1];
		var oldValue = combo.gridEditor.record.data[editCol + 'Value'];
		var newValue = record.data.value;
		if (!('scratch' == newValue || 'edit' == newValue)){
			combo.gridEditor.record.data[editCol + 'NewValue'] = newValue;
		}
	}

	var restoreOpt = new ${tabCols[0].value}StoreCmb.recordType({  value: 'restore', name: 'Restore custom view', selectable: true, tip: 'Click to restore custom view' });
	var genEnanbleOpt = new ${tabCols[0].value}StoreCmb.recordType({  value: 'generate', name: 'Generate from SDM', selectable: true, tip: '' });
	var genDisableOpt = new ${tabCols[0].value}StoreCmb.recordType({  value: 'generate', name: 'Generate from SDM', selectable: false, tip: '' });
	var resetOpt;

	var cmbBeforeShow = function cmbBeforeShow(combo, record, index){
		fitComboBoxToGridCell(combo);
		// append 'restore'
		var editCol = tabs[combo.gridEditor.col - 1];
		var cellValue = combo.gridEditor.record.data[editCol + 'Value'];
	   
	    if (cellValue.indexOf('redirect$') >= 0){
			if (combo.getStore().indexOf(restoreOpt) == -1){
				combo.getStore().add(restoreOpt);
			}
		} else{
			if (combo.getStore().indexOf(restoreOpt) != -1){
				combo.getStore().remove(restoreOpt);
			}
		}
	    
		var idxGenerateOpt = combo.getStore().find('value', 'generate');
		if (idxGenerateOpt >= 0) {
			combo.getStore().remove(combo.getStore().getAt(idxGenerateOpt));
			if (isDeprecatedSOAArtifact(combo.gridEditor.record.data.rowId)){		
				genDisableOpt.data.tip = "${gendisabletip}";
				combo.getStore().add(genDisableOpt);
			}else{
			    genEnanbleOpt.data.tip = "${genenabletip}".replace("tabName",combo.getStore().storeId);
				combo.getStore().add(genEnanbleOpt);
			}
		}
	}

	var cmbBeforeSel = function cmbBeforeSel(combo, record, index){
		// fix combo space
		var editCol = tabs[combo.gridEditor.col - 1];
		var cellValue = combo.gridEditor.record.data[editCol + 'Value'];

		if ('reset' == record.data.value){
			if ('custom' == cellValue){
				grid.stopEditing(true);
				Ext.Msg.show({
						title: '${confirmationTitle}',
						msg: '${overwriteConfirmMsg}',
						modal: true,
						icon: Ext.Msg.QUESTION,
						buttons: Ext.Msg.YESNO,
						fn: function(s){
							if (s == 'yes'){
								combo.gridEditor.record.data[editCol + 'NewValue'] = 'reset';
								combo.gridEditor.record.set(editCol + 'Name', 'Reset to Default');
							}
						}
				});
				return false;
			} else{
				return true;
			}
		} else if ('generate' == record.data.value && 'generate' != cellValue){
			grid.stopEditing(true);
			if (cellValue != 'hide') {
				Ext.Msg.show({
					title: '${confirmationTitle}',
					msg: "${generateSdmConfirmMsg}",
					modal: true,
					icon: Ext.Msg.QUESTION,
					buttons: Ext.Msg.YESNO,
					fn: function(s){
						if (s == 'yes'){
							combo.gridEditor.record.data[editCol + 'NewValue'] = 'generate';
							combo.gridEditor.record.set(editCol + 'Name', 'Generate from SDM');
						}
					}
				});				
			} else {
				combo.gridEditor.record.data[editCol + 'NewValue'] = 'generate';
				combo.gridEditor.record.set(editCol + 'Name', 'Generate from SDM');				
			}

			return false;
		}
	}

	function fitComboBoxToGridCell(combo){
		var indexCol = combo.gridEditor.col;
		var colWidth = grid.getColumnModel().getColumnWidth(indexCol);
		combo.el.dom.parentNode.style.width = colWidth + "px";
		combo.el.dom.style.width = (colWidth - combo.getTriggerWidth()) + "px";
	}
	function isDeprecatedSOAArtifact(artifactName){
		var found = false;
		for (i = 0; i < deprecatedSoaArray.length ; i++) {
		  if (deprecatedSoaArray[i] === artifactName) {
			return true;
		  }
		}
		return found;
	}

    var cmbTpl= new Ext.XTemplate(
    	'<tpl for=".">' ,
		'<div ext:qtip="{tip}" class="x-combo-list-item ' ,
		'<tpl if="selectable == false">' ,
		'x-combo-list-item-unsel' ,
		'</tpl>' ,
    	'">{name}</div>' ,
    	'</tpl>');

	var nameTpl = new Ext.XTemplate(
        '<tpl if="isLeaf == true">',
		'<span style="padding-left: {level * 20}px"><img src="<c:out value="${baseUrl}"/>/../design/base/skin/img/default/icon_hierarchy_leaf.png"/>{name}</span>',
        '</tpl>',
		'<tpl if="isLeaf == false">',
		'<span style="padding-left: {level * 20}px"><img id="img_{rowId}" onclick="javascript: rowdblclick(grid,{id} - 1, null)" src="<c:out value="${baseUrl}"/>/../design/base/skin/ext3/resources/images/default/tree/elbow-end-minus.gif"/><img src="<c:out value="${baseUrl}"/>/../design/base/skin/img/default/icon_hierarchy_branch_open.png"/>{name}</span>',
        '</tpl>'
    );

	var changeCellColor = function (value, meta, record) {
		if (value == 'Custom') {
			meta.css = 'custom';
		} if (value == 'Default') {
			meta.css = 'default';
		} else if (value != null && value.indexOf('Redirect') >= 0) {
			meta.css = 'redirect';
		}
		return value;
	}

    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store (created below)
    var cm = new Ext.grid.ColumnModel({
        // specify any defaults for each column
        defaults: {
			// columns are not sortable by default
            sortable: false
        },
        columns: [
			{
	            id: 'name',
	            header: 'Artifact Type',
	            width: 220,
				xtype: 'templatecolumn',
				tpl: nameTpl
	        }
			<c:forEach var="item" items="${tabCols}">,{
	            header: '<c:out value="${item.name}" escapeXml="true"/>',
	            dataIndex: '${item.value}Name',
	            width: 200,
				renderer: changeCellColor,
				editor: new Ext.form.ComboBox({
					store: ${item.value}StoreCmb,
					//valueField: 'value',
					displayField:'name',
					id:'${item.value}_FieldId',
					editable: false,
					typeAhead: true,
					mode: 'local',
					triggerAction: 'all',
					emptyText:'Click to change...',
					selectOnFocus:true,
					tpl: cmbTpl,
					listeners:{
						select: cmbSelect,					
						beforeselect: cmbBeforeSel,
						beforeshow: cmbBeforeShow
					}
				})
			}
			</c:forEach>
        ]
    });

	var grid_data =
	[
<c:set var="count" value="1"/>
<c:forEach var="item" items="${gridData}">
<c:if test="${count gt 1}">,</c:if>[<c:out value="${count}"/>,'<c:out value="${item.id}"/>','<c:out value="${item.atifactName}"/>',<c:out value="${item.leaf}"/>,<c:out value="${item.level}"/>,<c:out value="${item.editable}"/><c:forEach var="cmb" items="${item.visibilityDatas}">,'<c:out value="${cmb.visibilityValue}"/>','<c:out value="${cmb.visibilityName}"/>'</c:forEach>]<c:set var="count" value="${count + 1}"/></c:forEach>
	];
	var nameRecord = Ext.data.Record.create([
			{ name : 'id', mapping: 0},
            { name : 'rowId', mapping : 1 },
            { name : 'name', mapping : 2 },
            { name : 'isLeaf', mapping : 3 },
			{ name : 'level', mapping : 4 },
			{ name : 'editable', mapping : 5 }
			<c:set var="count" value="6"/>
			<c:forEach var="item" items="${tabCols}">
				,{ name : '<c:out value="${item.value}"/>Value', mapping : <c:out value="${count}"/> }
			    <c:set var="count" value="${count + 1}"/>
			    ,{ name : '<c:out value="${item.value}"/>Name', mapping : <c:out value="${count}"/> }
			    <c:set var="count" value="${count + 1}"/>
			</c:forEach>
        ]);

	var arrayReader = new Ext.data.ArrayReader({}, nameRecord);

	var memoryProxy = new Ext.data.MemoryProxy(grid_data);

	var store = new Ext.data.Store({
            reader : arrayReader,
            proxy : memoryProxy,
            pruneModifiedRecords: true
        });

    // create the editor grid
    grid = new Ext.grid.EditorGridPanel({
        store: store,
        cm: cm,
        renderTo: 'editor-grid',
        width: '100%',
        autoHeight:true,
		border: false,
		cls: 'myGridNoPaddingStyle',
		selModel : new Ext.grid.RowSelectionModel({singleSelect : true}),
        autoExpandColumn: 'name', // column with this id will be expanded
        //title: 'Customization Atifacts',
        frame: true,
        clicksToEdit: 1,
		listeners: {
            beforeedit: function(e) {
                    if (e.record.data.isLeaf == false){
						//return false;
					}
            },
			rowdblclick: rowdblclick
        },
        viewConfig: {
            getRowClass: function (record, rowIndex, rp, store) {
                rp.tstyle += 'height: 26px;';
            }
        }
    });

    // manually trigger the data store load
    store.load({
        // store loading is asynchronous, use a load listener or callback to handle results
        callback: function(){
        }
    });
	
    function btSaveClick(){
		var shouldCheck = determineArtifactsToCheckNotBrowsering();
		if (shouldCheck) {
			fixEmptyCmbName();
			getDisplayHiddenNotBroweringArtifacts(Ext.get('checkingHiddenNotBrowseringData').dom.value, function(invalidArtifacts) {
				if (invalidArtifacts) {
			        var showHiddenArtifactConfirmMsg = "${showHiddenArtifactConfirmMsg}";
			        showHiddenArtifactConfirmMsg = showHiddenArtifactConfirmMsg.replace('{0}', invalidArtifacts);
			    	Ext4.Msg.show({
			    		title: '${confirmationTitle}',
			    		msg: showHiddenArtifactConfirmMsg,
			    		modal: true,
			    		icon: Ext4.Msg.QUESTION,
			    		buttons: Ext4.Msg.YESNO,
			    		fn: function(s){
			    			if (s == 'yes') {
			    				// check data again for up-to-date data.
			    				determineArtifactsToCheckNotBrowsering();
			    				// always saving
			    				performSave(true);
			    			}
			    		}
			    	});
			    } else {
			    	performSave(false);
			    }
			});
		} else {
			performSave(false);
		}
	};
    
	function btCancelClick(){
		var updateddatas = grid.getStore().getModifiedRecords();
		if (updateddatas!= null && updateddatas.length > 0){
			Ext4.Msg.show({
				title: '${confirmationTitle}',
				msg: "${undoChangeConfirmMsg}",
				modal: true,
				icon: Ext4.Msg.QUESTION,
				buttons: Ext4.Msg.YESNO,
				fn: function(s){
					if (s == 'yes'){
						grid.getStore().reload();
						$("#changes_notification").hide();
						Ext4.getCmp("save-btn").setDisabled(true); 
						Ext4.getCmp("cancel-btn").setDisabled(true);
					}
				}
			});
		}
    };
	
	store.on('update',function (store, records, operation){		 	        
		var updateddatas = grid.getStore().getModifiedRecords();
		var count = 0;
        for (var i = 0; i < updateddatas.length; i++){			
			for (var tab in tabs){
				var tabId = tabs[tab];
				var oldValue = updateddatas[i].data[tabId + 'Value'];
				var newValue = updateddatas[i].data[tabId + 'NewValue'];
				if (newValue != null && newValue!= oldValue){					
					count++;
				}
			}			
		}
		var changeText;
		if(count > 0){		   
			$("#changes_notification").show();		
      if(count == 1)	{
        changeText = "There is 1 change so far.";
			} else {
        changeText = "There are " + count +" changes so far.";
      }			
			$("#changes_notification").html(changeText + " <a id=\"apply-link\" href=\"javascript:void(0)\" onclick=\"btSaveClick();\">Apply</a> them now...") ;
			Ext4.getCmp("save-btn").setDisabled(false); 
			Ext4.getCmp("cancel-btn").setDisabled(false); 
			Ext.get('apply-link').on('click', btSaveClick);
		}else{
			$("#changes_notification").hide();
			Ext4.getCmp("save-btn").setDisabled(true); 
			Ext4.getCmp("cancel-btn").setDisabled(true); 		
		}		
	});	
	
    Ext4.create('Ext.Button', {
    	id: 'save-btn',
        text: 'Apply Changes',
        renderTo: 'btnGroup',
        disabled: true,
        margin: '0 5 0 0',
        handler: btSaveClick
    });
    
    Ext4.create('Ext.Button', {
    	id: 'cancel-btn',
        text: 'Undo Changes',
        renderTo: 'btnGroup',
        disabled: true,
        handler: btCancelClick
    });
    
    // Get current snapshot of grid and its data to check if each one them is not hidden.
    // Then encode data in hidden value: checkingHiddenNotBrowseringData for checking later in server.
    // The return value also indicates there are some data needed to be checked.
    function determineArtifactsToCheckNotBrowsering() {
    	var shouldCheck = false;
        var records = [];
        
    	var modifiedRecords = grid.getStore().getModifiedRecords();
    	for (var i = 0; i< modifiedRecords.length; i++) {
    		var rowData = modifiedRecords[i];
    		var artifactName = rowData.data.rowId;
            var cells = [];
            for (var tabIdx = 0; tabIdx <= tabs.length - 1; tabIdx++) {
                var tabId = tabs[tabIdx];
                var oldValue = rowData.data[tabId + 'Value'];
                var newValue = rowData.data[tabId + 'NewValue'];

                if (!shouldCheckNotBrowsering(tabId, rowData)) {
                    continue;
                }
                cells.push({tabId: tabId, newValue: newValue, oldValue: oldValue});
                shouldCheck = true;
            }
            if (shouldCheck){
                records.push({artifactName: artifactName, cells: cells});
                shouldCheck = true;
            }
    	}
    	
		var result={
				records: records
		};
		Ext.get('checkingHiddenNotBrowseringData').dom.value = Ext.encode(result);
		return shouldCheck;
    }

    // To check whether artitact at given address: tabId and rowIndex are needed to be check it's not browsering or not.
    // it relates to feature: not hidden but not browsering.
    // Below cases don't need to be check:
    //   - If current value is already "Hidden"
    //   - If current value is "Copy" or "Redirect" from other tab which is currently "Hidden".
    function shouldCheckNotBrowsering(tabId, rowData) {
		var oldValue = rowData.data[tabId + 'Value'];
		var newValue = rowData.data[tabId + 'NewValue'];

		// If current value is "Hidden" or a copy/redirect to "Hidden", skip checking such items.
		if (newValue == "hide") {
			return false;
		}
		if (newValue && newValue.indexOf("copy$") != -1) {
			var targetTab = newValue.replace("copy$", "");
			var targetNewValue = getCellTabValue(rowData, targetTab);
			if (targetNewValue == "hide") {
				return false;
			}
		}
		if (newValue && newValue.indexOf("redirect$") != -1) {
			var targetTab = newValue.replace("redirect$", "");
			var targetNewValue = getCellTabValue(rowData, targetTab);
			if (targetNewValue == "hide") {
				return false;
			}
		}
		if (!newValue && oldValue == "hide") {
			return false;
		}
		return true;
    }

    // Get cell value of grid, return newValue if changed. else return oldValue.
    function getCellTabValue(rowData, colId) {
        if (!rowData) {
        	return null;
        }
        var newValue = rowData.data[colId + 'NewValue'];
        if (newValue) {
        	return newValue;
        }
        return rowData.data[colId + 'Value'];
    }

    // To perform saving all recent changes in grid as well as generating from SDM leftmenu/catalog
    // for artifacts that is not hidden but not browsering.
    // @param: forceSave: always saving data regardless any recent changes in grid or not.
    function performSave(forceSave) {
    	var updateddatas = grid.getStore().getModifiedRecords();
		var artifacts = '';
		var gridChanged = false;
		var records = [];
		var count = 0;

		for (var i = 0; i< updateddatas.length; i++){
			var artifactName = updateddatas[i].data.rowId;
			var rowChanged = false;
			var cells = [];
			for (var tab in tabs){
				var tabId = tabs[tab];
				var oldValue = updateddatas[i].data[tabId + 'Value'];
				var newValue = updateddatas[i].data[tabId + 'NewValue'];
				if (newValue != null && newValue!= oldValue){
					cells.push({tabId: tabId, newValue: newValue, oldValue: oldValue});
					rowChanged = true;
					count++;
				}
			}
			if (rowChanged){
				records.push({artifactName: artifactName, cells: cells});
				gridChanged = true;
			}
		}
		if (forceSave || gridChanged){
			var result={
				records: records
			};
			if (count > 0) {
				var saveCustomConfirmMsg = "${saveCustomConfirmMsg}";
				saveCustomConfirmMsg = saveCustomConfirmMsg.replace('{0}', count);
				Ext4.Msg.show({
					title: '${confirmationTitle}',
					msg: saveCustomConfirmMsg,
					modal: true,
					icon: Ext4.Msg.QUESTION,
					buttons: Ext4.Msg.YESNO,
					fn: function(s){
						if (s == 'yes'){
							fixEmptyCmbName();
							Ext.get('updateData').dom.value = Ext.encode(result);
							${prefix}_updateCustomization();
						}
					}

				});
			} else {
				fixEmptyCmbName();
				Ext.get('updateData').dom.value = Ext.encode(result);
				${prefix}_updateCustomization();
			}
		} else {
			Ext4.Msg.show({
			  title:'${inforTitle}',
			  msg: "${refreshGridMsg}",
			  buttons: Ext4.Msg.OK,
			  icon: Ext4.MessageBox.INFO
			});
		}
    };

	Ext.EventManager.onWindowResize(function () {
		var view = Ext.get('editor-grid').getViewSize();
        var width = view.width - 15;
		var height = view.height;

		grid.setSize(width, height);
    });
});

//]]>
</script>