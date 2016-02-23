<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="matchingStatus" type="int"--%>
<%--@elvariable id="uuid" type="java.lang.String"--%>
<%--@elvariable id="mergeDuplicatesBean" type="com.hp.systinet.integration.ucmdbImport.MergeDuplicates.MergeDuplicatesBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="integrationMessages"/>

<c:if test="${matchingStatus == 2}">

    <syswf:control mode="script" caption="${prefix}mergeDuplicatesAction" action="mergeDuplicatesAction"/>

    <fmt:message var="mergeDuplicatesString" key="ucmdbImport_table_link_mergeDuplicates"
                 bundle="${integrationMessages}"/>
    <c:choose>
        <%--when matching artifacts are no longer present--%>
        <c:when test="${empty mergeDuplicatesBean.matchingArtifacts}">
            <c:set var="mergeDuplicatesButtons">
                [{
                text : '<fmt:message key="mergeDuplicates.conflictsAlreadyRemoved.okButton.label"
                                     bundle="${integrationMessages}"/>',
                handler : function() {
                SPopup.Window.Instance['${prefix}_conflictsAlreadyRemovedDialog_window'].hide();
                },
                id: 'mergeDuplicates_okButton'
                }]
            </c:set>

            <syswf:component name="/core/impl/util/dialog" prefix="conflictsAlreadyRemovedDialog">
                <syswf:param name="handler" value="dummy"/>
                <syswf:param name="heading">${mergeDuplicatesString}</syswf:param>
                <syswf:param name="content"><fmt:message key="mergeDuplicates.conflictsAlreadyRemoved.message"
                                                         bundle="${integrationMessages}"/></syswf:param>
                <syswf:param name="controlName" value="${prefix}conflictsAlreadyRemovedDialogControl"/>
                <syswf:param name="customButtons" value="${mergeDuplicatesButtons}"/>
            </syswf:component>

            <a id="${prefix}_MergeDuplicates_handler" href="javascript:void(0);">
                <span>${mergeDuplicatesString}</span>
            </a>

            <script type="text/javascript">
                //<![CDATA[

                Ext.onReady(function() {
                    attachOn('${prefix}_MergeDuplicates_handler', 'click', ${prefix}conflictsAlreadyRemovedDialogControl);
                });
                //]]>
            </script>
        </c:when>
        <%--display popup with selection of matching duplicates--%>
        <c:otherwise>
            <syswf:component name="/core/window" prefix="mergeDuplicatesPopup">
                <syswf:param name="winId" value="${prefix}_MergeDuplicatesPopup_win"/>
                <syswf:param name="winTitle">${mergeDuplicatesString}</syswf:param>
                <syswf:param name="winComponent" value="/integration/ucmdbImport/mergeDuplicatesContent"/>
                <syswf:param name="winOpenFunctionName" value="${prefix}_MergeDuplicates_open"/>
                <syswf:param name="winOkAction" value="${prefix}mergeDuplicatesAction"/>
                <syswf:param name="winRenderContents" value="true"/>
                <syswf:param name="mergeDuplicatesBean" value="${mergeDuplicatesBean}"/>
                <syswf:param name="uuid" value="${uuid}"/>
                <%--<syswf:param name="winHeight" value="300" />--%>
                <%--<syswf:param name="winForceRefresh" value="false" />--%>
            </syswf:component>

            <a id="${prefix}_MergeDuplicates_handler" href="javascript:void(0);">
                <span>${mergeDuplicatesString}</span>
            </a>

            <script type="text/javascript">
                //<![CDATA[
                Ext.onReady(function() {
                    attachOn('${prefix}_MergeDuplicates_handler', 'click', ${prefix}_MergeDuplicates_open);
                });
                //]]>
            </script>
        </c:otherwise>
    </c:choose>

</c:if>