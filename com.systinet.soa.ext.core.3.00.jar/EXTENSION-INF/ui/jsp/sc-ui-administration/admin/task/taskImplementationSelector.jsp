<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${renderTaskImplementation}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages" />
    <syswf:control action="setImplementation" caption="setImplementation" mode="script" affects="." />
    <table class="UI Table Properties">
    <col class="LabelCol">
    <col>
        <tbody>
            <tr>
                <th><label class="UI Label Inline"><fmt:message key="editCustomTask.implementation" bundle="${messages}" />:</label>
                </th>
                <td>
                
                <c:choose>
                    <c:when test="${mode eq 'NEW'}">
                        <syswf:selectOne id="${prefix}_implementations" name="implementation" mode="menu" optionValues="${taskImplementationSelectorBean.implementations}"
                        optionCaptions="${taskImplementationSelectorBean.implementations}" property="selectedBeanName" optionCaptionsProperty="name" optionValuesProperty="beanName"
                        value="${taskImplementationSelectorBean}" size="1" />
                        
                        <c:if test="${empty taskImplementationSelectorBean.implementations}">  
                            <em class="x-form-invalid-msg UI Invalid">
                                <span><fmt:message key="editCustomTask.noImplementations" bundle="${messages}" /></span>
                            </em>    
                        </c:if>      
                    </c:when>
                    <c:otherwise>
                        ${taskImplementationSelectorBean.selectedCustomJobName}
                    </c:otherwise>  
                </c:choose>
                
                </td>
            </tr>
        </tbody>
    </table>
    
    <script type="text/javascript">
//<![CDATA[

        Ext.get('${prefix}_implementations').on('change',function(){
        	setImplementation();
        });
    
//]]>
</script>
</c:if>
