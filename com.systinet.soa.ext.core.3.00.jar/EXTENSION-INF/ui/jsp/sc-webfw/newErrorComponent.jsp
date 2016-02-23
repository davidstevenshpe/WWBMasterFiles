<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="messages"/>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="uimessages"/>

<fmt:message key="error_description" var="errorDescription" bundle="${messages}"/>
<fmt:message key="system_error" var="systemError" bundle="${messages}"/>
<fmt:message key="error_where" var="where" bundle="${messages}"/>
<fmt:message key="error_when" var="when" bundle="${messages}"/>
<fmt:message key="error_lastKnownLocation" var="lastKnownLocation" bundle="${messages}"/>
<fmt:message key="error_technicalDetails" var="technicalDetails" bundle="${messages}"/>
<fmt:message key="error_stackTrace" var="stackTrace" bundle="${messages}"/>
<fmt:message key="error_at" var="at" bundle="${messages}"/>
<fmt:message key="error_OK" var="ok" bundle="${messages}"/>

<table class="UI Layout" style="margin-left: 24px; width: 90%;">
	<tbody>
		<tr>
			<td class="UI Middle">
			    <syswf:uimessage type="error"><c:out value="${errorDescription}"/></syswf:uimessage>
			
			    <div class="UI Text Description">
			        <c:out value="${errorBean.description}"/>
			    </div>
			
			    <syswf:block className="UI Block Common">
			         <!--Details properties-->
			         <div class="Content">
			             <table class="UI Table Properties">
			                 <col class="LabelCol">
			                 <col>
			                 <tbody>
			                     <c:if test="${not empty errorBean.whereDetail}">
			                     <tr>
			                         <th><label class="UI Label Inline">${where}:</label></th>
			                         <td>
			                             <c:out value="${errorBean.whereDetail}"/>
			                         </td>
			                     </tr>
			                     </c:if>
			                     <tr>
			                         <th><label class="UI Label Inline">${when}:</label></th>
			                         <td>
			                             <c:out value="${errorBean.whenDetail}"/>
			                         </td>
			                     </tr>
			                 </tbody>
			             </table>
			         </div>
			    </syswf:block>
			</td>
		</tr>
		<tr>
			<td>
			    <syswf:block className="UI Block Green">
			       <div class="Content">
			           <table>
			           		<tr>
			           			<td>
			           				<!--Right side links  -->
						           <syswf:component name="lastKnownLocation" prefix="lastKnownLocationRight" wrap="false">
						               <syswf:param name="id">lastKnownLocationRight</syswf:param>
						               <syswf:param name="class">UI PageAction GoBack</syswf:param>
						               <syswf:param name="caption"><c:out value="${lastKnownLocation}"/></syswf:param>
						           </syswf:component>
			           			</td>
			           			<c:if test="${errorBean.enableTechnicalDetails}">
			           			<td style="padding-left: 30px;">
			           				<a href="javascript:void(0)" class="UI PageAction ViewDetails" id="technicalDetails"><span>${technicalDetails}</span></a>
			           			</td>
			           			</c:if>

			           		</tr>
			           </table>			           
			       </div>
			    </syswf:block>
			</td>
		</tr>
	</tbody>
</table>
<c:if test="${errorBean.enableTechnicalDetails}">
<div id="technicalDetailsContent" class="x-hidden">
	<div class="x-window-header"><c:out value="${technicalDetails}"/> (<c:out value="${stackTrace}"/>)</div>
	<div class="x-window-body">
	    <div class="UI Offset">
		    <%--
		    The following PRE tag has this nasty feature with formating, thus the foreach
		    must be at the beginning of the line.
		    TODO: ask Mac to use DIV with span classes as it was before instead of the PRE tag
		    TODO: ask Mac how to align the popoup to the left instead of center.
		     --%>
	    	<pre>
<c:forEach items="${errorBean.technicalDetails}" var="detail"><c:out value="${detail}" escapeXml="true"/>
	<c:forEach items="${detail.stackTrace}" var="varTraceLine">${at} <c:out value="${varTraceLine}" escapeXml="true"/>
	</c:forEach>
</c:forEach>
		    </pre>
	    </div>
    </div>
</div>
<script type="text/javascript">
//<![CDATA[
    SPopup.Window.init('technicalDetails', 'technicalDetailsContent', {
        width:550,
        height:400,
        plain:false,
        autoScroll:true,
        centerOnScreen:true,
        buttonAlign:'center',
        maximizable: true,/* show Maximize button */
        minimizable: false,
        buttons:[{
            text:'${ok}',
            handler:function() {
                SPopup.Window.Instance['technicalDetails'].hide();
            }
        }]
    });
//]]>
</script>
</c:if>