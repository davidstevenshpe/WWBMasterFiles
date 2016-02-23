<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<table class="UI Table Properties">
    <col class="LabelCol"/>
    <col/>
    <tbody>
         <tr> 
              <th >
                  <label class="UI Label Inline"><fmt:message key="birt.reportDefinition_label" bundle="${report_Message}"/></label>
              </th> 
              <td>
                  <span class="IconAlign"><c:out value="${definitionLabel}"/></span>
              </td>
         </tr>
         <c:if test="${not empty birtParams}">
              <tr>
                 <td colspan="2"><br><fmt:message key="birt.require_param_hint" bundle="${report_Message}"/></td>
              </tr>
              <c:forEach var="reportParam" items="${birtParams}">
                  <tr>
                      <th>
                          <label class="UI Label Inline" title="${reportParam.promptText}"><c:out value="${reportParam.promptText}"/>:</label>
                      </th>
                      <td>&nbsp;&nbsp;
                          <syswf:input name="${reportParam.name}" value="${reportParam}" property="value"
                                       hint="${reportParam.hint}" mode="text">
                               <syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>
                          </syswf:input>
                      </td>
                  </tr>
              </c:forEach>
          </c:if>
    </tbody>
</table>