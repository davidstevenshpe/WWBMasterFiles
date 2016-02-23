<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:choose>

    <c:when test="${visible}">
        ${content}
    </c:when>
    
    <c:otherwise>
        <div class="Form Collection Item">
            <table class="UI Table Properties">
                <colgroup>
                    <col class="LabelCol" />
                    <col />
                    <col class="RemoveCol"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th>
                            <label class="UI Label" for="${inputId}">${label}</label>
                        </th>
                        <td>
                            ${content}
                        </td>
                        <td>
                        
                            <syswf:component name="/core/impl/widget/search/removeLink" prefix="removeLink${status.index}" wrap="false">
                                <syswf:param name="status" value="${status}" />
                                <syswf:param name="removeFce" value="${removeFce}"/>
                                <syswf:param name="firstRemovable" value="${firstRemovable or (defaultVisible and not visible)}" />
                                <syswf:param name="condition" value="${webCondition}" />
                            </syswf:component>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>
