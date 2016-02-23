<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<c:set var="specificationValue" value="${fn:replace(specificationBean.specification, newLineChar, '')}"/>
<base target="_parent">
<c:out value="${specificationValue}" escapeXml="false"/>
<script type="text/javascript">
//<![CDATA[
var body = document.getElementsByTagName("body")[0];
body.addEventListener("load", prepareContent(), false);
function prepareContent() {
        var regex= new RegExp(/^#[\w-_ ]+/);
        var anchors = document.getElementsByTagName('a');
        for(var i=0;i<anchors.length;i++){
            var attrHref = anchors[i].getAttribute('href');
            if(attrHref!=null&&attrHref.match(regex)&&anchors[i].target==''){
                anchors[i].target='_self';
            }
        }
};
//]]>
</script>