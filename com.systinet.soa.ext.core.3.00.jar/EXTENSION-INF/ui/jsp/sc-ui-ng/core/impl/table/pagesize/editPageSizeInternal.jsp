<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<syswf:block className="UI Block Common">
    <div class="Content">
        <table class="UI Table Properties">
            <col class="LabelCol"/>
            <col>
            <tbody>
                <tr>
                    <th class="UI Label Inline"><fmt:message key="pageSize" bundle="${messages}"/>:</th>
                    <td>
                        <syswf:selectOne name="pageSize" value="${pageSizeInfoInternal}" property="pageSize" mode="menu" dataType="int"
                                         optionValues="${pageSizeValues}" optionCaptions="${pageSizeValues}"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</syswf:block>