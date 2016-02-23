<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:forEach items="${this.webConditions}" var="webCondition" varStatus="status">

    <c:set var="inputId" value="${prefix}GovernanceProcess${status.index}"/>
    
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects="..">
        <syswf:param name="condition" value="${webCondition}" />
    </syswf:control>

    <c:set var="content">
        <syswf:selectOne id="${inputId}" name="${inputId}" mode="menu" value="${webCondition}" property="value"  
        optionValues="${this.governanceProcesses}" optionValuesProperty="value" optionCaptions="${this.governanceProcesses}" 
        optionCaptionsProperty="label" />
    </c:set>
    
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${webCondition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>
            
    <script type="text/javascript">
//<![CDATA[

        
        Ext.onReady(function() {
            var search_artifact_type = new Ext.HP.ComboBox({
                id: '${inputId}',
                transform: '${inputId}',
                forceSelection: true,
                typeAhead: true,
                disableKeyFilter: false,
                editable: false,
                width: 200
            });
        });
        
    
//]]>
</script>
    
</c:forEach>