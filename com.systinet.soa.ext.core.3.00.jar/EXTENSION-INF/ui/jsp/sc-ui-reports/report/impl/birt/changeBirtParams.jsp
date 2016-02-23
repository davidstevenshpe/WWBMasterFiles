<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<fmt:message var="winTitle" key="birt_report.link.change_params.dialog.title" bundle="${report_Message}" />
<a href ="javascript:void(0);" id ="${prefix}_changeBirtParams" ><fmt:message key="birt_report.link.change_params.label" bundle="${report_Message}"/></a>

<syswf:component name="/core/window" prefix="addResourceCredential">
    <syswf:param name="winTitle" value="${winTitle}" />
    <syswf:param name="winComponent" value="/reports/impl/birt/changeBirtParamsWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openBirtParams" />
    <syswf:param name="winWidth" value="300" />
    <syswf:param name="winOkAction" value="${prefix}saveParams" />
    <syswf:param name="winOkLabel" value="Save" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="definitionLabel" value="${definitionLabel}"/>
    <syswf:param name="birtParams" value="${birtParams}"/>
    
</syswf:component>

<syswf:control mode="script" action="saveParams" caption="${prefix}saveParams"/>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
	    attachOn('${prefix}_changeBirtParams','click',function() {
	    	${prefix}openBirtParams();
	    });
	    moveWindow('${prefix}_addResourceCredentialwin','popupWindows');
	});

//]]>
</script>
