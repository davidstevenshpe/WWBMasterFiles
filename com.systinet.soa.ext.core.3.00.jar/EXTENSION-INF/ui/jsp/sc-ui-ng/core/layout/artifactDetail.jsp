<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set scope="request" var="syswfLastBlock" value="false" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<c:if test="${empty labelColumnClass}">
    <c:set var="labelColumnClass">LabelCol</c:set>
</c:if>

<syswf:component name="/core/relations/selectArtifacts" prefix="${prefix}ArtifactSelection"/>

<%-- need ${descriptors} - model, component, params --%>
<c:forEach var="contentItem" items="${this.bean.descriptorsList}" varStatus="status">
    <c:choose>
        <c:when test="${not empty contentItem.error}">
            ${contentItem.type}: ${contentItem.error} <br/>
        </c:when>
        <c:when test="${contentItem.group}">
            <c:set var="group" value="${contentItem}" />

            <c:set var="groupContent">
                <c:forEach var="groupItem" items="${group.elements}">
                    <c:choose>
                    <c:when test="${not empty groupItem.error}">
                        <tr>
                            <th><label class="UI Label Inline">${groupItem.type}:</label></th>
                            <td><span class="IconAlign">${groupItem.error}</span></td>
                        </tr>
                    </c:when>
                    <c:when test="${empty groupItem.error and (this.bean.mode ne 'view' or not groupItem.emptyModel or groupItem.property.acceptNull)}">
                        <c:choose>
                            <c:when test="${groupItem.type eq 'property'}">
                                <c:set var="output">
                                    <syswf:component name="${groupItem.component}" prefix="${groupItem.id}" wrapIfEmpty="false">
                                        <syswf:param name="model" value="${groupItem.model}"/>
                                        <syswf:param name="mode" value="${groupItem.displayType}"/>
                                        <syswf:param name="error" value="${groupItem.model.errorMessage}"/>
                                        <syswf:param name="artifact" value="${artifact}"/>
                                        <syswf:param name="showNAIfNull" value="${groupItem.property.acceptNull}"/>
                                        <syswf:paramSet value="${groupItem.params}"/>
                                    </syswf:component>
                                </c:set>                                
                                <c:if test="${fn:length(fn:trim(output)) > 0}">
                                	
                                	<c:if test="${not empty groupItem.property.helpText}">
	                                	<tr>
	                                		<td colspan="2">
	                                			<div class="help-text ${linkTabId}">
	                                				<c:out value="${groupItem.property.helpText}"/>
	                                			</div>
	                                		</td>
	                                	</tr>
                                	</c:if>
                                	
                                    <tr id="${groupItem.property.name}">
                                    	<c:choose>
                                    		<c:when test="${groupItem.property.renderMode eq 'group'}">
                                    			<td colspan="2">
													<c:out value="${output}" escapeXml="false" />
												</td>
                                    		</c:when>
                                    		<c:otherwise>
                                    		<th>
                                    			<label 
                                        		class="UI Label <c:choose><c:when test="${this.bean.mode ne 'view' and groupItem.required}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>"
												title="<c:out value="${groupItem.hint}"/>" >                                
		                                        <c:out value="${groupItem.label}"/>:</label>
		                                        <c:if test="${this.bean.mode ne 'view' and groupItem.required}"><sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></c:if></th>
		                                        <td>
		                                        	<c:choose>
			                                    		<c:when test="${this.bean.mode eq 'view'}">
			                                    			<span class="IconAlign"><c:out value="${output}" escapeXml="false" /></span>
			                                    		</c:when>
			                                    		<c:otherwise><c:out value="${output}" escapeXml="false" /></c:otherwise>
		                                    		</c:choose>
		                                              
		                                             <c:if test="${not empty groupItem.model.errorMessage}">
		                                                <em class="x-form-invalid-msg UI Invalid">
		                                                    <span><c:out value="${groupItem.model.errorMessage}"/></span>
		                                                </em>
		                                            </c:if>
		                                        </td>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </tr>
                                </c:if>
                            </c:when>
                            <c:when test="${groupItem.type eq 'display'}">
                                <c:set var="output">
                                    <syswf:component name="${groupItem.component}" prefix="${groupItem.id}" wrapIfEmpty="false">
                                        <syswf:param name="mode" value="${this.bean.mode}"/>
                                        <syswf:param name="artifact" value="${artifact}"/>
                                        <syswf:paramSet value="${groupItem.params}"/>
                                    </syswf:component>
                                </c:set>
                                <c:if test="${fn:length(fn:trim(output)) > 0}">
                                <tr>
                                    <th>
                                        <label class="UI Label <c:choose><c:when test="${this.bean.mode ne 'view' and groupItem.required}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>"
                                        	title="<c:out value="${groupItem.hint}"/>">
                                            <c:choose>
                                                <c:when test="${not empty groupItem.label}">
                                                    <c:out value="${groupItem.label}"/>:
                                                </c:when>
                                                <c:otherwise>
                                                    <%-- A default fallback as the label is optional. --%>
                                                    <c:out value="${groupItem.id}"/>:
                                                </c:otherwise>
                                            </c:choose>
                                        </label>
                                        <c:if test="${this.bean.mode ne 'view' and groupItem.required}"><sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></c:if>
                                    </th>
                                    <td>
                                    	<c:choose>
                                    		<c:when test="${this.bean.mode eq 'view'}">
                                    			<span class="IconAlign"><c:out value="${output}" escapeXml="false" /></span>
                                    		</c:when>
                                    		<c:otherwise><c:out value="${output}" escapeXml="false" /></c:otherwise>
                                    	</c:choose>
                                    </td>
                                </tr>
                                </c:if>
                            </c:when>
                            <c:when test="${groupItem.type eq 'component'}">
                                <c:set var="output">
                                    <syswf:component name="${groupItem.component}" prefix="${groupItem.id}" wrapIfEmpty="false">
                                        <syswf:param name="artifact" value="${artifact}"/>
                                        <syswf:paramSet value="${groupItem.params}" />
                                        <syswf:param name="model" value="${groupItem.model}"/>
                                    </syswf:component>
                                </c:set>
                                <c:if test="${fn:length(fn:trim(output)) > 0}">
                                </table>
                                <c:out value="${output}" escapeXml="false" />
                                <table class="UI Table Properties">
                                    <col class="<c:out value="${labelColumnClass}"/>" />
                                    <col />
                                </c:if>
                            </c:when>
                            <c:when test="${groupItem.type eq 'html'}">
                                </table>
                                        <c:if test="${not empty groupItem.nested.parameters}">
                                          <script>
                                          //<![CDATA[
                                                <c:out value="${groupItem.nested.id}=${groupItem.nested.parametersAsJSON}" escapeXml="false"/>;
//]]>
</script>
                                        </c:if>
                                        <c:out value="${groupItem.nested.contentAsString}" escapeXml="false"/>
                                <table class="UI Table Properties">
                                    <col class="<c:out value="${labelColumnClass}"/>" />
                                    <col />
                            </c:when>
                            <c:when test="${groupItem.type eq 'server-script'}">
                                    <syswf:component name="/data/js" prefix="${groupItem.nested.id}">
                                            <syswf:param name="sourceId" value="${groupItem.nested.id}" />
                                            <syswf:param name="code"><c:out value="${groupItem.nested.content}" escapeXml="false"/></syswf:param>
                                    </syswf:component>
                            </c:when>
                        </c:choose>
                    </c:when>
                    </c:choose>
                </c:forEach>
            </c:set>
            <c:if test="${fn:length(fn:trim(groupContent)) > 0}">
                <c:if test="${status.last}"><c:set var="appendClass" value=" Last" /></c:if>
                <syswf:block className="UI Block Common${appendClass}">
                <c:if test="${not empty group.label}">
                    <div class="Title">
                    <h3><span class="IconAlign"><c:out value="${group.label}"/></span></h3>
                    </div>
                </c:if>
                <div class="Content">
                <table class="UI Table Properties">
                    <col class="<c:out value="${labelColumnClass}"/>" />
                    <col />
                    <c:out value="${groupContent}" escapeXml="false" />
                </table>
                </div>
                </syswf:block>
            </c:if>
        </c:when>
        <c:when test="${contentItem.type eq 'property'}">
            <c:if test="${empty contentItem.error and (this.bean.mode ne 'view' or not contentItem.emptyModel)}">
                <c:choose>
                    <c:when test="${not empty contentItem.label and contentItem.params.labelAsHeading}">
                        <syswf:block className="UI Block Common Last">
                            <div class="Title">
                                <h3><span class="IconAlign"><c:out value="${contentItem.label}"/></span></h3>
                            </div>
                            <div class="Content">
                                <syswf:component name="${contentItem.component}" prefix="${contentItem.id}">
                                    <syswf:param name="mode" value="${contentItem.displayType}" />
                                    <syswf:param name="model" value="${contentItem.model}" />
                                    <syswf:param name="error" value="${contentItem.model.errorMessage}"/>
                                    <syswf:param name="artifact" value="${artifact}"/>
                                    <syswf:paramSet value="${contentItem.params}" />
                                </syswf:component>
                                <c:if test="${not empty contentItem.model.errorMessage}">
                                    <em class="x-form-invalid-msg UI Invalid">
                                        <span><c:out value="${contentItem.model.errorMessage}"/></span>
                                    </em>
                                </c:if>
                            </div>
                        </syswf:block>
                    </c:when>
                    <c:otherwise>
                        <syswf:component name="${contentItem.component}" prefix="${contentItem.id}">
                            <syswf:param name="mode" value="${contentItem.displayType}" />
                            <syswf:param name="model" value="${contentItem.model}" />
                            <syswf:param name="error" value="${contentItem.model.errorMessage}"/>
                            <syswf:param name="artifact" value="${artifact}"/>
                            <syswf:paramSet value="${contentItem.params}" />
                        </syswf:component>
                        <c:if test="${not empty contentItem.model.errorMessage}">
                            <em class="x-form-invalid-msg UI Invalid">
                                <span><c:out value="${contentItem.model.errorMessage}"/></span>
                            </em>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </c:when>
        <c:when test="${contentItem.type eq 'display'}">
            <c:if test="${empty contentItem.error and (this.bean.mode ne 'view' or not contentItem.emptyModel)}">
                <c:set var="output">
                    <syswf:component name="${contentItem.component}" prefix="${contentItem.id}">
                        <syswf:param name="artifact" value="${artifact}"/>
                        <syswf:paramSet value="${contentItem.params}" />
                    </syswf:component>
                </c:set>
                <c:if test="${fn:length(fn:trim(output)) > 0}">
                    <syswf:block className="UI Block Common">
                    <c:if test="${not empty contentItem.label}">
                        <div class="Title">
                            <h3><span class="IconAlign"><c:out value="${contentItem.label}"/></span></h3>
                        </div>
                    </c:if>
                    <div class="Content">
                        <c:out value="${output}" escapeXml="false" />
                    </div>
                    </syswf:block>
                </c:if>
            </c:if>
        </c:when>
        <c:when test="${contentItem.type eq 'component'}">
            <c:if test="${empty contentItem.error and (this.bean.mode ne 'view' or not contentItem.emptyModel)}">
                <syswf:component name="${contentItem.component}" prefix="${contentItem.id}">
                    <syswf:param name="artifact" value="${artifact}"/>
                    <syswf:param name="model" value="${contentItem.model}" />
                    <syswf:paramSet value="${contentItem.params}" />
                </syswf:component>
            </c:if>
        </c:when>
        <c:when test="${contentItem.type eq 'html'}">
                    <c:if test="${not empty contentItem.nested.parameters}">
                       <script>
                       //<![CDATA[
                            <c:out value="${contentItem.nested.id}=${contentItem.nested.parametersAsJSON}" escapeXml="false"/>;
//]]>
</script>
                    </c:if>
                    <c:out value="${contentItem.nested.contentAsString}" escapeXml="false"/>
         </c:when>
         <c:when test="${contentItem.type eq 'server-script'}">
                 <syswf:component name="/data/js" prefix="${contentItem.nested.id}">
                        <syswf:param name="sourceId" value="${contentItem.nested.id}" />
                        <syswf:param name="code"><c:out value="${contentItem.nested.content}" escapeXml="false"/></syswf:param>
                  </syswf:component>
         </c:when>
    </c:choose>
</c:forEach>
