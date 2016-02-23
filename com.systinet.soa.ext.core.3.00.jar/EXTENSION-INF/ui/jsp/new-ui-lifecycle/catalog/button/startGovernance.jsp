<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="startGov_artifact" var="artifact" bundle="${messages}"/>
<fmt:message key="startGov_process" var="process" bundle="${messages}"/>
<fmt:message key="startGov_governanceDetails" var="governanceDetails" bundle="${messages}"/>

<syswf:control mode="script" caption="startGovernancePost" action="startGovernanceAction"/>

<c:choose>
    <c:when test="${not empty message}">
        <c:out value="${message}"/>
    </c:when>
    <c:otherwise>
        <c:set var="onChangeAction">Ext.getCmp('startGovernance_okButton').enable();</c:set>
        <div class="Content" id="startGovernanceContent">
             <table class="UI Table Properties">
                 <colgroup>
                    <col class="LabelCol" />
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <td>
							<label class="UI Label Inline">${artifact}</label>
						</td>
                        <td>
							<span class="IconAlign">
                            	<c:out value="${artifactName}"/>
							</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        	<label class="UI Label Inline">${process}</label>
						</td>
                        <td>
                            <span class="IconAlign">
	                            <syswf:component name="/newUi/lc/common/widget/chooseGPCombo" prefix="startGov.processes">                                
	                                <syswf:param name="selectedProcessId" value="${bean}" property="selectedProcessId" />
	                                <syswf:param name="onChangeAction" value="${onChangeAction}" />
	                                <syswf:param name="preselectProcess" value="${true}" />
	                            </syswf:component>
							</span>                            
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>