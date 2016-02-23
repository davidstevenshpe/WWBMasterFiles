<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="this" type="com.hp.systinet.report.ui.impl.policy.ExternalDocumentSourceComponent"--%>
<%--@elvariable id="globalSession" type="java.util.Map"--%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />
<fmt:message key="policyreport.externaldocument.auth.label" var="auth_Label" bundle="${pr_Messages}" />

<br/>

<syswf:control mode="ajax" action="switchAuthentication" caption="${prefix}_switchAuthentication" id="${prefix}_switchAuthentication" />
<syswf:control mode="ajax" action="changeUrl" caption="${prefix}_changeUrl" id="${prefix}_changeUrl" />
<table class="UI Table Properties">
	<tr>
		<td width="5%">
			<label class="UI Label Inline">
				<fmt:message key="policyreport.externaldocument.url.label" bundle="${pr_Messages}" />:
			</label>
		</td>
		<td style="padding-right: 8px;">
			<syswf:input id="${prefix}_exDocUrl" name="exDocUrl" value="${this.docBean}" property="url">
				<syswf:attribute name="style" value="width:100%" />
				<syswf:attribute name="onChange">${prefix}_changeUrl();</syswf:attribute>
				<c:choose>
	                <c:when test="${empty errors['url']}">
	                    <syswf:attribute name="class">x-form-text UI Input x-form-field</syswf:attribute>
	                </c:when>
	                <c:otherwise>
	                    <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
	                </c:otherwise>
	            </c:choose>
			</syswf:input>
			<c:if test="${not empty errors['url']}">
                <em class="x-form-invalid-msg UI Invalid">
                    <c:out value="${errors['url']}"/>
                </em>
            </c:if>
                     
		    <script type="text/javascript">
//<![CDATA[

		        Ext.onReady(function() {
		            new Ext.HP.Input({
		                applyTo : '<c:out value="${prefix}_exDocUrl" />'
		            });
		        });
		    
//]]>
</script>
		</td>
	</tr>
    <c:if test="${this.showAuthenticationSection}">
    	<tr>
		<td></td>
		<td>
			<table>
				<tr>
					<td colspan="2">
						<syswf:selectOne id="${prefix}_switchAuth" name="switchAuth" value="${this.docBean}" 
						property="authentication" mode="checkbox" optionValues="true" optionCaptions="" dataType="boolean" >
							<syswf:attribute name="onChange">${prefix}_switchAuthentication();</syswf:attribute>
							<syswf:attribute name="class" value="x-form-text UI Input x-form-field" />
						</syswf:selectOne>
						<label class="UI Label Inline">${auth_Label}</label>
					</td>
				</tr>
				<tr>
					<td width="20%">
						<label class="UI Label Inline">
							<fmt:message key="policyreport.externaldocument.username.label" bundle="${pr_Messages}" />:
						</label>
					</td>
					<td style="padding-right: 8px;">
						<syswf:input id="${prefix}_exDocUsername" name="exDocUsername" value="${this.docBean}" property="username"  disabled="${not this.docBean.authentication}">
							<syswf:attribute name="style" value="width:100%" />
                            <syswf:attribute name="autocomplete" value="off"/>
							<c:choose>
				                <c:when test="${empty errors['username']}">
				                    <syswf:attribute name="class">x-form-text UI Input x-form-field</syswf:attribute>
				                </c:when>
				                <c:otherwise>
				                    <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
				                </c:otherwise>
				            </c:choose>
						</syswf:input>
						<c:if test="${not empty errors['username']}">
                            <em class="x-form-invalid-msg UI Invalid">
                                <c:out value="${errors['username']}"/>
                            </em>
                        </c:if>
                        
					    <script type="text/javascript">
//<![CDATA[

					        Ext.onReady(function() {
					            new Ext.HP.Input({
					                applyTo : '<c:out value="${prefix}_exDocUsername" />'
					            });
					        });
					    
//]]>
</script>
					</td>
				</tr>
				<tr>
					<td width="20%">
						<label class="UI Label Inline">
							<fmt:message key="policyreport.externaldocument.password.label" bundle="${pr_Messages}" />:
						</label>
					</td>
					<td style="padding-right: 8px;">
						<syswf:input id="${prefix}_exDocPassword" name="exDocPassword" value="${this.docBean}" property="password" disabled="${not this.docBean.authentication}" mode="password">
							<syswf:attribute name="style" value="width:100%" />
                            <syswf:attribute name="autocomplete" value="off"/>
							<c:choose>
				                <c:when test="${empty errors['password']}">
				                    <syswf:attribute name="class">x-form-text UI Input x-form-field</syswf:attribute>
				                </c:when>
				                <c:otherwise>
				                    <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
				                </c:otherwise>
				            </c:choose>
						</syswf:input>
						<c:if test="${not empty errors['password']}">
                            <em class="x-form-invalid-msg UI Invalid">
                                <c:out value="${errors['password']}"/>
                            </em>
                        </c:if>
                        
					    <script type="text/javascript">
//<![CDATA[

					        Ext.onReady(function() {
					            new Ext.HP.Input({
					                applyTo : '<c:out value="${prefix}_exDocPassword" />'
					            });
					        });
					    
//]]>
</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
    </c:if>
</table>