<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach items="${this.webConditions}" var="webCondition" varStatus="status">
    <c:set var="inputId" value="${prefix}select${status.index}" />
    
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects=".">
        <syswf:param name="condition" value="${webCondition}" />
    </syswf:control> 
    
    <c:set var="content">
        <syswf:component name="/core/impl/widget/relatedArtifactSuggestedSearch" prefix="searchInput${status.index}">
            <syswf:param name="webCondition" value="${webCondition}"/>
            <syswf:param name="inputId" value="${inputId}"/>
            <syswf:param name="targetSdmName" value="${targetSdmName}"/>
            <syswf:param name="class" value="x-form-text"/>
            <syswf:param name="allowAllAvailableArtifactTypes" value="${true}"/>
        </syswf:component>
    </c:set>
    
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="webCondition" value="${webCondition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>
    

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            var var_${inputId} = new Ext.form.TextField({
                applyTo: '${selectId}',
                width: 200
            });
        });
    
//]]>
</script>
    
</c:forEach>