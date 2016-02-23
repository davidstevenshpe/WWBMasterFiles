<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
 
<%-- ENH add optionClasses attribute to selectOne and selectMany tags --%>
 
 <%-- Publishing generic options --%>
<c:if test="${uiOptions != null && optionsSize > 0}">
    <c:forEach items="${uiOptions}" var="option">
        <tr>
            <c:set var="optionId" value="${prefix}_${option.id}"/>
            <th>
                <label for="${optionId}" title="${option.hint}">${option.caption}:</label>
            </th>
            <td> 
                <c:choose>
                    <c:when test="${option.optionType eq 'RadioOption'}">
                        <syswf:selectOne id="${optionId}" name="${option.id}" value="${option}" property="value" mode="radio"
                                         optionValues="${option.itemsKeys}" optionCaptions="${option.itemsCaptions}" hint="${option.hint}"
                                         optionHints="${option.itemsHints}" displayAsRow="true"/>
                    </c:when>
                    <%-- option type is here overriden by UI, because publishing options don't distinguish between single and multiple checkbox the way UI does --%>
                    <c:when test="${option.optionType eq 'CheckBoxSingle'}">
                        <syswf:selectOne id="${optionId}" name="${option.id}" value="${option}" property="value" mode="checkbox"
                                         optionValues="true" optionCaptions=" " dataType="boolean" hint="${option.hint}" >
                        </syswf:selectOne>
                    </c:when>
                    <c:when test="${option.optionType eq 'CheckboxOption'}">
                        <syswf:selectMany id="${optionId}" name="${option.id}" hint="${option.hint}" mode="checkbox" property="value" value="${option}"
        				    optionHints="${option.itemsHints}" optionCaptions="${option.itemsCaptions}" optionValues="${option.itemsKeys}" size="1"/>
                    </c:when>
                    <c:when test="${option.optionType eq 'ComboOption'}">
                        <syswf:selectOne id="${optionId}" name="${option.id}" value="${option}" property="value" mode="menu"
                                         optionValues="${option.itemsKeys}" optionCaptions="${option.itemsCaptions}" hint="${option.hint}"
                                         optionHints="${option.itemsHints}"/>
                    </c:when>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</c:if>