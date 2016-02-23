<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="sessionBean" type="com.hp.systinet.policy.ui.formvalidation.FormValidationBoxBean"--%>
<%--@elvariable id="countMap" type="java.util.Map"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/ux/jquery.jcarousel.js" var="jsJcarousel"/>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="messages"/>

<syswf:control mode="script" caption="fnChangeArtifactType" action="changeArtifactType" affects="." />

<syswf:block className="UI Block Common">
    <div class="Content">
        <table class="UI Table ExpressionBuilder Plain">
            <col class="XMediumCol">
            <col/>
           <tr>
                <td><div class="Title"><h3><span><fmt:message key="formValidation_type" bundle="${messages}" /></span></h3></div></td>
                <td><div class="Title"><h3><span><fmt:message key="formValidation_validated" bundle="${messages}" /></span></h3></div></td>
            </tr>
            <tr>
                <td>
                    <%-- ARTIFACT TYPES --%>
                    <div class="ExpressionSelect High com_carousel">
                    <syswf:input name="selectedArtifactType" value="${sessionBean}" property="selectedArtifactType" mode="hidden"/>
					<syswf:input name="selectedIndex" value="${sessionBean}" property="selectedIndex" dataType="int" mode="hidden"/>		
                        <ul id="mycarousel" class="jcarousel">
                        <c:forEach var="artifactType" items="${this.artifactTypes}" varStatus="status">
                            <li><div class="ExpressionNode <c:if test="${artifactType.first eq sessionBean.selectedArtifactType}">Active</c:if>">
                                    <a id="type_${artifactType.first}" href="javascript:void(0)">
                                        <span>
                                            <c:out value="${artifactType.second}"/>
                                        </span>
                                    </a>
                                    <c:set value="${countMap[artifactType.first]}" var="artifactTypeCount"/>
                                    <c:if test="${(not empty artifactTypeCount) and (artifactTypeCount gt 0)}">
                                        <span><c:out value="(${artifactTypeCount})"/></span>
                                    </c:if>
                                    <script type="text/javascript">
//<![CDATA[

                                        // Hook the following actions on mouse-click:
                                        Ext.get('type_${artifactType.first}').on('click',function(){
                                            Ext.get('technicalPoliciesTable').unmask();
                                            ExpressionBuilder.SetActiveNode(this);
                                            Ext.get('${prefix}_selectedArtifactType').dom.value = '${artifactType.first}';
                                            Ext.get('${prefix}_selectedIndex').dom.value = '${status.index}';
                                            fnChangeArtifactType();
                                        });
                                    
//]]>
</script>
                            </div></li>
                        </c:forEach>
                        </ul>
                        <div class="carouselcontrols vertical">
                            <a href="javascript:void(0)" class="carouselPrev" id="mycarousel-prev"><span><fmt:message key="previous" bundle="${messages}"/></span></a>
                            <a href="javascript:void(0)" class="carouselNext" id="mycarousel-next"><span><fmt:message key="next" bundle="${messages}"/></span></a>
                        </div>
                        <script type="text/javascript" src="<c:out value="${jsJcarousel}"/>"></script>
                        <script type="text/javascript">
//<![CDATA[

                            /**
                             * use the initCallback callback
                             * to assign functionality to the controls
                             */
                            function mycarousel_initCallback(carousel) {
                                jQuery('#mycarousel-next').bind('click', function() {
                                    carousel.next();
                                    return false;
                                });

                                jQuery('#mycarousel-prev').bind('click', function() {
                                    carousel.prev();
                                    return false;
                                });
                            };

                            jQuery(document).ready(function() {
                                jQuery('#mycarousel').jcarousel({
                                    //wrap:'both',
                                    scroll:5,
                                    start:Ext.get('${prefix}_selectedIndex').dom.value,
                                    vertical: true,
                                    initCallback: mycarousel_initCallback,
                                    buttonNextHTML:null,
                                    buttonPrevHTML:null,
									itemFallbackDimension:20
                                });
                            });
                        
//]]>
</script>
                    </div>
                </td>
                <td>
                    <%-- TECHNICAL POLICIES --%>
                    <div id="technicalPoliciesTable" class="Offset">
                        <syswf:component name="/core/table" prefix="tpTable">
                            <syswf:param name="customizationId" value="common.technicalPoliciesTable"/>
                            <syswf:param name="technicalPolicyItems" value="${sessionBean.technicalPolicyItems}" />
                            <syswf:param name="selectedArtifactType" value="${sessionBean.selectedArtifactType}"/>
                            <syswf:param name="boxComponentName" value="${prefix}"/>
                        </syswf:component>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</syswf:block>
