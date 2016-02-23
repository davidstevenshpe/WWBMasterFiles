<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message var="workingCaption" key="progressBarHolder.working" bundle="${widgetMessages}" />
<fmt:message var="resolveIssuesCaption" key="progressBarHolder.waiting" bundle="${widgetMessages}" />

<c:choose>
    <c:when test="${progressBar_requestSession.firstBar == progressBarId}">

        <c:set var="funcName">reloadProgressBar${progressBarId}</c:set>

        <syswf:control mode="script" action="reload" caption="${funcName}" affects=".">
            <syswf:param name="funcName" value="${funcName}"/>
            <syswf:param name="progressBar_requestSession" value="${progressBar_requestSession}" />
        </syswf:control>
        
            <c:choose>
                <c:when test="${not empty waitingMessage}">
                    <c:set var="warning">
                        <p class="Warning">${resolveIssuesCaption}</p>
                    </c:set>
                    <script type="text/javascript">
//<![CDATA[

                        if (${progressBarId}) {
                            Ext.get('${progressBarId}RenderDiv').update('${warning}');
                        };
                    
//]]>
</script>
                </c:when>
                <c:when test="${totalCount > 0 && currentCount == totalCount}">
                    <c:choose>
                        <c:when test="${not empty completeMessage}">
                            <script type="text/javascript">
//<![CDATA[

                                el = Ext.get('${progressBarId}RenderDiv');
                                el.dom.className='';
                                el.dom.style.position = 'static';
                                el.update('${completeMessage}');
                            
//]]>
</script>
                        </c:when>
                        <c:otherwise>
                            <script type="text/javascript">
//<![CDATA[

                                el = Ext.get('${progressBarId}RenderDiv');
                                el.dom.style.visibility='hidden';
                            
//]]>
</script>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${totalCount eq 0 && empty waitingMessage}">
                    <script type="text/javascript">
//<![CDATA[

                        if (${progressBarId}) {
                            el = Ext.get('${progressBarId}RenderDiv');
                            el.dom.style.visibility='visible';
                            ${progressBarId}.updateProgress(1.0, ' ');
                        };
                    
//]]>
</script>
                </c:when>
                <c:otherwise>
                    <script type="text/javascript">
//<![CDATA[

                        if (${progressBarId}) {
                            ${progressBarId}.updateProgress(${currentCount/totalCount},'${currentCount}/${totalCount}');
                        };
                    
//]]>
</script>
                </c:otherwise>
            </c:choose>

            <%-- TODO REVIEW (Svata, Sep 7, 2010): Design:P1: indiviudal progressbars should update themselves, the 1st reloader should just initiate update of the relvant regions --%>
            <c:forEach var="sg" items="${currentMap}">
                <c:if test="${progressBar_requestSession.firstBar != sg.key}">
                    <c:choose>
                        <c:when test="${not empty sg.value[5]}">
                            <c:set var="warning">
                                <p class="Warning">${resolveIssuesCaption}</p>
                            </c:set>
                            <script type="text/javascript">
//<![CDATA[

                                if (${sg.key}) {
                                    Ext.get('${sg.key}RenderDiv').update('${warning}');
                                };
                            
//]]>
</script>
                        </c:when>
                        <c:when test="${sg.value[1] > 0 && sg.value[0] == sg.value[1] && not empty sg.value[3]}">
                            <script type="text/javascript">
//<![CDATA[

                                Ext.get('${sg.key}RenderDiv').dom.className='';
                                Ext.get('${sg.key}RenderDiv').update('${sg.value[3]}');
                            
//]]>
</script>
                        </c:when>
                        <c:when test="${sg.value[1] eq 0 && empty sg.value[5]}">
                            <script type="text/javascript">
//<![CDATA[

                                if (${sg.key}) {
                                    ${sg.key}.updateProgress(1.00,'100%');
                                };
                            
//]]>
</script>
                        </c:when>
                        <c:otherwise>
                            <script type="text/javascript">
//<![CDATA[

                                if (${sg.key}) {
                                    ${sg.key}.updateProgress(${sg.value[0]/sg.value[1]},'${sg.value[0]}/${sg.value[1]}');
                                };
                            
//]]>
</script>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>

        <c:if test="${not empty progressBar_requestSession.progressBarList}">
            <script type="text/javascript">
//<![CDATA[

            setTimeout("callFunction('<c:out value="${funcName}"/>')", getRandomLoadingInterval());
            
//]]>
</script>
        </c:if>
    </c:when>
    <c:when test="${not empty waitingMessage}">
        <c:set var="warning">
            <p class="Warning">${resolveIssuesCaption}</p>                        
        </c:set>
        <script type="text/javascript">
//<![CDATA[

            if (${progressBarId}) {
                Ext.get('${progressBarId}RenderDiv').update('${warning}');
            };
        
//]]>
</script>
    </c:when>
    <c:when test="${totalCount eq 0 && empty waitingMessage}">
        <script type="text/javascript">
//<![CDATA[

            if (${progressBarId}) {
                ${progressBarId}.updateProgress(1.0, ' ');
            };
        
//]]>
</script>
    </c:when>
    <c:when test="${totalCount > 0 && currentCount == totalCount}">
        <c:choose>
            <c:when test="${not empty completeMessage}">
                <script type="text/javascript">
//<![CDATA[

                    el = Ext.get('${progressBarId}RenderDiv');
                    el.dom.className='';
                    el.dom.style.position = 'static';
                    el.update('${completeMessage}');
                
//]]>
</script>
            </c:when>
            <c:otherwise>
                <script type="text/javascript">
//<![CDATA[

                    el = Ext.get('${progressBarId}RenderDiv');
                    el.dom.style.visibility='hidden';
                
//]]>
</script>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
//<![CDATA[

            if (${progressBarId}) {
                el = Ext.get('${progressBarId}RenderDiv');
                el.dom.style.visibility='visible';
                ${progressBarId}.updateProgress(${currentCount/totalCount},'${currentCount}/${totalCount}');
            };
        
//]]>
</script>
    </c:otherwise>

</c:choose>