<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="message"/>
<fmt:message var="financialAlignmentLabel" key="cloudMigration.financialAlignment.label" bundle="${message}"/>
<fmt:message var="businessAlignmentLabel" key="cloudMigration.businessAlignment.label" bundle="${message}"/>
<fmt:message var="technicalAlignmentLabel" key="cloudMigration.technicalAlignment.label" bundle="${message}"/>
<table class="UI Table Properties">
   <colgroup>
      <col class="LabelCol">
      <col>
   </colgroup>
   <tbody>
	   <tr>
		  <td colspan="2">
			 <div class="help-text ${linkTabId}" style="display: none;">
				${financialAlignmentDesc}
			 </div>
		  </td>
	   </tr>
	   <tr id="financialAlignment">
		  <th><label class="UI Label Inline" title="Financial Alignment"> ${financialAlignmentLabel}:</label></th>
		  <td>
			 <span class="IconAlign">
				<div class="AJAXContainer">
					<span >${financialAlignment}</span>
				</div>
			 </span>
		  </td>
	   </tr>
	   <tr>
		  <td colspan="2">
			 <div class="help-text ${linkTabId}" style="display: none;">
				${businessAlignmentDesc}
			 </div>
		  </td>
	   </tr>
	   <tr id="businessAlignment">
		  <th><label class="UI Label Inline" title="Business Alignment"> ${businessAlignmentLabel}:</label></th>
		  <td>
			 <span class="IconAlign">
				<div class="AJAXContainer">
				   <span >${businessAlignment}</span>
				</div>
			 </span>
		  </td>
	   </tr>
	   <tr>
		  <td colspan="2">
			 <div class="help-text ${linkTabId}" style="display: none;">
				${technicalAlignmentDesc}
			 </div>
		  </td>
	   </tr>
	   <tr id="technicalAlignment">
		  <th><label class="UI Label Inline" title="Technical Alignment"> ${technicalAlignmentLabel}:</label></th>
		  <td>
			 <span class="IconAlign">
				<div class="AJAXContainer">
				   <span >${technicalAlignment}</span>
				</div>
			 </span>
		  </td>
	   </tr>
   </tbody>
</table>


	
