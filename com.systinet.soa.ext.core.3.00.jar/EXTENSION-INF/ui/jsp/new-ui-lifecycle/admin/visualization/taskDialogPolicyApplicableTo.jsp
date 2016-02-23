<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<c:choose>
    <c:when test="${not empty taskBean.policyUuid}">
        <c:if test="${taskBean.applicableArtifactTypes ne null}">
            <syswf:selectMany name="applicableTo" mode="checkbox" value="${taskBean}" property="applicableToIds" optionCaptionsProperty="humanReadableName" 
             optionValuesProperty="id" optionValues="${taskBean.applicableArtifactTypes}" optionCaptions="${taskBean.applicableArtifactTypes}">
              <syswf:attribute name="class" value="UI Form Checkbox Inline" />
              <c:if test="${taskBean.justOneApplicableTo}">
                <syswf:attribute name="disabled" value="disabled" />
              </c:if>
            </syswf:selectMany>
        </c:if>
        <em id="${prefix}policyApplicableTo" class="x-form-invalid-msg UI Invalid" style="display: none" >
            <span><fmt:message key="policyDialog.applicableToNotSet" bundle="${bundle}" /></span>
        </em>
        
        <script type="text/javascript">
//<![CDATA[

            function ${validateApplicableFunctionName}(){
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
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
//<![CDATA[

            function ${validateApplicableFunctionName}(){
            	return true;
            }
        
//]]>
</script>
    </c:otherwise>
</c:choose>
