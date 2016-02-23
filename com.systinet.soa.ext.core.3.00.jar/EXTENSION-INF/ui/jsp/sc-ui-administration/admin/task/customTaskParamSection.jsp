<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${renderParamSection}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
    
    <div class="Title">
        <h3><span><fmt:message key="customTask.taskParameters" bundle="${messages}" /></span></h3>
    </div>
    <div style="font-style:italic;margin:8px">
        <fmt:message key="newTaskArtifact_addArtifactCustom_description2" bundle="${messages}"/>
    </div>

    <table class="UI Table Properties">
        <colgroup>
            <col class="LabelCol"/>
            <col/>
            <col style="width:30px;" />
        </colgroup>
        <c:forEach var="parameterBean" varStatus="status" items="${customTaskParameterBeans}" >
        <tr>
            <td>
                <label class="UI Label Inline" for="">
                    ${parameterBean.label}:
                </label>
            </td>
            <td>
                 <syswf:component name="${parameterBean.display.component}" prefix="${reloadCount}a${status.index}">
                    <syswf:param name="model" value="${parameterBean.widgetModel}"/>
                    <syswf:param name="error" value="${parameterBean.widgetModel.errorMessage}"/>
                    <syswf:param name="mode" value="edit"/>
                    <syswf:paramSet value="${parameterBean.display.paramsMap}"/>
                </syswf:component>
                <c:if test="${not empty parameterBean.widgetModel.errorMessage}">
                    <em class="x-form-invalid-msg UI Invalid">
                        <span>${parameterBean.widgetModel.errorMessage}</span>
                    </em>
                </c:if> 
            </td>
        </tr>
        </c:forEach>
    </table>

</c:if>