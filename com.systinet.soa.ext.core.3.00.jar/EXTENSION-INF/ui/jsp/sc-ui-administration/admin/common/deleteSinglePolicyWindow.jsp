<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="messages" />

<c:choose>
    <c:when test="${empty artifactName}">
        <fmt:message bundle="${messages}" key="delete.message" var="mess" />
    </c:when>
    <c:otherwise>
        <fmt:message bundle="${messages}" key="delete.deleteArtifact" var="mess">
            <fmt:param><c:out value="${artifactName}" /></fmt:param>
        </fmt:message>
    </c:otherwise>
</c:choose>

<p class="Warning">${mess}</p>

<c:if test="${not empty referencingArtifacts}">
<div class="Message Info" id="${prefix}warn">
    <div class="MessageContainer">
        <div class="Icon"><span>&nbsp;</span></div>
        <div class="Content">
            <fmt:message bundle="${messages}" key="delete.referencingArtifacts" />
            <ul>
            <c:forEach items="${referencingArtifacts}" var="artifact" varStatus="status" end="2">
            	<li>
            		<c:choose>
		            	<c:when test="${artifact._artifactSdmName eq 'formValidation'}">
		      				<c:out value="${artifact.name}"/> (<fmt:message key="delete.artifactValidationLink" bundle="${messages}"/>)
		      			</c:when>
		      			<c:when test="${artifact._artifactSdmName eq 'lifeCycle'}">
		      				<syswf:component prefix="processLink_${status.index}" name="/newUi/lc/common/renderer/processLinkRenderer" wrap="false">
		      					<syswf:param name="caption" value="${artifact.name}"/>
		      					<syswf:param name="processUuid" value="${artifact._uuid}"/>
		      				</syswf:component>
		      			</c:when>
						<c:otherwise>					
		                    <syswf:component prefix="al${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
		                        <syswf:param name="uuid" value="${artifact._uuid}"/>
		                        <syswf:param name="caption" value="${artifact.name}"/>
		                        <syswf:param name="sdmName" value="${artifact._artifactSdmName}" />
		                    </syswf:component>		                
						</c:otherwise>
					</c:choose>
				</li>                
            </c:forEach>
            <c:if test="${fn:length(referencingArtifacts) > 3}">
                <li><a href="javascript:void(0)" id="${prefix}more">more ...</a></li>
            </c:if>
            </ul>
            <c:if test="${fn:length(referencingArtifacts) > 3}">
                <syswf:component name="/core/window" prefix="ral">
                    <syswf:param name="winComponent" value="/core/impl/bulk/referencingArtifactsList" />
                    <syswf:param name="winTitle" value="Referencing Artifacts" />
                    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
                    <syswf:param name="winCustomButtons">[]</syswf:param>
                    <syswf:param name="winWidth" value="300" />

                    <syswf:param name="referencingArtifacts" value="${referencingArtifacts}" />
                </syswf:component>
                <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function(){
                    attachOn('${prefix}more','click',${prefix}open);
                });
                
//]]>
</script>
            </c:if>
        </div>
    </div>
</div>
</c:if>

<c:if test="${empty disableAdvancedOptions}">
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
        <syswf:selectOne id="${prefix}includeSubartifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${settings}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true">
	        <syswf:attribute name="class" value="UI Form Checkbox" />
	    </syswf:selectOne>
        <label class="UI Label Inline" for="${prefix}includeSubartifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts" /></label>
        <br/>
        <c:choose>
            <c:when test="${not empty singleDelete and singleDelete}"><fmt:message bundle="${messages}" key="delete.ignoreSubUsageTip" var="hint" /></c:when>
            <c:otherwise><fmt:message bundle="${messages}" key="delete.ignoreUsageTip" var="hint" /></c:otherwise>
        </c:choose>        
        <syswf:selectOne id="${prefix}ignoreUsage" name="ignoreUsage" selectClass="UI Form Checkbox Inline" value="${settings}" property="ignoreUsage" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true">
            <syswf:attribute name="title" value="${hint}" />
            <syswf:attribute name="class" value="UI Form Checkbox" />	                  
        </syswf:selectOne>
        <label class="UI Label Inline" for="${prefix}ignoreUsage_0" title="${hint}"><fmt:message bundle="${messages}" key="delete.ignoreUsage" /></label>
    </div>
</div>
</c:if>