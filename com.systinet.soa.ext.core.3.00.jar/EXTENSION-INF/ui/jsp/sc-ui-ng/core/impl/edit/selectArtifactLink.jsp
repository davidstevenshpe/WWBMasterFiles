<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        var radio = Ext.get('${dataPrefix}_selectionRow${rowIndex}_0');
    	radio.on('click', function() {
            ${selectFunctionName}('${name}', '${uuid}');
    	});
    })    

//]]>
</script>