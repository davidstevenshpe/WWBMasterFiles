<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${mode eq 'view'}">
    <fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
    <c:choose>
        <c:when test="${this.value eq 'true'}">
            <fmt:message key="yes" bundle="${tornadoui_Message}"/>
        </c:when>
        <c:otherwise>
            <fmt:message key="no" bundle="${tornadoui_Message}"/>
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${mode eq 'edit'}">
    <span class="IconAlign">
    	<syswf:selectOne name="booleanWidget"
        mode="checkbox" optionValues="true" optionCaptions=" " 
        value="${this}" property="value">
        	<syswf:attribute name="class">UI Form Checkbox</syswf:attribute>
        </syswf:selectOne>
        
    </span>
</c:if>