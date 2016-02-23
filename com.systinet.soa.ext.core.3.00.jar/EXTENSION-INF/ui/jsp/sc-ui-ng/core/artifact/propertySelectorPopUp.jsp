<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
input parameters:
   * see /core/artifact/propertySelector
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<a href="javascript:void(0);" id="openPopUp" class="UI Icon Add"><span><fmt:message key="propertySelector.popup.addProperty" bundle="${bundle}"/></span></a>
<script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            attachOn('openPopUp','click',function() {
                ${prefix}openPropertySelector();
            });
        });

//]]>
</script>

<syswf:component name="/core/window" prefix="browsePopup">
    <syswf:param name="winTitle"><fmt:message key="propertySelector.popup.addProperty" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winComponent" value="/core/artifact/propertySelector"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openPropertySelector"/>    
    <syswf:param name="winOkLabel"><fmt:message key="ok" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winOkAction" value="functionAdd"/>
    <syswf:param name="winCancelLabel"><fmt:message key="cancel" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winButtonAlign" value="right"/>

    <syswf:param name="winRenderContents" value="true"/>
    <%--
    <syswf:param name="winRenderAlways" value="true"/>
    --%>
    <syswf:param name="winResizable" value="false"/>

    <syswf:param name="winWidth" value="300"/>
    <syswf:param name="winHeight" value="340"/>
    
    <syswf:param name="sdmName" value="${sdmName}"/>
    <syswf:param name="sdmNameList" value="${sdmNameList}"/>
    <syswf:param name="propertyListSelectionListener" value="${propertyListSelectionListener}"/>
    <syswf:param name="sections" value="${sections}"/>
    <syswf:param name="showRelated" value="${showRelated}"/>
    <syswf:param name="showAddToSection" value="${showAddToSection}"/>
    <syswf:param name="showAddToSection" value="${showAddToSection}"/>
    <syswf:param name="forTable" value="${forTable}"/>
    <syswf:param name="usedProperties" value="${usedProperties}"/>
</syswf:component>