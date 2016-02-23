<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uisccomponents_Message"/>

<div id="${filterContentId}" class="x-hidden">
    <table class="x-cmp-holder">
        <colgroup>
            <col />
            <col class="fulfill"/>
        </colgroup>
        <tbody>
            <tr>
                <th><label for="${prefix}_events_from"><fmt:message key="dateFilter.eventsFrom" bundle="${uisccomponents_Message}"/>:</label></th>
                <td>
                    <fmt:message var="modeLabels" key="dateFilter.options" bundle="${uisccomponents_Message}"/>
                    <syswf:selectOne name="events_from" value="${this}" property="selectedMode"
                                     optionValues="all,day,week,month,interval" optionCaptions="${modeLabels}"
                                     id="${prefix}_events_from" mode="menu"/>

                    <script type="text/javascript">
//<![CDATA[


                        function ${prefix}_validate() {

                            var startField = Ext.getCmp('${prefix}_start');
                            var startOk = "" == startField.getActiveError();
                            var endField = Ext.getCmp('${prefix}_end');
                            var endOk = "" == endField.getActiveError();

                            var okbutton = Ext.getCmp('<c:out value="${filterId}"/>_ok_button');
                            if (startOk && endOk) {
                                okbutton.enable();
                            } else {
                                okbutton.disable();
                            }
                        }

//]]>
</script>
                </td>
            </tr>


            <tr id="${prefix}_start_ct" style="display:none">
                <th><label for="${prefix}_start"><fmt:message key="dateFilter.start" bundle="${uisccomponents_Message}"/>:</label></th>
                <td>
                    <syswf:input name="interval_start" value="${this}" property="startDate" dataType="date"
                            id="${prefix}_start"/>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var startField = new Ext.HP.DateField({
                                id: '${prefix}_start',
                                applyTo: '${prefix}_start',
                                <c:if test="${not empty this.format}">format: '<c:out value="${this.format}"/>',</c:if>
                                cls: 'x-filter-menu-layer',
                                width: 100
                            });
                            startField.on('invalid', ${prefix}_validate);
                            startField.on('valid', ${prefix}_validate);
                        });

//]]>
</script>
                </td>
            </tr>
            <tr id="${prefix}_end_ct" style="display:none">
                <th><label for="${prefix}_end"><fmt:message key="dateFilter.end" bundle="${uisccomponents_Message}"/>:</label></th>
                <td>
                    <syswf:input name="interval_end" value="${this}" property="endDate" dataType="date"
                            id="${prefix}_end"/>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var endField = new Ext.form.DateField({
                                id: '${prefix}_end',
                                applyTo: '${prefix}_end',
                                <c:if test="${not empty this.format}">format: '<c:out value="${this.format}"/>',</c:if>
                                cls: 'x-filter-menu-layer',
                                width: 100
                            });
                            endField.on('invalid', ${prefix}_validate);
                            endField.on('valid', ${prefix}_validate);
                        });

//]]>
</script>
                </td>
            </tr>
        </tbody>
    </table>

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            var cmb_events_from = new Ext.HP.ComboBox({
                id: '${prefix}_events_from',
                transform: '${prefix}_events_from',
                forceSelection: true,
                typeAhead: true,
                disableKeyFilter: false,
                cls: 'x-focus',
                listClass: 'x-filter-menu-layer',
                width: 100
            });

            cmb_events_from.on('valid', function(cmp) {
                var interval_start_ct = Ext.get('${prefix}_start_ct');
                var interval_end_ct = Ext.get('${prefix}_end_ct');
                interval_start_ct.setVisibilityMode(Ext.Element.DISPLAY);
                interval_end_ct.setVisibilityMode(Ext.Element.DISPLAY);

                if (cmp.hiddenField.value == 'interval') {
                    interval_start_ct.show();
                    interval_end_ct.show();
                } else {
                    interval_start_ct.hide();
                    interval_end_ct.hide();
                }

            });
        });

//]]>
</script>


    <syswf:control mode="script" action="applyFilter" caption="${applyFilterControlName}" affects="."/>

</div>