<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ctrl" uri="http://systinet.com/jsp/extcontrols" %>


<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>

<fmt:message bundle="${msg}" var="usesLabel" key="CreateStructure_usesLabel"/>
<fmt:message bundle="${msg}" var="consumerProvidedBy" key="CreateStructure_consumerProvidedBy"/>
<fmt:message bundle="${msg}" var="consumerVersion" key="CreateStructure_consumerVersion"/>
<fmt:message bundle="${msg}" var="consumerSelectSubArtifact" key="CreateStructure_consumerSelectSubArtifact"/>
<fmt:message bundle="${msg}" var="consumerChange" key="CreateStructure_consumerChange"/>
<fmt:message bundle="${msg}" var="consumerSelect" key="CreateStructure_consumerSelect"/>
<fmt:message bundle="${msg}" var="providerProvidedBy" key="CreateStructure_providerProvidedBy"/>
<fmt:message bundle="${msg}" var="providerVersion" key="CreateStructure_providerVersion"/>
<fmt:message bundle="${msg}" var="providerSelectSubArtifact" key="CreateStructure_providerSelectSubArtifact"/>
<fmt:message bundle="${msg}" var="providerChange" key="CreateStructure_providerChange"/>
<fmt:message bundle="${msg}" var="providerSelect" key="CreateStructure_providerSelect"/>
<fmt:message bundle="${msg}" var="selectSlo" key="CreateStructure_sloSelect"/>
<fmt:message bundle="${msg}" var="changeSlo" key="CreateStructure_sloChange"/>

<fmt:message bundle="${msg}" var="selectProviderTitle" key="CreateStructure_SelectProviderTitle"/>
<fmt:message bundle="${msg}" var="selectProviderSubartifactTitle" key="CreateStructure_SelectProviderSubartifactTitle"/>
<fmt:message bundle="${msg}" var="selectConsumerTitle" key="CreateStructure_SelectConsumerTitle"/>
<fmt:message bundle="${msg}" var="selectConsumerSubartifactTitle" key="CreateStructure_SelectConsumerSubartifactTitle"/>
<fmt:message bundle="${msg}" var="selectLabel" key="CreateStructure_windowSelectLabel"/>

<div class="UI Block Plain">
	<div class="UI Edge">
		<div class="UI Edge">
			<div class="UI Edge">

				<c:if test="${structure.canChangeProvider}">
				    <syswf:component name="/core/window" prefix="selectProvider">
				        <syswf:param name="winId" value="selectProviderwin"/>
				        <syswf:param name="winTitle" value="${selectProviderTitle}"/>
				        <syswf:param name="winOpenFunctionName" value="selectProviderOwnerPopup"/>
				        <syswf:param name="winOkLabel" value="${selectLabel}"/>
				        <syswf:param name="winOkAction" value="selectProviderOwner"/>
				        <syswf:param name="winResizable" value="true"/>
				        <syswf:param name="winComponent" value="/core/impl/util/artifactSelectorWindow"/>
				
				        <%-- defect #68380: parentWindowId is required to make the selector's table resizable --%>
				        <syswf:param name="parentWindowId" value="selectProviderwin"/>
				        <syswf:param name="selectionBag" value="${providerSelection}"/>
				        <syswf:param name="artifactTypes" value="${structure.providerTypes}"/>
				        <syswf:param name="dqlCondition" value=":artifact.readyForConsumption = '1'"/>
				        <syswf:param name="showDataBeforeSearch" value="true"/>
				    </syswf:component>
				    <c:if test="${not empty structure.providerOwner}">
				        <syswf:component name="/core/window" prefix="subSelectProvider">
				            <syswf:param name="winId" value="subSelectProviderwin"/>
				            <syswf:param name="winTitle" value="${selectProviderSubartifactTitle}"/>
				            <syswf:param name="winOpenFunctionName" value="selectProviderPopup"/>
				            <syswf:param name="winOkAction" value="selectProvider"/>
				            <syswf:param name="winOkLabel" value="${selectLabel}"/>
				            <syswf:param name="winHeight" value="400"/>
				            <syswf:param name="winAutoScroll" value="true"/>
				            <syswf:param name="winComponent" value="/contract/impl/create/subArtifactSelector"/>
				
				            <syswf:param name="parentWindowId" value="subSelectProviderwin"/>
				            <syswf:param name="selectionBag" value="${providerSelection}"/>
				            <syswf:param name="selectProvider" value="${true}"/>
				            <syswf:param name="owner" value="${structure.providerRoot}"/>
				            <syswf:param name="contentCustomizationId" value="${providerSubSelectId}"/>
				            <syswf:param name="dqlCondition" value=":artifact.readyForConsumption = '1'"/>
				            <syswf:param name="showDataBeforeSearch" value="true"/>
				        </syswf:component>
				    </c:if>
				</c:if>
				
				<c:if test="${structure.canChangeConsumer}">
				    <syswf:component name="/core/window" prefix="selectConsumer">
				        <syswf:param name="winId" value="selectConsumerwin"/>
				        <syswf:param name="winTitle" value="${selectConsumerTitle}"/>
				        <syswf:param name="winOpenFunctionName" value="selectConsumerOwnerPopup"/>
				        <syswf:param name="winOkAction" value="selectConsumerOwner"/>
				        <syswf:param name="winOkLabel" value="${selectLabel}"/>
				        <syswf:param name="winResizable" value="true"/>
				        <syswf:param name="winComponent" value="/core/impl/util/artifactSelectorWindow"/>
				
				        <syswf:param name="parentWindowId" value="selectConsumerwin"/>
				        <syswf:param name="selectionBag" value="${consumerSelection}"/>
				        <syswf:param name="artifactTypes" value="${structure.consumerTypes}"/>
				        <syswf:param name="dqlCondition" value=":artifact._writable = '1'"/>
				        <syswf:param name="showDataBeforeSearch" value="true"/>
				    </syswf:component>
				
				    <c:if test="${not empty structure.consumerOwner}">
				        <syswf:component name="/core/window" prefix="subSelectConsumer">
				            <syswf:param name="winId" value="subSelectConsumerwin"/>
				            <syswf:param name="winTitle" value="${selectConsumerSubartifactTitle}"/>
				            <syswf:param name="winOpenFunctionName" value="selectConsumerPopup"/>
				            <syswf:param name="winOkAction" value="selectConsumer"/>
				            <syswf:param name="winOkLabel" value="${selectLabel}"/>
				            <syswf:param name="winResizable" value="true"/>
				            <syswf:param name="winComponent" value="/contract/impl/create/subArtifactSelector"/>
				
				            <syswf:param name="parentWindowId" value="subSelectConsumerwin"/>
				            <syswf:param name="selectionBag" value="${consumerSelection}"/>
				            <syswf:param name="selectProvider" value="${false}"/>
				            <syswf:param name="owner" value="${structure.consumerRoot}"/>
				            <syswf:param name="contentCustomizationId" value="${consumerSubSelectId}"/>
				            <syswf:param name="showDataBeforeSearch" value="true"/>
				            <syswf:param name="dqlCondition" value=":artifact._writable = '1'"/>
				        </syswf:component>
				    </c:if>
				</c:if>
				
				
				<div class="hp-cm-diagram">
				    <div class="hp-cm-diagram-item">
				        <c:choose>
				            <c:when test="${not empty structure.consumer}">
				                <div class="hp-corner-box hp-cm-consumer"><div><div><div><div>
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
				                        <span class="hp-cm-provided-by"><syswf:out value="${consumerProvidedBy}" context="HtmlBody"/>
				                            <syswf:component prefix="cProvided" name="/core/impl/util/artifactLinkRenderer" wrap="false">
				                                <syswf:param name="caption" value="${structure.consumerProvidedBy.name}"/>
				                                <syswf:param name="uuid" value="${structure.consumerProvidedBy._uuid}"/>
				                                <syswf:param name="sdmName" value="${structure.consumerProvidedBy._artifactSdmName}"/>
				                            </syswf:component>
				                        </span>
				                    </c:if>
				                    </div></div></div></div>
				                </div>
				                <ul class="hp-cm-diagram-meta">
				                    <c:if test="${structure.canChangeConsumer}">
				                        <c:if test="${structure.consumerStructured}">
				                            <li><a class="UI Icon SubArtifact" href="javascript:selectConsumerPopup();"><syswf:out value="${consumerSelectSubArtifact}" context="HtmlBody"/></a></li>
				                        </c:if>
				                        <li><a href="javascript:selectConsumerOwnerPopup();" class="UI Icon Edit"><syswf:out value="${consumerChange}" context="HtmlBody"/></a></li>
				                    </c:if>
				                </ul>
				            </c:when>
				            <c:otherwise>
				                <div class="hp-corner-box empty hp-cm-consumer"><div><div><div><div>
				                    <a id="contractmng-select-contracted" href="javascript:selectConsumerOwnerPopup();"><syswf:out value="${consumerSelect}" context="HtmlBody"/></a>
				                </div></div></div></div></div>
				            </c:otherwise>
				        </c:choose>
				    </div>
				
				    <div class="hp-cm-diagram-item">
				        <div class="hp-cm-uses">
				            <span><syswf:out value="${usesLabel}" context="HtmlBody"/></span>
				
				        </div>
				    </div>
				
				    <div class="hp-cm-diagram-item">
				        <c:choose>
				            <c:when test="${not empty structure.provider}">
				                <div class="hp-corner-box hp-cm-contractor"><div><div><div><div>
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
				                                <fmt:param><syswf:out value="${structure.provider.name}" context='HtmlBody'/></fmt:param>
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
				                        <span class="hp-cm-provided-by"><syswf:out value="${providerProvidedBy}" context="HtmlBody"/>
				                            <syswf:component prefix="pProvided" name="/core/impl/util/artifactLinkRenderer" wrap="false">
				                                <syswf:param name="caption" value="${structure.providerProvidedBy.name}"/>
				                                <syswf:param name="uuid" value="${structure.providerProvidedBy._uuid}"/>
				                                <syswf:param name="sdmName" value="${structure.providerProvidedBy._artifactSdmName}"/>
				                            </syswf:component>
				                        </span>
				                    </c:if>
				                    <c:if test="${not empty structure.availableSlos}">
				                        <div class="SLOToolbar">
				                            <c:if test="${not empty structure.selectedSlo}">
				                                <syswf:component prefix="slo" name="/core/impl/util/artifactLinkRenderer" wrap="false">
				                                    <syswf:param name="class" value="hp-cm-title"/>
				                                    <syswf:param name="caption" value="${structure.selectedSlo.name}"/>
				                                    <syswf:param name="uuid" value="${structure.selectedSlo._uuid}"/>
				                                    <syswf:param name="sdmName" value="${structure.selectedSlo._artifactSdmName}"/>
				                                    <syswf:param name="showIcon" value="${true}"/>
				                                </syswf:component>
				                                <c:set var="selectSlo" value="${changeSlo}"/>
				                            </c:if>
				                            <ctrl:selectMenu name="slo" label="${selectSlo}"
				                                 dropDownClass="SLO"
				                                 value="${structure}"
				                                 property="selectedSloUuid">
				                                <c:forEach items="${structure.availableSlos}" var="sloItem">
				                                    <ctrl:selectItem label="${sloItem.name}" value="${sloItem._uuid}"/>
				                                </c:forEach>
				
				                                <syswf:control mode="script" affects="." action="sloSelected" loadingMask="true"/>
				                             </ctrl:selectMenu>
				                        </div>
				                    </c:if>
				                    </div></div></div></div>
				                </div>
				                <ul class="hp-cm-diagram-meta">
				                    <c:if test="${structure.canChangeProvider}">
				                        <c:if test="${structure.providerStructured}">
				                            <li><a class="UI Icon SubArtifact" href="javascript:selectProviderPopup();"><syswf:out value="${providerSelectSubArtifact}" context="HtmlBody"/></a></li>
				                        </c:if>
				                        <li><a href="javascript:selectProviderOwnerPopup();" class="UI Icon Edit"><syswf:out value="${providerChange}" context="HtmlBody"/></a></li>
				                    </c:if>
				                </ul>
				            </c:when>
				            <c:otherwise>
				                    <div class="hp-corner-box empty hp-cm-contractor">
				                        <div>
				                            <div>
				                                <div>
				                                    <div>
				                                        <a id="contractmng-select-contracted" href="javascript:selectProviderOwnerPopup();"><syswf:out value="${providerSelect}" context="HtmlBody"/></a>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				            </c:otherwise>
				        </c:choose>
				    </div>
				    <div class="x-clear"></div>
				</div>
				
				<syswf:control mode="script" caption="selectProviderOwner" id="a" action="providerSelected" affects="." loadingMask="true">
				    <syswf:param name="owner" value="${true}"/>
				    <syswf:param name="selection" value="${providerSelection}"/>
				</syswf:control>
				<syswf:control mode="script" caption="selectProvider" id="b" action="providerSelected" affects="."  loadingMask="true">
				    <syswf:param name="owner" value="${false}"/>
				    <syswf:param name="selection" value="${providerSelection}"/>
				</syswf:control>
				<syswf:control mode="script" caption="selectConsumerOwner" id="c" action="consumerSelected" affects="."  loadingMask="true">
				    <syswf:param name="owner" value="${true}"/>
				    <syswf:param name="selection" value="${consumerSelection}"/>
				</syswf:control>
				<syswf:control mode="script" caption="selectConsumer" id="d" action="consumerSelected" affects="."  loadingMask="true">
				    <syswf:param name="owner" value="${false}"/>
				    <syswf:param name="selection" value="${consumerSelection}"/>
				</syswf:control>
			</div>
		</div>
	</div>
</div>
