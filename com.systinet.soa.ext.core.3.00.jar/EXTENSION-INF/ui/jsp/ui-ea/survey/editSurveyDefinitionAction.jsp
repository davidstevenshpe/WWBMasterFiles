<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="surveymessages"/>

<c:if test="${empty styleClass}" >
    <c:set var="styleClass" value="Edit" />
</c:if>

<c:choose>
    <c:when test="${ contextMenu == true}">
        <c:set var="itemClass" value="UI PageAction ${styleClass}" />
    </c:when>
    <c:otherwise>
        <c:set var="itemClass" value="context-button ${styleClass}" />
    </c:otherwise>
</c:choose>

<c:if test="${empty label}" >
    <fmt:message var="label" key="CONTEXT_ACTION_EDIT_LABEL" bundle="${messages}"/>
</c:if>

<c:choose>
    <c:when test="${this.hasRightPermission}">
	    <syswf:control mode="script" targetTask="/artifact/${this.artifact._uuid}" caption="${prefix}_editFunc" hint="&nbsp;">
	        <syswf:attribute name="class"><c:out value="${itemClass}"/></syswf:attribute>
            <syswf:taskParam name="view">admin</syswf:taskParam>
	        <syswf:taskParam name="editationListener" value="${surveyDefinitionEditListener}"/>
	    </syswf:control>
	    <a href="javascript:void(0);" id="${prefix}anchor" class="with-text ${itemClass}">
	        <span>${label}</span>
	    </a>
	    <script type="text/javascript">
	        //<![CDATA[
	           Ext.onReady(function() {
	               attachOn('${prefix}anchor','click', ${prefix}_editFunc);
	           });
	        //]]>
	    </script>
    </c:when>
    <c:otherwise>
        <fmt:message var="hasNotRightPermissionLabel" key="survey.action.editSurvey.hasNotRightPermission.label" bundle="${surveymessages}"/>
        <a href="javascript:void(0);" id="${prefix}anchor" class="with-text ${itemClass}" style="opacity: 0.6" title="${hasNotRightPermissionLabel}">
            <span>${label}</span>
        </a>
    </c:otherwise>
</c:choose>