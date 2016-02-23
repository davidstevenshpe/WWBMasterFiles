<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<table class="hp-version-flow">
    <tbody>
        <c:forEach items="${versioningViewItems}" var="row" varStatus="rowStatus">
        <tr>
            <c:forEach items="${versioningViewItems[rowStatus.index]}" var="cell" varStatus="status">
            <c:set var="item" value="${versioningViewItems[rowStatus.index][status.index]}" />
                <c:choose>
                    <c:when test="${empty item}"><td>&nbsp;</td></c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${item.type eq 'VERSION'}">
                                <td>
                                    <div class="hp-version-flow-item<c:if test="${version eq item.version}"> active</c:if>"><span><span><span><span>
                                    <syswf:selectOne mode="checkbox" name="versionToCompare" optionValues="${item.artifactBase._uuid}" value="" optionCaptions="" />
                                    <syswf:control mode="anchor" targetTask="/artifact/${item.artifactBase._uuid}" caption="${item.version}" id="link${rowStatus.index}${status.index}" /></span></span></span></span></div>
                                </td>
                            </c:when>
                            <c:when test="${item.type eq 'ICON'}">
                                <c:choose>
                                    <c:when test="${item.iconType eq 'ICON_PARENT_CHILD'}">
                                        <td>
                                            <div class="hp-version-flow-tree parentchild">&nbsp;</div>
                                        </td>
                                    </c:when>
                                    <c:when test="${item.iconType eq 'ICON_PARENT_CHILD_ASCENDANT'}">
                                        <td>
                                            <div class="hp-version-flow-tree parentchildascendant">&nbsp;</div>
                                        </td>
                                    </c:when>
                                    <c:when test="${item.iconType eq 'ICON_PARENT_CHILD_LINE_MIDDLE'}">
                                        <td>
                                            <div class="hp-version-flow-tree parentchildoffspringsibling">&nbsp;</div>
                                        </td>
                                    </c:when>
                                    <c:when test="${item.iconType eq 'ICON_PARENT_CHILD_LINE_TRUNK'}">
                                        <td>
                                            <div class="hp-version-flow-tree connector">&nbsp;</div>
                                        </td>
                                    </c:when>
                                    <c:when test="${item.iconType eq 'ICON_PARENT_CHILD_OFFSPRING'}">
                                        <td>
                                            <div class="hp-version-flow-tree parentchildoffspring">&nbsp;</div>
                                        </td>
                                    </c:when>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </c:otherwise>
                 </c:choose>
            </c:forEach>
          </tr>
        </c:forEach>
    </tbody>
</table>
            
<syswf:control mode="script" action="compare" caption="${buttonFunc}" targetDepth="${sessionStack.currentDepth}" />