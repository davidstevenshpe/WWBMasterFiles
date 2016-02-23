<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${mode eq 'table'}">
  <c:if test="${not empty styleClass}"><span class="${styleClass}" title="${this.date}">${this.date} ${this.time}</span></c:if>
  <c:if test="${empty styleClass}"><c:out value="${this.date} ${this.time}" /></c:if>
</c:if>

<c:if test="${mode eq 'view'}">
    <c:out value="${this.date} ${this.time}" />
</c:if>

<c:if test="${mode eq 'edit'}">
    <table class="UI Table Schedule">
        <col class="TimeCol" />
        <c:if test="${not hideTime}">
            <col class="TimeCol" />
        </c:if>
        <tr>
            <td>
                <syswf:input id="${prefix}_date" name="date" value="${this}" property="date">
                    <syswf:attribute name="class">UI Form Text LongString</syswf:attribute>
                </syswf:input>
                <script type="text/javascript">
//<![CDATA[
                    var dts_${prefix}_date = new Ext.HP.DateField({
                        id : '${prefix}_date',
                        applyTo : '${prefix}_date',
                        disableKeyFilter : true,
                        <c:if test="${not empty this.dateFormat}">format: '<c:out value="${this.dateFormat}"/>',</c:if>
                        autoHeight : true,
                        width : 150,
                        triggerAction : 'all'
                    });

//]]>
</script>
            </td>
            <c:if test="${not hideTime}">
                <td>
                    <syswf:component name="/core/impl/widget/timeCombo" prefix="time">
                        <syswf:param name="time" value="${this}" property="time"/>
                        <syswf:param name="notEditableTime" value="${notEditableTime}" />
                        <c:if test="${not empty timeType}">
                            <syswf:param name="timeType" value="${timeType}"/>
                        </c:if>
                    </syswf:component>
                </td>
            </c:if>
        </tr>
    </table>
</c:if>