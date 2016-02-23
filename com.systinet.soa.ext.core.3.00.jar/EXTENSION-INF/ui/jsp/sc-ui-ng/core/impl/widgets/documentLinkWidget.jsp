<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:choose>
    <c:when test="${this.renderRestLink}">
        <a href="${this.artifactTaskUri}" target="_blank"><c:out value="${this.name}" /></a>
    </c:when>
    <c:when test="${this.renderDocumentation && this.mode == 'both'}"> <%-- This one is used to swap link values for documentation artifact; see #61975 and fix #62796 --%>
        <c:choose>
            <c:when test="${not empty this.secondArtifactTaskUri && not empty this.name}">
				<div class="WrapText">
                	<%-- <fmt:message key="artifactLinkWidget.linkToArtifact" var="linkHint" bundle="${widgetMessages}"/> --%>
                	<c:set var="clickToDownloadLink">
               			<%-- Click link to download document --%>
               			<fmt:message key="artifactLinkWidget.downloadHint" var="downloadHint" bundle="${widgetMessages}"/>
	                	<syswf:control mode="anchor" caption="${this.name}" targetTask="${this.secondArtifactTaskUri}" targetDepth="${this.depth}" hint="${downloadHint}" id="data">
	                    	<syswf:param name="view" value="${this.view}"/>
	                    	<%-- TODO The artifactTabId should be stored inside the detailContextParams attribute and not passed separately. --%>
	                    	<c:if test="${not empty this.artifactTabId}">
	                        	<syswf:param name="artifactTabId" value="${this.artifactTabId}"/>
	                    	</c:if>
	                    	<c:if test="${not empty this.revision}">
	                        	<syswf:param name="revision" value="${this.revision}"/>
	                    	</c:if>
	                    	<c:if test="${not empty this.timeSlice}">
	                        	<syswf:param name="timeSlice" value="${this.timeSlice}"/>
	                    	</c:if>
	                    	<c:if test="${not empty this.detailContextParams}">
	                        	<c:forEach var="entry" items="${this.detailContextParams}">
	                            	<syswf:param name="${entry.key}" value="${entry.value}"/>
	                        	</c:forEach>
	                    	</c:if>
	                    	<c:if test="${this.mode == 'data'}">
	                        	<syswf:attribute name="target" value="dataContent"/>
	                    	</c:if>
	                	</syswf:control>
                	</c:set>
                	<c:choose>
                		<c:when test="${this.openWithOffice}">
                			<%-- Click link to open with office --%>
                			<syswf:component name="/core/webdav/openInOffice" prefix="${this.uuid}openInOffice">
								<syswf:param name="artifact" value="${this.artifact}"/>
								<syswf:param name="label" value="${this.name}"/>
								<syswf:param name="styleClass" value="emptyClass"/>
								<syswf:param name="officeLinkClass" value="Documentation-link"/>
								<syswf:param name="wrap" value="false"/>
								<syswf:param name="clickToDownloadLink" value="${clickToDownloadLink}"/>
							</syswf:component>
                		</c:when>
                		<c:otherwise>
                			<c:out value="${clickToDownloadLink}" escapeXml="false"/>
                		</c:otherwise>
                	</c:choose>
                	<syswf:control mode="anchor" caption="&nbsp;" targetTask="${this.artifactTaskUri}" targetDepth="${this.depth}" id="artifact" hint="Go to detail document">
                    	<c:if test="${not empty this.revision}">
                        	<syswf:param name="revision" value="${this.revision}"/>
                    	</c:if>
                    	<c:if test="${not empty this.timeSlice}">
                        	<syswf:param name="timeSlice" value="${this.timeSlice}"/>
                    	</c:if>
                    	<c:if test="${not empty class}">
                        	<syswf:attribute name="class" value="${class}"/>
                    	</c:if>
                       	<syswf:attribute name="style" value="margin: 0 0 0 5px; padding-top: 3px"/>
						<syswf:attribute name="class" value="UI Icon Artifact Documentation"/>
                	</syswf:control>
				</div>
            </c:when>
            <c:when test="${not empty this.name}">
                <c:out value="${this.name}" />
            </c:when>
        </c:choose>
    </c:when>
    <c:otherwise>
        <c:choose> <%-- Original code --%>
            <c:when test="${not empty this.artifactTaskUri && not empty this.name}">
                <syswf:control mode="anchor" caption="${this.name}" targetTask="${this.artifactTaskUri}" targetDepth="${this.depth}" id="artifact">
                    <syswf:param name="view" value="${this.view}"/>
                    <%-- TODO The artifactTabId should be stored inside the detailContextParams attribute and not passed separately. --%>
                    <c:if test="${not empty this.artifactTabId}">
                        <syswf:param name="artifactTabId" value="${this.artifactTabId}"/>
                    </c:if>
                    <c:if test="${not empty this.revision}">
                        <syswf:param name="revision" value="${this.revision}"/>
                    </c:if>
                    <c:if test="${not empty this.timeSlice}">
                        <syswf:param name="timeSlice" value="${this.timeSlice}"/>
                    </c:if>
                    <c:if test="${not empty this.detailContextParams}">
                        <c:forEach var="entry" items="${this.detailContextParams}">
                            <syswf:param name="${entry.key}" value="${entry.value}"/>
                        </c:forEach>
                    </c:if>
                    <c:choose>
	                    <c:when test="${this.mode == 'data'}">
	                        <syswf:attribute name="target" value="dataContent"/>
	                    </c:when>
	                    <c:otherwise>
	                    	<c:if test="${this.renderDocumentation}">
	                    		<syswf:attribute name="target" value="_blank"/><%-- URL document will be opened in new tab --%>
                    		</c:if>
	                    </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty class}">
                        <syswf:attribute name="class" value="${class}"/>
                    </c:if>
                    <c:if test="${not empty style}">
                        <syswf:attribute name="style" value="${style}"/>
                    </c:if>
                </syswf:control>

                <c:if test="${this.mode == 'both'}">
                    <fmt:message key="artifactLinkWidget.downloadHint" var="downloadHint" bundle="${widgetMessages}"/>
                    <syswf:control mode="anchor" targetTask="${this.secondArtifactTaskUri}" targetDepth="${this.depth}" caption="&nbsp;" hint="${downloadHint}" id="data">
                        <syswf:param name="view" value="${this.view}"/>
                        <%-- TODO The artifactTabId should be stored inside the detailContextParams attribute and not passed separately. --%>
                        <c:if test="${not empty this.artifactTabId}">
                            <syswf:param name="artifactTabId" value="${this.artifactTabId}"/>
                        </c:if>
                        <c:if test="${not empty this.revision}">
                            <syswf:param name="revision" value="${this.revision}"/>
                        </c:if>
                        <c:if test="${not empty this.detailContextParams}">
                            <c:forEach var="entry" items="${this.detailContextParams}">
                                <syswf:param name="${entry.key}" value="${entry.value}"/>
                            </c:forEach>
                        </c:if>
                        <syswf:attribute name="target" value="dataContent"/>
                        <syswf:attribute name="class" value="UI Icon DownloadDocument"/>
                    </syswf:control>
                </c:if>
            </c:when>
            <c:when test="${not empty this.name}">
                <c:out value="${this.name}" />
            </c:when>
        </c:choose>
    </c:otherwise>
</c:choose>