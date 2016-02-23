<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:forEach items="${this.webConditions}" var="webCondition" varStatus="status">
    <c:set var="inputId" value="${prefix}_widgetInput${status.index}"/>

    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects="..">
        <syswf:param name="condition" value="${webCondition}" />
    </syswf:control>

    <c:set var="content">
        <syswf:input name="widgetInput${status.index}" value="${webCondition}" property="value" id="${inputId}">
           <c:choose>
                 <c:when test="${webCondition.hasError}">
                    <syswf:attribute name="class">UI Form Text String Input x-form-text x-form-invalid</syswf:attribute>
                </c:when>
                <c:otherwise>
                    <syswf:attribute name="class">x-form-text x-form-field</syswf:attribute>
                </c:otherwise>
            </c:choose>
        </syswf:input>

        <c:if test="${webCondition.hasError}">
            <em class="x-form-invalid-msg UI Invalid">
                <span>${webCondition.errorMessage}</span>
            </em>
        </c:if>

        <c:if test="${not empty this.operatorValues and webCondition.showOperators}">
            <c:set var="operatorId" value="${prefix}_operator${status.index}"/>
            <syswf:selectOne mode="menu" value="${webCondition}" property="operator"
                optionValues="${this.operatorValues}" optionCaptions="${this.operatorCaptions}"
                name="operator${status.index}"
                id="${operatorId}">
            </syswf:selectOne>
        </c:if>

    </c:set>


    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${webCondition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="wrapped" value="${true}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>



    <c:if test="${dataType eq 'date'}">
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                    var dts_${prefix}_date = new Ext.HP.DateField({
                        id : '${inputId}_dateSelector',
                        applyTo : '${inputId}',
                        disableKeyFilter : true,
                        format: 'M j, Y',
                        autoHeight : true,
                        width : 150,
                        triggerAction : 'all'
                    });
            });

//]]>
</script>
    </c:if>
</c:forEach>