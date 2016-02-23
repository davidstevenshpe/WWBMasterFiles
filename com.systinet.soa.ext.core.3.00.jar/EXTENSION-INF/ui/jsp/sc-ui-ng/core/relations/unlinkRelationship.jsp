<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="title" bundle="${relationshipmessages}" key="confirm.window.title"/>
<fmt:message var="message" bundle="${relationshipmessages}" key="confirm.window.message">
	<fmt:param><syswf:out value="${artifact.name}" context="HtmlJSText"/></fmt:param>
</fmt:message>

<fmt:message var="unlinkText" bundle="${relationshipmessages}" key="unlink.text"/>
<fmt:message var="btnLink" bundle="${relationshipmessages}" key="confirm.window.btn.link"/>
<fmt:message var="btnCancel" bundle="${relationshipmessages}" key="confirm.window.btn.cancel"/>

<a id="${prefix}unlink" class="UI PageAction Delete" href="javascript:void(0);"><span>${unlinkText}</span></a>
<syswf:control mode="script" action="unlink" caption="${prefix}unlink"/>
<script type="text/javascript">
//<![CDATA[
	Ext.onReady(function(){
	    attachOn('${prefix}unlink','click',function() {
	    	
	    	Ext4.MessageBox.show({
	            title: '${title}',
	            msg: '${message}',
	            buttons: Ext4.MessageBox.YESNO,
	            buttonText:{ 
	                yes: '${btnLink}', 
	                no: '${btnCancel}' 
	            },
	            icon: Ext4.MessageBox.QUESTION,
	            fn: function(btn){
	            	if(btn == 'yes'){
	            		${prefix}unlink();
	            	}
	            }
	        });
	    });
	});
//]]>
</script>    
