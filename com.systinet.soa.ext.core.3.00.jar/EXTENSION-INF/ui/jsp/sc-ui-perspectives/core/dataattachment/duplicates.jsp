<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>

<syswf:component name="/core/layout/header" prefix="h">
    <syswf:param name="showBackButton" value="true" />
    <syswf:param name="title">
        <fmt:message bundle="${messages}" key="duplicates.header">
            <fmt:param>${artifact.name}</fmt:param>
        </fmt:message>
    </syswf:param>
</syswf:component>

<table class="UI Layout">
    <tr><td class="UI Middle">
    
    <syswf:block className="UI Block Common">
<syswf:component name="/core/table" prefix="t">
    <syswf:param name="datasource" value="${duplicatesDatasource}" />
    <syswf:param name="customizationId" value="shared.dataattachment.duplicatesTable" />
    <syswf:param name="selectionBag" value="${selectionBag}" />
    <syswf:param name="artifact" value="${artifact}" />
</syswf:component>
    </syswf:block>

    </td>
    <td class="UI Right">
        <syswf:block className="UI Block Common">
            <div class="Title">
                <h3><fmt:message bundle="${messages}" key="duplicates.info.header" /></h3>
            </div>
            <div class="Content">
                <p><fmt:message bundle="${messages}" key="duplicates.info.text" /></p>
            </div>
        </syswf:block>
    </td></tr>
</table>