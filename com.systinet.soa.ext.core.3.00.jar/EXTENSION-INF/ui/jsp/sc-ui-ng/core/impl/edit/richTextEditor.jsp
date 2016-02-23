<%--
Component parameters

startupMode: 'source', 'wysiwyg'
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<fmt:message bundle="${labels}" key="Artifact" var="artifactLabel" />

<c:if test="${not empty addArtifact}">
    <c:if test="${empty selectFunctionName}">
        <c:set var="selectFunctionName" value="${prefix}_selectArtifact" />
    </c:if>
    <c:if test="${empty handlerFunctionName}">
        <c:set var="handlerFunctionName" value="${prefix}_handler" />
    </c:if>
</c:if>

<script type="text/javascript">
//<![CDATA[

<c:if test="${not empty addArtifact}">
    function ${prefix}_selectArtifact(name, uuid) {}
</c:if>

    function ${prefix}_updateContent() {
        if (CKEDITOR.instances.<c:out value="${textAreaId}"/>) {
            CKEDITOR.instances.<c:out value="${textAreaId}"/>.updateElement();
        }
    }
    
    function createEditor() {
        if (CKEDITOR.instances.<c:out value="${textAreaId}"/>) {            
            CKEDITOR.instances.<c:out value="${textAreaId}"/>.destroy(true);
        }
        var editor = CKEDITOR.replace('<c:out value="${textAreaId}"/>', {
            <c:if test="${not empty width}">
                width : <c:out value="${width}"/>,
            </c:if>
            <c:if test="${not empty height}">
                height : <c:out value="${height}"/>,
            </c:if>
            toolbar: [
                 ['Bold', 'Italic', 'Underline', '-', 'TextColor',
                 <c:if test="${specificationPage}"> 
                  'BGColor',
                 </c:if> 
                  '-', 'NumberedList', 'BulletedList', 'Indent', 'Outdent', '/', 'JustifyLeft', 'JustifyCenter', 'JustifyRight'],
                  <c:if test="${specificationPage}"> 
                  ['Link','Unlink','Anchor'],
                 </c:if>
                 <c:if test="${not empty addArtifact}">
                     ['Artifact'],
                 </c:if>
                 ['Font', 'FontSize', 
                 <c:if test="${specificationPage}">
                    '-', 'Image', 'Table',
                 </c:if>
                 '-', 'Source']
             ],
            <c:if test="${not empty editorLocale}">
            language: '${editorLocale}',
            </c:if>
            // Fix defect of CKEditor in popups
            <c:if test="${not empty parentPopupWindowElementId or (startupMode eq 'source')}">
            startupMode: 'source',
            </c:if>
            toolbarCanCollapse: false,
            font_defaultLabel: 'Arial',
            fontSize_defaultLabel: '12px',
            fontSize_sizes: '10/10px;12/12px;16/16px;24/24px;48/48px;',
            disableNativeSpellChecker: true,
            scayt_autoStartup: false, 
            skin: 'office2003',
            resize_enabled: false,
            removeDialogTabs: 'image:advanced;image:Link;link:advanced'
        });
        
        editor.on('blur', function(ev) {
            editor.updateElement();
        });
        // Fix defect of CKEditor in popups
        <c:if test="${not empty parentPopupWindowElementId}">
        Ext.onReady(function() {
            ${parentPopupWindowElementId}_showHandlers.push(function() {
                CKEDITOR.instances['${textAreaId}'].setMode('wysiwyg');
            });
        })
        </c:if>

        <c:if test="${not empty addArtifact}">
            ${selectFunctionName} = function(name, uuid) {
                var text = '<a href="\${artifact(uuid=' + uuid + ')}">' + name + '</a>';
                editor.insertHtml(text);
            }

            editor.on('pluginsLoaded', function(ev) {
                var artifactDynamicCmd = {
                    exec : function(editor) {
                        ${handlerFunctionName}();
                    }
                };

                editor.addCommand('artifact', artifactDynamicCmd);
                editor.ui.addButton('Artifact', {
                    label: '${artifactLabel}',
                    command: 'artifact'
                });
            });
        </c:if>
    }
    
    <c:if test="${specificationPage}">
    CKEDITOR.on('dialogDefinition',function(ev){
    	var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
        if(dialogName == "link"){
            var targetTab = dialogDefinition.getContents('target');
            var targetItems = targetTab.get('linkTargetType').items;
            targetItems.splice(1,1);//frame
            targetItems.splice(1,1);//popup
            targetItems.splice(3,1);//self
        }
    });
    </c:if>
    
    <c:choose>
        <c:when test="${not empty eventToCreateEditor}">
            $(document).on('${eventToCreateEditor}', function(){
                createEditor();
            });
        </c:when>
        <c:otherwise>
            $(document).ready( function() {
                createEditor();
            });
        </c:otherwise>
    </c:choose>
    
//]]>
</script>
