<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div id="<c:out value="${prefix}" />">
<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%--Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.favorites.favoritesmessages" var="fav_Message"/>

<%-- Get Message --%>
<c:if test="${empty addCaption}">
    <fmt:message var="addCaption" key="add_caption" bundle="${fav_Message}"/>
</c:if>
<c:if test="${empty addHint}">
    <fmt:message var="addHint" key="add_hint" bundle="${fav_Message}"/>
</c:if>
<c:if test="${empty addClassName}">
    <c:choose>
        <c:when test="${mode eq 'table'}">
            <c:set var="addClassName" value="ControlIcon Favorite IsNotFavorite" />
        </c:when>
        <c:otherwise>
            <c:set var="addClassName" value="EA-right-panel" /> <%--UI PageAction AddFavorite  --%>
        </c:otherwise>
    </c:choose>
</c:if>
<c:if test="${empty removeCaption}">
    <fmt:message var="removeCaption" key="remove_caption" bundle="${fav_Message}"/>
</c:if>
<c:if test="${empty removeHint}">
    <fmt:message var="removeHint" key="remove_hint" bundle="${fav_Message}"/>
</c:if>
<c:if test="${empty removeClassName}">
    <c:choose>
        <c:when test="${mode eq 'table'}">
            <c:set var="removeClassName" value="ControlIcon Favorite IsFavorite" />
        </c:when>
        <c:otherwise>
            <c:set var="removeClassName" value="EA-right-panel" /> <%--UI PageAction RemoveFavorite --%>
        </c:otherwise>
    </c:choose>
</c:if>

<c:choose>
    <c:when test="${this.favAction eq 'addFavorite'}">
        <c:set var="caption" value="${addCaption}" />
        <c:set var="hint" value="${addHint}" />
        <c:set var="className" value="${addClassName}" />
    </c:when>
    <c:otherwise>
        <c:set var="caption" value="${removeCaption}" />
        <c:set var="hint" value="${removeHint}" />
        <c:set var="className" value="${removeClassName}" />
    </c:otherwise>
</c:choose>

<syswf:control action="${this.favAction}" mode="script" caption="${prefix}_ajax" affects=".">
    <syswf:param name="uuid" value="${this.uuid}"/>
    <syswf:attribute name="class" value="${className}"/>
</syswf:control>

<%-- <a id="<c:out value="${prefix}" />_link" href="javascript:void(0);" title="<c:out value="${hint}"/>" class="<c:out value="${className}"/>"><span><c:out value="${caption}" /></span></a> --%>
<a id="<c:out value="${prefix}" />_link" href="javascript:void(0);" title="<c:out value="${hint}"/>" class="<c:out value="${className}"/>">
	<c:if test="${mode ne 'table'}">	
		<c:out value="${caption}" />
	</c:if>
</a>
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){ Ext.get('<c:out value="${prefix}" />_link').on('click', ${prefix}_ajax); });

//]]>
</script>
</div>