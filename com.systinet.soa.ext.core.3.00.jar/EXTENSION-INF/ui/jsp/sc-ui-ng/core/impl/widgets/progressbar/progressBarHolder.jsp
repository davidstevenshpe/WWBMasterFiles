<%--
INPUT PARAMS

message - message displayed next to the progress bar (usually "Progress")
statusGetter - class implementing ProgressBarStatus interface
isRunning - state object ProgressBarReloader.Running, when set, PB will reload page after it's finished
redirectOnFinish - will reload a page and set global action to "progressBarFinished"
dontUpdateOnRefresh - when set (with any value), progress bar will not be updated just before refresh
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message var="workingCaption" key="progressBarHolder.working" bundle="${widgetMessages}" />

<c:set var="pbId">${prefix}progressBar</c:set>

<c:set var="pbIdRenderDiv">${pbId}RenderDiv</c:set>

<div id="${pbIdRenderDiv}" class="UI ProgressBar"></div>

<script type="text/javascript">
//<![CDATA[

    var ${pbId};

    Ext.onReady(function() {
        ${pbId} = new Ext.HP.Progress({
            text : '',
            renderTo : '${pbIdRenderDiv}',
            fieldLabel : '${message}'
        });

        ${pbId}.updateProgress(1.0,' ');
    });

//]]>
</script>

<div class="x-hidden">
    <syswf:component name="/core/impl/widgets/progressBarReloader" prefix="progressBar">
        <syswf:param name="statusGetter" value="${statusGetter}" />
        <syswf:param name="progressBarId" value="${pbId}"/>
    </syswf:component>
</div>