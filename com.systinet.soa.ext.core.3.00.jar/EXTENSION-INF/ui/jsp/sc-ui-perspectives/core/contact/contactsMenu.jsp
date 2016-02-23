<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="linkToManageContactsPageLabel" key="linkToManageContactsPageLabel" bundle="${contactmessages}"/>
<fmt:message var="linkToViewContactsPageLabel" key="linkToViewContactsPageLabel" bundle="${contactmessages}"/>
<fmt:message var="contactsMenuComponentTitle" key="contactsMenuComponentTitle" bundle="${contactmessages}"/>
<fmt:message var="contactDetailLinkLabel" key="contactDetailLinkLabel" bundle="${contactmessages}"/>
<fmt:message var="contactsMenuComponentError" key="contactsMenuComponentError" bundle="${contactmessages}">
    <fmt:param value="${artifact._artifactSdmName}"/>
    <fmt:param value="providedBy"/>
</fmt:message>

<%-- fix defect #52438 --%>
<c:if test="${not emptyContactsList or (not this.readOnly and hasWritePermission)}">    
        <div class="EA-right-panel">
           	<syswf:out value="${contactsMenuComponentTitle}" context="HtmlBody"/>
            <c:choose>
                <c:when test="${artifactTypeNotSupported}">
                    <div class="UI SystemMessage Error">
                        <div class="MessageContainer">
                            <div class="Text">${contactsMenuComponentError}</div>
                            <div class="x-clear"></div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="Content">
                        <ul class="UI Contacts">
                            <c:forEach var="useType" items="${this.contactsMap}">
                                <li>
                                    <c:set var="useTypeName" value="${this.useTypeValueNameMap[useType.key]}"/>
                                    <span><syswf:out value="${useTypeName}" context="HtmlBody"/></span>
                                    <ul>
                                        <c:set var="contactsList" value="${this.contactsMap[useType.key]}"/>
                                        <c:set var="numberOfContacts" value="${this.contactCounts[useType.key]}"/>
                                        <c:choose>
                                            <c:when test="${this.maximumVisibleItems < 1}">
                                                <c:set var="iterationLimit" value="${numberOfContacts}"/>
                                                <c:set var="exceedingNumberOfContacts" value="0"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="iterationLimit" value="${this.maximumVisibleItems - 1}"/>
                                                <c:set var="exceedingNumberOfContacts" value="${numberOfContacts - this.maximumVisibleItems}"/>
                                            </c:otherwise>
                                        </c:choose>                                    
                                        <c:forEach var="contactEntry" items="${contactsList}" varStatus="status" begin="0" end="${iterationLimit}">
                                            <li>
                                                <div class="x-hidden flyout-menu UI Dropdown" id="contact_${useType.key}_${status.index}_content">
                                                    <div class="DropdownTitle">
                                                        <h3><c:out value="${contactEntry.name}"/></h3>
                                                    </div>
                                                    <div class="DropdownContent">
                                                        <c:forEach var="email" items="${contactEntry.emails}">
                                                            <a href="mailto:${email}" class="UI Icon Email">
                                                                <span><c:out value="${email}"/></span>
                                                            </a>
                                                            <br/>
                                                        </c:forEach>
                                                        <c:forEach var="phone" items="${contactEntry.phones}">
                                                            <span class="UI Icon Phone"><c:out value="${phone}"/></span>
                                                            <br/>
                                                        </c:forEach>
                                                        <p class="Comment"><c:out value="${contactEntry.description}" escapeXml="false"/></p>
                                                    </div>
                                                    <div class="DropdownFooter">
                                                        <hr/>
                                                        <syswf:control id="contact_${useType.key}_${status.index}_innerLink" mode="anchor" caption="${contactDetailLinkLabel}" targetTask="/artifact/${contactEntry.uuid}" wrapper="span"/>
                                                    </div>
                                                </div>                                            
                                                <syswf:control id="contact_${useType.key}_${status.index}" mode="anchor" caption="${contactEntry.name}" targetTask="/artifact/${contactEntry.uuid}" wrapper="span">                                            
                                                    <syswf:attribute name="id" value="contact_${useType.key}_${status.index}"/>
                                                </syswf:control>
                                                <script type="text/javascript">
//<![CDATA[

                                                    Ext.onReady(function(){ Dropdown.init('contact_${useType.key}_${status.index}','contact_${useType.key}_${status.index}_content',{align:'tr-tl?'}); });
                                                
//]]>
</script>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${exceedingNumberOfContacts > 0}">
                                            <li>                                                    
                                                <span>                                               
                                                    <fmt:message key="contactsMenuComponentMoreContacts" bundle="${contactmessages}">
                                                        <fmt:param value="${exceedingNumberOfContacts}"/>
                                                    </fmt:message>
                                                </span>
                                            </li>
                                        </c:if>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="Footer">
                        <c:choose>
                            <c:when test="${not readOnly and hasWritePermission}">
                                <c:set var="contactsPageLinkLabel" value="${linkToManageContactsPageLabel}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="contactsPageLinkLabel" value="${linkToViewContactsPageLabel}"/>
                            </c:otherwise>
                        </c:choose>
                    
                        <c:choose>
                            <c:when test="${moreMode == 'tabs'}">
                                <syswf:control id="linkToContactsTask" mode="anchor" caption="${contactsPageLinkLabel}" hint="" targetTask="/artifact/${this.uuid}" wrapper="span">
                                    <c:if test="${not readOnly and hasWritePermission}"><syswf:attribute name="class" value="UI Icon Edit"/></c:if>
                                    <syswf:param name="artifactTabId" value="contacts"/>
                                </syswf:control>
                            </c:when>
                            <c:otherwise>
                                <syswf:control id="linkToContactsTask" mode="anchor" caption="${contactsPageLinkLabel}" hint="" targetTask="/common/artifact/contacts" wrapper="span">
                                    <c:if test="${not readOnly and hasWritePermission}"><syswf:attribute name="class" value="UI Icon Edit"/></c:if>
                                    <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
                                    <syswf:param name="artifactLocalName" value="${artifact._artifactSdmName}"/>
                                </syswf:control>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
</c:if>