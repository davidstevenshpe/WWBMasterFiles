<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages" var="system_Messages" />
<table class="UI Table Properties">
	<colgroup>
	   <col class="LabelCol" />
	   <col />
	</colgroup>
	<tbody>
	     <tr>
	         <th>
	             <label class="UI Label Inline"><fmt:message key="systemsettings.properties.name.label" bundle="${system_Messages}"/>:</label>
	        </th>
	        <td>
	            <span class="IconAlign"><c:out value="${propertyBean.name}"/></span>
	        </td>
	    </tr>
	    <tr>
	        <th>
	            <label class="UI Label Inline"><fmt:message key="systemsettings.properties.value.label" bundle="${system_Messages}"/>:</label>
	        </th>
	        <td>
	            <syswf:textArea id ="${prefix}_value_input" name="value" value="${propertyBean}" property="value">
                </syswf:textArea>
                <script type="text/javascript">
//<![CDATA[

                    var editorContent = new Ext.BoxComponent(
                        {
                            autoShow: true,
                            applyTo: '<c:out value="${prefix}_value_input"/>',
                            width: 300,
                            height: 100
                        }
                    );
                
//]]>
</script>
                                         
	          </td>
	      </tr>
	      
	 </tbody>
</table>
