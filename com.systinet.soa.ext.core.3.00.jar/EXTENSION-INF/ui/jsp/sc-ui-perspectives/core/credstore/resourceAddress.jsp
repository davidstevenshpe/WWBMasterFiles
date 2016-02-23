<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.credstore.credstoremessages" var="credstore_Messages"/>
<fmt:message var="addAddressCaption" key="credstore.add_address" bundle="${credstore_Messages}" />
<table class="UI Table Properties">
     <col class="LabelCol" />
     <col />
     <tbody>
         <c:forEach items="${resourceCredential.patterns}" var="urlPattern" varStatus="i">
            <tr>
               <td colspan="2">
                    <syswf:input id ="urlPatternId_${i.count}" name="urlPatternName_${i.count}" value="${urlPattern}" property="value">
				       <syswf:attribute name="class" value="UI Form Text String"></syswf:attribute>
				    </syswf:input>
				   
				    <syswf:control id="remove${i.count}" mode="postanchor" affects="." action="remove" wrapper="span">
				       <syswf:attribute name="class" value="UI Icon Delete Context"/>
				       <syswf:param name="urlPattern" value="${urlPattern}" />
				    </syswf:control>
               </td>
            </tr>
         </c:forEach>
         <tr>
              <td colspan="2">
                  <syswf:control mode="postanchor" affects="." action="addAddress" caption="${addAddressCaption}" >
					   <syswf:attribute name="class" value="UI Icon Add" />
				  </syswf:control>
              </td>
         </tr> 
     </tbody>
</table>         
             


