<%--
Parameters:
    savedSearchDefinition - instance of search to be shown
    nameMustNotBeEmpty - if true, warning that name can't be empty has to be shown
    showAtomFeed - by default false
    showUrl - if true, url is shown
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<fmt:message var="searchCriteriaLabel" key="search.searchCriteria" bundle="${searchmessages}" />
<fmt:message var="nameLabel" key="Name" bundle="${messages}" />
<fmt:message var="nameMustNotBeEmptyLabel" key="search.emptyMustNotBeEmpty" bundle="${searchmessages}" />
<fmt:message var="searchUrlLabel" key="search.searchUrl" bundle="${searchmessages}" />
<fmt:message var="searchFeedUrlLabel" key="search.searchFeedUrl" bundle="${searchmessages}" />
<fmt:message var="searchSharedSearchLabel" key="search.sharedSearch" bundle="${searchmessages}" />


<c:if test="${not empty savedSearchDefinition}" >
    <table class="UI Layout SearchSaveProperty">
        <colgroup>
            <col class="PropertyName" />
            <col />
        </colgroup>
        <tbody>
            <tr>
                <th>
                    <label for="searchsave_name"><c:out value="${nameLabel}"/>:</label>
                </th>
                <td>
                    <syswf:input id="${prefix}Name" name="searchName" value="${savedSearchDefinition}" property="name">
                        <c:if test="${nameMustNotBeEmpty}" >
                            <syswf:attribute name="class" value="x-form-invalid UI Input"></syswf:attribute>
                        </c:if>
						<c:if test="${savedSearchDefinition.owner != currentUser and not empty savedSearchDefinition.owner}">
							<syswf:attribute name="disabled">disabled</syswf:attribute>
						</c:if>
                    </syswf:input>
                    <c:if test="${nameMustNotBeEmpty}" >
                        <br/>
                        <em class="x-form-invalid-msg UI Invalid"><span>${nameMustNotBeEmptyLabel}</span></em>
                    </c:if>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var ${prefix}Name = new Ext.form.TextField({
                                applyTo: '${prefix}Name',
                                width: 254
                            });
                        });
                    
//]]>
</script>

                </td>
            </tr>
			<tr>
				<th></th>
				<td class="Overflow">					
						<syswf:selectOne id="${prefix}Shared" name="shared" selectClass="UI Form Checkbox Inline" value="${savedSearchDefinition}" 
	                 					property="shared" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" >
							<c:if test="${savedSearchDefinition.owner != currentUser and not empty savedSearchDefinition.owner}">
								<syswf:attribute name="disabled">disabled</syswf:attribute>
							</c:if>
							<syswf:attribute name="class" value="UI Form Checkbox" />
						</syswf:selectOne>  ${searchSharedSearchLabel}													
				</td>
			</tr>
            <c:if test="${showUrl}" >
                <tr>
                    <th>${searchUrlLabel}:</th>
                    <td class="Overflow">
                        <a href="${savedSearchDefinitionBaseUrl}${savedSearchDefinition.uuid}">${savedSearchDefinitionBaseUrl}${savedSearchDefinition.uuid}</a>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty atomFeedUrl}" >
                <tr>
                    <th>${searchFeedUrlLabel}:</th>
                    <td class="Overflow">
                        <a href="${atomFeedUrl}">${atomFeedUrl}</a>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <c:if test="${not empty filterDescriptors}">

        <h3>${searchCriteriaLabel}</h3>

        <table class="UI Layout SearchSaveProperty">
            <colgroup>
                <col class="PropertyName" />
                <col />
            </colgroup>
            <tbody>
                <c:forEach var="descriptor" items="${filterDescriptors}">
                    <tr>
                        <th>
                            <label><c:out value="${descriptor.label}" /><c:if test="${not empty descriptor.label}">:</c:if></label>
                        </th>
                        <td>
                            <c:choose>
                                <c:when test="${descriptor.descriptorType eq 'Owner'}">
                                    <c:forEach var ="value" items="${descriptor.values}" varStatus="valStatus">
	                                    <syswf:component prefix="principal_${valStatus.index}" name="/core/impl/util/principalLinkRenderer" wrap="false">
	                                         <syswf:param name="principal" value="${value}"/>
	                                         <syswf:param name="showIcon" value="${true}"/>
	                                    </syswf:component>
	                                    <c:if test="${not valStatus.last}">,</c:if>
                                    </c:forEach>
	                            </c:when>
	                            <c:when test="${descriptor.descriptorType eq 'Provider'}">
	                               <c:forEach var ="value" items="${descriptor.values}" varStatus="valStatus">
		                               <syswf:control id="Provider${valStatus.index}" mode="anchor" caption="${value.name}" targetTask="${value.url}" >
				                            <syswf:attribute name="class" value="UI Icon ${value.iconCss}" />
				                       </syswf:control>
				                       <c:if test="${not valStatus.last}">,</c:if>
			                       </c:forEach>
	                            </c:when>
	                            <c:otherwise>
	                                <c:forEach var ="value" items="${descriptor.values}" varStatus="valStatus">
	                                    <c:out value="${value}"/>
                                        <c:if test="${not valStatus.last}">
                                            ,
                                        </c:if>
                                    </c:forEach>
	                            </c:otherwise>
                            </c:choose>
                                                       
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</c:if>
