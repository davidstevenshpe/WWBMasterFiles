<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.security.securitymessages" var="securitymessages"/>
<fmt:message var="removeAccessWindow_warning" key="removeAccessWindow.warning" bundle="${securitymessages}"/>

<p class="Warning">${removeAccessWindow_warning}</p>

<div class="UI AdvancedOptions Labeled Closed">
    <div class="OptionsOpener">
        <a href="javascript:void(0);" id="${prefix}opener"><span><fmt:message bundle="${messages}" key="general.advancedOptions" /></span></a>
    </div>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}opener','click',function() {
                AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
            });
        });
    
//]]>
</script>
    <div class="Content">
        <syswf:selectOne id="${prefix}includeSubArtifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${optionsHolder}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true"/>
        <label class="UI Label Inline" for="${prefix}includeSubArtifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
    </div>
</div>
 