<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
//<![CDATA[
           
<c:set var="extRes">
	<c:if test="${not empty styles}">
	var extNiftyStyles = ${styles};
	for(var i = 0; i < extNiftyStyles.length; i++) niftyStyles.push(wr + extNiftyStyles[i]);
	</c:if>
	<c:if test="${not empty scripts}">
	var extNiftyScripts = ${scripts};
	for(var i = 0; i < extNiftyScripts.length; i++) niftyScripts.push(wr + extNiftyScripts[i]);
	</c:if>
    layoutManager.loadStyle(niftyStyles);
    layoutManager.loadScript(niftyScripts<c:if test="${not empty callback}">, ${callback}</c:if>);
</c:set>
if(!layoutManager.nifty) {
    <c:if test="${not empty ngApp}">
    document.getElementsByTagName('html')[0].setAttribute('ng-app', '${ngApp}');
    </c:if>
    var wr = '<c:out value='${webResourcePath}'/>', niftyStyles = [], niftyScripts = [];
    niftyScripts[0] = wr + '/skinem/bootstrap/js/bootstrap.min.js';
    niftyStyles[0] = wr + '/skinem/bootstrap/css/bootstrap.min.css';
    niftyStyles[1] = wr + '/skinem/bootstrap/css/nifty.min.css';
    niftyStyles[2] = wr + '/skinem/bootstrap/css/em.css';
	layoutManager.nifty = true;
	${extRes}
} else {
	var wr = '<c:out value='${webResourcePath}'/>', niftyStyles = [], niftyScripts = [];
	${extRes};
}
//]]>
</script>