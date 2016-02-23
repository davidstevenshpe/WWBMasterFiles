<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />

<p class="Warning"><fmt:message bundle="${messages}" key="delete.${relationOnly?'incoming.':''}message" /></p>

<c:if test="${not relationOnly}">
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
        <ul class="Choices">
            <li>
            <fmt:message bundle="${messages}" key="removeRelation.selection" var="radioCaptions" />
            <syswf:selectOne id="${prefix}mode" name="deleteMode" value="${settings}" property="deleteMode" mode="radio" optionValues="false,true" dataType="boolean" optionCaptions=" ${radioCaptions}" >
            	 <syswf:attribute name="class" value="UI Form Checkbox" />
            </syswf:selectOne>
            <ul class="Choices" id="${prefix}choices">
                <li>
                    <syswf:selectOne id="${prefix}includeSubartifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${settings}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" >
                    	<syswf:attribute name="class" value="UI Form Checkbox" />
                    </syswf:selectOne>
                    <label class="UI Label Inline" for="${prefix}includeSubartifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
                </li><li>
                    <fmt:message bundle="${messages}" key="delete.ignoreUsageTip" var="hint" />
                    <syswf:selectOne id="${prefix}ignoreUsage" name="ignoreUsage" selectClass="UI Form Checkbox Inline" value="${settings}" property="ignoreUsage" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true">
                        <syswf:attribute name="class" value="UI Form Checkbox" />
                        <syswf:attribute name="title" value="${hint}" />
                    </syswf:selectOne>
                    <label class="UI Label Inline" for="${prefix}ignoreUsage_0" title="${hint}"><fmt:message bundle="${messages}" key="delete.ignoreUsage" /></label>
                </li>
            </ul>
            </li>
        </ul>
        <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('${prefix}choices').enableDisplayMode();
            attachOn('${prefix}mode_0','click',function() {
                Ext.get('${prefix}choices').hide();
            });
            attachOn('${prefix}mode_1','click',function() {
                Ext.get('${prefix}choices').show();
            });
        });
        
//]]>
</script>
    </div>
</div>
</c:if>