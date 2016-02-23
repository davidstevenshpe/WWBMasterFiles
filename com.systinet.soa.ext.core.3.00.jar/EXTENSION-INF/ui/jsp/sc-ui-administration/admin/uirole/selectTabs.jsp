<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />
<fmt:message var="requiredTitle" key="required.title" bundle="${roleMsg}" />
<fmt:message var="requiredCaption" key="required" bundle="${roleMsg}" />

<table class="UI Table Properties" width="100%">
	<col class="LabelCol" />
    <col/>
    <c:if test="${not empty tabList}">
        <tr>
            <th><label class="UI Label Required Full"><fmt:message key="uirole.uiAccessGranted" bundle="${roleMsg}" />:</label><sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></th>
            <td>
                <c:forEach  var="tab" items="${tabList}">
                    <syswf:selectOne id="${tab.viewId}" name="${tab.viewId}"
                        value="${tab}" property="granted" mode="checkbox" optionValues="true"
                        optionCaptions="${tab.uiName}" dataType="boolean">
						<syswf:attribute name="class" value="UI Form Checkbox" />
					</syswf:selectOne>
                    <c:out value="${tab.uiName}"></c:out>
                    <br/>
                </c:forEach>
            </td>
        </tr>
    </c:if>
</table>
