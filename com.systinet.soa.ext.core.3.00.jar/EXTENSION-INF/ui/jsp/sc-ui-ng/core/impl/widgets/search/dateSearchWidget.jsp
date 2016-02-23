<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>


<c:forEach items="${this.webConditions}" var="condition" varStatus="status">
    <c:set var="inputId" value="${prefix}c${status.index}" />

    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects=".">
        <syswf:param name="condition" value="${condition}" />
    </syswf:control>

    <c:set var="content">
        <table class="UI Table Schedule">
            <col class="TimeCol" />
            <c:if test="${not hideTime}">
                <col class="BreakCol" />
                <col class="TimeCol" />
            </c:if>
            <tr>
                <td>
                    <syswf:input id="${inputId}" name="${inputId}" value="${condition}" property="date">
                    </syswf:input>
                </td>
                <c:if test="${not hideTime}">
                    <td>
                        <label class="UI Label Inline" for="${inputId}Time">&nbsp;: </label>
                    </td>
                    <td>
                        <syswf:component name="/core/impl/widget/timeCombo" prefix="${inputId}Time">
                            <syswf:param name="time" value="${condition}" property="time"/>
                        </syswf:component>
                    </td>
                </c:if>
            </tr>
        </table>


    </c:set>

    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}w">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${condition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            var dts_${inputId} = new Ext.HP.DateField({
                id : '${inputId}',
                applyTo : '${inputId}',
                disableKeyFilter : true,
                <c:if test="${not empty this.dateFormat}">format: '<c:out value="${this.dateFormat}"/>',</c:if>
                autoHeight : true,
                width : 150,
                triggerAction : 'all'
            });
        });

//]]>
</script>

</c:forEach>



