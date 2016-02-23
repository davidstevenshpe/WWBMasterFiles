<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.security.securitymessages" var="securitymessages"/>
<fmt:message var="checkAccessContent_user" key="checkAccessContent.user" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_noAccess" key="checkAccessContent.noAccess" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_accessReadWrite" key="checkAccessContent.accessReadWrite" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_accessReadOnly" key="checkAccessContent.accessReadOnly" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_accessWrite" key="checkAccessContent.accessWrite" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_accessGranted" key="checkAccessContent.accessGranted" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_selectUserLink" key="checkAccessContent.selectUserLink" bundle="${securitymessages}"/>
<fmt:message var="checkAccessContent_access" key="checkAccessContent.access" bundle="${securitymessages}"/>


<c:choose>
    <c:when test="${principalSelected}">
        <script type="text/javascript">
//<![CDATA[

            var selectButton = Ext.getCmp('${parentPrefix}_select');
            if (selectButton != null) {
                selectButton.hide();
            }
        
//]]>
</script>
    
        <c:choose>
            <c:when test="${principalAccessBean.readAccess and principalAccessBean.writeAccess}">
                <c:set var="accessType" value="${checkAccessContent_accessReadWrite}"/>
            </c:when>
            <c:when test="${principalAccessBean.readAccess and not principalAccessBean.writeAccess}">
                <c:set var="accessType" value="${checkAccessContent_accessReadOnly}"/>
            </c:when>
            <c:when test="${not principalAccessBean.readAccess and principalAccessBean.writeAccess}">
                <c:set var="accessType" value="${checkAccessContent_accessWrite}"/>
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${not principalAccessBean.readAccess and not principalAccessBean.writeAccess}">
                ${checkAccessContent_user}
                <syswf:component prefix="principal" name="/core/impl/util/principalLinkRenderer" wrap="false">
                    <syswf:param name="principal" value="${principalAccessBean.principal}"/>
                    <syswf:param name="showIcon" value="${false}"/>
                </syswf:component> 
                ${checkAccessContent_noAccess}
            </c:when>
            <c:otherwise>
                <div class="UI Text Description">
                    ${checkAccessContent_user}
                    <syswf:component prefix="principal" name="/core/impl/util/principalLinkRenderer" wrap="false">
                        <syswf:param name="principal" value="${principalAccessBean.principal}"/>
                         <syswf:param name="showIcon" value="${false}"/>
                     </syswf:component> 
                     <fmt:message key="checkAccessContent.hasAccess" bundle="${securitymessages}">
                        <fmt:param value="${accessType}"/>
                    </fmt:message>
                    ${checkAccessContent_access}
                    <%--
                    ${checkAccessContent_accessGranted}
                    <ul>
                        <c:forEach items="${principalAccessBean.principalGroupsAndRoles}" var="principal" varStatus="status">
                            <li>
                                <syswf:component prefix="principal_${status.index}" name="/core/impl/util/principalLinkRenderer">
                                    <syswf:param name="principal" value="${principal}"/>
                                    <syswf:param name="showIcon" value="${true}"/>
                                </syswf:component>
                            </li>
                        </c:forEach>
                        <c:if test="${principalAccessBean.displayMore}">
                            <li>
                                <fmt:message key="checkAccessContent.moreGroupsRoles" bundle="${securitymessages}">
                                    <fmt:param value="${principalAccessBean.totalCount - principalAccessBean.maximalDisplayedCount}"/>
                                </fmt:message>
                            </li>
                        </c:if>
                    </ul>
                    --%>
                </div>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                var selectButton = Ext.getCmp('${parentPrefix}_select');
                if (selectButton != null) { 
                    selectButton.show();
                }
            });
        
//]]>
</script>
        
        <syswf:component name="/core/impl/principal/selectorWindow" prefix="selector">
            <syswf:param name="listener" value="${this}"/>
            <syswf:param name="holder" value="${this}"/>
            <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />
            <syswf:param name="areaToUpdateOnSelect" value="${parentPrefix}_checkAccessContent_w_window"/>
            <syswf:param name="disableRolesTab" value="true"/>            
            <syswf:param name="disableGroupsTab" value="true"/>
            <syswf:param name="selectorWidth" value="400"/>
        </syswf:component>
    </c:otherwise>
</c:choose>