<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoComponentMessages" var="tcm"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.contract.contractmessages" var="contractMessages"/>

<c:if test="${not empty rows}">
	<syswf:block className="UI Block Common">
	    <div class="Title">
	        <h3><fmt:message key="web.listMyContracts_MyContracts" bundle="${tcm}"/></h3>
	    </div>
	    <div class="Content">
	                <ul class="UI Bullets">
	                <c:forEach items="${rows}" var="row" varStatus="status">
	                    <li><syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="row${status.index}" wrap="false">
	                        <syswf:param name="uuid" value="${row._uuid}" />
	                        <syswf:param name="caption" value="${row.name}" />
	                    </syswf:component></li>
	                </c:forEach>
	                </ul>
	    </div>
	    <div class="Footer">
	        <fmt:message var="more" key="more" bundle="${contractMessages}"/>
	        <syswf:control mode="anchor" targetTask="/${activeTab}/browseArtifact" caption="${more}">
	            <syswf:param name="artifactType" value="contractArtifact" />
	        </syswf:control>
	    </div>
	</syswf:block>
</c:if>