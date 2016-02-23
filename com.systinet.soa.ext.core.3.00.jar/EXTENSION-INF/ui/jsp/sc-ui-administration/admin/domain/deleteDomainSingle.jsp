<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<a href="javascript:void(0)" class="context-button Remove" id="${prefix}_actionLink" title="${title}"></a>

<c:set var="controlName" value="deleteDomains" />
<syswf:component name="/admin/domain/bulk/deleteDomain" prefix="deleteSingle">
	<syswf:param name="singlePrincipal" value="${uuid}" />
	<syswf:param name="controlName" value="${controlName}" />
	<syswf:param name="domainName" value="${domainName}" />		
</syswf:component>


<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        attachOn('${prefix}_actionLink', 'click', ${controlName});
    });

//]]>
</script>
