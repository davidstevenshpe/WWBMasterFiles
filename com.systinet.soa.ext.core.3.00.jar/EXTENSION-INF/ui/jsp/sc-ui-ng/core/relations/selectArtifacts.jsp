<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<fmt:message var="btClose" bundle="${relationshipmessages}" key="bt.close"/>
<fmt:message var="btCollapse" bundle="${relationshipmessages}" key="bt.collapse"/>
<fmt:message var="btSelect" bundle="${relationshipmessages}" key="bt.select"/>
<fmt:message var="btCancel" bundle="${relationshipmessages}" key="bt.cancel"/>

<fmt:message var="linkToNewTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToNew.tip"/>
<fmt:message var="linkToExistingTip" bundle="${relationshipmessages}" key="artifact.rel.table.linkToExisting.tip"/>
<fmt:message var="removeTip" bundle="${relationshipmessages}" key="artifact.rel.table.remove.tip"/>
<fmt:message var="emptyText" bundle="${relationshipmessages}" key="artifact.rel.table.emptyText"/>
<fmt:message var="titleConfirm" bundle="${relationshipmessages}" key="confirm.window.title"/>
<fmt:message var="msgConfirm" bundle="${relationshipmessages}" key="confirm.window.message.table"/>
<fmt:message var="btnLink" bundle="${relationshipmessages}" key="confirm.window.btn.link"/>
<fmt:message var="btnCancel" bundle="${relationshipmessages}" key="confirm.window.btn.cancel"/>
<fmt:message var="openInCatalog" bundle="${relationshipmessages}" key="open.in.catalog"/>
<fmt:message var="openInNavigator" bundle="${relationshipmessages}" key="open.in.navigator"/>
<fmt:message var="titleWarning" bundle="${relationshipmessages}" key="warning.window.title"/>

<syswf:component name="/data/js" prefix="server_code">
    <syswf:param name="sourceId" value="Relation"/>
    <syswf:param name="code">
    	function linkToExistingArtifact(sourceArtifact, relationName, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId) {
        	return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().linkToExistingArtifact(sourceArtifact, relationName, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId);
        }
        
        function linkToExistingArtifact(sourceArtifact, relationName, useType, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId) {
        	return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().linkToExistingArtifact(sourceArtifact, relationName, useType, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId);
        }               

        function addRelationToArtifact(sourceArtifact, relationName, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId) {
        	return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().addRelationToArtifact(sourceArtifact, relationName, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId);
        }

        function removeRelatedArtifact(sourceArtifact, relationName, targetArtifacts, inverseRelationName, relationSurveyId) {
    	    return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().removeRelatedArtifact(sourceArtifact, relationName, targetArtifacts, inverseRelationName, relationSurveyId);
        }

        function getShortcutPaths(value) {
	        return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().getShortcutPaths(value);
        }
        
        function linkToLatestArtifact(sourceArtifact, relationName, useType, targetArtifacts, forceNewOutgoing, relationSurveyId) {
        	return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().linkToLatestArtifact(sourceArtifact, relationName, useType, targetArtifacts, forceNewOutgoing, relationSurveyId);
        }
		
    	function linkRelsToExistingArtifact(sourceArtifacts, relationNames, useType, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId) {
        	return Packages.com.hp.systinet.sc.ui.relations.RelationshipActions.getInstance().linkRelsToExistingArtifact(sourceArtifacts, relationNames, useType, targetArtifacts, skipExistRelation, forceNewOutgoing, relationSurveyId);
        }
    </syswf:param>
</syswf:component>

<script type="text/javascript">
    //<![CDATA[
    var localMsg = {linkToNewTip: '${linkToNewTip}', linkToExistingTip: '${linkToExistingTip}', removeTip: '${removeTip}', emptyText: '${emptyText}',
        titleConfirm: '${titleConfirm}', msgConfirm: '${msgConfirm}', btnLink: '${btnLink}', btnCancel: '${btnCancel}',
        openInCatalog: '${openInCatalog}', openInNavigator: '${openInNavigator}', titleWarning: '${titleWarning}'};

    var eamURL = '${baseURL}';
    
    function buildArtifactLink (uuid,type,name,embedded) {
        var link='href=\"'+ SERVER_URI+'/../../service-catalog/artifact/' + uuid + '\"';
        return link;
    }

    function showSelectionArtifact(title, uuid, relationName, useType, artifactTypes, artifactRelationTable, extraParams) {
    	var forceNewOutgoing = extraParams ? extraParams.forceNewOutgoing : null;
    	var artifactRelationTables = extraParams ? extraParams.artifactRelationTables : null;
    	var skipExistRelation = extraParams ? extraParams.skipExistRelation : null;
    	var mode = extraParams ? extraParams.mode : null;
    	var relationSurveyId = extraParams ? extraParams.relationSurveyId : null;
    	var selectionMode = extraParams ? extraParams.selectionMode : null;
    	
    	//suport filter by domain
    	var domainTypesParam = extraParams ? extraParams.domainTypesParam : null;
    	var domainIdsParam = extraParams ? extraParams.domainIdsParam : null;
    	var domainNamesParam = extraParams ? extraParams.domainNamesParam : null;
    	
    	//custom columns
    	var customColumns = extraParams ? extraParams.customColumns : null;
    	var multipleRels = extraParams ? extraParams.multipleRels : null;
		
    	//custom dql
    	var customDql = extraParams ? extraParams.customDql : null;
    	
    	//true will remove all current targeted artifact base on relation name and link to newly selected artifact(s)
    	var onlyLinkLatest = extraParams ? extraParams.onlyLinkLatest : null;

        if (artifactTypes == null) artifactTypes = ${defaultArtifactTypes};
        
        if (forceNewOutgoing == undefined || forceNewOutgoing == null) {
        	forceNewOutgoing = false;
        }

		var sourceArtifacts;
		var relationNames;
		if (multipleRels == undefined || multipleRels == null) {
        	multipleRels = 'false';
        } else {
			if (multipleRels === 'true') {
				sourceArtifacts = extraParams.sourceArtifactUuids.split(',');
				relationNames = extraParams.relationshipNames.split(',');
			}
		}

        var selectArtifactTable = Ext4.create('EA.model.table.deliverable.ArtifactSelectionTable',
                {
                    localMsg: localMsg,
                    pageSize: ${this.pageSize},
                    uuid: uuid,
                    relationName: relationName,
                    artifactTypes: artifactTypes,
                    domainTypesParam: domainTypesParam,
                    domainIdsParam: domainIdsParam,
                    domainNamesParam: domainNamesParam,
                    customColumns: customColumns,
                    customDql: customDql,
                    selectionMode: selectionMode,
                    nameRenderer:function (v,m,record)
                    {
                        var text="<a "+ buildArtifactLink(record.data.uuid,record.data.type,record.data.name)
                                +" >" + Ext4.String.htmlEncode(record.data.name) + '</a>';
                        return text;
                    }
                });

        var selectArtifactWnd = Ext4.create('Ext4.window.Window', {
            title: title,
            layout: 'fit',
            items: [selectArtifactTable],
            modal : true,
            buttons: [{
                text: '${btSelect}',
                handler: function () {
                    
                	var selectedIds = selectArtifactTable.grid.getSelectionModel().getSelectedIds();
                    if(selectedIds.length > 0){
                        
                    	var me = this;
                        
                        if (skipExistRelation == null){
                            skipExistRelation = true;
                        }
												
                        var callbackFn = extraParams.callbackFn;
                        if (callbackFn) {
                        	callbackFn(selectedIds);
                        } else {
                        	
                        	var internalCallback = function(result){
                                if(result ==  'true'){
                                	try {
                                		appendSurveyArtifactUuidsStorage(relationSurveyId, selectedIds);
                                	} catch (e){}
                                    if(artifactRelationTable != null){
                                        artifactRelationTable.reloadData();
                                    }else if (artifactRelationTables != null){
                                        for (var i=0; i< artifactRelationTables.length ;i++){
                                            artifactRelationTables[i].reloadData();
                                        }
                                    }else{
                                    	location.reload();
                                    }
                                    me.up('window').close();
                                }else {
                                    Ext4.MessageBox.alert(localMsg.titleWarning, result);
                                }
                            };
                            
	                        if (mode != null && mode == 'Add') {
	                            addRelationToArtifact(uuid, relationName, selectedIds, skipExistRelation, forceNewOutgoing, relationSurveyId, internalCallback);
	                        }  else {
	                        	if(onlyLinkLatest === true || onlyLinkLatest === 'true'){
	                        		linkToLatestArtifact(uuid, relationName, useType, selectedIds, forceNewOutgoing, relationSurveyId, internalCallback);
	                        	} else if (multipleRels === 'true') {
									linkRelsToExistingArtifact(sourceArtifacts, relationNames, useType, selectedIds, skipExistRelation, forceNewOutgoing, relationSurveyId, internalCallback);
								} else {
	                            	linkToExistingArtifact(uuid, relationName, useType, selectedIds, skipExistRelation, forceNewOutgoing, relationSurveyId, internalCallback);
	                        	}
	                        }
                       	}
                    }
                }
            },
                {
                    text: '${btCancel}',
                    handler: function () {
                        this.up('window').close();
                    }
                }
            ]
        });

        selectArtifactWnd.show();
    }

    function isInvalidLink(artifactTypes, sdmName){
		for (var i=0; i<artifactTypes.length; i++){
            if (artifactTypes[i].type == sdmName){
                return false;
            }
        }
        return true;
    }

    function buildRelationTable(title, artifactSdmName, artifactName, uuid, relationName, useType, isValidUseType, autoHeight, artSelParams, divID, notShowLinkNew){
    	var serverUrl = artSelParams ? artSelParams.serverUrl : undefined;
    	var artifactTypes = artSelParams ? artSelParams.artifactTypes : undefined;
    	var modifyEnabled = artSelParams ? artSelParams.modifyEnabled : undefined;
    	var deleteEnabled = artSelParams ? artSelParams.deleteEnabled : undefined;
    	var artifactTypesList = artSelParams ? artSelParams.artifactTypesList : undefined;
    	var shortcutEnabled = artSelParams ? artSelParams.shortcutEnabled : undefined;
    	var outGoing = artSelParams ? artSelParams.outGoing : undefined;
    	var impliedArtifactIdList = artSelParams ? artSelParams.impliedArtifactIdList : undefined;
    	var inverseRelationName = artSelParams ? artSelParams.inverseRelationName : undefined;
    	var parentPrefix = artSelParams ? artSelParams.parentPrefix : undefined;
    	var isInvalid = artSelParams ? artSelParams.isInvalid : undefined;
    	var extraAttributes = artSelParams ? artSelParams.extraAttributes : undefined;
    	var relationSurveyId = artSelParams ? artSelParams.relationSurveyId : undefined;
    	var domainIdsParam = artSelParams ? artSelParams.domainIdsParam : undefined;
    	var domainTypesParam = artSelParams ? artSelParams.domainTypesParam : undefined;
    	var domainNamesParam = artSelParams ? artSelParams.domainNamesParam : undefined;
    	var customColumns = artSelParams ? artSelParams.customColumns : undefined;
    	var customDql = artSelParams ? artSelParams.customDql : undefined;
    	var shortcutContext = artSelParams ? artSelParams.shortcutContext : undefined;
    	    	
		var typesToBeList = '';
		if (artifactTypes != undefined){//FIXME: need to review about showing child types & invalid (red)
			//related defects: QCCR1D209559, QCCR1D209163, QCCR1D208398, QCCR1J76222, QCCR1D202919, QCCR1J75593
		    for (var i = 0; i < artifactTypes.length; i++) {
				if (i > 0) typesToBeList += ',';
				typesToBeList += artifactTypes[i].type;
			}
		} else {
			typesToBeList = artifactTypesList;
		}
		
        var extraAttributesInline = [];
        <c:if test="${not empty extraAttributes}">
        extraAttributesInline = ${extraAttributes};
        </c:if>
        <c:if test="${empty extraAttributes}">
        var extraAttribute = {};
          <c:if test="${not empty relationAttrBeans}">
           <c:forEach var="attr" items="${relationAttrBeans}" varStatus="status">
               extraAttribute.id = "${attr.mappedTo}";
               extraAttribute.label = "${attr.label}";
               extraAttribute.main = "${attr.major}";
               extraAttribute.defaultValue = "${attr.mappedVal}";
               extraAttribute.type = "string";
               extraAttributesInline.push(extraAttribute);
           </c:forEach>
          </c:if>
        if (extraAttributesInline.length == 0) {
            extraAttributesInline = extraAttributes;
        }
        </c:if>
        
        var artifactRelationTable = Ext4.create('EA.model.table.relationshipEditor.ArtifactRelationTable',
                {
					divID: divID,
                    extraAttributes: extraAttributesInline,
                    localMsg: localMsg,
                    pageSize: ${this.pageSize},
                    artifactSdmName: artifactSdmName,
                    uuid: uuid,
                    relationName: relationName,
                    useType: useType,
                    isValidUseType: isValidUseType,
                    serverUrl: serverUrl,
                    artifactTypes: artifactTypes,
                    modifyEnabled: modifyEnabled,
                    deleteEnabled: deleteEnabled,
                    artifactName: artifactName,
                    artifactTypesListString: typesToBeList,
                    autoHeight: autoHeight,
                    shortcutEnabled: shortcutEnabled,
                    outGoing: outGoing,
                    inverseRelationName: inverseRelationName,
                    relationSurveyId: relationSurveyId,
                    notShowLinkNew: notShowLinkNew,
                    domainIdsParam: domainIdsParam,
                    domainTypesParam: domainTypesParam,
                    domainNamesParam: domainNamesParam,
                    customColumns: customColumns,
                    customDql: customDql,
                    shortcutContext: shortcutContext,
                    nameRenderer:function (v,m,record)
                    {
                        var className = "";
						if (isInvalid == 'true' || isInvalidLink(artifactTypes, record.data.type)){
                            className = "class=\"invalid-link\"";
                        }
                        var text="<a " + className + buildArtifactLink(record.data.uuid,record.data.type,record.data.name)
                                +" >" + Ext4.String.htmlEncode(record.data.name) + '</a>';
                        if (record.data.unresolved) {
                            text = text + "<a class=\"shortcutUnresolvedLink\" href=\"javascript:openUnresolvedDialog('"+ record.data.uuid + "', '"+ record.data.name + "', '"+ parentPrefix+ "', '"+ record.data.type + "');\"></a>" ;
                        }
                        return text;
                    }
                });
        return artifactRelationTable;
    }

    function showArtifactRelation(title, artifactSdmName, artifactName, uuid, relationName, useType, isValidUseType, artSelParams, divID, notShowLinkNew){
        var artifactRelationTable = buildRelationTable(title, artifactSdmName, artifactName, uuid, relationName, useType, isValidUseType, false, artSelParams, divID, notShowLinkNew);

        var artifactRelationWnd = Ext4.create('Ext4.window.Window', {
            title: title,
            layout: 'fit',
            items: [artifactRelationTable],
            modal : true,
            buttons: [
                {
                    text: '${btClose}',
                    handler: function () {
                        if(artifactRelationTable.isDataChanged){
                        	location.reload();
                        }
                        this.up('window').close();
                    }
                }
            ]
        });

        artifactRelationWnd.show();
    }

    function showArtifactRelationInline(title, artifactSdmName, artifactName, uuid, relationName, useType, isValidUseType, artSelParams, divID, notShowLinkNew){
    	var idStr = "";
		if(divID != null){
			idStr = "_" + divID;
		}
        var tableDiv = document.getElementById ("tableview_" + relationName + idStr);
        if(tableDiv.childElementCount != 0) {
            return;
        }

        var artifactRelationTable = buildRelationTable(title, artifactSdmName, artifactName, uuid, relationName, useType, isValidUseType, true, artSelParams, divID, notShowLinkNew);

        if (Ext4.get("relationship_" + relationName + idStr) != null) { Ext4.get("relationship_" + relationName + idStr).hide(); }
        artifactRelationTable.render(tableDiv);

    }
    
    function makeArtifactSelParams(serverUrl, artifactTypes, modifyEnabled, deleteEnabled, artifactTypesList, shortcutEnabled,
            outGoing, impliedArtifactIdList, inverseRelationName, parentPrefix, isInvalid, extraAttributes, relationSurveyId,            
            domainIdsParam, domainTypesParam, domainNamesParam,
            customColumns,
            customDql,
            onlyLinkLatest) {
    	return {serverUrl:serverUrl, artifactTypes:artifactTypes, 
    		modifyEnabled:modifyEnabled, deleteEnabled:deleteEnabled, 
    		artifactTypesList:artifactTypesList, shortcutEnabled: shortcutEnabled,
            outGoing:outGoing, impliedArtifactIdList:impliedArtifactIdList, 
            inverseRelationName:inverseRelationName, parentPrefix:parentPrefix, 
            isInvalid:isInvalid, extraAttributes:extraAttributes, relationSurveyId:relationSurveyId, 
            domainIdsParam: domainIdsParam, domainTypesParam: domainTypesParam, domainNamesParam: domainNamesParam,
            customColumns: customColumns, customDql: customDql, onlyLinkLatest: onlyLinkLatest};
    }
    
    function buildLinkNewMenu (menuItem, subTypes, prefix, ref) {
		for (var i=0; i< subTypes.length; i++){
			var subType = subTypes[i];
			if (subType.hidden)continue;
			var subItem = Ext4.create('Ext4.menu.Item',{
                    cls:'context-menu-item',
					text: subType.label,
					abstractType: subType.abstractType,
					type: subType.type,
					handler: function(item) {
						if (!item.abstractType) {
							eval(prefix + item.type + 'linkToNewFunc();');
						}
					}
			});
			if (subType.subs.length > 0 && !subType.subs[0].hidden){
				var subMenu = Ext4.create('Ext4.menu.Menu', {bodyCls:'context-menu'});
				buildLinkNewMenu(subMenu, subType.subs, prefix, ref);
				subItem.setMenu(subMenu);
			}
			menuItem.add(subItem);
			if (!subItem.abstractType) {
				ref.lastItem = subItem;
				ref.count++;	
			}
		}
	}
	
	function buildLinkExistingMenu (menuItem, subTypes, prefix, ref, domainParam, customDql, fnCallback) {
		for (var i=0; i< subTypes.length; i++){
			var subType = subTypes[i];
			if (subType.hidden)continue;
			var subItem = Ext4.create('Ext4.menu.Item',{
                    cls:'context-menu-item',
					text: subType.label,
					abstractType: subType.abstractType,
					type: subType.type,
					handler: function(item) {
						if (!item.abstractType) {
							if (fnCallback) {
								var params = {
									  title: ref.wndTitle[item.type], 
								      uuid: ref.artifactUuid,
								      relationName: ref.relationshipName,
								      useType: ref.useType,
								      artifactTypes: [{type: item.type}],
								      artifactRelationTable: null,
								      //merge javascript properties
								      extraParams: $.extend({}, domainParam, {forceNewOutgoing: ref.forceNewOutgoing, relationSurveyId: ref.relationSurveyId, customDql: customDql})
								};
								fnCallback(params);
							} else {
							    showSelectionArtifact(ref.wndTitle[item.type], ref.artifactUuid, ref.relationshipName, ref.useType, 
									[{type: item.type}], null, $.extend({}, domainParam, {forceNewOutgoing: ref.forceNewOutgoing, relationSurveyId: ref.relationSurveyId, skipExistRelation: false, customDql: customDql}));
							}
						}
					}
			});
			if (subType.subs.length > 0 && !subType.subs[0].hidden){
				var subMenu = Ext4.create('Ext4.menu.Menu', {bodyCls:'context-menu'});
				buildLinkExistingMenu(subMenu, subType.subs, prefix, ref, domainParam, customDql, fnCallback);
				subItem.setMenu(subMenu);
			}
			menuItem.add(subItem);
			if (!subItem.abstractType) {
				ref.lastItem = subItem;
				ref.count++;	
			}
		}
	}

    Ext4.onReady(function(){
        Ext4.Loader.setPath('Ext4.app', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.portal', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.model', '${webResourcePath}/../../components/ui-ea/model');
        Ext4.Loader.setPath('EA.portlets', '${webResourcePath}/../../components/ui-ea/portlets');
    });

    //]]>
</script>