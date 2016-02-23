<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="styleClass" type="java.lang.String"--%>
<%--@elvariable id="label" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="this" type="com.hp.systinet.sc.ui.contextactions.EditArtifact"--%>
<%--@elvariable id="editationListener" type="com.hp.systinet.sc.ui.artifact.EditArtifactComponent.EditationListener"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="messages"/>

<c:if test="${empty styleClass}" >
    <c:set var="styleClass" value="Edit" />
</c:if>

<c:choose>
	<c:when test="${ contextMenu == true}">
		<c:set var="itemClass" value="UI PageAction ${styleClass}" />
	</c:when>
	<c:otherwise>
		<c:set var="itemClass" value="context-button ${styleClass}" />
	</c:otherwise>
</c:choose>

<c:if test="${empty label}" >
    <fmt:message var="label" key="CONTEXT_ACTION_EDIT_LABEL" bundle="${messages}"/>
</c:if>

<c:choose>
<c:when test="${this.permissions.write && this.editPageAvailable}">
<c:choose>
        <c:when test="${empty editationListener}">
        <c:choose>
				<c:when test="${ contextMenu == true}">
				<div class="EA-right-panel">
					<syswf:control mode="anchor" targetTask="/${this.activeView}/editArtifact" caption="${label}" hint="&nbsp;">
                		<syswf:attribute name="class"><c:out value="${itemClass}"/></syswf:attribute>
                		<syswf:taskParam name="uuid">${this.artifact._uuid}</syswf:taskParam>
            		</syswf:control>
				</div>
				</c:when>
				<c:otherwise>
					<c:choose>
        				<c:when test="${hasText == true}">        				
        					<c:set var="editFn" value="${prefix}e"/>
				            <syswf:control mode="script" id="${editFn}" caption="${editFn}" targetTask="/${this.activeView}/editArtifact">
				                <syswf:param name="uuid" value="${this.artifact._uuid}" />
				            </syswf:control>
				            <c:set var="anchorId" value="${prefix}anchor"/>
				            <a href="javascript:void(0);" id="${anchorId}" class="with-text ${itemClass}">
				            	<span>${label}</span>
				            </a>
				            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    attachOn('${anchorId}','click', ${editFn});
                });
            
//]]>
</script>
        				</c:when>
       					<c:otherwise>
       						<syswf:control mode="anchor" targetTask="/${this.activeView}/editArtifact" caption="" hint="${label}">
		                		<syswf:attribute name="class"><c:out value="${itemClass}"/></syswf:attribute>
		                		<syswf:taskParam name="uuid">${this.artifact._uuid}</syswf:taskParam>
		            		</syswf:control>
       					</c:otherwise>					
            		</c:choose>
				</c:otherwise>
			</c:choose>
        </c:when>
        <c:otherwise>
            <c:set var="editFn" value="${prefix}e"/>
            <syswf:control mode="script" id="${editFn}" caption="${editFn}"
                           targetTask="/${this.activeView}/editArtifact">
                <syswf:param name="uuid" value="${this.artifact._uuid}" />
                <syswf:param name="editationListener" value="${editationListener}"/>
            </syswf:control>

            <c:set var="anchorId" value="${prefix}anchor"/>            
			<c:choose>
				<c:when test="${ contextMenu == true}">
				<div class="EA-right-panel">
					<a href="javascript:void(0);" id="${anchorId}" class="${itemClass}">${label}</a>
				</div>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0);" id="${anchorId}" class="${itemClass}" title="${label}">&nbsp;</a>
				</c:otherwise>
			</c:choose>
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    attachOn('${anchorId}','click', ${editFn});
                });
            
//]]>
</script>
        </c:otherwise>
    </c:choose>
</c:when>
<c:otherwise>
	<c:if test="${hasText == true}">
		<a href="javascript:void(0);" id="${anchorId}" class="with-text ${itemClass}" style="opacity: 0.6">
        	<span>${label}</span>
        </a>
	</c:if>
</c:otherwise>
</c:choose>

