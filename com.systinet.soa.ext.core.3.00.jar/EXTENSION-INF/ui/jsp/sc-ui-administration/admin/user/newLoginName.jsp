<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="userMessages" />
<fmt:message var="requiredTitle" key="create.user.loginName.required_title" bundle="${userMessages}" />
 <table class="UI Table Properties">
     <col class="LabelCol">
     <col/>
     <tbody>
         <tr>
             <th><label class="UI Label Required Full"><fmt:message key="create.user.loginName.label" bundle="${userMessages}" />:</label><sup class="Required" title="${requiredTitle}">*</sup></th>
             <td>
                 <syswf:input id="${prefix}_newLoginName" name="loginName" value="${this.personArtifact}" property ="loginName">
                    <c:choose>
                        <c:when test="${empty error}">
                            <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
                        </c:when>
                        <c:otherwise>
                            <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
                        </c:otherwise>
                    </c:choose>
                </syswf:input>
                <c:if test="${not empty error}">
                    <em class="x-form-invalid-msg UI Invalid">
                        <c:out value="${error}"/>
                    </em>
                </c:if>

                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        new Ext.HP.Input({
                            applyTo : '<c:out value="${prefix}_newLoginName" />'
                        });
                    });

//]]>
</script>
             </td>
         </tr>
     </tbody>
 </table>

