<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage" var="ServerMsg" />
<c:choose>
    <c:when test="${serverListInfo.serverType eq 'SOAPE_SERVER'}">
        <fmt:message key="server.button.add.soape_server" var="caption"  bundle="${ServerMsg}" />
    </c:when>
    <c:when test="${serverListInfo.serverType eq 'BAC_SERVER'}">
        <fmt:message key="server.button.add.bac_server" var="caption"  bundle="${ServerMsg}" />
    </c:when>
    <c:when test="${serverListInfo.serverType eq 'STM_SERVER'}">
        <fmt:message key="server.button.add.stm_server" var="caption"  bundle="${ServerMsg}" />
    </c:when>
<%--    
    <c:when test="${serverListInfo.serverType eq 'UDDI_SERVER'}">
        <fmt:message key="server.button.add.uddi_server" var="caption"  bundle="${ServerMsg}" />
    </c:when>
 --%>    
    <c:otherwise>
        <fmt:message key="server.button.add.any_server" var="caption"  bundle="${ServerMsg}" />
    </c:otherwise>
</c:choose>
<c:if test="${isAllowShow}">

<div class="flex-container">
    <div style="flex-grow:1;" class="UI Middle">
        <syswf:block className="UI Block Common">
            <div class="Title">
                <h3>
                    <span><c:out value="${serverListInfo.title}"></c:out></span>
                </h3>
            </div>
            <c:set var="style">
                background-image: url(${deploymentUrl}/artifactIcon?type=${serverListInfo.artifacType}&format=small);
            </c:set>
            <syswf:block className="UI Block Common">
                <c:if test="${not empty serverListInfo.licenseInfo}">
                <div class="LicenseInfo"><span><c:out value="${serverListInfo.licenseInfo}"/></span></div>
                </c:if>
                <div class="Content">
                    <c:forEach  var="server" items="${serverListInfo.data}">
                        <div class="ArtifactInfo" style="${style}">
                            <c:set var="uuidString">
                                <c:out value="${server['_uuid']}"></c:out>
                            </c:set>
                            <c:choose>
                               <c:when test="${serverListInfo.catalogManaged}">
                                  <syswf:component prefix="${server['_uuid']}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                              <syswf:param name="uuid" value="${uuidString}"/>
                                              <syswf:param name="caption" value="${server['name']}"/>
                                  </syswf:component>
                               </c:when>
                               <c:otherwise>
                                  <syswf:control id="${server['_uuid']}" mode="anchor" caption="${server['name']}" targetTask="/admin/server/view" >
                                      <syswf:param name="serverUUID" value="${uuidString}" />
                                      <syswf:param name="domainId" value="${domainId}" />
                                  </syswf:control>
                               </c:otherwise>
                            </c:choose>
                            <br/>
                            <span><c:out value="${server['extra']}" escapeXml="false"/></span>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${isAllowAdd}">
                    <div class="x-clear"></div>
                    <syswf:control id="${serverListInfo.artifacType}Add" mode="anchor" caption="${caption}" targetTask="${serverListInfo.createNewServerTask}"  >
                        <syswf:param name="sdmName" value="${serverListInfo.artifacType}" />
                        <syswf:param name="domainId" value="${domainId}" />
                        <syswf:param name="actionMode" value="new" />
                        <syswf:attribute name="class" value="UI Icon Add" />
                    </syswf:control>
                </c:if>
            </syswf:block>
        </syswf:block>  
    </div>
</div>

</c:if>
