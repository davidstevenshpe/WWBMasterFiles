<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
<fmt:message key="policyDialog.changeLink" var="changeLink" bundle="${bundle}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<c:set var="policyBean" value="${policyDialogBean.selectedPolicyBean}" />

<div class="Content">
    <table class="UI Table Properties" summary="">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody> 
        <%-- Policy --%>
        <tr> 
            <th><label class="UI Label Inline" for="policyName"><fmt:message key="policyDialog.policyName" bundle="${bundle}"/>:</label></th>
            <td>
                 <span class="IconAlign"><c:out value="${policyBean.policyName}"/></span> (<syswf:control mode="postanchor" action="changePolicy" caption="${changeLink}" />)  
            </td>
        </tr>
        <%-- Applicable To --%>
        <tr>
            <th>
                <label class="UI Label Inline" for="applicableTo"><fmt:message key="policyDialog.applicableTo" bundle="${bundle}"/>:</label>
                <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>                   
            </th>
            <td>
                <c:if test="${policyBean.applicableArtifactTypes ne null}">
                    <syswf:selectMany name="applicableTo" mode="checkbox" value="${policyBean}" property="applicableToIds" optionCaptionsProperty="humanReadableName" 
                     optionValuesProperty="id" optionValues="${policyBean.applicableArtifactTypes}" optionCaptions="${policyBean.applicableArtifactTypes}">
                      <syswf:attribute name="class" value="UI Form Checkbox Inline" />
                      <c:if test="${policyBean.justOneApplicableTo}">
                        <syswf:attribute name="disabled" value="disabled" />
                      </c:if>
                    </syswf:selectMany>
                </c:if>
                <em id="${prefix}policyApplicableTo" class="x-form-invalid-msg UI Invalid" style="display: none" >
                    <span><fmt:message key="policyDialog.applicableToNotSet" bundle="${bundle}" /></span>
                </em>
            </td>
        </tr>
        <%-- Required for approval --%>
        <tr>
            <th>
                <label class="UI Label Inline"><fmt:message key="policyDialog.requiredForApproval" bundle="${bundle}"/>:</label>                
            </th>
            <td>
              <syswf:selectOne mode="checkbox"  property="required" value="${policyBean}" optionValues="true" optionCaptions=" " name="required" dataType="boolean" >
                    <syswf:attribute name="class" value="UI Checkbox Inline" />
              </syswf:selectOne>
            </td>
        </tr>
        </tbody>
    </table>

</div>

<script type="text/javascript">
//<![CDATA[

    function validatePolicyWin(){
        var selectedApplicableToCount = $("input[id*=${prefix}_applicableTo]:checked").length;
                                
        if (selectedApplicableToCount > 0){
            Ext.get('${prefix}policyApplicableTo').dom.style.display="none";            
            return true;                    
        }else{
        	Ext.get('${prefix}policyApplicableTo').dom.style.display="block";            
            return false;
        }        
    }


//]]>
</script>
