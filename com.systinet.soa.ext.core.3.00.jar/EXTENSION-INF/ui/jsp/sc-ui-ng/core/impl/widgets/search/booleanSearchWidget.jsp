<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoUIMessages"/>

<c:if test="${empty optionCaptions}">
    <c:set var="optionCaptions">
        <fmt:message bundle="${tornadoUIMessages}" key="yes"/>,<fmt:message bundle="${tornadoUIMessages}" key="no"/>
    </c:set>
</c:if>

<c:forEach items="${this.webConditions}" var="condition" varStatus="status">
    <c:set var="inputId" value="${prefix}BooleanWidget${status.index}"/>
    
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects="..">
        <syswf:param name="condition" value="${condition}" />
    </syswf:control>    
    
    <c:set var="content" >
        <syswf:selectOne id="${inputId}" name="${inputId}" displayAsRow="true" mode="radio" 
            value="${condition}" optionValues="true,false" optionCaptions="${optionCaptions}" property="value" />
    </c:set>
    
        
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="label" value="${label}"/>
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${condition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>
    
    
</c:forEach>