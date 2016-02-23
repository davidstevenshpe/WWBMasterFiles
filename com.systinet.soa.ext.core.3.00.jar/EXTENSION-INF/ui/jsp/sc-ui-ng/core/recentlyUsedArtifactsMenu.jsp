<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    <c:if test='${not empty dropToLeft}'>
	    	Ext.get('${prefix}usedArtifact').setStyle('left','auto');
	    	Ext.get('${prefix}usedArtifact').setStyle('right','0px');
	    </c:if>
	});
                
//]]>
</script>

<c:if test="${not empty this.links}">
	<c:forEach items="${this.links}" var="link" varStatus="status">
		<c:if test="${not link.deleted}">
			
			<c:set var="fixedLength" value="25"/>
			<c:set var="itemName" value="${link.name}"/>
			<c:if test="${fn:length(itemName) > fixedLength}">
				<c:set var="itemName" value="${fn:substring(link.name,0,fixedLength)}..."/>
				<c:set var="title" value="${link.name}"/>
			</c:if>
							
			<li>
                <syswf:control mode="anchor" targetTask="${link.url}" caption="${itemName}" targetDepth="0" id="${status.index}_name">
                    <c:if test="${not empty link.params}">
                        <syswf:paramSet value="${link.params}"/>
                    </c:if>
                    <c:if test="${not empty title and fn:length(title) > 0}">
                        <syswf:attribute name="title" value="${title}" />
                        <c:set var="title" value=""/>
                    </c:if>
                    <syswf:attribute name="class" value="menu-artifact-name" />
                </syswf:control>
                <c:choose>
                    <c:when test="${not empty link.sdmName}">
                        <syswf:control mode="anchor" targetTask="${link.url}" caption="${link.artifactLabel}" targetDepth="0" id="${status.index}_type" wrapper="em">
                            <c:if test="${not empty link.params}">
                                <syswf:paramSet value="${link.params}"/>
                            </c:if>
                            <syswf:attribute name="class" value="menu-artifact-type" />
                        </syswf:control>
                    </c:when>
                    <c:otherwise>
                        <div>&nbsp;</div>
                    </c:otherwise>
                </c:choose>
		    </li>
	    </c:if>
	</c:forEach>
</c:if>