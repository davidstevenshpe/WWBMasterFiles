<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.integration.ui.bac.BacIntegrationUiL10n" var="bundle"/>
<fmt:message key="bac.integration.lastUpdate" var="lastUpdate" bundle="${bundle}" />
<fmt:message key="bac.integration.detail" var="detailLink" bundle="${bundle}" />
<fmt:message key="bac.integration.detail.close" var="winClose" bundle="${bundle}" />
<fmt:message key="bac.integration.detail.title" var="dataIntegrationDetailsTitle" bundle="${bundle}" />
<fmt:message key="bac.integration.refresh" var="refreshLink" bundle="${bundle}" />
<fmt:message key="bac.integration.synchronize" var="synchronizeLink" bundle="${bundle}" />
<fmt:message key="bac.integration.synchronize.cancel" var="bacIntegrationCancel" bundle="${bundle}" />

<syswf:control mode="script" action="refreshStatus" formName="ContentForm" caption="reload${prefix}" affects="." />

<span id="${prefix}working" class="UI Icon Working" style="display:none">
  <fmt:message key="bac.integration.checking" bundle="${bundle}"/>
</span>

<c:choose>
    <c:when test="${bacIntegrationSectionBean.statusIcon eq null}">
        <div id="divreload${prefix}">
                <%-- do AJAX call --%>
            <script type="text/javascript">
                //<![CDATA[

                manageInterval('reload${prefix}');

                Ext.onReady(function() {
                    Ext.get('${prefix}working').dom.style.display="block";
                })
                //]]>
            </script>
        </div>
    </c:when>
    <c:otherwise>
        <fmt:formatDate type="both" var="lastSynchronized" value="${bacIntegrationSectionBean.lastSynchronized}" />
        <div id="${prefix}section">
            <h4 class="Subheader">
                <syswf:control mode="anchor" caption="${bacIntegrationSectionBean.serverName}" targetTask="/admin/server/view" >
                    <syswf:param name="serverUUID" value="${bacIntegrationSectionBean.serverUuid}" />
                </syswf:control>            
            </h4>
            <label><fmt:message key="bac.integration.status" bundle="${bundle}" />:</label>
                
            <span class="${bacIntegrationSectionBean.statusIcon}" title="${lastUpdate}: ${lastSynchronized}" >
                <syswf:out value="${bacIntegrationSectionBean.statusText}" context="HtmlBody"/>
            </span>
            <br>

            <c:choose>
                <c:when test="${bacIntegrationSectionBean.offline}">
                    <syswf:control id="bacRefresh" mode="anchor" action="refresh" caption="${refreshLink}" affects="." />
                </c:when>
                <c:otherwise>
                    <syswf:control id="bacSynchronize" mode="script" action="synchronize" caption="${prefix}synchronize" />
                    <a id="${prefix}syncLink" href="javascript:void(0)" class="UI Icon Synchronize">${synchronizeLink}</a>

                    <fmt:message key="bac.integration.synchronize.confirm" var="confirmSync" bundle="${bundle}">
                        <fmt:param><syswf:out value="${artifact.name}" context="HtmlBody"/></fmt:param>
                        <fmt:param><syswf:out value="${bacIntegrationSectionBean.serverName}" context="HtmlBody"/></fmt:param>
                    </fmt:message>

                    <script type="text/javascript">
                        //<![CDATA[
                        var handler = function(){ 
                            Ext.get('${prefix}section').dom.style.display="none";                
                            Ext.get('${prefix}working').dom.style.display="block"; 
                            ${prefix}synchronize();
                        };
                        
                        var element = Ext.get('${prefix}syncLink');
                        element.on('click', function() {
                           ${prefix}_syncDialog_showDialog(element, null,
                                   '${confirmSync}',
                                   null, handler, false);
                        });
                        //]]>
                    </script>
                    
                </c:otherwise> 
             </c:choose>
            &nbsp;| 
            <syswf:control mode="postanchor" onSubmit="${prefix}_openDetail" caption="${detailLink}" >
                <syswf:attribute name="class" value="UI Icon Info"></syswf:attribute>
            </syswf:control>                
        </div>
        
        <script type="text/javascript">
            //<![CDATA[
            Ext.onReady(function() {
                if (${statusChangeJsListener}){
                    ${statusChangeJsListener}(${bacIntegrationSectionBean.offline},'${prefix}');        
                }
            })
            //]]>
        </script>         
        
        <%-- Synchronize confirmation dialog --%>
        <c:set var="syncCustomButtons">
            [{
                text     : '${synchronizeLink}',
                disabled : false,
                handler  : function() {
                    SPopup.Window.Instance['${prefix}syncDialogId'].hide();
                    ${calledHandler}
                },
                id: '${prefix}_okButton'
            },{
                text     : '${bacIntegrationCancel}',
                handler  : function(){
                    SPopup.Window.Instance['${prefix}syncDialogId'].hide();
                    return false;
                },
                id: '${prefix}_cancelButton'
            }]
        </c:set>
       
        <syswf:component prefix="syncDialog" name="/core/impl/util/dialog">
            <syswf:param name="windowId" value="${prefix}syncDialogId" />
            <syswf:param name="handler" value="dummy" />
            <syswf:param name="heading"><fmt:message key="bac.integration.synchronize" bundle="${bundle}"/></syswf:param>
            <syswf:param name="noUndo" value="false" />
            <syswf:param name="customButtons" value="${syncCustomButtons}" />    
        </syswf:component>        
        
        <%-- Detail window --%>
        <c:set var="closeButton">
            [{
                text     : '${winClose}',
                disabled : false,
                handler  : function() {
                    SPopup.Window.Instance['${prefix}detailWindow'].hide();
                },
                id: '${prefix}_closeButton'
            }]
        </c:set>        
        
        <syswf:component name="/core/window" prefix="detailWindow">
            <syswf:param name="winId">${prefix}detailWindow</syswf:param>
            <syswf:param name="winTitle">${dataIntegrationDetailsTitle}</syswf:param>
            <syswf:param name="winComponent" value="/integration/bac/bacIntegrationSectionDetail"/>
            <syswf:param name="winOpenFunctionName" value="${prefix}_openDetail" />
            <syswf:param name="winCustomButtons" value="${closeButton}" /> 
            
            <syswf:param name="bacIntegrationSectionBean" value="${bacIntegrationSectionBean}" />
        </syswf:component>                        
             
    </c:otherwise>
</c:choose> 
