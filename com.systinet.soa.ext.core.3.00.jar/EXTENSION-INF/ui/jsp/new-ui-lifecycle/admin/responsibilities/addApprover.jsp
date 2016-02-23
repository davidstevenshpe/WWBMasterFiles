<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="addApprover.approvedBy" var="approvedByLabel" bundle="${messages}"/>
<fmt:message key="addApprover.passiveApproval" var="passiveApprovalLabel" bundle="${messages}"/>
<fmt:message key="addApprover.after" var="afterLabel" bundle="${messages}"/>
<fmt:message key="addApprover.days" var="daysLabel" bundle="${messages}"/>
<fmt:message key="addApprover.days" var="daysLabel" bundle="${messages}"/>
<fmt:message key="addApprover.votesRequired" var="votesRequiredLabel" bundle="${messages}"/>
<fmt:message key="addApprover.changeLink" var="changeLink" bundle="${messages}"/>

<table class="UI Table Properties">
  <col class="SmallLabelCol" />
  <col />
  <tbody>
  <tr>
    <td>
    	<label class="UI Label Inline">${approvedByLabel}</label>
    </td>
 	<td style="vertical-align:middle">
         <syswf:component prefix="${prefix}${editorId}${status.index}v" name="/core/impl/util/principalLinkRenderer" wrap="false">
             <syswf:param name="principal" value="${approverHolder.principal}"/>
             <syswf:param name="showIcon" value="${true}"/>
         </syswf:component>
 	    (<syswf:control mode="postanchor" action="changePrincipal" caption="${changeLink}" />)
 	</td>
 </tr>
<c:if test="${not approverHolder.userSelected}">
	 <tr>
	    <td>
	     	<label class="UI Label Inline">${votesRequiredLabel}</label>
	    </td>
	    <td style="vertical-align:middle">
	        <syswf:input name="votesRequired"  value="${approverHolder}" property="votesRequired" dataType="int" >
			  	<syswf:attribute name="class" value="UI Form Input Text Int" />	       
	        </syswf:input>
	    </td>
	 </tr>
</c:if>
 <tr>
    <td>
    	<label class="UI Label Inline">${passiveApprovalLabel}</label>
    </td>
    <td style="vertical-align:middle">
    	  <syswf:selectOne mode="checkbox"  property="passiveApproval" value="${approverHolder}" optionValues="true" optionCaptions=" " name="passiveApproval" dataType="boolean" >
				<syswf:attribute name="class" value="UI Checkbox Inline" />
				<syswf:attribute name="id" value="${prefix}_passiveApproval" />				    	  
    	  </syswf:selectOne>
    		&nbsp;${afterLabel}             

		  <syswf:input id="${prefix}_passiveApprovalLimit"  name="${prefix}_passiveApprovalLimit" disabled="${not approverHolder.passiveApproval}" 
		  value="${approverHolder}" property="passiveApprovalDays" dataType="int" >
		  	<syswf:attribute name="class" value="UI Form Input Text Int" />		  	
		  </syswf:input> ${daysLabel}
	</td>
  </tr>  
  </tbody>
</table>

<script type="text/javascript">
//<![CDATA[

	Ext.get('${prefix}_passiveApproval_0').on('change',function(){
	    Ext.get('${prefix}_passiveApprovalLimit').dom.disabled = (Ext.get('${prefix}_passiveApproval_0').dom.checked) ? false:true;
	});

//]]>
</script>
