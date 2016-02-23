<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<c:choose>
    <c:when test="${actionMode eq 'edit'}">
	    <syswf:block className="UI Block Common">
	        <div class="Content">
		        <table class="UI Table Properties">
		           <col class="LabelCol"/>
		           <col/>
		           <tbody>
			           <tr> 
			                <th>
			                    <label class="UI Label Inline"><fmt:message key="birt.reportDefinition_label" bundle="${report_Message}"/></label>
			                </th> 
			                <td>
			                    <syswf:control mode="script" affects="." action="changeDefinition" caption="${prefix}changeDefinition" loadingMask="true"/>
			                    <syswf:selectOne name="reportDefinitionTypeSelector" value="${this}" property="definitionId"
			                                     mode="menu" optionCaptions="${this.definitionTypes}"
			                                     optionCaptionsProperty="label" optionValues="${this.definitionTypes}"
			                                     optionValuesProperty="definitionId">
			                        <syswf:attribute name="onChange">${prefix}changeDefinition();</syswf:attribute>
			                    </syswf:selectOne>
			                </td>
			            </tr>
		           </tbody>
		       </table>
	       </div>
	       
	    </syswf:block> 
    
	    <c:if test="${this.definitionId ne '_none_defintionId_'}">
	       <syswf:component name="/detail/editArtifactProperties" prefix="nameDesc">
	           <syswf:param name="artifact" value="${artifact}"/>
	           <syswf:param name="customizationId" value="${parentCustomizationId}.namedescsProperties"/>
	       </syswf:component>
	    </c:if>     
	    <syswf:block  className="UI Block Common">
	        <div class="Content">
		        <table class="UI Table Properties">
		           <col class="LabelCol"/>
		           <col/>
		           <tbody>
			           <c:if test="${not empty this.parameters}">
			                <tr> 
			                   <td colspan="2"><br><fmt:message key="birt.require_param_hint" bundle="${report_Message}"/></td>
			                </tr>
			                <c:forEach var="reportParam" items="${this.parameters}">
			                    <tr>
			                        <th>
			                            <label class="UI Label Inline" title="${reportParam.promptText}"><c:out value="${reportParam.promptText}"/>:</label>
			                        </th>
			                        <td>&nbsp;&nbsp;
			                            <syswf:input name="reportParam_${reportParam.name}" value="${reportParam}" property="value"
			                                         hint="${reportParam.hint}" mode="text">
			                                 <syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>
			                            </syswf:input>
			                        </td>
			                    </tr>
			                </c:forEach>
			            </c:if>
		            </tbody>
		        </table>
	        </div>
	    </syswf:block>
    </c:when> 
    <c:otherwise>
        <syswf:block className="UI Block Common">
                <div class="Content">
                   <table class="UI Table Properties">
                       <col class="LabelCol" />
                       <col/>
                       <tbody>
                           <tr>
                               <th colspan="2">
                                   <div class="Title"><h3><fmt:message key="birt.reportParameters_label" bundle="${report_Message}"/></h3> </div>
                               </th>
                           </tr>
                           <tr>    
			                   <th>
			                       <label class="UI Label Inline"><fmt:message key="birt.reportDefinition_label" bundle="${report_Message}"/></label>
			                   </th>
			                   <td>
			                       <span class="IconAlign" title="${this.definitionLabel}">&nbsp;&nbsp;<c:out value="${this.definitionLabel}"/></span>
			                   </td>
                           </tr>
			               <c:forEach var="reportParam" items="${this.parameters}">
			                   <tr>
			                       <th>
			                           <label class="UI Label Inline" title="${reportParam.promptText}"><c:out value="${reportParam.promptText}"/>:</label>
			                       </th>
			                       <td>
			                           <span class="IconAlign" title="${reportParam.value}">&nbsp;&nbsp;<c:out value="${reportParam.value}"/></span>
			                       </td>
			                   </tr>
			               </c:forEach>
			               <c:if test ="${not empty this.parameters}">
				                <tr>
				                   <td colspan="2">
				                       <syswf:component name="/reports/impl/birt/changeBirtParams" prefix="changeParamsPrefix">
				                           <syswf:param name="artifact" value="${artifact}"/>
				                       </syswf:component>
				                   </td>
				                </tr>
			               </c:if>
                       </tbody>
                   </table>
                </div>
        </syswf:block>   
    </c:otherwise> 
</c:choose>
