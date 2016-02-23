<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="messages"/>

<fmt:message bundle="${messages}" key="unspecified" var="unspecified" />

<c:if test="${not empty targetArtifacts}">

<c:if test="${empty label}">
    <c:set var="label" value="${componentHeader}" />
</c:if>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span>${label}</span></h3>
        
    </div>
    <div class="Content">
        <table class="UI Table Grid">
        <col />
        <col />
        <col />
        <tr>
        <c:forEach items="${targetArtifacts}" var="target" varStatus="status">
            <td>
                <ul class="UI GridItem" style="background-image: url(${deploymentUrl}/artifactIcon?type=${target.sdmName}&amp;format=large);">
                   <li class="Name">
                        <syswf:component prefix="m${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                            <syswf:param name="uuid" value="${target.uuid}"/>
                            <syswf:param name="caption" value="${target.name}"/>
                            <syswf:param name="sdmName" value="${target.sdmName}"/>
                            <syswf:param name="timeSlice" value="${artifact._sliceTime}"/>
                        </syswf:component>
                   </li>
                    <li><fmt:message bundle="${messages}" key="version"><fmt:param>${target.version}</fmt:param></fmt:message><c:if test="${fn:length(wsdls[target.uuid]) eq 1}">,<c:choose>
                                      <c:when test="${wsdls[target.uuid][0].type eq 'managedEndpoint'}">Managed</c:when>
                                      <c:otherwise>Functional</c:otherwise></c:choose></c:if><c:if test="${not empty target.extraProperty}">, ${target.extraProperty}</c:if></li>
                    <c:if test="${not empty wsdls[target.uuid]}">
                    <li>
                         <c:choose>
                             <c:when test="${fn:length(wsdls[target.uuid]) eq 1}">
                                 <a href="${wsdls[target.uuid][0].restLink}"><fmt:message bundle="${messages}" key="downloadWsdl" /></a>
                             </c:when>
                             <c:otherwise>
                                 <div class="hp-mini-combo">
                                 <select id="${prefix}selWsdl">
                                 <option value="" selected="selected"><fmt:message bundle="${messages}" key="downloadWsdl" /></option>
                                 <c:forEach items="${wsdls[target.uuid]}" var="wsdl">
                                     <option value="${wsdl.restLink}"><c:choose><c:when test="${wsdl.type eq 'managedEndpoint'}">Managed</c:when><c:otherwise>Functional</c:otherwise></c:choose>: <c:out value="${wsdl.environment}" default="${unspecified}" /><c:if test="${fn:length(wsdlLocations[target.uuid]) > 1}"> (${wsdl.wsdlLocation})</c:if></option>
                                 </c:forEach>
                                 </select>
                                 </div>
                                 <input id="${prefix}select_wsdls_val" type="hidden" />
                                 <script type="text/javascript">
//<![CDATA[

                                     Ext.onReady(function() {
                                         ${prefix}combo = new Ext.HP.MiniComboBox({
                                             transform: '${prefix}selWsdl',
                                             hiddenField: '${prefix}select_wsdls_val',
                                             listWidth: 190,
                                             cls: 'hp-mini-combo-field'
                                         });
                                         ${prefix}combo.on('select',function(item) {
                                             val = item.value;
                                             if (val!="") {
                                                 window.location.href = val;
                                             }
                                         });
                                     });
                                 
//]]>
</script>
                             </c:otherwise>
                         </c:choose>
                     </li>
                   </c:if>
                   <!-- li><a href="#">Download WSDL</a></li -->
               </ul>
            </td>
        </c:forEach>
        </tr>
        </table>
    </div>
    <div class="Footer">
        <c:choose>
            <c:when test="${numberOfArtifacts <= 3}">
                <fmt:message bundle="${messages}" key="details" var="more" />
            </c:when>
            <c:otherwise>
                <fmt:message bundle="${messages}" key="andMore" var="more">
                    <fmt:param>${numberOfArtifacts - 3}</fmt:param>
                </fmt:message>
            </c:otherwise>
        </c:choose>
        <syswf:control mode="anchor" targetTask="/artifact/${artifact._uuid}" caption="${more}">
            <syswf:param name="tabId" value="details" />
        </syswf:control>
    </div>
</syswf:block>

</c:if>