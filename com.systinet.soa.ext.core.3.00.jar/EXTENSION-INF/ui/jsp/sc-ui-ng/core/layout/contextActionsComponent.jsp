<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message key="typeMap.invalidComponentLabel" var="invalidComponentLabel" bundle="${widgetMessages}"/>
<fmt:message key="historyTabLink" var="historyTabLink" bundle="${widgetMessages}"/>

<c:set var="custContent">
    <c:if test="${not empty customizeLinks}">
    <div class="Footer">
         <c:out value="${customizeLinks}" escapeXml="false"/>
    </div>
    </c:if>
</c:set>
<c:set var="conActContent">
        <c:choose>
        <c:when test="${deleted}">
            <syswf:component name="/core/contextActions/undeleteArtifact" prefix="undelete" wrap="false">
                <syswf:param name="artifact" value="${artifact}" />
            </syswf:component>
            <syswf:component name="/core/contextActions/purgeArtifact" prefix="purge" wrap="false">
                <syswf:param name="artifact" value="${artifact}" />
            </syswf:component>
        </c:when>
        <c:when test="${notLastRevision or displayRevisionActions}">
            <%-- Revision View actions only --%>
            <syswf:control id="linkToHistoryTab" mode="anchor" caption="${historyTabLink}" hint="" targetTask="/artifact/${artifact._uuid}">
                <syswf:attribute name="class" value="UI PageAction History"/>
                <syswf:param name="artifactTabId" value="history"/>
            </syswf:control>
            <syswf:component name="/core/contextActions/revisionsNavigation" prefix="revisionsNavigation">
                <syswf:param name="artifact" value="${artifact}"/>
            </syswf:component>            
            <c:if test="${notLastRevision}">
                <syswf:component name="/core/contextActions/revertArtifactToRevision" prefix="revertToRevision">
                    <syswf:param name="artifact" value="${artifact}" />
                </syswf:component>
            </c:if>
        </c:when>
        <c:otherwise>
		    <c:set var="havingCommonIcon" value="0" scope="page" />
			<c:set var="numberOfCommon" value="0" scope="page" />		
            <c:forEach var="contextAction" items="${internalContextActions.elements}">
				<c:if test="${(this.typeMap[contextAction] == 2 ||  this.typeMap[contextAction] == 1) && not empty contextAction.paramsMap['common']}" >
				   <c:set var="numberOfCommon" value="${numberOfCommon + 1}" scope="page"/>	
				   <c:set var="havingCommonIcon" value="1" scope="page" />
					<c:choose>
						<%--Component--%>
						<c:when test="${this.typeMap[contextAction] == 2}">
							<c:set var="componentContent">
								<syswf:component name="${contextAction.componentName}" prefix="${contextAction.id}"
												 wrap="false">
								<syswf:paramSet value="${contextAction.paramsMap}" />
								<c:if test="${empty contextAction.paramsMap['artifact']}">
									<syswf:param name="artifact" value="${artifact}" />
								</c:if>
								<c:if test="${empty contextAction.paramsMap['uuid']}">
									<syswf:param name="uuid" value="${artifact._uuid}" />
								</c:if>
								</syswf:component>
							</c:set>
							<c:if test="${fn:length(fn:trim(componentContent)) > 0}">
								<c:out value="${componentContent}" escapeXml="false"/>
								<c:set var="lastContextActionIsRuler" value="${false}"/>
							</c:if>
						</c:when>
						<%--Group--%>
						<c:when test="${this.typeMap[contextAction] == 0}">
							<c:set var="groupExists" value="${true}"/>
							<c:choose>
								<c:when test="${not empty contextAction.styleClass}">
									<c:set var="groupClass" value="${contextAction.styleClass}"/>
								</c:when>
								<c:otherwise>
									<c:set var="groupClass" value="x-hidden flyout-menu UI Dropdown Transparent"/>
								</c:otherwise>
							</c:choose>
							<div id="${contextAction.id}_content" class="${groupClass}" style="position: absolute;
									z-index: 11000; visibility: hidden; left: -10000px; top: -10000px;">
								<div class="DropdownTitle">
									<h3><c:out value="${contextAction.label}"/></h3>
								</div>
								<div class="DropdownContent">
									<c:forEach var="subAction" items="${contextAction.elements}">
										<c:choose>
											<%--Component--%>
											<c:when test="${this.typeMap[subAction] == 2}">
												<c:set var="groupComponentContent">
													<syswf:component name="${subAction.componentName}"
																	 prefix="${subAction.id}" wrap="false">
													<syswf:paramSet value="${subAction.paramsMap}" />
													</syswf:component>
												</c:set>
												<c:if test="${fn:length(fn:trim(groupComponentContent)) > 0}">
													<c:out value="${groupComponentContent}" escapeXml="false"/>
													<c:set var="lastSubActionIsRuler" value="${false}"/>
												</c:if>
											</c:when>
											<%--Ruler--%>
											<c:when test="${this.typeMap[subAction] == 3}">
												<c:if test="${not lastSubActionIsRuler}">
													<hr/>
													<c:set var="lastSubActionIsRuler" value="${true}"/>
												</c:if>
											</c:when>
											<%--TaskItem--%>
											<c:when test="${this.typeMap[subAction] == 1}">
												<syswf:control mode="anchor" caption="${subAction.label}"
															   hint="${subAction.description}"
															   targetTask="${subAction.taskLocation}"
															   id="${contextAction.id}${subAction.id}">
												<syswf:paramSet value="${subAction.paramsMap}"/>
													<c:if test="${not empty subAction.styleClass}">
														  <syswf:attribute name="class" value="${subAction.styleClass}"/>
													</c:if>
												</syswf:control>
												<c:set var="lastSubActionIsRuler" value="${false}"/>
											</c:when>
											<%--html--%>
											<c:when test="${this.typeMap[subAction] == 6}">
												<c:if test="${not empty subAction.parameters}">
												  <script>
												  //<![CDATA[
														<c:out value="${subAction.id}=${subAction.parametersAsJSON}" escapeXml="false"/>;
	//]]>
	</script>
												</c:if>
												<c:out value="${subAction.contentAsString}" escapeXml="false"/>
											</c:when>
											<%--server-script--%>
											<c:when test="${this.typeMap[subAction] == 5}">
												<syswf:component name="/data/js" prefix="${subAction.id}">
													<syswf:param name="sourceId" value="${subAction.id}" />
													<syswf:param name="code"><c:out value="${subAction.content}" escapeXml="false"/></syswf:param>
												</syswf:component>
											</c:when>
										</c:choose>
									</c:forEach>
									<c:if test="${not empty contextAction.description}">
										<p class="Comment"><c:out value="${contextAction.description}"/></p>
									</c:if>
								</div>
								<%--<div class="DropdownFooter">--%>
									<%--<hr/>--%>
									<%--<a href="#">--%>
										<%--<span>How To Use Analytic Tools?</span>--%>
									<%--</a>--%>
								<%--</div>--%>
							</div>
							<a id="${contextAction.id}" class="UI PageAction Dropdown Left"
							   href="javascript:void(0)" style="">
								<span><c:out value="${contextAction.label}"/></span>
							</a>
							<c:set var="lastContextActionIsRuler" value="${false}"/>
						</c:when>
						<%--html--%>
						<c:when test="${this.typeMap[contextAction] == 6}">
							<c:if test="${not empty contextAction.parameters}">
							  <script>
							  //<![CDATA[
									<c:out value="${contextAction.id}=${contextAction.parametersAsJSON}" escapeXml="false"/>;
	//]]>
	</script>
							</c:if>
							<c:out value="${contextAction.contentAsString}" escapeXml="false"/>
						</c:when>
						<%--server-script--%>
						<c:when test="${this.typeMap[contextAction] == 5}">
							<syswf:component name="/data/js" prefix="${contextAction.id}">
								<syswf:param name="sourceId" value="${contextAction.id}" />
								<syswf:param name="code"><c:out value="${contextAction.content}" escapeXml="false"/></syswf:param>
							</syswf:component>
						</c:when>
						<%--Ruler--%>
						<c:when test="${this.typeMap[contextAction] == 3}">
							<c:if test="${not lastContextActionIsRuler}">
								<hr/>
								<c:set var="lastContextActionIsRuler" value="${true}"/>
							</c:if>
						</c:when>
						<%--TaskItem--%>
						<c:when test="${this.typeMap[contextAction] == 1}">
							<syswf:control mode="anchor" caption="${contextAction.label}"
										   hint="${contextAction.description}"
										   targetTask="${contextAction.taskLocation}"
										   id="${contextAction.id}">
								<syswf:paramSet value="${contextAction.paramsMap}"/>
								<c:if test="${not empty contextAction.styleClass}">
									<syswf:attribute name="class" value="${fn:replace(contextAction.styleClass, 'UI PageAction', 'context-button')}"/>
								</c:if>	
							</syswf:control>
							<c:set var="lastContextActionIsRuler" value="${false}"/>
						</c:when>
						<c:when test="${this.typeMap[contextAction] == -2}">
							<div class="UI SystemMessage Error">
							<div class="MessageContainer">
								<div class="Text">${invalidComponentLabel} <c:out value="${contextAction.componentName}"/></div>
							</div>
							</div>
						</c:when>
					</c:choose>
				</c:if>	
            </c:forEach>
			<c:choose>
			    <c:when test="${havingCommonIcon == 1}" >
					<c:if test="${numberOfCommon lt fn:length(internalContextActions.elements)}" >
						<div class="x-hidden flyout-menu UI Dropdown Transparent" id="actions_list_content">
							<div class="DropdownContent">
						<c:forEach var="contextAction" items="${internalContextActions.elements}">			   
							<c:if test="${(this.typeMap[contextAction] == 2 ||  this.typeMap[contextAction] == 1) && empty contextAction.paramsMap['common']}" >					
								<c:choose>
									<%--Component--%>
									<c:when test="${this.typeMap[contextAction] == 2}">
										<c:set var="componentContent">
											<syswf:component name="${contextAction.componentName}" prefix="${contextAction.id}"
															 wrap="false">
											<syswf:paramSet value="${contextAction.paramsMap}" />
											<c:if test="${empty contextAction.paramsMap['artifact']}">
												<syswf:param name="artifact" value="${artifact}" />
											</c:if>
											<c:if test="${empty contextAction.paramsMap['uuid']}">
												<syswf:param name="uuid" value="${artifact._uuid}" />
											</c:if>
												<syswf:param name="contextMenu" value="true" />
											</syswf:component>
										</c:set>
										<c:if test="${fn:length(fn:trim(componentContent)) > 0}">
											<c:out value="${componentContent}" escapeXml="false"/>
											<c:set var="lastContextActionIsRuler" value="${false}"/>
										</c:if>
									</c:when>
									
									<%--TaskItem--%>
									<c:when test="${this.typeMap[contextAction] == 1}">								    									
										<div class="EA-left-panel">
											<syswf:control mode="anchor" caption="${contextAction.description}"
														   hint="${contextAction.description}"
														   targetTask="${contextAction.taskLocation}"
														   id="${contextAction.id}">
												<syswf:paramSet value="${contextAction.paramsMap}"/>
												<c:if test="${not empty contextAction.styleClass}">
													  <syswf:attribute name="class" value="${fn:replace(contextAction.styleClass, 'context-button', 'UI PageAction')}"/>
												</c:if>										
											</syswf:control>
										</div>
										<c:set var="lastContextActionIsRuler" value="${false}"/>
									</c:when>
									<c:when test="${this.typeMap[contextAction] == -2}">
										<div class="UI SystemMessage Error">
										<div class="MessageContainer">
											<div class="Text">${invalidComponentLabel} <c:out value="${contextAction.componentName}"/></div>
										</div>
										</div>
									</c:when>
								</c:choose>						
							</c:if>		
						</c:forEach>
							</div>
						</div>
						
						<a href="javascript:void(0);" onclick="return false;" class="context-button ShowMore" id="actions_list" title="${lable}"></a>

						<script type="text/javascript">
						//<![CDATA[

							Ext.onReady(function(){ Dropdown.init('actions_list','actions_list_content',{align:'tl-bl',forceRefresh:true,shadow:false}); });

						//]]>
						</script>
					</c:if>
				</c:when >
				<c:otherwise>
					<c:forEach var="contextAction" items="${internalContextActions.elements}">
				
						<c:choose>
							<%--Component--%>
							<c:when test="${this.typeMap[contextAction] == 2}">
								<c:set var="componentContent">
									<syswf:component name="${contextAction.componentName}" prefix="${contextAction.id}"
													 wrap="false">
									<syswf:paramSet value="${contextAction.paramsMap}" />
									<c:if test="${empty contextAction.paramsMap['artifact']}">
										<syswf:param name="artifact" value="${artifact}" />
									</c:if>
									<c:if test="${empty contextAction.paramsMap['uuid']}">
										<syswf:param name="uuid" value="${artifact._uuid}" />
									</c:if>
									</syswf:component>
								</c:set>
								<c:if test="${fn:length(fn:trim(componentContent)) > 0}">
									<c:out value="${componentContent}" escapeXml="false"/>
									<c:set var="lastContextActionIsRuler" value="${false}"/>
								</c:if>
							</c:when>
							<%--Group--%>
							<c:when test="${this.typeMap[contextAction] == 0}">
								<c:set var="groupExists" value="${true}"/>
								<c:choose>
									<c:when test="${not empty contextAction.styleClass}">
										<c:set var="groupClass" value="${contextAction.styleClass}"/>
									</c:when>
									<c:otherwise>
										<c:set var="groupClass" value="x-hidden flyout-menu UI Dropdown"/>
									</c:otherwise>
								</c:choose>
								<div id="${contextAction.id}_content" class="${groupClass}" style="position: absolute;
										z-index: 11000; visibility: hidden; left: -10000px; top: -10000px;">
									<div class="DropdownTitle">
										<h3><c:out value="${contextAction.label}"/></h3>
									</div>
									<div class="DropdownContent">
										<c:forEach var="subAction" items="${contextAction.elements}">
											<c:choose>
												<%--Component--%>
												<c:when test="${this.typeMap[subAction] == 2}">
													<c:set var="groupComponentContent">
														<syswf:component name="${subAction.componentName}"
																		 prefix="${subAction.id}" wrap="false">
														<syswf:paramSet value="${subAction.paramsMap}" />
														</syswf:component>
													</c:set>
													<c:if test="${fn:length(fn:trim(groupComponentContent)) > 0}">
														<c:out value="${groupComponentContent}" escapeXml="false"/>
														<c:set var="lastSubActionIsRuler" value="${false}"/>
													</c:if>
												</c:when>
												<%--Ruler--%>
												<c:when test="${this.typeMap[subAction] == 3}">
													<c:if test="${not lastSubActionIsRuler}">
														<hr/>
														<c:set var="lastSubActionIsRuler" value="${true}"/>
													</c:if>
												</c:when>
												<%--TaskItem--%>
												<c:when test="${this.typeMap[subAction] == 1}">
													<syswf:control mode="anchor" caption="${subAction.label}"
																   hint="${subAction.description}"
																   targetTask="${subAction.taskLocation}"
																   id="${contextAction.id}${subAction.id}">
													<syswf:paramSet value="${subAction.paramsMap}"/>
														<c:if test="${not empty subAction.styleClass}">
															  <syswf:attribute name="class" value="${subAction.styleClass}"/>
														</c:if>
													</syswf:control>
													<c:set var="lastSubActionIsRuler" value="${false}"/>
												</c:when>
												<%--html--%>
												<c:when test="${this.typeMap[subAction] == 6}">
													<c:if test="${not empty subAction.parameters}">
													  <script>
													  //<![CDATA[
															<c:out value="${subAction.id}=${subAction.parametersAsJSON}" escapeXml="false"/>;
		//]]>
		</script>
													</c:if>
													<c:out value="${subAction.contentAsString}" escapeXml="false"/>
												</c:when>
												<%--server-script--%>
												<c:when test="${this.typeMap[subAction] == 5}">
													<syswf:component name="/data/js" prefix="${subAction.id}">
														<syswf:param name="sourceId" value="${subAction.id}" />
														<syswf:param name="code"><c:out value="${subAction.content}" escapeXml="false"/></syswf:param>
													</syswf:component>
												</c:when>
											</c:choose>
										</c:forEach>
										<c:if test="${not empty contextAction.description}">
											<p class="Comment"><c:out value="${contextAction.description}"/></p>
										</c:if>
									</div>
									<%--<div class="DropdownFooter">--%>
										<%--<hr/>--%>
										<%--<a href="#">--%>
											<%--<span>How To Use Analytic Tools?</span>--%>
										<%--</a>--%>
									<%--</div>--%>
								</div>
								<a id="${contextAction.id}" class="UI PageAction Dropdown Left"
								   href="javascript:void(0)" style="">
									<span><c:out value="${contextAction.label}"/></span>
								</a>
								<c:set var="lastContextActionIsRuler" value="${false}"/>
							</c:when>
							<%--html--%>
							<c:when test="${this.typeMap[contextAction] == 6}">
								<c:if test="${not empty contextAction.parameters}">
								  <script>
								  //<![CDATA[
										<c:out value="${contextAction.id}=${contextAction.parametersAsJSON}" escapeXml="false"/>;
		//]]>
		</script>
								</c:if>
								<c:out value="${contextAction.contentAsString}" escapeXml="false"/>
							</c:when>
							<%--server-script--%>
							<c:when test="${this.typeMap[contextAction] == 5}">
								<syswf:component name="/data/js" prefix="${contextAction.id}">
									<syswf:param name="sourceId" value="${contextAction.id}" />
									<syswf:param name="code"><c:out value="${contextAction.content}" escapeXml="false"/></syswf:param>
								</syswf:component>
							</c:when>
							<%--Ruler--%>
							<c:when test="${this.typeMap[contextAction] == 3}">
								<c:if test="${not lastContextActionIsRuler}">
									<hr/>
									<c:set var="lastContextActionIsRuler" value="${true}"/>
								</c:if>
							</c:when>
							<%--TaskItem--%>
							<c:when test="${this.typeMap[contextAction] == 1}">
								<syswf:control mode="anchor" caption="${contextAction.label}"
											   hint="${contextAction.description}"
											   targetTask="${contextAction.taskLocation}"
											   id="${contextAction.id}">
									<syswf:paramSet value="${contextAction.paramsMap}"/>
									<c:if test="${not empty contextAction.styleClass}">
										  <syswf:attribute name="class" value="${contextAction.styleClass}"/>
									</c:if>
								</syswf:control>
								<c:set var="lastContextActionIsRuler" value="${false}"/>
							</c:when>
							<c:when test="${this.typeMap[contextAction] == -2}">
								<div class="UI SystemMessage Error">
								<div class="MessageContainer">
									<div class="Text">${invalidComponentLabel} <c:out value="${contextAction.componentName}"/></div>
								</div>
								</div>
							</c:when>
						</c:choose>
					
					</c:forEach>
				</c:otherwise>
			</c:choose>
        </c:otherwise>
        </c:choose>
        <%--Add Javascripts for group pop-ups --%>
        <c:if test="${groupExists}">
            <%--Usage: Dropdown.init(String Activator,String Content, optional Object Configuration)--%>
            <script type="text/javascript">
//<![CDATA[

                <c:forEach var="contextAction" items="${internalContextActions.elements}">
                    <c:choose>
                        <c:when test="${this.typeMap[contextAction] == 0}">
                            Ext.onReady(function(){
                                Dropdown.init(
                                        '${contextAction.id}','${contextAction.id}_content',{align:'tr-tl?'}
                                );
                            });
                        </c:when>
                    </c:choose>
                </c:forEach>
            
//]]>
</script>
        </c:if>
</c:set>
<c:if test="${fn:length(fn:trim(conActContent)) > 0 || fn:length(fn:trim(custContent)) > 0}">
<div class="UI Block Green ContextAction">
    <c:out value="${custContent}" escapeXml="false" />
    <div class="Content">
    <c:out value="${conActContent}" escapeXml="false" />
    </div>
</div>
</c:if>
