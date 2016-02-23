<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messagess"/>

<c:choose>
    <c:when test="${errorOccured}">
        <div class="UI SystemMessage Error">
            <div class="MessageContainer">
                <div class="Text">
                    <fmt:message key="async_processing_exception_P2" bundle="${frameworkJsp_Messagess}">
                        <fmt:param value="${asyncResult.cause.message}"/>
                        <fmt:param value="${componentName}"/>
                    </fmt:message>
                </div>
                <div class="x-clear"></div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <syswf:component prefix="async" name="${asyncComponentName}">
            <syswf:paramSet value="${asyncComponentParams}"/>
            <syswf:param name="running" value="${running}"/>
        </syswf:component>
        <c:if test="${running}">

            <syswf:control mode="script" affects="." caption="${prefix}_refresh" action="refresh"/>

            <c:choose>
                <c:when test="${refreshInterval > 0}">
                    <script type="text/javascript">
//<![CDATA[


                        if (${prefix}_timeout) {
                            clearTimeout(${prefix}_timeout);
                        }

                        var ${prefix}_timeout;

                        Ext.onReady(function(){
                            var compEl = Ext.get('${prefix}_async');
                            var myMask = new Ext.LoadMask(compEl);
                            myMask.show();
                            ${prefix}_timeout = setTimeout('${prefix}_refresh()', ${refreshInterval});
                        });
                    
//]]>
</script>
                </c:when>
                <c:otherwise>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function(){
                            var compEl = Ext.get('${prefix}_async');
                            var myMask = new Ext.LoadMask(compEl);
                            myMask.show();
                            ${prefix}_refresh();
                        });
                    
//]]>
</script>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:otherwise>
</c:choose>

