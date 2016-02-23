<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<fmt:message var="technicalDetail_link" key="technicalDetail" bundle="${messages}"/>
<fmt:message var="technicalDetail_title" key="technicalDetail" bundle="${messages}"/>
<fmt:message var="ok_label" key="OK" bundle="${messages}"/>

<div class="UI SystemMessage <c:choose><c:when test="${type eq 'warning'}">Warning</c:when><c:when test="${type eq 'error'}">Error</c:when><c:otherwise>Info</c:otherwise></c:choose>">
<div class="MessageContainer">
    <c:if test="${isRunning}">
         <syswf:component name="/core/impl/widgets/progressBar" prefix="inReport" wrap="true">
            <syswf:param name="statusGetter" value="${statusGetter}"/>
            <syswf:param name="isRunning" value="${isRunning}"/>
         </syswf:component>
    </c:if>
    
    <div class="Text">
        <strong>${text}</strong>    
    </div>
    <c:if test="${not empty technicalDetail}">
           <div class="ErrorDetails">
               <a id="uilink_techdetails" href="javascript:void(0);" class="UI Icon ViewDetails">${technicalDetail_link}</a>
     
               <script type="text/javascript">
//<![CDATA[

                   Ext.onReady(function() {
                       Ext.get('uilink_techdetails').on('click', function() {
                           SPopup.Window.forceOpen('techdetails-win', 'technical_details_content', {
                               id: 'techdetails-win',
                               width: 640,
                               height: 320,
                               autoScroll: true,
                               resizable: true,
                               plain: false,
                               cls: 'hp-stacktrace-window',
                               centerOnScreen: true,
                               buttonAlign: 'center',
                               maximizable: true,/* show Maximize button */
                               minimizable: false,
                               buttons: [{
                                   text: '${ok_label}',
                                   handler: function() {
                                       // do your code
                                       SPopup.Window.Instance['techdetails-win'].hide();
                                   }
                               }
                           ]});
                       });
                       
                       moveWindow('technical_details_content','popupWindows');
                   });
               
//]]>
</script>
          
           
               <div id="technical_details_content" class="x-hidden">
                   <div class="x-window-header">${technicalDetail_title}</div>
                   <div class="x-window-body">
                       <div class="UI Offset">
                           ${technicalDetail}
                       </div>
                   </div>
               </div>
           </div>
     </c:if>
    <div class="x-clear"></div>   
</div>
</div>
