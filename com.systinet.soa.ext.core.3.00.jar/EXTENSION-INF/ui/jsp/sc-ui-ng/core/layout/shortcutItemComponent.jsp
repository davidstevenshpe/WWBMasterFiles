<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="tableView" bundle="${relationshipmessages}" key="table.view.text"/>
<fmt:message var="shortcutTypeLinkNew" bundle="${relationshipmessages}" key="relationship.type.link.new"/>
<fmt:message var="shortcutTypeLinkExisting" bundle="${relationshipmessages}" key="relationship.type.link.existing"/>
<fmt:message var="titleWarning" bundle="${relationshipmessages}" key="warning.window.title"/>
<fmt:message var="relationWndTitle" bundle="${relationshipmessages}" key="relation.window.title">
	<fmt:param value="${descriptor.label}"/>
	<fmt:param value="${artifact.name}"/>
</fmt:message>

<fmt:message var="selectionWndTitle" bundle="${relationshipmessages}" key="select.window.title">
	<fmt:param value="${artifactType}"/>
	<fmt:param value="${artifactName}"/>
</fmt:message>

<fmt:message var="selectionWndTitle" bundle="${relationshipmessages}" key="select.window.title">
	<fmt:param value="artifact"/>
	<fmt:param value="${artifact.name}"/>
</fmt:message>

<fmt:message var="labelTooltip" bundle="${relationshipmessages}" key="relationship.shortcut.label.tooltip">
	<fmt:param value="${fullPath}"/>
</fmt:message>

<fmt:message var="labelMissing" bundle="${relationshipmessages}" key="relationship.shortcut.label.missing"/>
<c:if test="${empty label}">
	<c:set var="label" value="${labelMissing}"/>
</c:if>

<c:set var="modifyEnabled">
    <c:choose>
        <c:when test="${canBeEntered && hasWritePermission}">${true}</c:when>
        <c:otherwise>${false}</c:otherwise>
    </c:choose>
</c:set>

<c:set var="artifactTypeListForTableView">
	[<c:forEach var="item" items="${relatedArtifactTypes}" varStatus="status">
		{type:'${item.type}', label:'${item.label}', hidden: ${item.hidden}, callback: function(){${prefix}${item.type}${status.index}func()}, titleWnd: '<syswf:out value="${selectionWndTitle}" context="HtmlJSText"/>'}
		<c:if test="${not status.last}">,</c:if>
	</c:forEach>]
</c:set>
<c:set var="artifactTypeListForShortcutTableView">
	[<c:forEach var="item" items="${artifactTypesForShortcut}" varStatus="status">
		{type:'${item.type}', label:'${item.label}', hidden: ${item.hidden}, callback: function(){${prefix}${item.type}${status.index}func()}, titleWnd: '<syswf:out value="${selectionWndTitle}" context="HtmlJSText"/>'}
		<c:if test="${not status.last}">,</c:if>
	</c:forEach>]
</c:set>


<c:forEach var="item" items="${artifactTypesForShortcut}" varStatus="status">
	<syswf:control id="${prefix}${item.type}${status.index}id" mode="script" caption="${prefix}${item.type}${status.index}func" targetTask="/${viewId}/newArtifact">
        <syswf:param name="sdmName" value="${item.type}"/>
        <syswf:param name="creationListener" value="${linkToNewRelationListener}"/>
    </syswf:control>
</c:forEach>

<c:set var="linkExistingListener">
   function showShortcutArtifactSelection(params) {
        params = (!params || params == null) ? {} : params;
        var selectedArtifactTypes = params.artifactTypes;
        if (!selectedArtifactTypes || selectedArtifactTypes == null) {
            selectedArtifactTypes = [{type: '${artifactType}'}];
        }
        var displayTitle = params.title;
        if (!displayTitle || displayTitle == null) {
            displayTitle = '<syswf:out value="${selectionWndTitle}" context="HtmlJSText"/>';
        }
	    showSelectionArtifact(displayTitle, 
	       '${artifact._uuid}', '${relationshipName}', null, selectedArtifactTypes, null, 
	       {forceNewOutgoing: 'false', relationSurveyId: '${relationSurveyId}', callbackFn: function(selectedIds) {
	           var selectedIdArray = '';
	           for (var idx = 0; idx < selectedIds.length; idx++) {
	               selectedIdArray += selectedIds[idx];
	               if (idx < selectedIds.length - 1) {
	                   selectedIdArray += ",";
	               }
	           }
	           createShortcutInstance('${shortcutDefinition.getString("uniqueKey")}', '${artifact._uuid}', selectedIdArray, function(result) {
	               if (result == 'true') {
	                   var tmp = $(location).attr('href').split('?')[0];
	                   	if(tmp.indexOf("doSurvey") == -1){
	                       	window.location.href = tmp;
	                   	}else{
	                   		//in doSurvey page, surveyUuid and artifactUuid in query string must not be removed to avoid exception.
	                   		window.location.href=window.location.href;
	                   	}
	               } else {
	                   Ext4.MessageBox.alert('${titleWarning}', result);
	               }
	           } );
	       }});
   }
</c:set>


<c:if test="${not empty relatedArtifactTypes}">
<c:set var="output">
<%-- descriptor.component: simpleRelationWidget  --%>
    <syswf:component name="${descriptor.component}" prefix="${prefix}${descriptor.id}" wrapIfEmpty="false">
        <syswf:param name="model" value="${descriptor.model}"/>
        <syswf:param name="mode" value="${descriptor.displayType}"/>
        <syswf:param name="error" value="${descriptor.model.errorMessage}"/>
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="artifactType" value="${artifactType}"/>
        <syswf:param name="hint" value="${descriptor.hint}"/>
        <syswf:param name="relationshipLabel" value="${descriptor.label}"/>
        <syswf:param name="hasWritePermission" value="${modifyEnabled}"/>
        <syswf:param name="artifactTypeListForTableView" value="${artifactTypeListForTableView}"/>
        <syswf:paramSet value="${descriptor.params}"/>
		<syswf:param name="showDropMenu" value="false"/>
		<syswf:param name="artifactTypes" value="${filterArtifactTypes}"/>
		<syswf:param name="moreLinkId" value="${prefix}_leftClickMenu_${descriptor.property.name}_shortcut"/>		
		<syswf:param name="outGoing" value="${outGoing}"/>
		<syswf:param name="paths" value="${paths}"/>
		<syswf:param name="shortcutContext" value="true"/>
		<syswf:param name="shortcutDefinition" value="${shortcutDefinition}"/>
		<syswf:param name="parentPrefix" value="${prefix}"/>
		<syswf:param name="editorBlockID" value="${descriptor.property.name}"/>
		<syswf:param name="creationArtifactRelationListener" value="${linkToNewRelationListener}"/>
		<syswf:param name="linkExistingArtifactRelationListener" value="${linkExistingListener}"/>
		<syswf:param name="relationSurveyId" value="${relationSurveyId}"/>
		<syswf:param name="shortcutArtifactLinkHolders" value="${shortcutArtifactLinkHolders}"/>
    </syswf:component>
</c:set>

<c:if test="${not empty output}">
<table class="UI Table Properties">
<colgroup>
	<col class="LabelCol">
	<col>
</colgroup>
<tbody>
     <tr id="${descriptor.property.name}">
     <c:choose>
	     <c:when test="${not empty showLabel and showLabel eq false}"></c:when>
	     <c:otherwise>
	         <th>
	         	<label class="UI Label Inline Italic" title="<c:out value="${labelTooltip}"/>" id="${prefix}${descriptor.property.name}">
	         		<c:out value="${label}"/>:
	         	</label>
	       	 </th>
	  	 </c:otherwise>
  	 </c:choose>
         <td>
  			<span class="IconAlignItalic"><c:out value="${output}" escapeXml="false" /></span>
         </td>
     </tr>
    </tbody>
</table>
</c:if>
</c:if>
<div id="tableview_${descriptor.property.name}">

</div>

<c:set var="tableViewListener">
<c:choose>
	<c:when test="${tableViewOnly}">
	       showArtifactRelation('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', 
	                     '${artifact.artifactDescriptor.sdmName}', '${artifactName}', '${artifact._uuid}', 
	                     '${descriptor.property.name}', null, null, 
	                     
	                     {serverUrl:'${baseUrl}', artifactTypes:${artifactTypeListForShortcutTableView}, 
				          modifyEnabled:'${modifyEnabled}', deleteEnabled:'${deleteEnabled}', 
				          artifactTypesList:'${filterArtifactTypes}', shortcutEnabled: 'true',
				          outGoing:'${outGoing}', impliedArtifactIdList:'${impliedArtifactIdList}', 
				          parentPrefix:'${prefix}', relationSurveyId:'${relationSurveyId}', shortcutContext: 'true'})
	</c:when>
	<c:otherwise>
	       showArtifactRelationInline('<syswf:out value="${relationWndTitle}" context="HtmlJSText"/>', 
	                           '${artifact.artifactDescriptor.sdmName}', '${artifactName}', '${artifact._uuid}', 
	                           '${descriptor.property.name}', null, null, 
	                           
	                           {serverUrl:'${baseUrl}', artifactTypes:${artifactTypeListForShortcutTableView}, 
	                            modifyEnabled:'${modifyEnabled}', deleteEnabled:'${deleteEnabled}', 
	                            artifactTypesList:'${filterArtifactTypes}', shortcutEnabled: 'true',
	                            outGoing:'${outGoing}', impliedArtifactIdList:'${impliedArtifactIdList}', 
	                            parentPrefix:'${prefix}', relationSurveyId:'${relationSurveyId}', shortcutContext: 'true'})
	</c:otherwise>
</c:choose>
</c:set>

<syswf:input id="${prefix}_shortcutDefinitionInpt" name="shortcutDefinitionInpt" mode="hidden" value="" />
<syswf:input id="${prefix}_shortcutDefinitionInpt_child" name="_shortcutDefinitionInpt_child" mode="hidden" value="" />
<syswf:control id="${prefix}addNewShortcutArtifactLinkRedirect" mode="script" caption="${prefix}_ShortcutNewArtifactFuncLink" targetTask="/common/newShortcutArtifactLink"/>

<syswf:input id="${prefix}_shortcutId" name="shortcutId" mode="hidden" value="" />
<syswf:input id="${prefix}_sourceUuid" name="sourceUuid" mode="hidden" value="${artifact._uuid}" />
<syswf:input id="${prefix}_targetUuid" name="targetUuid" mode="hidden" value="" />
<syswf:input id="${prefix}_shortcutFromSdm" name="shortcutFromSdm" mode="hidden" value="" />
<syswf:input id="${prefix}_shortcutToSdm" name="shortcutToSdm" mode="hidden" value="" />
<syswf:input id="${prefix}_relation" name="relation" mode="hidden" value="" />
<syswf:control mode="script" caption="${prefix}_createNewArtifactShortcut" action="createNewArtifactShortcut"/>

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="shortcutItemComponent"/>
  <syswf:param name="code">
    function getLinkedArtifacts(shortcutKey, sourceUuid, targetUuid)
    {
       return Packages.com.hp.systinet.sc.ui.layout.ShortcutResolveActions.getInstance().getLinkedArtifacts(shortcutKey, sourceUuid, targetUuid);
    }
    function createArtifactRelation(shortcutKey, sourceUuid, targetUuid, artifactSdm, artifactUuid, artifactName)
    {
       return Packages.com.hp.systinet.sc.ui.layout.ShortcutResolveActions.getInstance().createArtifactRelation(shortcutKey, sourceUuid, targetUuid, artifactSdm, artifactUuid, artifactName);
    }
    function save(shortcutKey, sourceUuid, targetUuid)
    {
       return Packages.com.hp.systinet.sc.ui.layout.ShortcutResolveActions.getInstance().save(shortcutKey, sourceUuid, targetUuid);
    }
    function cancel(shortcutKey, sourceUuid, targetUuid)
    {
       return Packages.com.hp.systinet.sc.ui.layout.ShortcutResolveActions.getInstance().cancel(shortcutKey, sourceUuid, targetUuid);
    }
    function cancelShortcuts(shortcutKeys)
    {
       return Packages.com.hp.systinet.sc.ui.layout.ShortcutResolveActions.getInstance().cancel(shortcutKeys);
    }
    function createShortcutInstance(shortcutKey, srcArtifactUuid, tarArtifactUuid)
    {
       return Packages.com.hp.systinet.sc.ui.layout.ShortcutItemActions.getInstance().createShortcut(shortcutKey, srcArtifactUuid, tarArtifactUuid);
    }
  </syswf:param>
</syswf:component>


<script type="text/javascript">
//<![CDATA[
    Ext4.onReady(function(){
    	<c:if test="${isSurveyPage}">
	    	// to store relation artifact uuids in local storage
	    	try {
	    		setSurveyArtifactUuidsStorage('${relationSurveyId}', '${relationArtifactUuids}');
	    	} catch (e) {
	    		console.log(e);
	    	}
		</c:if>
    	
    	var shortcutMenuLink = Ext4.get('${prefix}_leftClickMenu_${descriptor.property.name}_shortcut');
    	if(shortcutMenuLink != null) {
           	var menu = new Ext4.menu.Menu({
    			bodyCls: 'context-menu',
    			shadow: false,
                id: '${prefix}_leftClickMenu_${descriptor.property.name}_shortcut_context'
    		});
        	shortcutMenuLink.on('click', function(e){
        		if(!menu.isVisible()) {
            		menu.showAt(e.getXY());
        		}
        	});
    	}
    	
    	Ext.get('${prefix}_shortcutDefinitionInpt').dom.value = Ext.encode(${shortcutDefinition});
    	Ext.get('${prefix}_shortcutDefinitionInpt_child').dom.value = Ext.encode(${childDefinitions});
    });
    
    /**
     * Open resolve shortcut dialog.
     */
    function openUnresolvedDialog(tarUuid, tarName, parentPrefix, tarSdmName) {
    	var matchShortcutDef;
    	
    	var shortcutInp = Ext.get(parentPrefix + '_shortcutDefinitionInpt');
        if (shortcutInp && shortcutInp.dom) {
	        var shortcutDef = Ext.get(parentPrefix + '_shortcutDefinitionInpt').dom.value;
	        shortcutDef = eval('(' + shortcutDef + ')');
	        if (isMatchesShortcutDef(shortcutDef, '${artifact._artifactSdmName}', tarSdmName)
	        		|| isMatchesShortcutDef(shortcutDef, tarSdmName, '${artifact._artifactSdmName}')) {
	            matchShortcutDef = shortcutDef;
	        }
        }
        if (!matchShortcutDef) {
        	var shortcutInpChild = Ext.get(parentPrefix + '_shortcutDefinitionInpt_child');
            if (shortcutInpChild && shortcutInpChild.dom) {
                var shortcutDefChild = Ext.get(parentPrefix + '_shortcutDefinitionInpt_child').dom.value;
                shortcutDefChild = eval('(' + shortcutDefChild + ')');
                if (shortcutDefChild && shortcutDefChild.length > 0) {
                    for (var idx = 0; idx < shortcutDefChild.length; idx++) {
                        var defChild = shortcutDefChild[idx];
                        if (isMatchesShortcutDef(defChild, '${artifact._artifactSdmName}', tarSdmName)
                        		|| isMatchesShortcutDef(defChild, tarSdmName, '${artifact._artifactSdmName}')) {
                            matchShortcutDef = defChild;
                            break;
                        }
                    }
                }
            }
        }
        if (!matchShortcutDef) {
            console.log('There is no existing shortcut definition with key');
            return;
        }
        
        var isRightSideArtifact = matchShortcutDef.definition[0].sdmName == '${artifact.artifactDescriptor.sdmName}';
    	if (isRightSideArtifact) {
    	    openUnresolvedShortcutDialog(matchShortcutDef.id, '${artifact._uuid}', '<syswf:out value="${artifact.name}" context="HtmlJSText"/>', tarUuid, tarName, parentPrefix, tarSdmName);
    	} else {
            openUnresolvedShortcutDialog(matchShortcutDef.id, tarUuid, tarName, '${artifact._uuid}', '<syswf:out value="${artifact.name}" context="HtmlJSText"/>', parentPrefix, tarSdmName);
    	}
    }
    
    /**
     * Open resolve shortcut dialog.
     */
    function openUnresolvedShortcutDialog(shortcutKey, sourceUuid, sourceName, tarUuid, tarName, parentPrefix, tarSdmName) {
    	var matchShortcutDef = getShortcutDef(shortcutKey, parentPrefix);
        if (!matchShortcutDef) {
        	console.log('There is no existing shortcut definition with key: ' + shortcutKey);
        	return;
        }
        if (!createResolveWindowSession(matchShortcutDef.id, sourceUuid, sourceName, tarUuid, tarName, parentPrefix, tarSdmName)) {
        	return;
        }
        
        var readonly = false;
        if ('${hasWritePermission}' == 'true') {
            readonly = false;
        } else {
            readonly = true;
        }
        
        getLinkedArtifacts(matchShortcutDef.id, sourceUuid, tarUuid, function(result){
	        var shortcutResolutionComponent = Ext4.create('EA.model.shortcut.ShortcutResolutionWindow', {
	    		id: parentPrefix + '_shortcut-resolution-dialog',
	  			renderTo: parentPrefix + '_shortcut-resolution',
	  			config:{
	  				source: {
	  					"name": sourceName,
						"uuid": sourceUuid
	  				},
	  				dest: {
	  					"name": tarName,
						"uuid": tarUuid
	  				},
	  				path: matchShortcutDef,
	  				parentPrefix: parentPrefix,
	  				intermediate: result,
	  				readonly: readonly
	  			}
	        });
	        shortcutResolutionComponent.show();
        });
    }
    
    /**
     * Create new shortcut artifact.
     */
    function createNewShortcutArtifact(fromSdm, toSdm, relation, parentPrefix, sourceUuid, targetUuid, shortcutKey) {
    	Ext.get(parentPrefix + '_shortcutFromSdm').dom.value = fromSdm;
    	Ext.get(parentPrefix + '_shortcutToSdm').dom.value = toSdm;
    	Ext.get(parentPrefix + '_relation').dom.value = relation;
    	Ext.get(parentPrefix + '_sourceUuid').dom.value = sourceUuid;
    	Ext.get(parentPrefix + '_targetUuid').dom.value = targetUuid;
    	Ext.get(parentPrefix + '_shortcutId').dom.value = shortcutKey;
    	
    	var fn = eval(parentPrefix + '_createNewArtifactShortcut');
    	fn();
    	
    	// mark all opening shortcut window at resumning mode so that when back to creation screen, they will be reopened.s
    	markOpeningWindowResuming();
    }
    
    function saveResolveShortcut(sourceUuid, targetUuid, parentPrefix, shortcutKey, fnCallback) {
    	save(shortcutKey, sourceUuid, targetUuid, function(result) {
    		if (result == 'true' || result == true) {
    			if (fnCallback) {
    				fnCallback();
    			}
    		} else {
    			console.log('Cannot save shortcut resolve');
    		}
    	});
    }
    
    function cancelResolveShortcut(sourceUuid, sourceName, targetUuid, targetName, parentPrefix, shortcutKey, fnCallback) {
        cancelResolveWindowSession(shortcutKey, sourceUuid, sourceName, targetUuid, targetName, parentPrefix);
        cancel(shortcutKey, sourceUuid, targetUuid, function(result){
        	if (fnCallback) {
        		fnCallback();
        	}
        });
    }
    
    function createLinkArtifactRelation(sourceUuid, targetUuid, parentPrefix, artifactSdm, artifactUuid, artifactName, shortcutKey, fnCallback) {
        createArtifactRelation(shortcutKey, sourceUuid, targetUuid, artifactSdm, artifactUuid, artifactName, function(result){
             if (fnCallback) {
                 fnCallback();
             }
        });
    }
    
    function isMatchesShortcutDef(def, srcArtifactSdm, tarArtifactSdm) {
    	if (!def) {
    		return false;
    	}
    	var src = def.definition[0].sdmName;
    	var target = def.definition[def.definition.length - 1].sdmName;
    	return (src == srcArtifactSdm && target == tarArtifactSdm) || (src == tarArtifactSdm && target == srcArtifactSdm);
    }
    
    function getShortcutDef(shortcutKey, parentPrefix) {
        var matchShortcutDef;
        
        var shortcutInp = Ext.get(parentPrefix + '_shortcutDefinitionInpt');
        if (shortcutInp && shortcutInp.dom) {
            var shortcutDef = Ext.get(parentPrefix + '_shortcutDefinitionInpt').dom.value;
            shortcutDef = eval('(' + shortcutDef + ')');
            if (shortcutDef.id == shortcutKey) {
                matchShortcutDef = shortcutDef;
            }
        }
        if (!matchShortcutDef) {
            var shortcutInpChild = Ext.get(parentPrefix + '_shortcutDefinitionInpt_child');
            if (shortcutInpChild && shortcutInpChild.dom) {
                var shortcutDefChild = Ext.get(parentPrefix + '_shortcutDefinitionInpt_child').dom.value;
                shortcutDefChild = eval('(' + shortcutDefChild + ')');
                if (shortcutDefChild && shortcutDefChild.length > 0) {
                    for (var idx = 0; idx < shortcutDefChild.length; idx++) {
                        var defChild = shortcutDefChild[idx];
                        if (defChild.id == shortcutKey) {
                            matchShortcutDef = defChild;
                            break;
                        }
                    }
                }
            }
        }
        return matchShortcutDef;
    }
//]]>
</script>

<c:if test="${modifyEnabled}">
    <syswf:component name="/core/relations/linkRelationshipToNewArtifact" prefix="${prefix}linkRelationshipToNewArtifact">
        <syswf:param name="parentMenuId" value="${prefix}_leftClickMenu_${descriptor.property.name}_shortcut_context"/>
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="relationshipName" value="${relationshipName}"/>
        <syswf:param name="class" value="UI PageAction LinkToNew"/>
        <syswf:param name="text" value="${shortcutTypeLinkNew}"/>
        <syswf:param name="type" value="ul"/>
        <syswf:param name="artifactTypes" value="${filterArtifactTypes}"/>
        <syswf:param name="customRelationship" value="${customRelationship}"/>
        <syswf:param name="forceNewOutgoing" value="${forceNewOutgoing}"/>
        <syswf:param name="useType" value="${useType}"/>
        <syswf:param name="creationArtifactRelationListener" value="${linkToNewRelationListener}"/>
    </syswf:component>
    <syswf:component name="/core/relations/linkRelationshipToExistingArtifact" prefix="${prefix}linkRelationshipToExistingArtifact">
        <syswf:param name="parentMenuId" value="${prefix}_leftClickMenu_${descriptor.property.name}_shortcut_context"/>
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="relationshipName" value="${relationshipName}"/>
        <syswf:param name="class" value="UI PageAction LinkToExisting"/>
        <syswf:param name="text" value="${shortcutTypeLinkExisting}"/>
        <syswf:param name="type" value="ul"/>
        <syswf:param name="artifactTypes" value="${filterArtifactTypes}"/>
        <syswf:param name="customRelationship" value="${customRelationship}"/>
        <syswf:param name="useType" value="${useType}"/>
        <syswf:param name="linkExistingArtifactRelationListener" value="${linkExistingListener}"/>
    </syswf:component>
</c:if>

<script type="text/javascript">
    //<![CDATA[
    Ext4.onReady(function(){
	    <c:if test="${not notShowTableViewMenu}" >
	        var menu = Ext4.getCmp('${prefix}_leftClickMenu_${descriptor.property.name}_shortcut_context');
	        if(menu != null) {
	            menu.add({
	                cls: 'context-menu-item icon TableView',
	                text:'${tableView}',
	                listeners: { 
	                    'click': function() {
	                        ${tableViewListener};
	                    }
	                }
	            });
	        }
	    </c:if>
    });
    //]]>
</script>