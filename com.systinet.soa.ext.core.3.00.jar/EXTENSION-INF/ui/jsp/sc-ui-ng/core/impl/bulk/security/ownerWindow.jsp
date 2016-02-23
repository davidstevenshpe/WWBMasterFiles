<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<div>
    <label class="UI Label Inline"><fmt:message bundle="${messages}" key="changeOwner.label" /></label> 
    <span class="Comment">
    <c:choose>
        <c:when test="${empty holder.selectedPrincipal}">
            <fmt:message bundle="${messages}" key="changeOwner.notChanged" />
        </c:when>
        <c:otherwise>
            <syswf:component prefix="owner" name="/core/impl/util/principalLinkRenderer" wrap="false">
                <syswf:param name="principal" value="${holder.selectedPrincipal.id}"/>
                <syswf:param name="showIcon" value="${true}"/>
            </syswf:component>
        </c:otherwise>
    </c:choose>
    </span> 
    <a href="javascript:void(0);" class="UI Icon" id="${prefix}select_owner"><span><fmt:message bundle="${labels}" key="change" /></span></a>

</div>

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
        <syswf:selectOne id="${prefix}includeSubartifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${holder}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}includeSubartifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
    </div>
</div>

<syswf:control mode="script" caption="${prefix}saveState" action="saveState" />

<syswf:component name="/core/principal/selector" prefix="pricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}open" />
    <syswf:param name="windowTitle">
        <fmt:message bundle="${messages}" key="changeOwner.selectUser" />
    </syswf:param>
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="winOnRenderCallback" value="${null}" passNull="true"/>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    attachOn('${prefix}select_owner','click',function() {
        ${prefix}open();
        ${prefix}saveState();
        })
});
<c:if test="${not empty winOnRenderCallback}">
function ${winOnRenderCallback}() {
    ${prefix}open();
}
</c:if>

//]]>
</script>
