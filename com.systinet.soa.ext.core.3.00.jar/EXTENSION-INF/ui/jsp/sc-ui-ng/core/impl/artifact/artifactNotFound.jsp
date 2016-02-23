<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.artifact.ArtifactMessages" var="messages" />

<fmt:message var="title" key="artifactNotFound.title" bundle="${messages}" />
<fmt:message var="description" key="artifactNotFound.description" bundle="${messages}" />
<fmt:message var="artifactId" key="artifactNotFound.artifactId" bundle="${messages}" />
<fmt:message var="when" key="artifactNotFound.when" bundle="${messages}" />
<fmt:message var="lastKnownLocation" key="artifactNotFound.lastKnownLocation" bundle="${messages}" />
<fmt:message var="search" key="artifactNotFound.search" bundle="${messages}" />

<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
                <!-- Title and description -->
                <div class="UI PageIdentity">
                    <h1>${title}</h1>
                </div>
    
                <div class="UI Text Description">${description}</div>
    
                <!-- Details properties -->
                <syswf:block className="UI Block Common">
                    <div class="Content">
                    <table class="UI Table Properties">
                        <col class="LabelCol">
                        <col>
                        <tbody>
                            <c:if test="${not empty bean.artifactIdentifier}">
                            <tr>
                                <th><label class="UI Label Inline">${artifactId}:</label></th>
                                <td><syswf:out value="${bean.artifactIdentifier}" context="HtmlBody"/></td>
                            </tr>
                            </c:if>
                            <tr>
                                <th><label class="UI Label Inline">${when}:</label></th>
                                <td><syswf:out value="${bean.whenDetail}" context="HtmlBody"/></td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">${lastKnownLocation}:</label></th>
                                <td><syswf:component name="lastKnownLocation" prefix="lastKnownLocationRight" wrap="false" /></td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                </syswf:block>
            </td>

            <td class="UI Right">
                <!-- Right side links -->
                <syswf:block className="UI Block Green">
                    <div class="Content">
                        <c:if test ="${activeTab eq 'reports' || activeTab eq 'admin'}">
                            <c:set var="activeTab" value ="provider"/>
                        </c:if>
                        
	                    <syswf:control mode="anchor" caption="${search}" id="searchRight" targetTask="/${activeTab}/advancedSearch">
	                        <syswf:param name="advancedOptionsExpanded">true</syswf:param>
	                        <syswf:attribute name="class" value="UI PageAction Search" />
	                    </syswf:control> 
	                    <syswf:component name="lastKnownLocation" prefix="lastKnownLocationRight2" wrap="false">
	                        <syswf:param name="id">lastKnownLocationRight</syswf:param>
	                        <syswf:param name="class">UI PageAction GoBack</syswf:param>
	                        <syswf:param name="caption">${lastKnownLocation}</syswf:param>
	                    </syswf:component>
                    </div>
                </syswf:block>
            </td>
        </tr>
    </tbody>
</table>