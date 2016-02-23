<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="canDisplayComponent" type="boolean"--%>
<c:if test="${canDisplayComponent}">
    <%--@elvariable id="processBean" type="com.hp.systinet.lifecycle.ui.admin.process.ProcessBean"--%>
    <%--@elvariable id="lfTabId" type="java.lang.String"--%>
    <c:if test="${not empty processBean.process}">
        <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
        <fmt:message var="subtitle" key="processView.subtitle" bundle="${messages}"/>
        <table class="UI Layout">
            <tbody>
            <tr id="pagetitle" class="EA-Blue-Bar">
                <td class="UI Middle">
                    <div class="UI PageIdentity">
                        <h3 class="EA-top-header">
                        	<c:out value="${processBean.process.name}"/>
                      	</h3>

                        <h2 class="UI Icon Customize"><c:out value="${subtitle}"/><c:if
                                test="${not empty processBean.processStatusLabel}">,
                            <c:out value="${processBean.processStatusLabel}"/></c:if></h2>
                            <%-- TODO add correct icon --%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <syswf:component prefix="tabs" name="/core/layout/tabs">
                        <syswf:param name="process" value="${processBean.process}"/>
                        <syswf:param name="customizationId" value="admin.lifecycle.process.processTabs"/>
                        <c:if test="${not empty lfTabId}">
                            <syswf:param name="tabId" value="${lfTabId}"/>
                        </c:if>
                    </syswf:component>
                </td>
            </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty processBean.process}">
        <syswf:component name="/newUi/lc/admin/process/processDeleted" prefix="deleted"/>
    </c:if>
</c:if>