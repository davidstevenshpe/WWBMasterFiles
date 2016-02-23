<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>    

<c:if test="${not empty globalSession['userName']}">
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="serverFolderLabel" key="serverFolderLabel" bundle="${importsMessages}"/>
<fmt:message var="newFolderWindowTitle" key="newFolderWindowTitle" bundle="${importsMessages}"/>
<fmt:message var="selectServerFolderWindowTitle" key="selectServerFolderWindowTitle" bundle="${importsMessages}"/>
<fmt:message var="newFolderButton" key="newFolderButton" bundle="${importsMessages}"/>
<fmt:message var="newFolderWindowOK" key="newFolderWindowOK" bundle="${importsMessages}"/>
<fmt:message var="newFolderWindowCancel" key="newFolderWindowCancel" bundle="${importsMessages}"/>
<fmt:message var="rootFolderLabel" key="rootFolderLabel" bundle="${importsMessages}"/>
<fmt:message var="selectServerFolderButton" key="selectServerFolderButton" bundle="${importsMessages}"/>
<fmt:message var="selectServerFolderWindowOK" key="selectServerFolderWindowOK" bundle="${importsMessages}"/>
<fmt:message var="selectServerFolderWindowCancel" key="selectServerFolderWindowCancel" bundle="${importsMessages}"/>


<tr>
    <th>
        <label for="${prefix}serverFolderInputId" class="UI Label">${serverFolderLabel}</label>
    </th>
    <td>
    
        <div id="${prefix}publishLocalFile_serverFolderSelect_local_newfolderwin_source" class="x-hidden webfw-Window">
            <div class="x-window-header">${newFolderWindowTitle}</div>
            <div class="x-window-body">
                <div class="Offset">
                    <input id="${prefix}publishLocalFile_serverFolderSelect_local_newfoldername" type="text" name="uploadDocumentName" class="x-input x-newfolder-input" />                    
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var ${prefix}publishLocalFile_serverFolderSelect_local_newfoldername = new Ext.form.TextField({
                                applyTo: '${prefix}publishLocalFile_serverFolderSelect_local_newfoldername',
                                width: 327
                            });                 
                        });
                    
//]]>
</script>
                </div>
            </div>
        </div>
        
        <div id="${prefix}publishLocalFile_serverFolderSelect_source" class="x-hidden webfw-Window">
            <div class="x-window-header">${selectServerFolderWindowTitle}</div>
            <div class="x-window-body">
                <div id="${prefix}ctServerFolder-local"></div>
                
                <script type="text/javascript">
//<![CDATA[

                   Ext.onReady(function() {
                	   
                        var ${prefix}publishLocalFile_serverFolderSelect_local = new Ext.HP.Tree({
                            id: '${prefix}cmp-serverfolder-tree-local',
                            el: '${prefix}ctServerFolder-local',
                            cls: 'x-serverfolder-tree',
                            bbar: new Ext.Toolbar({
                                items: [{
                                    id: '${prefix}serverfolder-new-folder',
                                    text: '${newFolderButton}',
                                    disabled: true,
                                    handler: function() {
                                        SPopup.Window.forceOpen('${prefix}serverfolder_local_newfolder', '${prefix}publishLocalFile_serverFolderSelect_local_newfolderwin_source', {
                                            width: 350,
                                            autoHeight: true,
                                            modal: true,
                                            resizable: false,
                                            centerOnScreen: true,
                                            plain: false,
                                            buttonAlign: 'right',
                                            renderTo: 'popupWindows',
                                            buttons: [{
                                                text: '${newFolderWindowOK}',
                                                handler: function() {
                                                    
                                                	// do your code
                                                    var tree = Ext.getCmp('${prefix}cmp-serverfolder-tree-local');
                                                    var parent = tree.getSelectionModel().getSelectedNode();
                                                    
                                                    // new folder node
                                                    var nfn = new Ext.tree.TreeNode({
                                                        id: Ext.id(),
                                                        leaf: false,
                                                        text: Ext.get('${prefix}publishLocalFile_serverFolderSelect_local_newfoldername').getValue(),
                                                        uiProvider: Ext.HP.NewFolderUI
                                                    });
                                                    
                                                    nfn.folder = parent.folder + tree.pathSeparator + Ext.get('${prefix}publishLocalFile_serverFolderSelect_local_newfoldername').getValue();
                                                    parent.expand(false, true, function(node){
														parent.appendChild(nfn);
														nfn.select();
														nfn.toggle();														
													});
                                                    
                                                    SPopup.Window.Instance['${prefix}serverfolder_local_newfolder'].hide();
                                                }
                                            }, {
                                                text: '${newFolderWindowCancel}',
                                                handler: function() {
                                                    SPopup.Window.Instance['${prefix}serverfolder_local_newfolder'].hide();
                                                }
                                              }
                                        ]});
                                    },
                                    iconCls: 'new-serverfolder'
                                }]
                            }),
                            listeners: {
                                load: function() {
                                    Ext.getCmp('${prefix}serverfolder-new-folder').enable();
                                },
                                afterrender: function() {
                                    this.bottomToolbar.el.setWidth('auto');
                                    this.bottomToolbar.container.setWidth('100%');
                                 }
                            },
                            loader: new Ext.HP.TreeLoader({
                                url: '${locationsBrowserUrl}',
                                baseParams: {
                                    alt: 'js'
                                },
                                showFiles: false
                            }),
                            root: new Ext.tree.AsyncTreeNode({
                                text: '[${rootFolderLabel}]',
                                id: 'location',
                                expanded: true,
                                listeners: {
                                    'load': {
                                        fn: function(n) {
                                            n.expand(false, false, function(node) {
                                                node.folder = 'location';
                                                node.select();
                                            });
                                        }
                                    }
                                }
                            })
                        });
                                    
                        var ts = new Ext.tree.TreeSorter(${prefix}publishLocalFile_serverFolderSelect_local, {
                            folderSort: true
                        });
                                    
                        ${prefix}publishLocalFile_serverFolderSelect_local.render();
                   });
                
//]]>
</script>
                
            </div>
        </div>   
        
        <script type="text/javascript">
//<![CDATA[


            getSelectedFolder = function(selectedNode) {
                var result = '';
                var n = selectedNode;
                if (n.parentNode == null) return '/';
                while (n.parentNode != null) {
                    result = '/' + n.text + result;
                    n = n.parentNode;
                }
                return result;
            }
            
            ${prefix}processSelection_local_uid = function() {
                var selectedNode = Ext.getCmp('${prefix}cmp-serverfolder-tree-local').getSelectionModel().getSelectedNode();
                if (selectedNode == null) {
                    Ext.get('${prefix}serverFolderInputId').dom.value='';
                } else {
                    Ext.get('${prefix}serverFolderInputId').dom.value = getSelectedFolder(selectedNode);
                }
            }
        
//]]>
</script>
    
        <syswf:input id="${prefix}serverFolderInputId" name="publishLocalFile_serverFolder" value="${importFileBean}" property="serverFolder" hint="" mode="text"/>
               
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                var ${prefix}serverFolderInputId = new Ext.HP.ServerFolderField({
                    id: '${prefix}serverFolderInputId',
                    applyTo: '${prefix}serverFolderInputId',
                    width: <c:out value="${inputWidth}" default="600" />,
                    buttonText: '${selectServerFolderButton}',
                    buttonHandler: function(evt) {
                        SPopup.Window.forceOpen('${prefix}serverfolder_local', '${prefix}publishLocalFile_serverFolderSelect_source', {
                            id: '${prefix}cmp-publishLocalFile_serverFolder-win',                            
                            width: 440,
                            autoHeight: true,
                            resizable: false, 
                            centerOnScreen: true,
                            plain: false,
                            buttonAlign: 'right',
                            renderTo: 'popupWindows',
                            buttons: [{
                                text: '${selectServerFolderWindowOK}', 
                                handler: function() {
                                	${prefix}processSelection_local_uid();
                                    SPopup.Window.Instance['${prefix}serverfolder_local'].hide();
                                    ${recalculateLocationFunction}({ serverFolder : Ext.get('${prefix}serverFolderInputId').dom.value });
                                }
                            }, {
                                text: '${selectServerFolderWindowCancel}',
                                handler: function() {
                                    SPopup.Window.Instance['${prefix}serverfolder_local'].hide();
                                }
                            }
                        ]});
                    }
                });
            });
        
//]]>
</script>
        
        <c:if test="${importType eq 'local'}">
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    Ext.get('${prefix}serverFolderInputId').on('blur', function() {
                        Ext.get('${parentPrefix}_locationAfterUploadlocationText').dom.value = "";
                        ${recalculateLocationFunction}({ serverFolder : Ext.get('${prefix}serverFolderInputId').dom.value });
                    });
                });    
            
//]]>
</script>
        </c:if>
        
        <c:if test="${importType eq 'remote'}">
            <script type="text/javascript">
//<![CDATA[

            	Ext.onReady(function() {
    	            Ext.get('${prefix}serverFolderInputId').on('blur', function() {
    	                Ext.get('${parentPrefix}_locationAfterUpload$locationsCombo').dom.value = "";
        	            ${recalculateLocationFunction}({ serverFolder : Ext.get('${prefix}serverFolderInputId').dom.value });
            	    });
            	});    
            
//]]>
</script>
        </c:if>
        
    </td>
</tr>