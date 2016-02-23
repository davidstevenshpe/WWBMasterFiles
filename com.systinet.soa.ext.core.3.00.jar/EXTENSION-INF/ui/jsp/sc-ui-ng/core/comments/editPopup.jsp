<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<syswf:input id="${prefix}_commentId" name="commentId" mode="hidden" value="${bean}" property="commentId" />

<syswf:control caption="${prefix}_saveComment" mode="script" action="save">
    <syswf:param name="bean" value="${bean}" />
</syswf:control>
<syswf:control caption="${prefix}_editComment" mode="script" action="edit">
    <syswf:param name="bean" value="${bean}" />
</syswf:control>
<syswf:control caption="${prefix}_deleteComment" mode="script" action="deleteComment">
    <syswf:param name="bean" value="${bean}" />
</syswf:control>
<syswf:control caption="${prefix}_deleteAllComments" mode="script" action="deleteAllComments" />


<fmt:message key="editPopup.title.edit" var="editTitle" bundle="${commentsmessages}" />
<fmt:message key="editPopup.title.new" var="newTitle" bundle="${commentsmessages}" />
<fmt:message key="editPopup.title.reply" var="replyTitle" bundle="${commentsmessages}" />

<fmt:message key="editPopup.confirm.deleteComment.header" var="deleteCommentHeader" bundle="${commentsmessages}" />
<fmt:message key="editPopup.confirm.deleteThread.header" var="deleteThreadHeader" bundle="${commentsmessages}" />
<fmt:message key="editPopup.confirm.deleteComment.content" var="deleteCommentContent" bundle="${commentsmessages}" />
<fmt:message key="editPopup.confirm.deleteThread.content" var="deleteThreadContent" bundle="${commentsmessages}" />
<fmt:message key="editPopup.confirm.deleteComment.actionCaption" var="deleteCommentActionCaption" bundle="${commentsmessages}" />
<fmt:message key="editPopup.confirm.deleteThread.actionCaption" var="deleteThreadActionCaption" bundle="${commentsmessages}" />

<syswf:component name="/core/impl/util/dialog" prefix="dialog">
    <syswf:param name="heading">${deleteCommentHeader}</syswf:param>
    <syswf:param name="content">${deleteCommentContent}</syswf:param>
    <syswf:param name="controlName" value="${prefix}_dialog_control" />
    <syswf:param name="actionCaption">${deleteCommentActionCaption}</syswf:param>
    <syswf:param name="noUndo" value="true" />
</syswf:component>

<script type='text/javascript'>
//<![CDATA[
    function ${prefix}_popup(element, id, title, text, caption, handler, editableTitle) {
    }
    
    function ${prefix}_new(element) {
        ${prefix}_popup(element, '', '', '', '${newTitle}', ${prefix}_saveComment, true);
    }
    
    function ${prefix}_reply(element, id, title, text) {
        ${prefix}_popup(element, id, title, text, '${replyTitle}', ${prefix}_saveComment, false);
    }
    
    function ${prefix}_edit(element, id, title, text, editableTitle) {
        ${prefix}_popup(element, id, title, text, '${editTitle}', ${prefix}_editComment, editableTitle);
    }

    function ${prefix}_delete(element, id) {
        var element = element.on('click', function() {
            var handler = function() {
                Ext.get('${prefix}_commentId').dom.value = id;
                ${prefix}_deleteComment();
            };
    	    ${prefix}_dialog_showDialog(element, '${deleteCommentHeader}', '${deleteCommentContent}', '${deleteCommentActionCaption}', handler, true);
        });
    }

    function ${prefix}_deleteAll(element) {
        var element = element.on('click', function() {
            var handler = function() {
                ${prefix}_deleteAllComments();
            };
            ${prefix}_dialog_showDialog(element, '${deleteThreadHeader}', '${deleteThreadContent}', '${deleteThreadActionCaption}', handler, true);
        });
    }

//]]>
</script>

<!-- BEGIN: ADD COMMENT DIALOG -->
<div id="${prefix}_content" class="x-hidden">
    <div class="x-window-header" id="${prefix}_caption">${newTitle}</div>
    <div class="x-window-body">
        <div id="${prefix}_newTitle">
            <p class="Comment">
                ${caption}
            </p>
            <div id="${prefix}_title" class="Offset">
                <syswf:input id="${prefix}_title_input" name="commentPopup_title_input" 
                        value="${bean}" property="title" />
                <script type='text/javascript'>
                //<![CDATA[
                    Ext.onReady(function() {
                        new Ext.HP.Input({
                            id: '${prefix}_title_input',
                            stateful: false,
                            width: 674,
                            maxLength: 255,
                            applyTo: '${prefix}_title_input'
                        });                                                                                                                                                                     
                    }); 
                
//]]>
</script>
            </div>
        </div>
        <div id="${prefix}_editTitle" style="display: none">
            <p class="Comment">
                ${replyCaption} <span id="${prefix}_title_display"><syswf:out context="HtmlBody" value="${bean.title}"/></span>
            </p>
        </div>
        
        <div id="${prefix}_editor" class="AJAXContainer Offset">
            <syswf:textArea id="${prefix}_editor_textArea" name="commentPopup_editor_textArea"
                    value="${bean}" property="text">
            </syswf:textArea>
            <syswf:component name="/core/impl/edit/richTextEditor" prefix="editor" wrap="false">
                <syswf:param name="textAreaId" value="${prefix}_editor_textArea"/>
                <syswf:param name="width" value="674"/>
                <syswf:param name="height" value="300"/>
                <syswf:param name="addArtifact" value="true"/>
                <syswf:param name="handlerFunctionName">${prefix}_showPopup</syswf:param>
                <syswf:param name="selectFunctionName">${prefix}_onSelectArtifact</syswf:param>
            </syswf:component>
        </div>
    </div>
</div>
<syswf:component name="/core/search/selector/artifactSelector" prefix="addLink">
    <syswf:param name="jsOpenFunction">${prefix}_showPopup</syswf:param>
    <syswf:param name="jsSelectFunction">${prefix}_onSelectArtifact</syswf:param>
</syswf:component>

<!-- END: ADD COMMENT DIALOG -->


<fmt:message var="cancelCaption" bundle="${messages}" key="Cancel"/>
<fmt:message var="saveCaption" bundle="${commentsmessages}" key="editPopup.save"/>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        var win_add_comment = new Ext.HP.Window({
            applyTo: '${prefix}_content',
            width: 700,
            autoheight: true,
            modal: true,
            buttons: [{
                text: '${saveCaption}',
                handler: ${prefix}_new
            }, {
                text: '${cancelCaption}',
                handler: function(){
                    win_add_comment.hide();
                }
            }]
        });

        Ext.get('${prefix}_editTitle').setVisibilityMode(Ext.Element.DISPLAY);
        Ext.get('${prefix}_newTitle').setVisibilityMode(Ext.Element.DISPLAY);

        ${prefix}_popup = function(element, id, title, text, caption, handler, editableTitle) {
            element.on('click', function() {
                if (editableTitle) {
                    Ext.get('${prefix}_editTitle').hide();
                    Ext.get('${prefix}_newTitle').show();

                    Ext.getCmp('${prefix}_title_input').setValue(title);
                } else {
                    Ext.get('${prefix}_newTitle').hide();
                    Ext.get('${prefix}_editTitle').show();

                    Ext.get('${prefix}_title_display').update(title);
                }

                CKEDITOR.instances.${prefix}_editor_textArea.setData(text);
                Ext.get('${prefix}_commentId').dom.value = id;
                Ext.get('${prefix}_caption').update(caption);

                win_add_comment.buttons[0].setHandler(handler);
                
                win_add_comment.centerOnScreen();
                win_add_comment.show(element);

                if (editableTitle) {
                	Ext.getCmp('${prefix}_title_input').focus(true, 1000);
                } else {
                    //CKEDITOR.instances.${prefix}_editor_textArea.focus();
                    var focustask = function() { CKEDITOR.instances.${prefix}_editor_textArea.focus(); };
                    focustask.defer(1000);
                }
            });
        }

    });
    

//]]>
</script>
