<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="hasNoContent" type="java.lang.Boolean"--%>
<%--@elvariable id="message" type="java.lang.String"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>

<c:if test="${hasNoContent && not externalContent}">
    <fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
    <fmt:message var="infoMsg" key="warning" bundle="${tornadoui_Message}"/>

    <fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsmessages"/>
    <fmt:message var="noContentWarning" key="noContentWarning" bundle="${importsmessages}"/>
    <fmt:message var="noContentLink" key="noContentLinkCaption" bundle="${importsmessages}"/>

    <c:set var="controlName" value="${prefix}uploadContent"/>

    <syswf:component prefix="upload" name="/core/dataattachment/uploadDataContent">
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="controlName" value="${controlName}"/>
        <syswf:param name="hasNoContent" value="${hasNoContent}"/>
    </syswf:component>
    <div class="x-window-body">
    <div class="Message Warning">
        <div class="MessageContainer">
            <div class="Icon"><span>&nbsp;</span></div>
            <div class="Content">
                <strong><c:out value="${infoMsg}"/>:</strong>
                <c:out value="${noContentWarning}"/>

                <a href="javascript:void(0);" id="${prefix}Link">${noContentLink}</a>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        Ext.get('${prefix}Link').on('click', function() {
                            ${controlName}();
                        });
                    });
                
//]]>
</script>
            </div>
            <%--div class="x-clear"></div--%>
        </div>
    </div>
    </div>
</c:if>