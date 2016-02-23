<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="exportmessages" />
<fmt:message var="title" bundle="${exportmessages}" key="import.csv.header" />
<fmt:message var="desc" bundle="${exportmessages}" key="import.csv.desc" />
<div id="content-container" style="display:none">
	<div id="page-content">
		<div class="panel pad-hor" ng-controller="emCommonController" style="margin-bottom: 0px"><%--add inline css to avoid conflicting another page--%>
			<div class="pad-hor">
				<div header data="{title:'${title}', desc: '${desc}'}"></div>
				<div class="row pad-all" action-button data="{id:'download-template-button',label:'Download Template to Get Started',class:'btn-labeled fa fa-download'}">
				</div>
				<div id="template-message"></div>
			</div>
			<div class="panel-heading">
				<div class="panel-control">
					<ul class="nav nav-tabs">
						<li id="link-tab-files" class="active"><a href="#files-tab-box" data-toggle="tab"><fmt:message bundle="${exportmessages}" key="import.csv.file" /></a></li>
						<li id="link-tab-settings"><a  href="#settings-tab-box" data-toggle="tab"><fmt:message bundle="${exportmessages}" key="import.csv.settings" /></a></li>
					</ul>
				</div>
				<h3 id="panel-import-title" class="panel-title">Upload Data</h3>
			</div>
			<div class="panel-body" style="min-height: 300px"><%--add inline css to avoid conflicting another page--%>
				<div class="tab-content">
					<div class="tab-pane fade active in" id="files-tab-box">
						<div id="import-dropzone" action="#" class="dropzone">
							<div class="dz-default dz-message">
								<div class="dz-icon icon-wrap icon-circle icon-wrap-md">
									<i class="fa fa-cloud-upload fa-3x"></i>
								</div>
								<div>
									<p class="dz-text">Drop file(s) to upload</p>
									<p class="text-muted">or click to pick manually</p>
								</div>
							</div>
							<div class="fallback">
								<input name="file" type="file" multiple/>
							</div>
						</div>
						<div id="${prefix}_dropzone_exmsg" style="display:none;color:red;">
							<p>${fileMaxExceedMessage}</p>									
						</div>
					</div>
					<div class="tab-pane fade" id="settings-tab-box">
						<p>
							<em><fmt:message bundle="${exportmessages}" key="import.csv.settings.desc" /></em>
						</p>
						<button class="btn btn-gray btn-em info" onclick="return emCommon.toggleHelpText(this,'page-content')" help-text="less">
							<span>Show more information</span>
						</button>
						<div class="setting-table">
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.artifactType.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.artifactType" />:</div>
								<div combobox data="artifactTypes" id="${prefix}_artifactTypeOptions"></div>
							</div>
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.columnSeparator.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.columnSeparator" />:</div>
								<div input-char data="columnSeparator"></div>
							</div>
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.valueSeparator.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.valueSeparator" />:</div>
								<div input-char data="valueSeparator"></div>
							</div>
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.dateFormat.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.dateFormat" />:</div>
								<div input-date-format data="dateFormat"></div>
							</div>
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.processingMode.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.processingMode" />:</div>
								<div single-choice data="processingModes"></div>
							</div>
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.relationshipMode.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.relationshipMode" />:</div>
								<div single-choice data="relationshipModes"></div>
							</div>
							<div class="row pad-top">
								<div class="help-text">
									<fmt:message bundle="${exportmessages}" key="import.csv.propertyMode.helpText" />
								</div>				
							</div>
							<div class="row">
								<div class="col-sm-2 pt-10"><fmt:message bundle="${exportmessages}" key="import.csv.propertyMode" />:</div>
								<div single-choice data="propertyModes"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="pad-top" action-button data="importButton">
				</div>
			</div>
		</div>
	</div>
</div>
<div id="import-link-holder" style="display:none">
<syswf:control mode="anchor" action="dropzoneAction" id="${prefix}LinkImportCSV">
	<syswf:param name="actionToken" value="${actionToken}"/>
</syswf:control>
</div>
<syswf:control mode="script" caption="${prefix}CsvImport" action="importCSV" id="${prefix}ScriptImportCSV"/>
<syswf:input mode="hidden" name="file" value="${bean}" property="file" dataType="int"/>
<syswf:input mode="hidden" name="artifactType" value="${bean}" property="artifactType" />
<syswf:input mode="hidden" name="token" value="${bean}" property="token" />
<syswf:input mode="hidden" name="separator" value="${bean}" property="separator" />
<syswf:input mode="hidden" name="mode" value="${bean}" property="mode" dataType="enum"/>
<syswf:input mode="hidden" name="dateFormat" value="${bean}" property="dateFormat"/>
<syswf:input mode="hidden" name="dropRelations" value="${bean}" property="dropRelations" dataType="boolean"/>
<syswf:input mode="hidden" name="updateEmptyFields" value="${bean}" property="updateEmptyFields" dataType="boolean"/>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/skinem/dropzone/dropzone.min.js"></script>
<script type="text/javascript">
//<![CDATA[

$('#import-dropzone').attr('action',$('#import-link-holder a').attr('href'));

emCommon.dataScope['artifactTypes'] = eval('(${bean.artifactTypes})');
emCommon.dataScope.setSelectedIndex('artifactTypes','${prefix}_artifactType');

emCommon.dataScope['columnSeparator'] = {disabled: true,value:'${bean.separator}'};
emCommon.dataScope['valueSeparator'] = {value:'${bean.token}'};
emCommon.dataScope['dateFormat'] = {value:'${bean.dateFormat}'};

emCommon.dataScope['processingModes'] = eval('(${values.processingModes})');
emCommon.dataScope.setSelectedIndex('processingModes','${prefix}_mode');

/*_dropRelations*/
emCommon.dataScope['relationshipModes'] = {
		values: [false,true],
		captions: ['<fmt:message bundle="${exportmessages}" key="import.csv.relationshipMode.add" />','<fmt:message bundle="${exportmessages}" key="import.csv.relationshipMode.force" />']
}
emCommon.dataScope.setSelectedIndex('relationshipModes','${prefix}_dropRelations');
/*_updateEmptyFields*/
emCommon.dataScope['propertyModes'] = {
		values: [false,true],
		captions: ['<fmt:message bundle="${exportmessages}" key="import.csv.propertyMode.ignore" />','<fmt:message bundle="${exportmessages}" key="import.csv.propertyMode.force" />']
}
emCommon.dataScope.setSelectedIndex('propertyModes','${prefix}_updateEmptyFields');
emCommon.dataScope['importButton'] = {id:'import-button',label:'Start Import', disabled: true}
var ${prefix}_totalFiles = 0;
var ${prefix}_isDzImportButtonClick = false;
var ${prefix}_excelFiles = 0;
var ${prefix}_csvFiles = 0;
function initCsvDropzone() {
	Dropzone.options.importDropzone = {
		autoProcessQueue: false,
		paramName: '${filesNameTemplate}',
		acceptedFiles: '.csv,.xls,.xlsx',
		maxFilesize: ${maxFileSize},
		uploadMultiple: true,
		parallelUploads: ${maxFiles},
		addRemoveLinks: true,
		dictFileTooBig: '${fileSizeExceedMessage}',
		createImageThumbnails: false,
		init: function() {
		  emCommon.dropZone = this;
		  emCommon.dropZone.on('addedfile', function(file) {
			${prefix}_totalFiles +=1;
			if(/(\.xls)|(\.xlsx)$/.test(file.name)){
				${prefix}_excelFiles+=1;
			}else if(/(\.csv)$/.test(file.name)){
				${prefix}_csvFiles+=1;
				emCommon.scope.$apply(function() {
					emCommon.scope['columnSeparator'].disabled = false;
				});
			}
			var files = this.getQueuedFiles();
			emCommon.dataScope['artifactTypes'].selectedIndex = 0;
			if(${prefix}_totalFiles > 1){
				$('#${prefix}_artifactTypeOptions').find('*').attr('disabled', true);
			}else{
				if(${prefix}_excelFiles > 0){
					$('#${prefix}_artifactTypeOptions').find('*').attr('disabled', true);
				}else{
					detectArtifactType(emCommon.dataScope['artifactTypes'].selectedIndex);
				}
				
			}
				
				
			if(${prefix}_totalFiles > ${maxFiles}) {
						
				$('#${prefix}_dropzone_exmsg').show();
				emCommon.scope.$apply(function() {
					emCommon.scope['importButton'].disabled = true;
				});
			}else{
				emCommon.scope.$apply(function() {
					emCommon.scope['importButton'].disabled = false;
				});
			}
			if(file.previewElement != null){
				
					var detail = file.previewElement.querySelector('.dz-details');
					if(detail != null){
						detail.setAttribute('title',file.name);
						var img = detail.querySelector('img');
						if(img != null)
						{
							detail.removeChild(img);
						}
						if(/(\.csv)$/.test(file.name)){
							var myImage = Dropzone.createElement("<div class='data-dz-thumbnail-csv'></div>");
							detail.appendChild(myImage);
						}else if(/(\.xls)|(\.xlsx)$/.test(file.name))
						{
							var myImage = Dropzone.createElement("<div class='data-dz-thumbnail-xls'></div>");
							detail.appendChild(myImage);
						}
						
					
					}
					
					var error_mark = file.previewElement.querySelector('div.dz-error-mark');
					if(error_mark != null){
						var span = error_mark.querySelector('span');
						error_mark.removeChild(span);
						var myImage = Dropzone.createElement("<div class='dz-failed-file'></div>");
						error_mark.appendChild(myImage);
					}
					
				}
				
		  		
		  		
		  });
		  emCommon.dropZone.on('removedfile', function(file) {
				${prefix}_totalFiles -=1;
				if(/(\.xls)|(\.xlsx)$/.test(file.name)){
					${prefix}_excelFiles-=1;
				}else if(/(\.csv)$/.test(file.name)){
					${prefix}_csvFiles-=1;
				}
				
				if(${prefix}_csvFiles > 0){
					emCommon.scope.$apply(function() {
						emCommon.scope['columnSeparator'].disabled = false;
					});
				}else{
					emCommon.scope.$apply(function() {
						emCommon.scope['columnSeparator'].disabled = true;
					});
				}
				var files = this.getQueuedFiles();
				if(${prefix}_totalFiles <= ${maxFiles}) {
					$('#${prefix}_dropzone_exmsg').hide();					
					if(${prefix}_totalFiles <= 1) {
						if(${prefix}_excelFiles > 0){
							emCommon.dataScope['artifactTypes'].selectedIndex = 0;
							$('#${prefix}_artifactTypeOptions').find('*').attr('disabled', true);
						}else{
							detectArtifactType(emCommon.dataScope['artifactTypes'].selectedIndex);
							$('#${prefix}_artifactTypeOptions').find('*').attr('disabled', false);
							if(${prefix}_totalFiles == 0) {
								emCommon.scope.$apply(function() {
									emCommon.scope['importButton'].disabled = true;
								});
							}
						}
						
						
					}else{
						emCommon.scope.$apply(function() {
							emCommon.scope['importButton'].disabled = false;
						});
					}
					
					
				}
			  	
		  });
		  emCommon.dropZone.on('queuecomplete', function() {
			if(${prefix}_isDzImportButtonClick && this.getQueuedFiles().length == 0){
				${prefix}CsvImport();
			}
		  });
		}
	}
}

function detectArtifactType(val) {
	  if(val == 0) {
		  $('#panel-import-title').html('Upload Data');
	  } else {
		  $('#panel-import-title').html('Upload Data about '+ emCommon.dataScope['artifactTypes'].captions[val] + '(s)');
	  }
}

$(document).ready(function () {
	layoutManager.loadStyle(['<c:out value='${webResourcePath}'/>/skinem/dropzone/dropzone.css','<c:out value='${webResourcePath}'/>/skinem/dropzone/dropzone_em.css'], function(){$('#content-container').show();});	
	initCsvDropzone();
	detectArtifactType(emCommon.dataScope['artifactTypes'].selectedIndex);
	emCommon.scope.$watch('artifactTypes.selectedIndex', function(val) {
		detectArtifactType(val);
	});
	
	$('#import-button').click(function() {
		$('#${prefix}_separator').val(emCommon.dataScope['columnSeparator'].value);
		$('#${prefix}_token').val(emCommon.dataScope['valueSeparator'].value);
		$('#${prefix}_dateFormat').val(emCommon.dataScope['dateFormat'].value);
		$('#${prefix}_file').val(${prefix}_totalFiles);
		$('#${prefix}_artifactType').val(emCommon.dataScope['artifactTypes'].values[emCommon.dataScope['artifactTypes'].selectedIndex]);
		$('#${prefix}_mode').val(emCommon.dataScope['processingModes'].values[emCommon.dataScope['processingModes'].selectedIndex]);
		$('#${prefix}_dropRelations').val(emCommon.dataScope['relationshipModes'].values[emCommon.dataScope['relationshipModes'].selectedIndex]);
		$('#${prefix}_updateEmptyFields').val(emCommon.dataScope['propertyModes'].values[emCommon.dataScope['propertyModes'].selectedIndex]);
		${prefix}_isDzImportButtonClick = true;
		emCommon.scope.$apply(function() {
			emCommon.scope['importButton'].disabled = true;
		});
		emCommon.dropZone.processQueue();
	});
	$('#download-template-button').click(function() {
		$('#template-message').html('');
		$('#${prefix}_artifactType').val(emCommon.dataScope['artifactTypes'].values[emCommon.dataScope['artifactTypes'].selectedIndex]);
		if('${template}' != ''){
			window.location = SERVER_URI + '/../../../platform/rest/location' + '${template}';
		}else{
			
			$.ajax({
			url:'',
			type: 'GET',
			data: {
				action: 'getImportTemplate',
				artifactType: emCommon.dataScope['artifactTypes'].values[emCommon.dataScope['artifactTypes'].selectedIndex]
			},
			success: function(data) {
				var artifactType = emCommon.dataScope['artifactTypes'].values[emCommon.dataScope['artifactTypes'].selectedIndex];
				if(data.indexOf('noTemplate') == 0) {
					
					var sampleUuid = data.length > 10 ? data.split(':')[1] : '';
					var link = '<a href="' + SERVER_URI + '/../../service-catalog/document/' + sampleUuid + '" style="color:#3b8dd5">Application Component</a>';
					
					if(artifactType==''){
						msg = 'Please select an artifact type you want to download the template for.';
						if(sampleUuid!=''){
							msg = msg.replace('.', ',');
							msg += ' or download the template for ' + link + ' and modify it to suit your needs.';
						}
					}else{
						msg = 'No template available for ' + emCommon.dataScope['artifactTypes'].captions[emCommon.dataScope['artifactTypes'].selectedIndex] + '.';
						if(sampleUuid!=''){
							msg += ' You can download the template for ' + link + ' and modify it to suit your needs.';
						}
					}
					
					$('#template-message').html(msg);
					
				} else {
					window.location = SERVER_URI + '/../../service-catalog/document/' + data;
				}
				
				if (artifactType=='' && ($('.nav.nav-tabs li#link-tab-settings').attr('class') != 'active')) {
					$('.nav.nav-tabs li').toggleClass("active");
					$('.tab-content div').toggleClass("active in");
				}
			},
			error: function(data) {
				console.log(data);
			}
		});
		
		}
		
	});
});

//]]>
</script>