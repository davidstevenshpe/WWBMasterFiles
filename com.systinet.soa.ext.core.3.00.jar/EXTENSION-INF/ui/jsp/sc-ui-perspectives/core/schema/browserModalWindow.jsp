<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
Component parameters

winOpenFunctionName - name of the JS function that opens this window, the name has to be bound to
                      a click action on an element. The function is generated here, called from
                      parent component

--%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>
<fmt:message var="windowLabel" key="schemaBrowser" bundle="${schemaMessages}"/>
<fmt:message var="backButtonLabel" key="backButtonLabel" bundle="${schemaMessages}"/>
<fmt:message var="closeButtonLabel" key="closeButtonLabel" bundle="${schemaMessages}"/>


<script type="text/javascript">
/* <![CDATA[ */

    var win;
    var ${prefix}WinMask;

/* ]]> */
</script>
<c:set var="winMask" value="${prefix}WinMask" />

<div id="${prefix}Content" style="display:none" class="x-hidden">    
    <syswf:component name="/core/schema/browserWindowContent" prefix="w">
        <syswf:paramSet value="${componentParams}" />
        <syswf:param name="inWindow" value="${true}" />
        <syswf:param name="jsWinVarName" value="win" />
        <syswf:param name="jsWinMaskVarName" value="${winMask}" />
        <syswf:param name="jsHideToolTipsName" value="hideToolTips" />
        <syswf:param name="jsDestroyToolTipsName" value="destroyToolTips" />
        <syswf:param name="backAction" value="${prefix}Back" />
        <syswf:param name="backButtonId" value="${prefix}BackButton" />
    </syswf:component>    
</div>


<script type="text/javascript" >
/* <![CDATA[ */   
        var ${winOpenFunctionName} = function(title) {
            if(win == null) {
                var el=Ext.get('${prefix}Content');
                var h=document.documentElement.clientHeight-100;
                var optimal_w=h/3*4;
                var max_w=document.documentElement.clientWidth-100;
                var w=optimal_w>max_w?max_w:optimal_w;
    
                var closeHandler=function() {
                    browsingDepth=0;
                    destroyToolTips();
                    win.remove(0);
                    win.hide();
                    ${closeFunction}();
                };
                
                win = new Ext.Window({
                       id: '${prefix}Win',
                       title       : '${windowLabel}',
                       width:      w,
                       height:     h,
                       modal       : true,
                       closeAction :'hide',
                       autoScroll  : true,
                       plain       : true,
                       layout      : 'card',
                       shim        : true,
                       maximizable : false,
                       buttons:  [{
                           text     : '${backButtonLabel}',
                           handler  : function() {
                    	       destroyToolTips();
                               ${prefix}Back();
                           },
                           id: '${prefix}BackButton'
                       },{
                           text     : '${closeButtonLabel}',
                           handler  : closeHandler,
                           id: '${prefix}CloseButton'
                       }]
               });
    
    
    
                // extjs bug
                win.addListener('hide',function(th) { Ext.getBody().removeClass('x-window-maximized-ct'); closeHandler(); }); 
                win.addListener('maximize',function(th) { window.scrollTo(0,0); hideToolTips(); }); 
                win.addListener('resize',function(th) { hideToolTips(); }); 
                win.addListener('move',function(th) { hideToolTips(); }); 
            } 
            win.show();
            Ext.get('${prefix}BackButton').hide();
           

            ${winMask} = new Ext.LoadMask(Ext.get('${prefix}Win'));
            ${winMask}.show();
           
      }

       
    
/* ]]> */
</script>

