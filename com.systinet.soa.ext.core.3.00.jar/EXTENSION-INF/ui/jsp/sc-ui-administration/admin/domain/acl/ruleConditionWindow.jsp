<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="ruleCondition.operation.is" var="isOperation" bundle="${domain_Messages}" />
<fmt:message key="ruleCondition.operation.not" var="notOperation" bundle="${domain_Messages}" />

<c:choose>
<c:when test="${empty holder.taxs}">
	<label><syswf:out value="${noConditionsLabel}" context="HtmlBody"/></label>
</c:when>
<c:otherwise>
	<table class="UI Table ExpressionBuilder">
		<col>
		<col class="XShortCol">
		<col>
		<tbody>
			<tr>
				<td class="">
					<div class="ExpressionSelect">
						<c:forEach items="${holder.taxs}" var="tax" varStatus="cnt">
							<c:choose>
								<c:when test="${tax.taxUri eq holder.currentCondition.taxUri}">
									<div class="ExpressionNode Active">
										<a href="javascript:void(0)" id="${prefix}_changeCurrentTaxLink_${cnt.count}"><span><syswf:out value="${tax.taxName}" context="HtmlBody"/></span></a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="ExpressionNode">
										<a href="javascript:void(0)" id="${prefix}_changeCurrentTaxLink_${cnt.count}"><span><syswf:out value="${tax.taxName}" context="HtmlBody"/></span></a>
									</div>
								</c:otherwise>
							</c:choose>
							<script type="text/javascript">
							//<![CDATA[

								Ext.onReady(function() {
								    attachOn('${prefix}_changeCurrentTaxLink_${cnt.count}','click', function() { ${prefix}_changeCurrentTax_${cnt.count}(); });
								});
							
							//]]>
							</script>
							<syswf:control mode="ajax" action="changeTax" caption="${prefix}_changeCurrentTax_${cnt.count}" id="${prefix}_changeCurrentTax_${cnt.count}">
								<syswf:param name="taxUri" value="${tax.taxUri}" />
							</syswf:control>
						</c:forEach>
					</div>
				</td>
				<td>
					<div class="ExpressionSelect">			
					<c:choose>
						<c:when test="${holder.currentCondition.operator eq 'IS'}">						
							<div class="ExpressionNode Active">
								<a href="javascript:void(0)" id="${prefix}_changeToIsOperatorLink"><span><syswf:out value="${isOperation}" context="HtmlBody"/></span></a>
							</div>
							<div class="ExpressionNode">
								<a href="javascript:void(0)" id="${prefix}_changeToIsNotOperatorLink"><span><syswf:out value="${notOperation}" context="HtmlBody"/></span></a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="ExpressionNode">
								<a href="javascript:void(0)" id="${prefix}_changeToIsOperatorLink"><span><syswf:out value="${isOperation}" context="HtmlBody"/></span></a>
							</div>
							<div class="ExpressionNode Active">
								<a href="javascript:void(0)" id="${prefix}_changeToIsNotOperatorLink"><span><syswf:out value="${notOperation}" context="HtmlBody"/></span></a>
							</div>					
						</c:otherwise>
					</c:choose>
					</div>
					<syswf:control mode="ajax" action="changeOperator" caption="${prefix}_changeToIsOperator" id="${prefix}_changeToIsOperator">
						<syswf:param name="operator" value="IS" />
					</syswf:control>
					<syswf:control mode="ajax" action="changeOperator" caption="${prefix}_changeToIsNotOperator" id="${prefix}_changeToIsNotOperator">
						<syswf:param name="operator" value="NOT" />
					</syswf:control>				
					<script type="text/javascript">
					//<![CDATA[

						Ext.onReady(function() {
						    attachOn('${prefix}_changeToIsOperatorLink','click', function() { ${prefix}_changeToIsOperator(); });
						    attachOn('${prefix}_changeToIsNotOperatorLink','click', function() { ${prefix}_changeToIsNotOperator(); });
						});
					
					//]]>
					</script>				
				</td>
				<td>
					<div class="ExpressionSelect">
						<c:forEach items="${holder.currentValues}" var="value" varStatus="cnt">
							<div class="ExpressionNode">
								<syswf:selectOne id="${prefix}_selectValue_${cnt.count}" name="selectValue_${cnt.count}" 
									selectClass="UI Form Checkbox Inline" value="${value}" property="checked" 
									mode="checkbox" optionValues="true" optionCaptions=" " optionValuesEnabled="${value.enable}" 
									dataType="boolean" displayAsRow="true">
									<syswf:attribute name="class" value="UI Form Checkbox" />
								</syswf:selectOne>
								<label class="UI Label Inline" for="${prefix}_selectValue_${cnt.count}_0"><syswf:out value="${value.name}" context="HtmlBody"/></label>
							</div>
						</c:forEach>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</c:otherwise>	
</c:choose>