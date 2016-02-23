<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="providerPropertyLabel" key="providerPropertyLabel" bundle="${contactmessages}"/>
<fmt:message var="changeProviderLinkLabel" key="changeProviderLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="clearProviderLinkLabel" key="clearProviderLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="setProviderLinkLabel" key="setProviderLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="changeProviderDialogTitle" key="changeProviderDialogTitle" bundle="${contactmessages}"/>
<fmt:message var="noteInChangeProviderDialogLabel" key="noteInChangeProviderDialogLabel" bundle="${contactmessages}"/>
<fmt:message var="warningInChangeProviderDialog" key="warningInChangeProviderDialog" bundle="${contactmessages}"/>
<fmt:message var="changeProviderDialogSuggestSearchLegend" key="changeProviderDialogSuggestSearchLegend" bundle="${contactmessages}"/>
<fmt:message var="changeProviderDialogNewContactLink" key="changeProviderDialogCreateNewContactLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewUserProfileLinkLabel" key="addContactDialogCreateNewUserProfileLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="addContactDialogCreateNewOrgUnitLinkLabel" key="addContactDialogCreateNewOrgUnitLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="changeProviderDialogCloseButtonCaption" key="changeProviderDialogCloseButtonCaption" bundle="${contactmessages}"/>
<fmt:message var="providerComponentError" key="providerComponentError" bundle="${contactmessages}">
    <fmt:param value="${artifact._artifactSdmName}"/>
    <fmt:param value="providedBy"/>
</fmt:message>


<table class="UI Table Properties" summary="">
    <colgroup>
        <col class="LabelCol"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <th>
                <label class="UI Label Inline" title="">${providerPropertyLabel}</label>
            </th>
            <td><span class="IconAlign">
            
                <c:choose>
                    <c:when test="${artifactTypeNotSupported}">
                        <div class="UI SystemMessage Error">
                            <div class="MessageContainer">
                                <div class="Text">${providerComponentError}</div>
                                <div class="x-clear"></div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>                       
            
                        <c:if test="${not empty this.artifactLinkHolders}">
                            <c:forEach items="${this.artifactLinkHolders}" var="linkHolder" varStatus="status">
                                <c:choose>
                                    <c:when test="${linkHolder.sdmName eq 'personArtifact'}">
                                        <c:set var="class" value="UI Icon Contact"/>
                                    </c:when>
                                    <c:when test="${linkHolder.sdmName eq 'organizationUnitArtifact'}">
                                        <c:set var="class" value="UI Icon OrganizationUnit" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="class" value="UI Icon Leaf" />
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${not status.last}">
                                        <c:set var="suffix" value=", " />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="suffix" value="" />
                                    </c:otherwise>
                                </c:choose>
                                <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="${status.count}" wrap="${wrap}">
                                        <syswf:param name="uuid" value="${linkHolder.uuid}" />
                                        <syswf:param name="caption" value="${linkHolder.name}" />
                                        <syswf:param name="timeSlice" value="${linkHolder.timeSlice}" />
                                        <syswf:param name="class" value="${class}" />
                                        <syswf:param name="suffix" value="${suffix}" />
                                    </syswf:component>
                            </c:forEach>
                        </c:if>                      

                        <c:if test="${hasWritePermission and not this.readOnly}">
                        	&nbsp;(
                            <a href="javascript:void(0);" id="${prefix}change_provider">
                                <span>
                                    <c:choose>
                                        <c:when test="${empty this.artifactLinkHolders}">${setProviderLinkLabel}</c:when>
                                        <c:otherwise>${changeProviderLinkLabel}</c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                            
                            <c:if test="${not empty this.artifactLinkHolders}" >
                            	,&nbsp;
	                            <a href="javascript:void(0)"  id="${prefix}ClearProvider">
	                            	<span>
	                            		<c:out value="${clearProviderLinkLabel}" />
	                            	</span>
	                            </a>
	                            
	                            <syswf:control mode="script" id="${prefix}C" caption="${prefix}C" action="clear" affects="." />
	                            
	                            <script type="text/javascript">
//<![CDATA[

	                                Ext.get('${prefix}ClearProvider').on('click', function() {
	                                    ${prefix}C();
	                                });
	                            
//]]>
</script>
	                            
	                        </c:if>
                            )

                            <syswf:component name="/core/selector/providerSelector" prefix="addContactWindow">
                                <syswf:param name="openFceName" value="${prefix}OpenSelector"/>
                                <syswf:param name="providerSelectorListener" value="${providerSelectorListener}"/>
                                <syswf:param name="affectsOnSelection" value="${prefix}"/>
                                <syswf:param name="submitBeforeCreation" value=".." />
                            </syswf:component>

                            <script type="text/javascript">
//<![CDATA[

                                Ext.get('${prefix}change_provider').on('click', function() {
                                    ${prefix}OpenSelector();
                                });
                            
//]]>
</script>
                            

                        </c:if>

                    </c:otherwise>
                </c:choose>
			</span>
            </td>
        </tr>
    </tbody>
</table>