<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="approverBeans" type="java.util.List<com.hp.systinet.lifecycle.ui.admin.visualization.ApproversSection.ApproverSectionEntry>"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="approverHolder" type="com.hp.systinet.lifecycle.ui.admin.responsibilities.AddApproverHolder"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
<fmt:message key="addApprover.addLabel" var="addLabel" bundle="${bundle}"/>
<fmt:message key="addApprover.title" var="addApproverTitle" bundle="${bundle}"/>
<fmt:message key="editApprover.title" var="editApproverTitle" bundle="${bundle}"/>
<fmt:message key="selectApprover.title" var="selectApproverTitle" bundle="${bundle}"/>

<syswf:control id="approverActionDelete" mode="script" caption="approverActionDelete" action="delete" affects="."
               loadingMask="true"/>
<syswf:control id="approverActionEdit" mode="script" caption="approverActionEdit" action="edit" affects="."
               loadingMask="true"/>
<syswf:input id="encodedName" name="approverEncodedName" value="" mode="hidden"/>


<%-- Delete confirm dialog --%>
<syswf:component prefix="approverDeleteDialog" name="/core/impl/util/dialog">
    <syswf:param name="handler" value="dummy"/>
    <syswf:param name="heading"><fmt:message key="approversSection.deletePopupTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="noUndo" value="false"/>
</syswf:component>


<syswf:block className="UI Block Plain">
    <div class="Title"><h4><span><fmt:message key="approversSection.title" bundle="${bundle}"/></span></h4></div>


    <div class="Content">
        <div class="Offset">
            <c:choose>
                <c:when test="${not empty approverBeans}">
                        <c:forEach items="${approverBeans}" var="approverEntry" varStatus="approversStatus">
                            <table class="UI Table Properties">
                                <col class="MidLabelCol"/>
                                <col width="20px"/>
                                <col/>
                                <col class="ControlCol"/>
                                <col width="26px"/>
                                <tr>
                                    
                                    <td>
                                        <syswf:component name="/core/impl/util/principalLinkRenderer"
                                                         prefix="voter${approversStatus.index}" wrap="false">
                                            <syswf:param name="principal" value="${approverEntry.voter}"/>
                                            <syswf:param name="showIcon" value="${true}"/>
                                        </syswf:component>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <div class="UI Icon ${approverEntry.withPassiveApproval ? 'EventUserActionPending' : 'Unknown'}">
                                            <c:out value="${approverEntry.info}"/>
                                        </div>
                                    </td>
                                        <%--edit, delete--%>
                                    <td>
                                        <div class="Text RightAlign">
                                            <a id="approverEdit_${approversStatus.count}" href="javascript:void(0)"
                                               class="UI Icon Edit">
                                                <span><fmt:message key="button.edit" bundle="${bundle}"/></span></a> &nbsp;
                                            <a id="approver_del_${approversStatus.count}"
                                               href="javascript:void(0)"
                                               class="UI Icon Delete">
                                                <span><fmt:message key="button.delete" bundle="${bundle}"/></span></a>
                                        </div>
                                    </td>
                                    <td></td>                 
                                </tr>
                            </table>
                        </c:forEach>
                </c:when>
                <c:otherwise>
                    <fmt:message key="sections.noItems" bundle="${bundle}"/>
                </c:otherwise>
            </c:choose>
            <script type="text/javascript">
//<![CDATA[

                <c:forEach items="${approverBeans}" var="approverEntry" varStatus="approversStatus">
                Ext.onReady(function() {
                    var handler = function() {
                        Ext.get('encodedName').dom.value = '<syswf:out context="HtmlJSText" value="${approverEntry.encodedName}"/>';
                        approverActionDelete();
                    };
                    var element = Ext.get('approver_del_${approversStatus.count}');
                    element.on('click', function() {
                        ${prefix}_approverDeleteDialog_showDialog(element, null,
                                '<fmt:message key="approversSection.deleteQuestion" bundle="${bundle}"/>',
                                null, handler, false);
                    });
                });
                attachOn('approverEdit_${approversStatus.count}','click',function() { editApproverAction('<syswf:out context="HtmlJSText" value="${approverEntry.encodedName}"/>'); });
                </c:forEach>
            //]]>
            </script>

	<syswf:component name="/core/principal/selector" prefix="addApproverPricipalSelector">
	    <syswf:param name="jsOpenFunction" value="${prefix}openSelectorAddApprover" />
        <syswf:param name="enableContactsTab" value="true" />
	    <syswf:param name="windowTitle" value="${selectApproverTitle}"/>
	    <syswf:param name="holder" value="${approverHolder}" />
	</syswf:component>


    <c:if test="${approverHolder.principal ne null}">
        <syswf:control mode="script" action="addApprover" caption="${prefix}addApprover" />
        <syswf:control mode="script" action="cancelAddApprover" caption="${prefix}cancelAddApprover" />

        <c:choose>
            <c:when test="${approverHolder.principalToBeReplaced ne null}">
                <c:set var="windowTitle" value="${editApproverTitle}"></c:set>
            </c:when>
            <c:otherwise>
                <c:set var="windowTitle" value="${addApproverTitle}"></c:set>
            </c:otherwise>
        </c:choose>

        <syswf:component name="/core/window" prefix="addApprover">
            <syswf:param name="winTitle">${windowTitle}</syswf:param>
            <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/addApprover"/>
            <syswf:param name="winOpenFunctionName" value="${prefix}open" />
            <syswf:param name="winOkLabel" value="${addLabel}" />
            <syswf:param name="winOkAction" value="${prefix}addApprover" />
            <syswf:param name="winCancelAction" value="${prefix}cancelAddApprover" />

            <syswf:param name="approverHolder" value="${approverHolder}" />
            <syswf:param name="parentComponent" value="${prefix}" />
        </syswf:component>

        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                ${prefix}open();
            })
            //]]>
        </script>
	</c:if>

	<c:if test="${approverHolder.changingPrincipal}">
		<script type="text/javascript">
//<![CDATA[

			Ext.onReady(function() {
				${prefix}openSelectorAddApprover();
			})
            //]]>
		</script>
	</c:if>

    <a id="approverAdd"  class="UI Icon Add" href="javascript:${prefix}openSelectorAddApprover()">
        <span><fmt:message key="approversSection.addApprover" bundle="${bundle}"/></span></a>
    </div>
    </div>

    <script type="text/javascript">
//<![CDATA[

        function editApproverAction(encodedName){
            Ext.get('encodedName').dom.value = encodedName;
            approverActionEdit();
        }
        //]]>
    </script>

</syswf:block>
