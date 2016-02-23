<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<fmt:message var="label" key="survey.mark.completed.label" bundle="${messages}"/>

<syswf:control caption="${prefix}_markCompleted" mode="script" action="markCompleted">
</syswf:control>

<c:choose>
	<c:when test="${contextMenu}">
		<div class="EA-right-panel">
			<a id="markCompleted" href="javascript:void(0);" class="UI PageAction MarkCompleted">${label}</a>
		</div> 	
	</c:when>
	<c:otherwise>
		<a id="markCompleted" href="javascript:void(0);" class="with-text context-button MarkCompleted">
           	<span>${label}</span>
        </a>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${this.completed or not this.permissions.write}">
<script type="text/javascript">
    
//<![CDATA[

    Ext.onReady(function() {
        $('a.with-text.context-button.MarkCompleted').css('opacity', '0.6');
    });
	
//]]>

</script>	
	</c:when>
	<c:otherwise>
<script type="text/javascript">
    
//<![CDATA[

    Ext.onReady(function() {
        attachOn('markCompleted', 'click', ${prefix}_markCompleted);
    });
	
//]]>

</script>	
	</c:otherwise>
</c:choose>