<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.composite.compositeMessages" var="compositeMessages"/>

<fmt:message var="showMoreParentsLink" key="showMoreParentsLink" bundle="${compositeMessages}"/>
<fmt:message var="cancelButtonLabel" key="cancelButtonLabel" bundle="${compositeMessages}"/>
<fmt:message var="parentsSuffix" key="parentsSuffix" bundle="${compositeMessages}"/>
<fmt:message var="impactOfPrefix" key="impactOfPrefix" bundle="${compositeMessages}"/>
<fmt:message var="dependenciesOfPrefix" key="dependenciesOfPrefix" bundle="${compositeMessages}"/>
<fmt:message var="governanceTreePrefix" key="governanceTreePrefix" bundle="${compositeMessages}"/>
<fmt:message var="dependenciesHead" key="dependenciesHead" bundle="${compositeMessages}"/>
<fmt:message var="impactHead" key="impactHead" bundle="${compositeMessages}"/>
<fmt:message var="lifecycleTreeHead" key="lifecycleTreeHead" bundle="${compositeMessages}"/>

<div class="Breadcrumbs">
    <c:choose>
        <c:when test="${not governanceTreeMode}">
            <c:if test="${inverted}">
                <div class="Title Config">
                    <table>
                        <tbody>
                            <tr>
                                <td><h3>${impactHead}</h3></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                ${impactOfPrefix}
            </c:if>
            <c:if test="${not inverted}">
                <div class="Title Config">
                    <table>
                        <tbody>
                            <tr>
                                <td><h3>${dependenciesHead}</h3></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                ${dependenciesOfPrefix}
            </c:if>
           
            <c:out value="${artifact.name}"/>
        </c:when>        
        <c:otherwise>
            <div class="Title Config">
                <table>
                    <tbody>
                        <tr>
                            <td><h3>${lifecycleTreeHead}</h3></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            ${governanceTreePrefix} <c:out value="${artifact.name}"/>
        </c:otherwise>
    </c:choose>
    
</div>

    <%-- The 'show more parents' feature is disabled. --%>
    <%--
    <c:set var="moreParentsId" value="${prefix}more_parents"/>
    <c:set var="loadParentPaths" value="${prefix}loadParentPaths"/>

    <div class="MoreParents">       
        <a id="${moreParentsId}" href="javascript:void(0);">${showMoreParentsLink}</a>
    </div>        

    <div id="${prefix}more_parents_content" class="x-hidden">
        <div class="x-window-header">'${artifact.name}' ${parentsSuffix}</div>
        <div class="x-window-body">
            <div class="UI Offset ParentsList">
                <syswf:component name="/core/impl/composite/parentPathWindow" prefix="parentPathWindow">
                    <syswf:param name="inverseTraversalRuleSet" value="${this.inverseTraversalRuleSet}"/>
                    <syswf:param name="loadParentPathsFunctionName" value="${loadParentPaths}"/>
                    <syswf:param name="parentPath" value="${this.parentPath}"/>
                    <syswf:param name="parentPathsCountLimit" value="${this.parentPathsCountLimit}"/>
                    <syswf:param name="parentPathLengthLimit" value="${this.parentPathLengthLimit}"/>
                </syswf:component>
            </div>
        </div>
    </div>

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {                                                                                                                                                    
            var buttons = [
                {text: '${cancelButtonLabel}', handler: function() { SPopup.Window.Instance['${moreParentsId}'].hide(); }}
            ];
                                                                            
            SPopup.Window.init('${moreParentsId}','${prefix}more_parents_content', {
                    autoScroll: true, buttons: buttons, width: 500, height: 300, resizable: false, centerOnScreen: true
                });                      
        });                     
    
//]]>
</script>
     --%>

    <%-- ENH Johnny - set the height and width relatively to fit inside the popup window --%>
    <%--    
    <script type="text/javascript">
//<![CDATA[

        attachOn('${moreParentsId}', 'click', ${loadParentPaths})
        Ext.get('${prefix}_parentPathWindow').setHeight(218);
        Ext.get('${prefix}_parentPathWindow').setWidth(473);
    
//]]>
</script>

    <div class="x-clear"></div>
    --%>