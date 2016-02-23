<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.layout.LayoutMessages" var="layout_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="dashboard.box_closeThisArea" var="closeThisArea" bundle="${layout_Messages}"/>
<fmt:message key="dashboard.box_customizeThisAreaContent" var="customizeThisAreaContent" bundle="${layout_Messages}"/>
<fmt:message key="dashboard.box_rssHint" var="box_rssHint" bundle="${layout_Messages}"/>

<c:forEach var="area" items="${box.assignedAreas}" varStatus="status">
    <div class="shrTrayBlock" id="section_<c:out value="${status.index}"/>">
    	<input type="hidden" id="section_<c:out value="${status.index}"/>_hidden" value="<c:out value="${area.name}" />" />
        <div class="shrTrayHeader">
            <h3 class="handle"><c:out value="${area.caption}"/></h3>
            <a id="section_<c:out value="${status.index}"/>_open" class="fold <syswf:component name="savehidestatus" prefix="SHS1${status.index}" wrap="false"><syswf:param name="component" value="section_${area.name}" /></syswf:component>" onclick="swapPageMenuItem(this.id,'section_<c:out value="${area.name}" />'); return false;" href="#" title="<fmt:message key="dashboard.box_expandCollapse" bundle="${layout_Messages}"/>">
				<span><fmt:message key="dashboard.box_expandCollapse" bundle="${layout_Messages}"/></span>
			</a>
		</div>
		<div id="section_<c:out value="${status.index}"/>_open_area" <syswf:component name="savehidestatus" prefix="SHS2${status.index}" wrap="false"><syswf:param name="component" value="section_${area.name}" /><syswf:param name="display" value="style" /></syswf:component>>
            <c:out value="${area.code}" escapeXml="false"/>
            <div class="clear"></div>
        </div>
    </div>
</c:forEach>


