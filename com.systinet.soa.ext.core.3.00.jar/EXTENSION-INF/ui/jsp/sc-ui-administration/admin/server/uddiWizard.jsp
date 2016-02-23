<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage"
	var="serverMsg" />
<fmt:message key="edit.next" var="next"
	bundle="${serverMsg}" />
<fmt:message key="edit.next.hint" var="nextHint"
	bundle="${serverMsg}" />
<fmt:message key="edit.cancel" var="cancel"
	bundle="${serverMsg}" />				
<fmt:message key="edit.cancel.hint" var="cancelhint"
	bundle="${serverMsg}"/>

<fmt:message var="requiredCaption" key="required" bundle="${serverMsg}" />
<fmt:message var="requiredTitle" key="required.title" bundle="${serverMsg}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
	<syswf:param name="title" value="${title}" /> 
</syswf:component>

<syswf:block className="UI Block Common">
<table class="UI Table Properties">
    <col class="MidLabelCol"/>
    <col/>
	<tr>
		<th ><label class="UI Label Required Full"><fmt:message key="edit.label.hostname" bundle="${serverMsg}" />:</label>
			<sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></th>
		<td>
			<div class="Text">
				<syswf:input  name="host" value="${uddiWizard}" property="host" mode="text" >
					<syswf:attribute name="style" value="width:98%"></syswf:attribute>
	            	<syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>							
				</syswf:input>
			</div>
		</td>
	</tr>
	<c:if test="${not empty validationResult['hostName']}">
	          
              <tr>
                    <td></td>
                    <td>
                        <em class="x-form-invalid-msg UI Invalid">
                            <span class="Comment">${validationResult['hostName']}</span>
                        </em>
                    </td>
              </tr>
    </c:if>
	<tr>
		<th ><label class="UI Label Required Full" ><fmt:message key="edit.label.port" bundle="${serverMsg}" />:</label>
			<sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></th>
		<td>
			<div class="AJAXContainer">
				<syswf:input  name="port" value="${uddiWizard}" property="port" mode="text" >
					<syswf:attribute name="style" value="width:98%"></syswf:attribute>
	            	<syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>										
				</syswf:input>
			</div>	
		</td>
	</tr>
	<c:if test="${not empty validationResult['httpPort']}">
              <tr>
                    <td></td>
                    <td>
                        <em class="x-form-invalid-msg UI Invalid">
                            <span class="Comment">${validationResult['httpPort']}</span>
                        </em>
                    </td>
              </tr>
    </c:if>
	<tr>
		<th><label class="UI Label Required Full" ><fmt:message key="edit.label.sslport" bundle="${serverMsg}" />:</label>
			<sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></th>
		<td>
			<div class="AJAXContainer">
				<syswf:input  name="sslPort" value="${uddiWizard}" property="sslPort" mode="text" >
					<syswf:attribute name="style" value="width:98%"></syswf:attribute>
	            	<syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>										
				</syswf:input>
			</div>
		</td>
	</tr>
	<c:if test="${not empty validationResult['sslPort']}">
              <tr>
                    <td></td>
                    <td>
                        <em class="x-form-invalid-msg UI Invalid">
                            <span class="Comment">${validationResult['sslPort']}</span>
                        </em>
                    </td>
              </tr>
    </c:if>
	<tr>
		<th><label class="UI Label Inline"><fmt:message key="edit.label.context" bundle="${serverMsg}" />:</label></th>
		<td>
			<div class="AJAXContainer">
				<syswf:input  name="serverContext" value="${uddiWizard}" property="serverContext" mode="text" >
					<syswf:attribute name="style" value="width:98%"></syswf:attribute>
	            	<syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>										
				</syswf:input>
			</div>
		</td>
	</tr>
	<tr>
		<th ><label class="UI Label Inline" ><fmt:message key="edit.label.isregistry" bundle="${serverMsg}" />:</label></th>
		<td>
			<syswf:selectOne id="isRegistry" name="isRegistry" 
				value="${uddiWizard}" property="isRegistry" mode="checkbox" optionValues="true"
				dataType="boolean" optionCaptions="">
				<syswf:attribute name="class" value="UI Form Checkbox" />
			</syswf:selectOne>	
		</td>
	</tr>
</table>
</syswf:block>
<syswf:block className="UI Block Green">
	<div class="UI Form Controls">
		<syswf:control mode="button" caption="${next}" hint="${nextHint}" action="doNext" >
			<syswf:attribute name="class" value="btn btn-primary" />
		</syswf:control> 
		<syswf:control mode="button" caption="${cancel}" hint="${cancelhint}"  action="rollback" targetDepth="${sessionStack.currentDepth-1}">
			<syswf:attribute name="class" value="btn btn-gray" />
		</syswf:control>
	</div>
</syswf:block>