<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages"/>

<fmt:message bundle="${messages}" key="synchronize.message" var="message"/>
<fmt:message bundle="${messages}" key="synchronize.localChangesOptionLabel" var="localChangesOptionLabel"/>
<fmt:message bundle="${messages}" key="synchronize.localChangesKeep" var="localChangesKeep"/>
<fmt:message bundle="${messages}" key="synchronize.localChangesOverwrite" var="localChangesOverwrite"/>
<fmt:message bundle="${messages}" key="synchronize.localChangesOptionHint" var="localChangesOptionHint"/>

<p class="Warning"><c:out value="${message}"/></p>

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
        <h5>${localChangesOptionLabel}<span class="Hint" title="${localChangesOptionHint}"></span></h5>
        <ul class="Choices">
            <li>
                <syswf:selectOne id="${prefix}keepLocalChanges" name="keepLocalChanges" optionClasses="UI Label Inline,UI Label Inline" value="${settings}" property="keepLocalChanges" mode="radio" optionValues="true,false" dataType="boolean" optionCaptions="${localChangesKeep},${localChangesOverwrite}" displayAsRow="true"/>
            </li>
        </ul>                
    </div>
</div>
