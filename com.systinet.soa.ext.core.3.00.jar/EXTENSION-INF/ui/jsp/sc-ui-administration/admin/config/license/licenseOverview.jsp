<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.license.LicenseMessages"
    var="license_Messages" />
<fmt:setBundle basename="com.hp.systinet.platform.rebranding"
    var="rebranding_Messages" />
<fmt:message key="rebranding.productName" var="productName"
    bundle="${rebranding_Messages}" />
                <syswf:block className="UI Block Common">                   
                    <c:if test="${licenseInfo.valid}">
                        <fmt:message key="wizardSummary_licenseConditions_title"
                            var="licenseConditionsArea" bundle="${license_Messages}" />
                        <div class="Title">
                            <h3><span>
                                <fmt:message key="wizardSummary_licenseConditions_title" bundle="${license_Messages}" />
                            </span></h3>
                        </div>
                        <div class="Content">
                            <table class="UI Table Properties">
                                <col class="LabelCol">
                                <col>                           
                                <tr>
                                    <td style="width:20%">
                                        <label class="UI Label Inline"> 
                                            <fmt:message key="wizardSummary_property_validFor" bundle="${license_Messages}" />
                                        </label>
                                    </td>
                                    <td style="width:80%">
                                        <c:out value="${licenseInfo.expirationInfo}" /> 
                                        <c:if test="${remainingDays != null}">
                                            <fmt:formatDate value="${remainingDays}" var="formatedDate" />
                                            <fmt:message key="licenseOverview_remainingDays_P1"
                                                bundle="${license_Messages}">
                                                <fmt:param value="${formatedDate}" />
                                            </fmt:message>
                                        </c:if>
                                    </td>                                           
                                </tr>
                            
                            </table><hr/>
                            <table class="UI Table Properties">
                                <col class="LabelCol">
                                <col>
                                
                                <c:forEach var="capacity" items="${licenseInfo.capacityNames}">
                                    <c:choose>
                                        <c:when test="${not newLicenseInfo.capacitiesMap[capacity].deprecated and capacityNameForLusUsersManagement != null and capacityNameForLusUsersManagement eq capacity }">
                                            <tr>
                                                <td style="width:55%; white-space: nowrap">
                                                    <label class="UI Label Inline">
                                                        <c:out value="${licenseInfo.capacitiesMap[capacity].label}" />:
                                                    </label>
                                                </td>
                                                <td style="width:15%">
                                                    <c:out value="${licenseInfo.capacitiesMap[capacity].capacityStr}" />
                                                    <c:if test="${limitsUsed[capacity] != null}">
                                                        <fmt:message key="licenseOverview_used_P1"
                                                            bundle="${license_Messages}">
                                                            <fmt:param value="${limitsUsed[capacity]}" />
                                                        </fmt:message>
                                                    </c:if>
                                                </td>
                                                <td align="right" style="width:30%">
                                                    <fmt:message key="licenseOverview_manageLUS_caption" var="manageLUSCaption" bundle="${license_Messages}" />
                                                    <div class="UI Icon Edit">                                      
                                                        <syswf:control targetTask="/common/license/browseLicensedUsers" caption="${manageLUSCaption}" mode="anchor" />
                                                    </div>                                      
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${ not licenseInfo.capacitiesMap[capacity].deprecated }">
                                                <tr>
                                                    <td style="width:55%; white-space: nowrap">
                                                        <label class="UI Label Inline">
                                                            <c:out value="${licenseInfo.capacitiesMap[capacity].label}" />:
                                                        </label>
                                                    </td>
                                                    <td style="width:15%">
                                                        <c:out value="${licenseInfo.capacitiesMap[capacity].capacityStr}" />
                                                        <c:if test="${limitsUsed[capacity] != null}">
                                                            <fmt:message key="licenseOverview_used_P1"
                                                                bundle="${license_Messages}">
                                                                <fmt:param value="${limitsUsed[capacity]}" />
                                                            </fmt:message>
                                                        </c:if>
                                                    </td>
                                                    <td style="width:30%"></td>
                                                </tr>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            
                            </table><hr/>
                            <!-- 
                            <table class="UI Table Properties">
                                <col class="LabelCol">
                                <col>
                                    <tr>
                                        <td style="width:20%">
                                            <label class="UI Label Inline">
                                                <fmt:message key="wizardSummary_productFeatures_title" bundle="${license_Messages}" />
                                            </label>
                                        </td>
                                        <td style="width:80%">                                      
                                            <c:forEach var="feature" items="${licenseInfo.featureNames}">
                                                <c:if test="${not licenseInfo.featuresMap[feature].deprecated}">
                                                    <c:choose>
                                                        <c:when test="${licenseInfo.featuresMap[feature].enabled}">
                                                            <span class="UI Icon Feature Yes"><c:out value="${licenseInfo.featuresMap[feature].label}" /></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="UI Icon Feature No"><c:out value="${licenseInfo.featuresMap[feature].label}" /></span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>                                           
                            </table>  
                             -->                                  
                        </div>
                    </c:if>
                </syswf:block>
                <syswf:block className="UI Block Common">
                    <div class="Content">
                        <fmt:message key="licenseOverview_enterLicenseKey_caption" var="enterLicenseKeyCaption" bundle="${license_Messages}" /> 
                        <syswf:control targetTask="/common/license/enterKey" caption="${enterLicenseKeyCaption}" mode="anchor">
                            <syswf:attribute name="class" value="UI PageAction Edit" />
                        </syswf:control> 
                    </div>
            </syswf:block>