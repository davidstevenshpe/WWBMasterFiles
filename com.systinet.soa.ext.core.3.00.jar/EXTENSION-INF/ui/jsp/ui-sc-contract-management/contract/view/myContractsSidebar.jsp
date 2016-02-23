<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>
<c:if test="${not empty rows}">
	<syswf:block className="UI Block Common">
	    <div class="Title">
	        <h3><fmt:message key="MyContractsSidebar_caption" bundle="${msg}"/></h3>
	    </div>
	    <div class="Content">
	                <ul class="UI Bullets">
	                <c:forEach items="${rows}" var="row" varStatus="status">
                        <c:choose>
                            <c:when test="${row.providing == '1'}">
                                <fmt:message var="caption" key="TableWidget_ContractName_My_Providing" bundle="${msg}">
                                    <fmt:param value="${row.p_name}"/>
                                    <fmt:param value="${row.c_name}"/>
                                    <fmt:param value="${row.cp_name}"/>
                                </fmt:message>
                            </c:when>
                            <c:otherwise>
                                <fmt:message var="caption" key="TableWidget_ContractName_My_Using" bundle="${msg}">
                                    <fmt:param value="${row.p_name}"/>
                                    <fmt:param value="${row.c_name}"/>
                                    <fmt:param value="${row.cp_name}"/>
                                </fmt:message>
                            </c:otherwise>
                        </c:choose>
	                    <li><syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="row${status.index}" wrap="false">
	                        <syswf:param name="uuid" value="${row._uuid}" />
	                        <syswf:param name="caption" value="${caption}" />
	                    </syswf:component></li>
	                </c:forEach>
	                </ul>
	    </div>
	    <div class="Footer">
	        <fmt:message var="more" key="MyContractsSidebar_more" bundle="${msg}"/>
            <c:choose>
                <c:when test="${empty artifactUuid}">
                    <syswf:control mode="anchor" targetTask="/${activeTab}/contract/myContracts" caption="${more}"/>
                </c:when>
                <c:otherwise>
                    <syswf:control mode="anchor" targetTask="/${activeTab}/contract/artifactContracts" caption="${more}">
                        <syswf:param name="artifactUuid">${artifactUuid}</syswf:param>
                    </syswf:control>
                </c:otherwise>
            </c:choose>
	    </div>
	</syswf:block>
</c:if>