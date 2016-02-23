<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>

<a href="${this.href}" id="${prefix}win">${this.value}</a>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
	${prefix}w = new Ext.Window({
	    title: '<fmt:message bundle="${messages}" key="duplicates.locationbrowser.title" />',
	    height: 600,
	    width: 900,
	    bodyCfg: {
	        tag: 'iframe',
	        src: '${this.href}',
	        style: 'border: 0 none'
	    }
	});
    attachOn('${prefix}win','click',function(event) { ${prefix}w.show(); event.preventDefault(); event.stopPropagation(); });
});

//]]>
</script>