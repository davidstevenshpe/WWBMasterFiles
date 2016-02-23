<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>
<c:choose>
    <c:when test="${not empty results}">
        <table style="width:100%">
            <col width="20px" class="x-grid3-td-expander"/>
            <col/>
            <tbody>
            <tr>
                <td rowspan="2"><a href="javascript:void(0)" onclick="togglePolicyComplianceRow(this)" class="x-grid3-row-expander" style="width:18px;display:block">&nbsp;</a></td>
                <td><syswf:control targetTask="/artifact/${uuid}" caption="${name}" mode="anchor"/></td>
            </tr>
            <tr>
                <td>
                    <div id="rs-${uuid}" class="x-grid3-row-body">
                        <c:forEach items="${results}" var="result">
                            <c:set var="curTpName" value=""/>
                            <c:forEach items="${result.errorAssertions}" var="item"  varStatus="status">
                                <c:if test="${curTpName != item.tpName}">
                                    <c:if test="${curTpName != ''}">
                                        <c:out value="</div>"  escapeXml="false"/>
                                    </c:if>
                                    <c:out value="<div class='Children' name='tp_${uuid}_${item.tpId}'>" escapeXml="false"/>
                                    <div style="background-color:#efefef;">
                                        <syswf:control targetTask="/artifact/${item.tpUuid}" caption="${item.tpName}" mode="anchor"/>
                                    </div>
                                </c:if>
                                <div class="Child Error">
                                    <div class="ChildLabel">
                                        <syswf:control targetTask="/artifact/${item.assertionDefUuid}" caption="${item.name}" mode="anchor"/>
                                    </div>
                                    <div class="ChildBody" style="">
                                        <fmt:message key="policyreport.error.missing.message" bundle="${messages}" var="missingMsg"/>
											<span class="Comment">
                                                <c:choose>
                                                    <c:when test="${not empty item.errorHint}">
                                                        <c:forEach items="${item.processedErrorHint}" var="j"><c:choose>
                                                            <c:when test="${j.class.name eq 'java.lang.String'}"><c:out value="${j}" escapeXml="true"/></c:when>
                                                            <c:otherwise><syswf:control targetTask="/artifact/${j.uuid}" caption="${j.name}" mode="anchor"/></c:otherwise>
                                                        </c:choose></c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${ missingMsg }"/>
                                                    </c:otherwise>
                                                </c:choose>
				                        	</span>
                                    </div>
                                </div>
                                <c:set var="curTpName" value="${item.tpName}"/>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <div style="padding-left:20px">
            <syswf:control targetTask="/artifact/${uuid}" caption="${name}" mode="anchor"/>
        </div>
    </c:otherwise>
</c:choose>