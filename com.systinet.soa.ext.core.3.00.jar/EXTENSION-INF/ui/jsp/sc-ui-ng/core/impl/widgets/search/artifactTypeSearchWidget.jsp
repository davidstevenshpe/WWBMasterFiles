<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:forEach items="${this.webConditions}" var="webCondition" varStatus="status">

    <c:set var="inputId" value="${prefix}ArtifactType${status.index}"/>
    
    
    <syswf:control mode="script" action="onTypeChanged" caption="${prefix}${status.index}submitChangedType" id="${prefix}typeChanged${status.index}" affects="..">
        <syswf:param name="webCondition" value="${webCondition}" />
    </syswf:control>
    
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects="..">
        <syswf:param name="condition" value="${webCondition}" />
    </syswf:control>
    
    <c:set var="content">
        <syswf:selectOne id="${inputId}" name="${inputId}" mode="menu" value="${webCondition}" property="value" optionValues="${this.optionValues}" optionCaptions="${this.optionCaptions}"/>
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                var search_artifact_type = new Ext.HP.ComboBox({
                    id: '${inputId}',
                    transform: '${inputId}',
                    forceSelection: true,
                    typeAhead: false,
                    disableKeyFilter: false,
                    editable: true,
                    triggerAction: 'all',
                    onSelect: function(record){
                    	this.setValue(record.id);
                        this.collapse();
                        ${prefix}${status.index}submitChangedType();
                    },
					listeners:{
						scope: this,
						afterRender: function (comp) {
							var item = comp.getStore().data.items[0];
							comp.emptyText = item.data.text;
						},
						change: function (comp, value) {
							if (comp.getRawValue() == null || comp.getRawValue() == '') {
								var item0 = comp.getStore().data.items[0];
								comp.setValue(item0.data.value);
							}
						}						
					},
                    width: 200
                });
            });
            
        
//]]>
</script>
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
            
</c:forEach>