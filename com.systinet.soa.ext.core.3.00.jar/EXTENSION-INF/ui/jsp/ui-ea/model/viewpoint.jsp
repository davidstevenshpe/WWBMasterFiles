<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<syswf:component name="/data/js" prefix="js">
    <syswf:param name="sourceId" value="UIHandler"/>
    <syswf:param name="code">
        function getTaskProgress(task)
        {
            return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskProgressJSON(task);
        }

        function getTaskResults(task)
        {
            return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskResult(task);
        }

        function getDependencyAnalysis(uuid,resultTypes,style)
        {
            return Packages.com.hp.systinet.ea.ui.widgets.ImpactAndDependencyAnalyzer.getInstance().getDependencyAnalysis(uuid,resultTypes,style, 'true');
        }
    </syswf:param>
</syswf:component>


<script type="text/javascript" >

//<![CDATA[

<c:choose>
	<c:when test="${empty this.viewPoint.meta}">
		META_<c:out value='${id}'/> = {};
		var viewPointLocation_${id} = "<c:out value='${webContext}'/>/svg/viewPoints/notfound.svg";
	</c:when>
	<c:otherwise>
		META_<c:out value='${id}'/>=<c:out escapeXml="false" value='${this.viewPoint.meta}'/>;
		var viewPointLocation_${id} = "<c:out value='${this.viewPoint.location}'/>";
	</c:otherwise>
</c:choose>

//]]>

</script>

<object class="embed-svg" id="embed_<c:out value='${id}'/>" type="image/svg+xml"></object>