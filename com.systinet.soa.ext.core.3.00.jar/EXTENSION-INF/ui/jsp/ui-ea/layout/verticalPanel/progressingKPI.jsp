<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="panelStyle">
<c:if test="${fn:startsWith(color, '#')}">
background-color:${color}
</c:if>
</c:set>
<c:set var="panelClass">
<c:if test="${not fn:startsWith(color, '#')}">
bg-${color}
</c:if>
</c:set>
<div class="panel media pad-all mar-no ${panelClass}" style="${panelStyle}">
	<div class="media-left">
		<span class="icon-wrap icon-wrap-sm icon-circle"> <i
			class="fa fa-${icon} fa-2x"></i>
		</span>
	</div>
	<div class="media-body">
		<p class="h3 text-thin media-heading" id="${prefix}-number"></p>
		<div class="text-uppercase"> <c:out value="${label}" />
		</div>
	</div>
	<div class="progress progress-xs progress-dark-base">
		<div role="progressbar" aria-valuemin="0"
			aria-valuemax="100" class="progress-bar progress-bar-light" id="${prefix}-progress-number"></div>
	</div>
	<div>
		<div class="pad-btm"><em><c:out value="${text}" /></em></div>
	</div>
</div>
<script type="text/javascript">
//<![CDATA[
Ext4.onReady(function(){
    var dqlStore=Ext4.create('EA.model.tools.DQLStore', { 
        query: "<query>${dql}</query>", 
        fields: []
    });
    dqlStore.on('load', function(res) {
        if(res.data.items[0] !== undefined && res.data.items[1] !== undefined) {
            var actual = res.data.items[0].raw.numberArtifact;
            var total = res.data.items[1].raw.numberArtifact;
            if(actual !== undefined && total !== undefined) {
                var result = 0;
                if(total !== 0) {
                    result = Math.round(actual*100/total);
                }
                var per = result + '%';
                $('#${prefix}-number').text(per);
                $('#${prefix}-progress-number').css('width', per);
            }
        }
    });
    dqlStore.load();
});
//]]>
</script>