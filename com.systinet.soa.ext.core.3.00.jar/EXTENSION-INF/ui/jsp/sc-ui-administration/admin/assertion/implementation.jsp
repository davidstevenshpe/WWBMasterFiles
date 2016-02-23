<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.assertion.AssertionMessages" var="messages" />
    <table class="UI Table Properties">
       <col class="LabelCol"/>
       <col/>
       <tbody>
        <tr> 
            <th>
                <label class="UI Label Inline"><fmt:message key="assertion.validates" bundle="${messages}"/></label>
            </th> 
            <td>
                <span class="IconAlign"><syswf:out value="${applicableTo}" context="HtmlBody"/></span>
            </td>
        </tr>
        <tr> 
            <th>
                <label class="UI Label Inline"><fmt:message key="assertion.type" bundle="${messages}"/></label>
            </th> 
            <td>
                 <span class="IconAlign"><syswf:out value="${dialect}" context="HtmlBody"/></span>
            </td>
        </tr>
       </tbody>
   </table>
<pre class="HorizontalSrollBar">
    <syswf:out value="${definition}" context="HtmlBody"/>
</pre>
   
   
