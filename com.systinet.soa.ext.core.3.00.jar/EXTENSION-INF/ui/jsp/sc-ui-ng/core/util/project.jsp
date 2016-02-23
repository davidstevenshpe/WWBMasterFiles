<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message var="edit" key="Edit" bundle="${labels}"/>

    <div class="EA-right-panel">
        <div class="Content">
            <div class="Title">
                <h3>
                    ${projectsLabel}
                </h3>
            </div>
            <div class="Content" id="${prefix}Content">
                <c:forEach var="project" items="${projects}" varStatus="status">
                    <syswf:control id="project_${status.index}" mode="anchor" caption="${project.name}" hint="${project.description}" targetTask="/artifact/${project._uuid}" wrapper="span">
                        <syswf:attribute name="id" value="project_${status.index}"/>
                    </syswf:control><br/>
                </c:forEach>
            </div>
            <%--c:if test="${moreMode == 'tabs'}">
                <div class="Footer">
                    <syswf:control id="linkToRelationshipsTab" mode="anchor" caption="${edit}" hint="" targetTask="/artifact/${artifact._uuid}" wrapper="span">
                        <syswf:attribute name="class" value="UI Icon Edit"/>
                        <syswf:param name="artifactTabId" value="relationships"/>
                    </syswf:control>
                </div>
            </c:if--%>
            
            
                   <br/>
                   
                   <syswf:control caption="${prefix}E" mode="script" action="confirmEdit"/>
                   
                    <syswf:component name="/core/window" prefix="projectSelectorWindow">
                        <syswf:param name="winId">${prefix}W</syswf:param>
                        <syswf:param name="winTitle">${projectsLabel}</syswf:param>
                        <syswf:param name="winComponent" value="/core/util/projectEdit"/>
                        <syswf:param name="winOpenFunctionName" value="${prefix}OW" />
                        <syswf:param name="winOkAction" value="${prefix}E" />
                        <syswf:param name="winButtonAlign" value="right" />
                        <syswf:param name="artifact" value="${artifact}" />
                        <syswf:param name="selectionBag" value="${selectionBag}" />
                    </syswf:component>

                    <a class="UI Icon Edit" href="javascript:void(0)" id="${prefix}EL"><span><fmt:message key="Edit" bundle="${labels}" /></span></a>

                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            Ext.get('${prefix}EL').on('click', function() {
                                ${prefix}OW();
                            });
                        });
                    
//]]>
</script>
                      
       </div>
       
    </div>
    
        
