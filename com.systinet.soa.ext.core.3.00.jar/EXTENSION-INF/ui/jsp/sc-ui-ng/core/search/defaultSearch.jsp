<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:control id="${prefix}defaultSearch" mode="script" targetTask="/common/${this.defaultSearch}" caption="${prefix}defaultSearch">
</syswf:control>
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
    	${prefix}defaultSearch();
    	return false;
    });

//]]>
</script>