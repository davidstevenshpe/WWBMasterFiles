<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>

<fmt:message bundle="${msg}" var="usesLabel" key="ContractStructure_usesLabel"/>
<fmt:message bundle="${msg}" var="consumerProvidedBy" key="ContractStructure_consumerProvidedBy"/>
<fmt:message bundle="${msg}" var="consumerVersion" key="ContractStructure_consumerVersion"/>
<fmt:message bundle="${msg}" var="providerProvidedBy" key="ContractStructure_providerProvidedBy"/>
<fmt:message bundle="${msg}" var="providerVersion" key="ContractStructure_providerVersion"/>
<fmt:message bundle="${msg}" var="purged" key="ContractStructure_purged"/>
<fmt:message bundle="${msg}" var="purgedSLO" key="ContractStructure_purged_slo"/>

<syswf:block className="UI Block Plain">
    <div class="hp-cm-diagram">

        <div class="hp-cm-diagram-item">
            <div class="hp-corner-box hp-cm-consumer"><div><div><div><div>
                <c:choose>
                    <c:when test="${not empty structure.consumer}">
                        <c:choose>
                            <c:when test="${structure.consumerVisible}">
                                <syswf:component prefix="consumer" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                    <syswf:param name="class" value="hp-cm-title"/>
                                    <syswf:param name="caption" value="${structure.consumer.name}"/>
                                    <syswf:param name="uuid" value="${structure.consumer._uuid}"/>
                                    <syswf:param name="sdmName" value="${structure.consumer._artifactSdmName}"/>
                                    <syswf:param name="showIcon" value="${true}"/>
                                </syswf:component>
                            </c:when>
                            <c:otherwise>
                                <fmt:message bundle="${msg}" key="CreateStructure_consumerInOwner">
                                    <fmt:param><syswf:out value="${structure.consumer.name}" context="HtmlBody"/></fmt:param>
                                    <fmt:param>
                                        <syswf:component prefix="consumer" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                            <syswf:param name="class" value="hp-cm-title"/>
                                            <syswf:param name="caption" value="${structure.consumerOwner.name}"/>
                                            <syswf:param name="uuid" value="${structure.consumerOwner._uuid}"/>
                                            <syswf:param name="sdmName" value="${structure.consumerOwner._artifactSdmName}"/>
                                            <syswf:param name="showIcon" value="${true}"/>
                                        </syswf:component>
                                    </fmt:param>
                                </fmt:message>
                            </c:otherwise>
                        </c:choose>

                       	<c:if test="${not empty structure.consumerVersion}">
                       		<span class="hp-cm-provided-by">
                       			<syswf:out value="${consumerVersion}" context="HtmlBody"/>
                       			<syswf:out value="${structure.consumerVersion}" context="HtmlBody"/>
                       		</span>
                       	</c:if>
                        <c:if test="${not empty structure.consumerProvidedBy}">
                            <span class="hp-cm-provided-by">
                                <syswf:out value="${consumerProvidedBy}" context="HtmlBody"/>
                                <syswf:component prefix="cProvided" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                    <syswf:param name="caption" value="${structure.consumerProvidedBy.name}"/>
                                    <syswf:param name="uuid" value="${structure.consumerProvidedBy._uuid}"/>
                                    <syswf:param name="sdmName" value="${structure.consumerProvidedBy._artifactSdmName}"/>
                                </syswf:component>
                            </span>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <span><i><syswf:out value="${purged}" context="HtmlBody"/></i></span>
                    </c:otherwise>
                </c:choose>
                </div></div></div></div>
            </div>
        </div>

        <div class="hp-cm-diagram-item">
            <div class="hp-cm-uses">
                <span><syswf:out value="${usesLabel}" context="HtmlBody"/></span>
            </div>
        </div>

        <div class="hp-cm-diagram-item">
            <div class="hp-corner-box hp-cm-contractor"><div><div><div><div>
                <c:choose>
                    <c:when test="${not empty structure.provider}">
                        <c:choose>
                            <c:when test="${structure.providerVisible}">
                                <syswf:component prefix="provider" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                    <syswf:param name="class" value="hp-cm-title"/>
                                    <syswf:param name="caption" value="${structure.provider.name}"/>
                                    <syswf:param name="uuid" value="${structure.provider._uuid}"/>
                                    <syswf:param name="sdmName" value="${structure.provider._artifactSdmName}"/>
                                    <syswf:param name="showIcon" value="${true}"/>
                                </syswf:component>
                            </c:when>
                            <c:otherwise>
                                <fmt:message bundle="${msg}" key="CreateStructure_providerInOwner">
                                    <fmt:param><syswf:out value="${structure.provider.name}" context="HtmlBody"/></fmt:param>
                                    <fmt:param>
                                        <syswf:component prefix="providerOwner" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                            <syswf:param name="class" value="hp-cm-title"/>
                                            <syswf:param name="caption" value="${structure.providerOwner.name}"/>
                                            <syswf:param name="uuid" value="${structure.providerOwner._uuid}"/>
                                            <syswf:param name="sdmName" value="${structure.providerOwner._artifactSdmName}"/>
                                            <syswf:param name="showIcon" value="${true}"/>
                                        </syswf:component>
                                    </fmt:param>
                                </fmt:message>
                            </c:otherwise>
                        </c:choose>

                       	<c:if test="${not empty structure.providerVersion}">
                       		<span class="hp-cm-provided-by">
                       			<syswf:out value="${providerVersion}" context="HtmlBody"/>
                       			<syswf:out value="${structure.providerVersion}" context="HtmlBody"/>
                       		</span>
                       	</c:if>
                        <c:if test="${not empty structure.providerProvidedBy}">
                            <span class="hp-cm-provided-by">
                                <syswf:out value="${providerProvidedBy}" context="HtmlBody"/>
                                <syswf:component prefix="pProvided" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                    <syswf:param name="caption" value="${structure.providerProvidedBy.name}"/>
                                    <syswf:param name="uuid" value="${structure.providerProvidedBy._uuid}"/>
                                    <syswf:param name="sdmName" value="${structure.providerProvidedBy._artifactSdmName}"/>
                                </syswf:component>
                            </span>
                        </c:if>
                        
                        <c:if test="${structure.sloAvailable}">
                        	<c:choose>
	                        	<c:when test="${not empty structure.selectedSlo}">
	                        		<syswf:component prefix="slo" name="/core/impl/util/artifactLinkRenderer" wrap="false">
		                                <syswf:param name="class" value="hp-cm-title"/>
		                                <syswf:param name="caption" value="${structure.selectedSlo.name}"/>
		                                <syswf:param name="uuid" value="${structure.selectedSlo._uuid}"/>
		                                <syswf:param name="sdmName" value="${structure.selectedSlo._artifactSdmName}"/>
		                                <syswf:param name="showIcon" value="${true}"/>
		                            </syswf:component>	
	                        	</c:when>
	                        	<c:otherwise>
	                        		<span><i><syswf:out value="${purgedSLO}" context="HtmlBody"/></i></span>
	                        	</c:otherwise>
	                        </c:choose>	
                        </c:if>                                               
                    </c:when>
                    <c:otherwise>
                        <span><i><syswf:out value="${purged}" context="HtmlBody"/></i></span>
                    </c:otherwise>
                </c:choose>
                </div></div></div></div>
            </div>
        </div>
        <div class="x-clear"></div>
    </div>
</syswf:block>
