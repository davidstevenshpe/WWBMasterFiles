<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%--Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.rating.ratingmessages" var="rating_Message"/>

<%-- Get Message --%>
<fmt:message key="rating.title" var="title" bundle="${rating_Message}"/>
<fmt:message key="rating.loader" var="loader" bundle="${rating_Message}"/>
<fmt:message key="rating.votesTotal" var="votesTotal" bundle="${rating_Message}"><fmt:param value="${rating.voteCount}" /></fmt:message>
<fmt:message key="rating.voted" var="ratingVoted" bundle="${rating_Message}"><fmt:param value="${rating.myVote.vote}" /></fmt:message>

<syswf:control mode="script" affects="." caption="${prefix}reload" action="vote"/>

<c:if test="${not empty domainLabel}">
	<div class="domain-text-page">
		<span>Located in</span>
		<span id="${prefix}_changeDomain" style="cursor:pointer;">${domainLabel}</span>
	</div>
</c:if>

<span class="rate-info">${votesTotal}</span>

<c:forEach begin="1" end="5" var="i">
   <fmt:message var="hint" key="rating.starHint" bundle="${rating_Message}">
   		 <fmt:param value="${i}" />
		 <c:choose>
			<c:when test="${not empty rating.myVote.vote}">
				 <fmt:param value="${ratingVoted} " />
			</c:when>
			<c:otherwise>
				 <fmt:param value="" />
			</c:otherwise>
		</c:choose>   		
    </fmt:message>
    <span><a id="${prefix}-${i}" class="EA-icon-star-vote<c:if test="${(rating.rating + 0.5) >= i}">d</c:if> vorable" href="javascript:void(0)" title="${hint}" onclick="${prefix}reload({rate: ${i}});">&nbsp;</a></span>
</c:forEach>
    <script type="text/javascript">
//<![CDATA[
          
           $('#${prefix} span a.vorable').hover(function(){
	    	   var iHover = 1;	   
	    	   try{
	    		   iHover = $(this).attr('id').split('-')[1];
	    	   }catch(e){
	    	   }
        	   for(var i = 1; i <= 5; i++){
        		   $('#${prefix}-' + i).addClass('EA-hov-star-vote' + (i<=iHover?'d':''));
        	   }
           },function(){
	    	   var iHover = 1;    	   
	    	   try{
	    		   iHover = $(this).attr('id').split('-')[1];
	    	   }catch(e){
	    	   }
        	   for(var i = 1; i <= 5; i++){
        		   $('#${prefix}-' + i).removeClass('EA-hov-star-vote' + (i<=iHover?'d':''));
        	   }
           });
    //]]>
</script>

<c:set var="editDomainComponent">
    <syswf:component name="/core/impl/bulk/edit/domain" prefix="d" wrap="false">
        <syswf:param name="controlName" value="${prefix}d" />
        <syswf:param name="artifact" value="${artifact}" />
    </syswf:component>
</c:set>

<c:if test="${fn:length(fn:trim(editDomainComponent)) > 0}">

	<c:out value="${editDomainComponent}" escapeXml="false" />

	<script type="text/javascript">
//<![CDATA[
          Ext.onReady(function(){
        	attachOn('${prefix}_changeDomain', 'click', ${prefix}d);
           	moveWindow('${prefix}_d_dw', 'popupWindows');
          });
          
    //]]>
</script>

</c:if>


