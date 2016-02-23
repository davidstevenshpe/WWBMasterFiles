<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<fmt:message bundle="${labels}" var="environmentLabel" key="endpoints.environment" />
<fmt:message bundle="${labels}" var="addLabel" key="endpoints.add" />
<fmt:message bundle="${labels}" var="createLabel" key="endpoints.create" />
<fmt:message bundle="${labels}" var="unspecifiedLabel" key="endpoints.unspecified" />

<c:forEach var="group" items="${groups}" varStatus="status">



    <syswf:block className="UI Block Common">
        <table class="UI Table Properties">
            <col class="LabelCol">
            <col>
            <tbody>
                <tr>
                    <th>
                        <label class="UI Label Inline">${environmentLabel}</label>
                    </th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty group.environment}">
                                <syswf:out value="${group.environment}" context="HtmlBody"/>    
                            </c:when>
                            <c:otherwise>
                               <i><syswf:out value="${unspecifiedLabel}" context="HtmlBody"/></i>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty group.link}">
                            (<a href="${group.link}"><fmt:message bundle="${labels}" key="endpoints.downloadWsdl" /></a>)
                        </c:if>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="webfw-Window" id="${prefix}-webfw-Window">
        <syswf:component name="/core/relations/genericRelationshipComponent" prefix="t${status.index}">
            <syswf:param name="tableDefinitionId" value="${tableDefinitionId}"/>
            <syswf:param name="relation" value="${relation}"/>
            <syswf:param name="artifact" value="${artifact}"/>
            <syswf:param name="datasource" value="${group.dataSource}"/>
            <syswf:param name="dataSourceBinding" value="${group.dataSource}"/>
        </syswf:component>
        </div>
    </syswf:block>
</c:forEach>

<c:if test="${hasWritePermission}" >

    <a id="${prefix}AddLink" href="javascript:void(0);" class="UI Icon Add"><c:out value="${addLabel}" /></a>

    <syswf:control id="add" mode="anchor" caption="${createLabel}" hint="" targetTask="/${viewId}/newArtifact">
        <syswf:attribute name="class" value="UI Icon New"/>
        <syswf:param name="sdmName" value="endpointArtifact"/>
        <syswf:param name="creationListener" value="${creationListener}"/>
    </syswf:control>
    
    <syswf:component name="/core/relations/addRelation" prefix="AddComp">
        <syswf:param name="relation" value="endpoint"/>
        <syswf:param name="addMode" value="search"/>
        <syswf:param name="controlName" value="${prefix}Add"/>
        <syswf:param name="controlAction" value="addRelation"/>
    </syswf:component>
        
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('${prefix}AddLink').on('click', function() {
                ${prefix}Add();
            });
        });
    
//]]>
</script>
</c:if>



