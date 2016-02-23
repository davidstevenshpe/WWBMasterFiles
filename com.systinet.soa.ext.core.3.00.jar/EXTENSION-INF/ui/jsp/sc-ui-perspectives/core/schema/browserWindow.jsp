<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>
<fmt:message var="namespaceLabel" key="targetNamespace" bundle="${schemaMessages}"/>
<fmt:message var="linkWsdlBrowserLabel" key="browser.link.wsdl" bundle="${schemaMessages}"/>
<fmt:message var="linkSchemaBrowserLabel" key="browser.link.schema" bundle="${schemaMessages}"/>

<c:if test="${showContent}">

    <c:set var="uuid" value="${artifact._uuid}" />
    <c:set var="revision" value="${artifact._revision}" />
    
    <syswf:control mode="script" caption="${prefix}OpenBrowser" action="openBrowser" affects="." />
    
    <syswf:control mode="script" caption="${prefix}CloseBrowser" action="closeBrowser" affects="." />
    
    <syswf:component name="/core/schema/browserModalWindow" prefix="browserWindow">
        <syswf:param name="winOpenFunctionName" value="${prefix}Open" />
        <syswf:param name="winBackButtonId" value="${prefix}BackButton" />
        <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
        <syswf:param name="loadFunction" value="${prefix}LoadBrowser" />
        <syswf:param name="closeFunction" value="${prefix}CloseBrowser" />
    </syswf:component>
    
    
    
    <script type="text/javascript">
//<![CDATA[

    var ${prefix}GoToBrowser = function(params) {
        //just javascript to open browser window
        ${prefix}Open();
        //ajax (without refresh of some area) which sets flag, that window has been opened
        ${prefix}OpenBrowser();
        //load of centent in window
        ${prefix}LoadBrowser(params);
    };
    
//]]>
</script>
    
    <c:choose>
        <c:when test="${asLink}">
            <c:set var="linkCaption">
                <c:choose><c:when test="${viewType == 'wsdl'}">${linkWsdlBrowserLabel}</c:when>
                          <c:otherwise>${linkSchemaBrowserLabel}</c:otherwise>
                </c:choose>
            </c:set>
            <c:if test="${not common}"><%-- for compatibility with legacy versions --%>
              <c:set var="blockClassName">EA-left-panel</c:set>
              <c:set var="linkClassName">UI PageAction BrowseWSDL</c:set>
              <c:set var="linkText" value="${linkCaption}"/>
            </c:if>
            <c:if test="${common}"><%-- context buttons displayed at top content --%>
              <c:set var="blockClassName">AJAXContainer</c:set>
              <c:set var="linkClassName">context-button BrowseWSDL</c:set>
              <c:set var="linkText" value=""/>
            </c:if>
          <div class="${blockClassName}">
            <a href="javascript:void(0);" class="${linkClassName}" title="${linkCaption}"
                onclick="${prefix}GoToBrowser({elementViewType: '${viewType}', elementUuid: '${uuid}', elementRevision: '${revision}'})" >${linkText}</a>
          </div>
        </c:when>
        <c:otherwise>
    
            <table class="UI Table Properties">
                <col class="LabelCol">
                <col>
                <tbody>
                    <tr>
                        <th>
                            <label class="UI Label Inline"><syswf:out value="${namespaceLabel}" context="HtmlBody"/>:</label>
                        </th>
                        <td>
                            <syswf:out value="${artifact.targetNamespace}" context="HtmlBody"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            
            
            <syswf:component name="/core/schema/browserWindowContent" prefix="Content">
                <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                <syswf:param name="goToFunction" value="${prefix}GoToBrowser" />
                <syswf:param name="loadFunction" value="${prefix}LoadContent" />
            </syswf:component>
            
            
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function(){
                    ${prefix}LoadContent({elementViewType: '${viewType}', elementUuid: '${uuid}', elementRevision: '${revision}', elementLocalName: '${localName}', elementNamespace: '${namespace}'});
                });
            
//]]>
</script>
        </c:otherwise>
    </c:choose>
    
    <c:if test="${browserItem.initialized}" >
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function(){
                ${prefix}Open();
            });
        
//]]>
</script>
    </c:if>
</c:if>   
