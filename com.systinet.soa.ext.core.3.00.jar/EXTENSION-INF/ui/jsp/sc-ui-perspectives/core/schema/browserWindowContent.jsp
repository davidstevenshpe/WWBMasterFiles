<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:control mode="script" caption="${prefix}GoToFunctionInner" action="goTo" affects="." />
<script type="text/javascript">
//<![CDATA[

    var ${prefix}GoToFunction = function(params) {
        //show loading mask
        <c:if test="${inWindow}">
            ${jsWinMaskVarName}.show();
        </c:if>
        //run goto function
        ${prefix}GoToFunctionInner(params);
    };

//]]>
</script>

<c:if test="${empty goToFunction}" >
    <c:set var="goToFunction" value="${prefix}GoToFunction" />
</c:if>

<c:choose>
    <c:when test="${not empty initializationError}">
            Internal error during initialization: ${initializationError} 
    </c:when>
    <c:otherwise>
    
    

        <c:if test="${inWindow}">
        
        
            <script type="text/javascript" >
            //<![CDATA[
            
                var visibility=new Array();
            
                var tooltips = [];
                var tooltipIDs = [];
                var tooltipsCounter=0;
                var visibility=new Array();
            
                
                var viewElement = function(localName, namespace){
                	${prefix}GoTo({elementViewType: 'schemaElement', elementLocalName: localName, elementNamespace: namespace, showXml: true});
                };
        
                var ${prefix}GoTo = function(params){
                	${jsDestroyToolTipsName}();
                    ${prefix}GoToFunction(params);
                };
                
                var ${jsHideToolTipsName} = function()
                {
                    for (i=0;i<tooltips.length;i++) {
                       if (tooltips[i].isVisible()) tooltips[i].hide();
                    } 
                }
            
                var ${jsDestroyToolTipsName} = function()
                {
                    for (i=0;i<tooltips.length;i++) {
                        tooltips[i].destroy();
                      } 
                      tooltips = [];
                      tooltipIDs = [];
                      tooltipsCounter = 0;            
                }
        
                var switchElementVisibility=function(obj, id) {
                   visibility[id]=!visibility[id];
                   animate=false;
        
                   Ext.get(id+'8').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],animate);
                   if(Ext.get(id+'7') != null) {
                    Ext.get(id+'7').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],animate);
                    Ext.get(id+'6').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],animate);
                   }
                   
        
                   Ext.get(id+'5').setVisibilityMode(Ext.Element.DISPLAY).setVisible(!visibility[id],false);
                   Ext.get(id+'4').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],false);
        
                   Ext.get(id+'3').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],animate);
                   Ext.get(id+'9').setVisibilityMode(Ext.Element.DISPLAY).setVisible(!visibility[id],animate);
                   Ext.get(id+'2').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],animate);
                   Ext.get(id+'1').setVisibilityMode(Ext.Element.DISPLAY).setVisible(visibility[id],animate);
        
                   hideToolTips();
                   
                   if(!Ext.isIE) {
	   					var rootParents = $(obj).parents('td.NoMarginNoPadding[rowspan=2]');
						if(visibility[id]) {
							rootParents.each(function(){
								$(this).prev().height($(this).height()/2);
							});
						}else{
							rootParents.each(function(){
								$(this).prev().height('auto');
							});
						}
                   }
                }
            
                
            
//]]>
</script>
        
            <syswf:control mode="script" caption="${prefix}Back" action="back" affects="." />
            <script type="text/javascript">
//<![CDATA[

                var ${backAction} = function(params) {
                    //if back button is hidden after navigation, it has to be hide berore ajax request to prevent double click
                	<c:if test="${stackSize == 2}" >
                        Ext.get('${backButtonId}').hide();
                    </c:if>
                    //show mask
                    ${jsWinMaskVarName}.show();
                    
                    //run back function
                	${prefix}Back(params);
                };
            
//]]>
</script>
        </c:if>    
        
        
        
        <c:if test="${contentLoaded}">
        
            <div id="${prefix}XmlGraph">
        
                <c:choose>
                    <c:when test="${targetViewType == 'wsdl'}">
                        <syswf:component name="/core/schema/viewWsdl" prefix="viewWsdl">
                            <syswf:param name="uuid" value="${targetUuid}" />
                            <syswf:param name="tableId" value="${prefix}T" />
                            <syswf:param name="revision" value="${targetRevision}" />
                            <syswf:param name="goToFunction" value="${goToFunction}" />
                            <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                        </syswf:component>
                    </c:when>
                    
                     <c:when test="${targetViewType == 'schema'}">
                        <syswf:component name="/core/schema/viewSchemaIndex" prefix="viewSchemaIndex">
                            <syswf:param name="uuid" value="${targetUuid}" />
                            <syswf:param name="tableId" value="${prefix}T" />
                            <syswf:param name="revision" value="${targetRevision}" />
                            <syswf:param name="namespace" value="${targetNamespace}" />
                            <syswf:param name="goToFunction" value="${goToFunction}" />
                            <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                        </syswf:component>
                    </c:when>
                    
                    <c:when test="${targetViewType == 'schemaElement'}">
                            <syswf:component name="/core/schema/viewSchemaElement" prefix="viewSchemaElement">
                                <syswf:param name="localName" value="${targetLocalName}" />
                                <syswf:param name="localNameAlias" value="${targetLocalNameAlias}" />
                                <syswf:param name="namespace" value="${targetNamespace}" />
                                <syswf:param name="type" value="${targetType}" />
                                <syswf:param name="goToFunction" value="${prefix}GoTo" />
                                <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                            </syswf:component>
                    </c:when>
                
                </c:choose>
            </div>
                    
            <div id="${prefix}XmlSchema">
                <c:if test="${targetViewType == 'schemaElement'}">
                    <syswf:component name="/core/schema/viewXml" prefix="Xml">
                        <syswf:param name="uuid" value="${targetUuid}" />
                        <syswf:param name="revision" value="${targetRevision}" />
                        <syswf:param name="localName" value="${targetLocalName}" />
                        <syswf:param name="namespace" value="${targetNamespace}" />
                        <syswf:param name="type" value="${targetType}" />
                        <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                    </syswf:component>
                </c:if>
            </div>
        </c:if>
         
         
        <syswf:control mode="script" caption="${prefix}LoadContent" action="loadContent" affects="." />
        <script type="text/javascript">
//<![CDATA[

            var ${loadFunction} = function(params){
                ${prefix}LoadContent(params);
            };
        
            <c:if test="${inWindow && contentLoaded}" >
                Ext.onReady(function(){
                    var schemaPaneWidth=830>win.getInnerWidth() ? win.getInnerWidth()-30 : 800;
                    var panel=new Ext.Panel({
                        layout      :'border',
                        bodyStyle   : 'background:white',
                        autoWidth: true,
                        defaults: {
                           collapsible: true,
                           split: true,
                           bodyStyle: 'padding:15px'
                        },
                        items: [
                          <c:if test="${targetViewType == 'schemaElement'}">      
                                    {
                               style   : 'background:white;',
                               title: 'XML View',
                               autoScroll  : true,
                               width: schemaPaneWidth,
                               region:'east',
                               margins: '0 0 0 0',
                               cmargins: '0 0 0 0',
                               <c:choose>
                                    <c:when test="${targetShowXml}" >
                                        collapsed:false,
                                    </c:when>
                                    <c:otherwise>
                                        collapsed:true,
                                    </c:otherwise>
                               </c:choose>
                                    
                               contentEl: '${prefix}XmlSchema'
                            },
                        </c:if>
                        {
                           id: 'schemaPane',
                           collapsible: false,
                           autoScroll: true,
                           width: 800,
                           region:'center',
                           border:false,
                           contentEl: '${prefix}XmlGraph'
                        }]
                        });
                    
                     ${jsWinVarName}.remove(0);
                     ${jsWinVarName}.add(panel);
                     ${jsWinVarName}.getLayout().setActiveItem(0);
                     ${jsWinMaskVarName}.hide();
                     <c:if test="${targetViewType == 'schemaElement'}">      
                         panel.on('afterlayout', function(panel) {
                                                    panel.getComponent(1).body.on('scroll', function() { hideToolTips(); });
                                                    if(!Ext.isIE) {
                                                        $('td.NoMarginNoPadding[rowspan=2]', $('#schemaPane')).each(function(){
                                                        	$(this).prev().height($(this).height()/2);
                                                        });
                                                    }
                                                 }
                                 );
                     </c:if>
                     ${jsWinVarName}.doLayout();
                     panel.getComponent(0).addListener('beforeExpand', function(panel) {hideToolTips(); } );

                
                    var backButton = Ext.get('${backButtonId}')
                    <c:choose>
                        <c:when test="${stackSize > 1}" >
                            backButton.show();
                        </c:when>
                        <c:otherwise >
                            backButton.hide();
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${targetViewType == 'schema' or targetViewType == 'wsdl'}">
                                Ext.getCmp('${prefix}T').getView().refresh();
                    </c:if>                    
                });
            </c:if>
        
//]]>
</script>

    </c:otherwise>
</c:choose>