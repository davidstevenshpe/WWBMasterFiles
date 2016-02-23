<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.security.securitymessages" var="securitymessages"/>
<fmt:message var="addAccessWindow_labelReadOnly" key="addAccessWindow.labelReadOnly" bundle="${securitymessages}"/>
<fmt:message var="addAccessWindow_labelReadWrite" key="addAccessWindow.labelReadWrite" bundle="${securitymessages}"/>
<fmt:message var="addAccessWindow_noEntitySelected" key="addAccessWindow.noEntitySelected" bundle="${securitymessages}"/>
<fmt:message var="addAccessWindow_selectEntitiesLink" key="addAccessWindow.selectEntitiesLink" bundle="${securitymessages}"/>


<table class="UI Table Properties">
    <col class="MidLabelCol"/>
    <col />
    <tbody>
        <tr>
            <th>
                <c:choose>
                    <c:when test="${accessType eq 'read'}">
                        ${addAccessWindow_labelReadOnly}
                    </c:when>
                    <c:when test="${accessType eq 'readWrite'}">
                        ${addAccessWindow_labelReadWrite}
                    </c:when>
                </c:choose>
            </th>
            <td>
                <c:choose>
                    <c:when test="${empty holder.selectedPrincipals}">
                        <span class="NoChange">${addAccessWindow_noEntitySelected}</span>
                    </c:when>
                    <c:otherwise>
                        <ul id="owner_list" class="UserList">
                            <c:forEach items="${holder.selectedPrincipals}" var="selectedPrincipal" varStatus="status">
                                <li>
                                   <syswf:component prefix="owner_${status.count}" name="/core/impl/util/principalLinkRenderer" wrap="false">
                                       <syswf:param name="principal" value="${selectedPrincipal.id}"/>
                                       <syswf:param name="showIcon" value="${true}"/>
                                   </syswf:component>
                               </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th></th>
            <td>
                <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}select_principals"><span>${addAccessWindow_selectEntitiesLink}</span></a>
            </td>
        </tr>
    </tbody>
</table>

<div class="UI AdvancedOptions Labeled Closed">
    <div class="OptionsOpener">
        <a href="javascript:void(0);" id="${prefix}opener"><span><fmt:message bundle="${messages}" key="general.advancedOptions" /></span></a>
    </div>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}opener','click',function() {
                AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
            });
        });
    
//]]>
</script>
    <div class="Content">
        <syswf:selectOne id="${prefix}includeSubartifacts" name="includeSubartifacts" selectClass="UI Form Checkbox Inline" value="${holder}" property="includeSubartifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}includeSubartifacts_0"><fmt:message bundle="${messages}" key="general.includeSubartifacts"/></label>
    </div>
</div>

<syswf:control mode="script" caption="${prefix}saveState" action="saveState" />

<syswf:component name="/core/principal/selector" prefix="principalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}open" />
    <syswf:param name="windowTitle">Select Entities</syswf:param>
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="overrideselectionModel" value="multiple" />
    <syswf:param name="winOnRenderCallback" value="${null}" passNull="true"/>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        attachOn('${prefix}select_principals','click',function() {
            ${prefix}open();
            ${prefix}saveState();
            })
    });
   
    <c:if test="${not empty winOnRenderCallback}">
        function ${winOnRenderCallback}() {
            ${prefix}open();
        }
    </c:if>

//]]>
</script>