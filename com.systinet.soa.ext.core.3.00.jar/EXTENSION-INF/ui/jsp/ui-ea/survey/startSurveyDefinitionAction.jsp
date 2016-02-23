<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<fmt:message var="label" key="survey.action.startSurvey.label" bundle="${messages}"/>

<syswf:control mode="script" targetTask="/survey/startSurvey" caption="${prefix}_startSurveyFn" hint="&nbsp;">
    <syswf:attribute name="class"><c:out value="${itemClass}"/></syswf:attribute>
    <syswf:taskParam name="surveyDefUuid">${this.artifact._uuid}</syswf:taskParam>
</syswf:control>

<c:choose>
    <c:when test="${not this.hasRightPermission}">
        <fmt:message var="hasNotRightPermissionLabel" key="survey.action.startSurvey.hasNotRightPermission.label" bundle="${messages}"/>
        <a id="${prefix}_startSurveyDef" href="javascript:void(0);" class="with-text context-button StartSurvey" title="${hasNotRightPermissionLabel}">
		    <span>${label}</span>
		</a>
        <script type="text/javascript">
			//<![CDATA[
			    Ext.onReady(function() {
			        $('a.with-text.context-button.StartSurvey').css('opacity', '0.6');
			    });
			//]]>
	    </script>
    </c:when>
    <c:otherwise>
        <a id="${prefix}_startSurveyDef" href="javascript:void(0);" class="with-text context-button StartSurvey">
		    <span>${label}</span>
		</a>
		<script type="text/javascript">
			//<![CDATA[
			    Ext.onReady(function() {
			        attachOn('${prefix}_startSurveyDef', 'click', ${prefix}_startSurveyFn);
			    });
			//]]>
		</script>   
    </c:otherwise>
</c:choose>