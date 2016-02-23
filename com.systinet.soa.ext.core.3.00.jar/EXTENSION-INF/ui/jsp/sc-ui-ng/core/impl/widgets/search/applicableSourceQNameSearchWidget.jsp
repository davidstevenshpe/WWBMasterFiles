<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:if test="${not empty this.webCondition}">
    <c:set var="inputId" value="${prefix}ArtifactType"/>


    <syswf:control mode="script" action="onTypeChanged" caption="${prefix}submitChangedType" id="${prefix}typeChanged" affects="..">
        <syswf:param name="webCondition" value="${this.webCondition}" />
    </syswf:control>

    <syswf:control id="${prefix}remove" mode="script" caption="${prefix}remove" action="onRemove" affects="..">
        <syswf:param name="condition" value="${this.webCondition}" />
    </syswf:control>

    <c:set var="content">
        <syswf:selectOne id="${inputId}" name="${inputId}" mode="menu" value="${this.webCondition}" property="value" optionValues="${this.optionValues}" optionCaptions="${this.optionCaptions}"/>

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
                    triggerAction: 'all',
                    onSelect: function(record){
                    	this.setValue(record.id);
                        this.collapse();
                        ${prefix}submitChangedType();
                    },
                    width: 200
                });
            });

        
//]]>
</script>
    </c:set>

    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${this.webCondition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove"/>
    </syswf:component>
</c:if>
