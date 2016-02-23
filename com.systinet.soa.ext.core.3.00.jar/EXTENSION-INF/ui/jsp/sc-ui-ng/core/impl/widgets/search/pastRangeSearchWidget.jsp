<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:forEach items="${this.webConditions}" var="webCondition" varStatus="status">

    <c:set var="inputId" value="${prefix}select${status.index}" />
    
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects="..">
        <syswf:param name="condition" value="${webCondition}" />
    </syswf:control> 

    <c:set var="content">
        <syswf:selectOne name="pastRange${status.index}" mode="menu"
            optionValues="${this.optionValues}" optionCaptions="${this.optionCaptions}"
            value="${webCondition}" property="value"
            id="${inputId}"/>
    </c:set>
    
    
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="webCondition" value="${webCondition}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>
    
          
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            var var_${selectId}ComboBox = new Ext.HP.ComboBox({
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