<%-- 
Component parameters
	toggleId - when clicking on this element id, selection window will show up 
	saveCallback - callback method after pressing 'Save changes'. If not defined, page will be reloaded
	setting (optional) - domain selection settings of current log-in user 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.domainselectionmessages" var="domainMsg"/>
<fmt:message var="titleWnd" key="domain.selection.window.title" bundle="${domainMsg}"/>
<fmt:message var="nonReferenceArchitectureDomain" key="domain.selection.window.non.reference.architecture.domain" bundle="${domainMsg}"/>
<fmt:message var="nonReferenceDemoDomain" key="domain.selection.window.non.reference.demo.domain" bundle="${domainMsg}"/>
<fmt:message var="nonReferenceDomain" key="domain.selection.window.non.reference.domain" bundle="${domainMsg}"/>
<fmt:message var="referenceDomain" key="domain.selection.window.reference.domain" bundle="${domainMsg}"/>
<fmt:message var="customDomain" key="domain.selection.window.custom.domain" bundle="${domainMsg}"/>
<fmt:message var="closeBtn" key="domain.selection.window.close" bundle="${domainMsg}"/>
<fmt:message var="saveBtn" key="domain.selection.window.save" bundle="${domainMsg}"/>
<fmt:message var="placeHolder" key="domain.selection.window.empty.text" bundle="${domainMsg}"/>

<div id="${prefix}domainSelectionModal" class="modal" role="dialog">
	<div class="modal-dialog domainSelectionDialog">
		<div class="modal-content">
			
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">${titleWnd}</h4>
			</div>
			
			<div class="modal-body">

				<div class="box-inline mar-rgt">								
					<input id="nonReferenceArchitectureDomainToggle" type="checkbox">
				</div>
				<span>${nonReferenceArchitectureDomain}</span>
				
				<br><br>
				
				<div class="box-inline mar-rgt">								
					<input id="nonReferenceDemoDomainToggle" type="checkbox">
				</div>
				<span>${nonReferenceDemoDomain}</span>
				
				<br><br>
				
				<div class="box-inline mar-rgt">								
					<input id="referenceDomainToggle" type="checkbox">					
				</div>
				<span>${referenceDomain}</span>
				
				<br><br>
				
				<div class="box-inline mar-rgt">								
					<input id="customDomainToggle" type="checkbox">					
				</div>
				<span>${customDomain}</span>
				
				<br><br>
				
				<select id="customDomainSelect" multiple>
				</select>
				
			</div>
			
			<div class="modal-footer">
				<button id="seletionDomainCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">${closeBtn}</button>
				<button id="seletionDomainSaveBtn" type="button" class="btn btn-primary">${saveBtn}</button>
			</div>
		</div>

	</div>
</div>

<syswf:control mode="script" caption="${prefix}_settingSaveChanges" action="settingSaveChanges" affects="."/>

<c:set var="domainList">
    [<c:forEach var="item" items="${domains}" varStatus="status">
    {
    	uuid: '${item.uuid}',
    	name: '${item.name}',
    	value:'${item.domainId}', 
    	type: '${item.domainType.name}'
	}
    <c:if test="${not status.last}">,</c:if>
	</c:forEach>]
</c:set>

<c:set var="domainSelected">
    [<c:forEach var="item" items="${setting.customDomainList}" varStatus="status">
    {
    	uuid: '${item.uuid}',
    	name: '${item.name}',
    	value:'${item.domainId}', 
    	type: '${item.domainType.name}'
	}
    <c:if test="${not status.last}">,</c:if>
	</c:forEach>]
</c:set>

<script type="text/javascript">
//<![CDATA[

function onLoadScriptCallback() {
	
    var toggleId = '${toggleId}';
   	$("#" + toggleId).attr("data-toggle", "modal")
   							.attr("data-target", "#${prefix}domainSelectionModal");
   	
   	var domainList = ${domainList};
   	var domainSelected = ${domainSelected};
   	var customDomainSelect = $('select#customDomainSelect');

   	//add all possible domain
   	for(var i=0; i<domainList.length; i++){
   		var domain = domainList[i];
   		customDomainSelect.append(function(){
   			var attr = "value=\"" + domain.value + "\"";
   			var html = "<option " + attr + ">";
   			html += domain.name;
   			if(domain.type == 'Reference Model' || domain.type == 'Demo Data'){
   				html += " (" + domain.type + ")";
   			}
   			html += "</option>";
   			return html;
   		});
   		
   	}
   	
   	//mark some domains selected
   	for(var i=0; i<domainSelected.length; i++){
   		var domain = domainSelected[i];
   		$("select#customDomainSelect > option[value='" + domain.value + "']").prop("selected", true);
   	}
   	
   	//apply 'chosen' library
   	customDomainSelect.chosen({
   		width:'100%',
   		placeholder_text_multiple: '${placeHolder}'
  	}).change(function(evt, params){
  		if(!customDomainSelect.chosen().val()) saveBtn.prop("disabled", true);
  		else saveBtn.removeAttr("disabled");
  	});
   	
   	//button elements
   	var saveBtn = $('#seletionDomainSaveBtn');
   	var closeBtn = $('#seletionDomainCloseBtn');
   	
   	//checkbox elements
	var nonReferenceArchitectureDomainEle = document.querySelector('#nonReferenceArchitectureDomainToggle');
	var nonReferenceDemoDomainEle = document.querySelector('#nonReferenceDemoDomainToggle');
	var referenceDomainEle = document.querySelector('#referenceDomainToggle');
	var customDomainEle = document.querySelector('#customDomainToggle');
	
	//apply 'Switchery' library
	var nonReferenceArchitectureDomainToggle = new Switchery(nonReferenceArchitectureDomainEle);
	var nonReferenceDemoDomainToggle = new Switchery(nonReferenceDemoDomainEle);
	var referenceDomainToggle = new Switchery(referenceDomainEle);
	var customDomainToggle = new Switchery(customDomainEle);

	//event handler
	saveBtn.click(function(){
		
		var propValue = [];
		
		if(nonReferenceArchitectureDomainEle.checked){
			propValue[propValue.length] = "NON-REFERENCE-ARCHITECTURE-DOMAIN";
		}
		if(nonReferenceDemoDomainEle.checked){
			propValue[propValue.length] = "NON-REFERENCE-DEMO-DOMAIN";
		}
		if(referenceDomainEle.checked){
			propValue[propValue.length] = "REFERENCE-DOMAIN";
		}
		if(customDomainEle.checked){
			propValue[propValue.length] = customDomainSelect.chosen().val();
		}
		
		${prefix}_settingSaveChanges({
			propValue: propValue.join(","),
			callback: function () {
				<c:choose>
					<c:when test="${not empty saveCallback}">
						${saveCallback}();
					</c:when>
					<c:otherwise>
					    if (window.changedCentralArtifactUuid && window.changedCentralArtifactUuid.length > 0) {
					    	var href = window.location.href;
					    	var newParam = "uuid=" + window.changedCentralArtifactUuid;
					    	var startIdx = href.indexOf('uuid');
					    	if (startIdx != -1) {
					    		var endIdx = href.indexOf('&', startIdx);
					    		if (endIdx == -1) {
					    			endIdx = href.length;
					    		}
					    		var oldParam = href.substr(startIdx, endIdx - startIdx);
					    		href = href.replace(href.substr(startIdx, endIdx - startIdx), newParam);
					    	} else {
					    		href += "&" + newParam;
					    	}
					    	window.location = href;
					    } else {
							window.location.reload();
					    }
					</c:otherwise>
				</c:choose>
			}
		});
	});
	
    var onCloseDialogFn = function() {
        setTimeout(function(){
			
			saveBtn.removeAttr("disabled");
			
			//clear all selected items
		   	customDomainSelect.val('');
			
		  	//mark some domains selected
		   	for(var i=0; i<domainSelected.length; i++){
		   		var domain = domainSelected[i];
		   		$("select#customDomainSelect > option[value='" + domain.value + "']").prop("selected", true);
		   	}
		  
		   	customDomainSelect.trigger("chosen:updated");
		   	
		   	//reset all switchery to default settings
		   	if(nonReferenceArchitectureDomainEle.checked) nonReferenceArchitectureDomainToggle.setPosition(true);
		   	if(nonReferenceDemoDomainEle.checked) nonReferenceDemoDomainToggle.setPosition(true);
		   	if(referenceDomainEle.checked) referenceDomainToggle.setPosition(true);
		   	if(customDomainEle.checked) customDomainToggle.setPosition(true);
		   	
		   	if(!nonReferenceArchitectureDomainEle.checked){
	   	<c:if test="${setting.nonReferenceArchitectureDomain eq true}">
	   	    nonReferenceArchitectureDomainToggle.setPosition(true);
		</c:if>}
		   	if(!nonReferenceDemoDomainEle.checked){
	   	<c:if test="${setting.nonReferenceDemoDomain eq true}">
	   	    nonReferenceDemoDomainToggle.setPosition(true);
		</c:if>}
		   	
		   	if(!referenceDomainEle.checked){
		<c:if test="${setting.referenceDomain eq true}">
			referenceDomainToggle.setPosition(true);
		</c:if>}
			
		   	if(!customDomainEle.checked){
		<c:if test="${setting.customDomain eq true}">
			customDomainToggle.setPosition(true);
		</c:if>}
		   
		}, 500);
    }
	
    $('#${prefix}domainSelectionModal').on('hidden.bs.modal', function (e) {
    	onCloseDialogFn();
   	})
	
	closeBtn.click(function(){
		onCloseDialogFn();
	});
	
	nonReferenceArchitectureDomainEle.onchange = function() {
		if (this.checked) {
			saveBtn.removeAttr("disabled");
		}
		if (this.checked && customDomainEle.checked) {
			customDomainToggle.setPosition(true);
			customDomainSelect.prop('disabled', true).trigger('chosen:updated');
		}
		else if(!this.checked && !nonReferenceDemoDomainEle.checked && !referenceDomainEle.checked){
			saveBtn.prop("disabled", true);
		}
	};
	nonReferenceDemoDomainEle.onchange = function() {
		if (this.checked) {
			saveBtn.removeAttr("disabled");
		}
		if (this.checked && customDomainEle.checked) {
			customDomainToggle.setPosition(true);
			customDomainSelect.prop('disabled', true).trigger('chosen:updated');
		}
		else if(!this.checked && !nonReferenceArchitectureDomainEle.checked && !referenceDomainEle.checked){
			saveBtn.prop("disabled", true);
		}
	};
	
	referenceDomainEle.onchange = function() {
		if (this.checked) {
			saveBtn.removeAttr("disabled");
		}
		if (this.checked && customDomainEle.checked) {
			customDomainToggle.setPosition(true);
			customDomainSelect.prop('disabled', true).trigger('chosen:updated');			
		}
		else if(!this.checked && !nonReferenceArchitectureDomainEle.checked && !nonReferenceDemoDomainEle.checked && !customDomainEle.checked){
			saveBtn.prop("disabled", true);
		}
	};

	customDomainEle.onchange = function() {
		if (this.checked) {
			if (!customDomainSelect.chosen().val()){
				saveBtn.prop("disabled", true);	
			}else{
				saveBtn.removeAttr("disabled");
			}
			customDomainSelect.prop('disabled', false).trigger('chosen:updated');
			
			if (nonReferenceArchitectureDomainEle.checked) {
				nonReferenceArchitectureDomainToggle.setPosition(true);
			}
			if (nonReferenceDemoDomainEle.checked) {
				nonReferenceDemoDomainToggle.setPosition(true);
			}
			if (referenceDomainEle.checked) {
				referenceDomainToggle.setPosition(true);
			}
		}
		else if(!nonReferenceArchitectureDomainEle.checked && !nonReferenceDemoDomainEle.checked && !referenceDomainEle.checked && !this.checked){
			saveBtn.prop("disabled", true);
		}
	};
	
	//onload
<c:if test="${setting.nonReferenceArchitectureDomain eq true}">
	nonReferenceArchitectureDomainToggle.setPosition(true);
	customDomainSelect.prop('disabled', true).trigger('chosen:updated');
</c:if>
<c:if test="${setting.nonReferenceDemoDomain eq true}">
	nonReferenceDemoDomainToggle.setPosition(true);
	customDomainSelect.prop('disabled', true).trigger('chosen:updated');
</c:if>
<c:if test="${setting.referenceDomain eq true}">
	referenceDomainToggle.setPosition(true);
	customDomainSelect.prop('disabled', true).trigger('chosen:updated');
</c:if>
<c:if test="${setting.customDomain eq true}">
	customDomainToggle.setPosition(true);
	customDomainSelect.prop('disabled', false).trigger('chosen:updated');
</c:if>
	
}

//]]>
</script>

<syswf:component name="/newui/nifty" prefix="nifty">
	<syswf:param name="styles"  value="['/skinem/bootstrap/switchery/switchery.min.css', '/skinem/chosen/chosen.min.css']"/>
	<syswf:param name="scripts" value="['/skinem/bootstrap/switchery/switchery.min.js',  '/skinem/chosen/chosen.jquery.js']"/>
	<syswf:param name="callback" value="onLoadScriptCallback"/>
</syswf:component>