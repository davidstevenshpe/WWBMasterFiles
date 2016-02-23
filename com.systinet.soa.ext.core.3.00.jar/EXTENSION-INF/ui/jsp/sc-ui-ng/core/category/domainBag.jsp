<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="title" type="String"--%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.edit.EditMessages" var="editMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uiComponentMessages"/>

<%--@elvariable id="this" type="com.hp.systinet.sc.ui.category.DomainBagComponent"--%>
<%--@elvariable id="selectedDomainsBean" type="com.hp.systinet.sc.ui.category.DomainBagComponent.SelectedDomainsBean"--%>
<c:if test="${mode eq 'edit' || not empty this.domains}">

<c:set var="titleVar">
    <c:choose>
        <c:when test="${empty title}">
            <fmt:message key="domainBag.title" bundle="${widgetMessages}"/>
        </c:when>
        <c:otherwise>
            <c:out value="${title}"/>
        </c:otherwise>
    </c:choose>
</c:set>

<c:set var="content">
    <div class="Content">
    <table class="UI Table Properties">
        <col/>
        <tbody>
        <c:choose>
        
            <c:when test="${empty this.domains and not empty forceAllForEmpty }">
                <tr>
                    <td><fmt:message key="domainBag.all.domains" bundle="${uiComponentMessages}"/></td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach items="${this.domains}" var="item" varStatus="stat">
		            <tr>
		                <td>
		                    <%-- settings as variable to ensure there is no space before comma --%>
		                    <c:set var="itemValue">
		                        <c:out value="${item.name}" />
		
		                        <c:if test="${mode eq 'edit'}">
		                            <fmt:message key="domainBag.delete" bundle="${widgetMessages}" var="delete"/>
		                            <syswf:control id="remove${item.domainId}" mode="anchor" action="remove" caption="${delete}" wrapper="span">
		                                <syswf:param name="domainId" value="${item.domainId}"/>
		                                <syswf:attribute name="class" value="UI Icon Delete Context"/>
		                            </syswf:control>
		                        </c:if>
		                    </c:set>
		
		                    <c:out value="${itemValue}" escapeXml="false"/>
		                    <c:choose>
		                        <c:when test="${category.showParents}"><br/></c:when>
		                        <c:when test="${not stat.last}">,</c:when>
		                    </c:choose>
		                </td>
		            </tr>
		        </c:forEach>
            </c:otherwise>
        </c:choose>
        
        </tbody>
    </table>
    </div>
    <div class="Title">
    <c:if test="${mode eq 'edit'}">
        <a href="javascript:void(0)" id="editDomainId" class="UI Icon ${not empty iconType ? iconType : 'Edit'}">
            <fmt:message key="editDomains" bundle="${widgetMessages}" var="default" />
            <c:out value="${buttonText}" default="${default}" />
        </a>
    </c:if>
    </div>
</c:set>

<c:choose>
<c:when test="${empty doNotWrap}">
<syswf:block className="UI Block Common">
<div class="Title">
    <h3>
        <span><c:out value="${titleVar}"/></span>
    </h3>
</div>
${content}
</syswf:block>
</c:when>
<c:otherwise>
${content}
</c:otherwise>
</c:choose>

</c:if>

<c:if test="${mode eq 'edit'}">
<syswf:control mode="script" caption="onDomainsSelection" action="onDomainsSelection"/>
<syswf:control mode="script" caption="onCancel" action="onCancel" />


<fmt:message key="selectDomains" bundle="${widgetMessages}" var="winTitle" />

<syswf:component name="/core/window" prefix="domainsPopup">
    <syswf:param name="winId" value="selectDomains_win"/>
    <syswf:param name="winTitle">${winTitle}</syswf:param>
    <syswf:param name="winComponent" value="/core/category/domainSelectionContent"/>
    <syswf:param name="winOpenFunctionName" value="edit_Domains_Open"/>
    <syswf:param name="winOkAction" value="onDomainsSelection"/>
    <syswf:param name="winCancelAction" value="onCancel"/>
    <syswf:param name="winRenderContents" value="true"/>
    <syswf:param name="selectedDomainsBean" value="${selectedDomainsBean}"/>
    <syswf:param name="uuid" value="${uuid}"/>
    <%--<syswf:param name="winHeight" value="300" />--%>
    <%--<syswf:param name="winForceRefresh" value="false" />--%>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        attachOn('editDomainId', 'click', edit_Domains_Open);
    });

//]]>
</script>
</c:if>