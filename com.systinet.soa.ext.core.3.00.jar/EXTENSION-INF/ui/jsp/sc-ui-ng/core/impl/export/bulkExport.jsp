<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<div class="hp-export-dialog">
<syswf:component name="/core/window" prefix="w">
    <syswf:param name="winTitle" value="Export" />
    <syswf:param name="winComponent" value="/core/export/exportArtifactWindow" />
    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
    <syswf:param name="winOkLabel" value="Export" />
    <syswf:param name="winOkAction" value="${prefix}export" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="winRenderContents" value="true" />
    
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="type" value="${type}" />
</syswf:component>
</div>

<syswf:control mode="script" action="export" caption="${prefix}export" />

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    ${prefix}open();
}

//]]>
</script>