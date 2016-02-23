<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="removeWidget" var="removeMsg" bundle="${widgetMessages}"/>

<c:if test="${not empty this.webCondition}" >

    <syswf:control id="${prefix}remove" mode="script" caption="${prefix}remove" action="onRemove" affects="..">
    </syswf:control> 
    
    <c:set var="inputId" value="${prefix}_selectId" />
    
    <c:set var="content">
        <syswf:selectOne name="widgetInput${status.index}" displayAsRow="true" mode="menu" 
            value="${this.webCondition}" optionValues="${this.valuesList}" 
            optionCaptions="${this.captionsList}" property="value"
            id="${inputId}" />
    </c:set>        
    
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${this.webCondition}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="removeFce" value="${prefix}remove"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
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

</c:if>