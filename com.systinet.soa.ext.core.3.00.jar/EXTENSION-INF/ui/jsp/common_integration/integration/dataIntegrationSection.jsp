<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="bundle"/>
<fmt:message key="dataIntegration.showAll" var="showAll" bundle="${bundle}"/>
<fmt:message key="dataIntegration.showOnlineOnly" var="showOnlineOnly" bundle="${bundle}"/>

<c:if test="${hasPriviledge and not empty dataIntegrations}">
    <syswf:block className="EA-right-panel">
        <div class="Title">
            <h3><fmt:message key="dataIntegration.synchronization.title" bundle="${bundle}"/></h3>
        </div>
                    
        <div class="Content">
            <c:forEach items="${dataIntegrations}" var="dataIntegration" varStatus="status">
                <syswf:component name="${dataIntegration.uiRendererComponent}" prefix="dataIntegration_${status.index}" >
                    <syswf:param name="dataIntegration" value="${dataIntegration}" />
                    <syswf:param name="statusChangeJsListener" value="${prefix}statusListener" />
                </syswf:component>
                <br />
                <c:if test="${dataIntegration.offline}">
                    <c:set var="someOffline" value="true" />
                </c:if>
            </c:forEach>
        </div>
        
        <div id="${prefix}Footer" class="Footer">
            <c:choose>            
                <c:when test="${showOfflineIntegrations}">
                    <syswf:control mode="anchor" action="showOnlineOnly" caption="${showOnlineOnly}" affects="." >
                        <syswf:attribute name="id" value="${prefix}showOnlineOnly" />
                    </syswf:control>
                </c:when>
                <c:otherwise>
                    <syswf:control mode="anchor" action="showAll" caption="${showAll}" affects="." >
                        <syswf:attribute name="id" value="${prefix}showAll" />
                        <syswf:attribute name="style" value="display: none;" />                        
                    </syswf:control>
                </c:otherwise>
            </c:choose>
            </div>
    </syswf:block>
    
    <script type="text/javascript">
        //<![CDATA[

        function ${prefix}statusListener(offline, prefix){
            if (offline && ${!showOfflineIntegrations}){
                Ext.get(prefix).dom.style.display="none";
            }else{
                Ext.get(prefix).dom.style.display="block";
            }
            var el = Ext.select("div.Content > div[id^=${prefix}_dataIntegration]{display=none}");
            
            var showAll = Ext.get('${prefix}showAll');            
            var footer = Ext.get('${prefix}Footer');
            
            if (el.getCount() == 0){
                if (showAll){
                	footer.dom.style.display="none";
                	showAll.dom.style.display="none";
                }
            }else{
                if (showAll){
                	footer.dom.style.display="block";
                    showAll.dom.style.display="block";                    
                }                                                                            
            }
        }
        //]]>
    </script>    
</c:if>