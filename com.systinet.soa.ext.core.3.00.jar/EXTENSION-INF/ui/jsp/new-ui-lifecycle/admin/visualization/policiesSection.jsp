<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="policyDqlCondition" type="java.lang.String"--%>
<%--@elvariable id="policySelector" type="com.hp.systinet.sc.ui.search.selector.ArtifactSelectorListener"--%>
<%--@elvariable id="policyDialogBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.PolicyDialogBean"--%>
<%--@elvariable id="policyBeans" type="java.util.List"--%>
<%--@elvariable id="availaibleApplicableTo" type="java.lang.String"--%>
<%--@elvariable id="openSelectorCondition" type="java.lang.Boolean"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<fmt:message key="addPolicy.title" var="addPolicyTitle" bundle="${bundle}"/>
<fmt:message key="editPolicy.title" var="editPolicyTitle" bundle="${bundle}"/>

<syswf:control id="policyActionDelete" mode="script" caption="policyActionDelete" action="delete" affects="." loadingMask="true"/>
<syswf:control id="policyActionSave" mode="script" caption="policyActionSave" action="save" affects="." loadingMask="true"/>
<syswf:control id="policyActionClose" mode="script" caption="closePolicyDialog" action="closeDialog" affects="." loadingMask="true"/>
<syswf:control id="updateDqlConditionId" mode="script" caption="updateDqlConditionCaption" action="updateDqlCondition" affects="." loadingMask="true"/>

<syswf:input id="policyId" name="policyId" value="" mode="hidden"/>


<%-- Delete confirm dialog --%>
<syswf:component prefix="policyDeleteDialog" name="/core/impl/util/dialog">
    <syswf:param name="handler" value="dummy" />
    <syswf:param name="heading"><fmt:message key="policiesSection.deletePopupTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="noUndo" value="false" />
</syswf:component>

<%-- Policy Selector --%>
<syswf:component name="/core/search/selector/artifactSelector" prefix="policySelector">
    <syswf:param name="jsOpenFunction" value="openPolicySelector" />
    <syswf:param name="windowTitle"><fmt:message key="policiesSection.policySelectorWindowTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="selectorListener" value="${policySelector}" />
    <syswf:param name="artifactType" value="hpsoaTechnicalPolicyArtifact" />
    <syswf:param name="dqlCondition" value="${policyDqlCondition}" />
    <syswf:param name="showDataBeforeSearch" value="true" />
    <syswf:param name="selectorCustomizationId" value="shared.technicalPolicySelector"/>
    <syswf:param name="availaibleApplicableTo" value="${availaibleApplicableTo}"/>
</syswf:component>

<%-- Policy Dialog --%>

<fmt:message key="policyDialog.okLabel" var="okLabel" bundle="${bundle}"/>
<fmt:message key="policyDialog.cancelLabel" var="cancelLabel" bundle="${bundle}"/>

<c:set var="customButtons">
    [{
        text     : '${okLabel}',
        disabled : false,
        handler  : function() {
            if (validatePolicyWin()){
                policyActionSave();
                SPopup.Window.Instance['policyDialog'].removeListener('beforehide',closePolicyDialog);                
                SPopup.Window.Instance['policyDialog'].hide();
            }
        },
        id: '${prefix}_okEditPolicy'        
    },{
            text     : '${cancelLabel}',
            handler  : function(){
                closePolicyDialog();
                SPopup.Window.Instance['policyDialog'].removeListener('beforehide',closePolicyDialog);
                SPopup.Window.Instance['policyDialog'].hide();
                return false;
            },
            id: '${prefix}_cancelEditPolicy'
        }]    
</c:set>

<syswf:component name="/core/window" prefix="policyDialog">
    <syswf:param name="winTitle" value="${editPolicyTitle}"/>
    <syswf:param name="winId" value="policyDialog"/>
    <syswf:param name="winComponent" value="/newUi/lc/admin/visualization/policyDialog"/>
    <syswf:param name="winOpenFunctionName" value="openEditPolicyDialog" />
    <%-- winCancelAction called when window is closed by cross button --%>
    <syswf:param name="winCancelAction" value="closePolicyDialog" />
    <syswf:param name="winGetParamsFunctionName" value="policyDialog_getParams" />
    <syswf:param name="winWidth" value="500" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="policyDialogBean" value="${policyDialogBean}" />
    <syswf:param name="parentComponent" value="${prefix}" />
    <syswf:param name="winCustomButtons" value="${customButtons}" />    
</syswf:component>

<c:if test="${policyDialogBean.selectedPolicyBean ne null and not policyDialogBean.changePolicy}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
        	openEditPolicyDialog();
            SPopup.Window.Instance['policyDialog'].setTitle('${addPolicyTitle}');            
        })
    
//]]>
</script>                
</c:if>

<c:if test="${policyDialogBean.changePolicy}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
        	openPolicySelector();
        })
    
//]]>
</script>                
</c:if>

<script type="text/javascript">
//<![CDATA[


    function policyDialog_getParams() {
        return {
            'validationDefinitionDataId' : Ext.get('policyId').dom.value
        };
    }

    function editPolicy(policyId){
        Ext.get('policyId').dom.value = policyId;
        openEditPolicyDialog();
    }

//]]>
</script>

<syswf:block className="UI Block Plain">
    <div class="Title">
    <h4><span><fmt:message key="policiesSection.title" bundle="${bundle}" /></span></h4>
    </div>
    <div class="Content">
    <div class="Offset">    
    
    <c:forEach var="policyBean" varStatus="status" items="${policyBeans}" >
        <%--@elvariable id="policyBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.PolicyBean"--%>
        <table class="UI Table Properties">        
            <col class="FormSelectCol">
            <col class="MidLabelCol">
            <col>            
            <col class="ControlCol">
            <col class="SpacerCol">
                <tr>
                    <td><a id="policy_${status.index}_switch"
                        class="UI Icon Expand" href="javascript:void(0)"><span><fmt:message key="expandLink.label" bundle="${bundle}" /></span></a></td>
                    <td>
                        <syswf:component prefix="policy_${policyBean.id}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                            <syswf:param name="uuid" value="${policyBean.policyUuid}"/>
                            <syswf:param name="caption" value="${policyBean.policyName}"/>
                            <syswf:param name="class" value="IconAlign"/>                            
                        </syswf:component>                        
                    </td>
                    <td>
                    
                    <%-- required/optional --%>                    
                        <c:choose>
                            <c:when test="${policyBean.required}">
                                <span class="UI Icon Required">
                                    <fmt:message key="policiesSection.requiredStatus.true" bundle="${bundle}" />
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="UI Icon Unknown">
                                    <fmt:message key="policiesSection.requiredStatus.false" bundle="${bundle}" />
                                </span>
                            </c:otherwise>
                        </c:choose>                                            
                    </td>
                                        
                    <td>
                    <div class="Text RightAlign">
                        <a id="policyEdit_${policyBean.id}" href="javascript:void(0)" class="UI Icon Edit">
                            <span><fmt:message key="policiesSection.edit" bundle="${bundle}"/></span>
                        </a> &nbsp;
                        <a id="policy_del_${policyBean.id}" class="UI Icon Delete" href="javascript:void(0)">
                            <span><fmt:message key="policiesSection.delete" bundle="${bundle}" /></span>
                       </a>
                    </div>
                    </td>
                    <td></td>
                </tr>
        </table>
        <div id="policy_${status.index}_comment" class="Comment x-hidden">
            <table class="UI Table Properties">
                <col class="FormSelectCol"/>
                <col/>
                <tr>
                    <td></td>
                    <td>
                        <p class="Comment Plain">
                            <c:if test="${not empty policyBean.description}">
                                <syswf:out value="${policyBean.description}" context="HtmlBody"/>
                                <br/>
                            </c:if>
                            <strong><fmt:message key="policiesSection.applicableTo" bundle="${bundle}" />:</strong>
                            <c:forEach var="artifactType" varStatus="atStatus" items="${policyBean.applicableToLabels}">
                                <c:out value="${artifactType}"/><c:if test="${not atStatus.last}">,</c:if>
                            </c:forEach>
                        </p>
                    </td>
                </tr>
            </table>
        </div>
        <script type="text/javascript">
//<![CDATA[

            Ext.get('policy_${status.index}_switch').on('click',function(){
                AdvancedOptions.Comment.Switch('policy_${status.index}_switch','policy_${status.index}_comment');
            });
        
//]]>
</script>
    </c:forEach> 

    <script type="text/javascript">
//<![CDATA[

        <c:forEach var="policy" items="${policyBeans}">       
                        
            var element = Ext.get('policy_del_${policy.id}');            
            element.on('click', function() {
               ${prefix}_policyDeleteDialog_showDialog(element, null,
                       '<fmt:message key="policiesSection.deleteQuestion" bundle="${bundle}"/>',
                       null, function(){
                                storePolicyId('${policy.id}'); 
                                policyActionDelete(); 
                              }, 
                       false);
            });
            attachOn('policyEdit_${policy.id}','click',function() { editPolicy('${policy.id}'); });            
        </c:forEach>

        function storePolicyId(policyId) {
            Ext.get('policyId').dom.value = policyId;
        }
              
    
//]]>
</script>

    <a id="policyAdd" class="UI Icon Add" href="javascript:void(0)">
        <span><fmt:message key="policiesSection.addPolicy" bundle="${bundle}" /></span>
    </a>

    <script type="text/javascript">
//<![CDATA[

        attachOn('policyAdd','click',function() {
            updateDqlConditionCaption();
        });
    
//]]>
</script>

    <c:if test="${openSelectorCondition}">
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                openPolicySelector();
            })
        
//]]>
</script>
    </c:if>

    </div>
    </div>
</syswf:block>
