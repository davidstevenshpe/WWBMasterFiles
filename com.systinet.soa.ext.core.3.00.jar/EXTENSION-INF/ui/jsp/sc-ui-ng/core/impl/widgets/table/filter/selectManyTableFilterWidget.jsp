<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uisccomponents_Message"/>

<div class="webfw-Window" id="${prefix}-webfw-Window">
<div id="${filterContentId}" class="x-hidden">
    <div class="x-cmp-separator">
        <script type="text/javascript">
//<![CDATA[

            function ${prefix}_validate() {
                var checked = false;
                var allChecked = true;
                Ext.get('${filterContentId}').select('input').each(function(input) {
                    if ('${filterContentId}_selectall' != input.dom.id) {
                        checked = checked || input.dom.checked;
                        allChecked = allChecked && input.dom.checked;
                    }
                }, this);
                var okbutton = Ext.getCmp('<c:out value="${filterId}"/>_ok_button');
                if (okbutton) {
                    if (checked) {
                        okbutton.enable();
                    } else {
                        okbutton.disable();
                    }
                }
                var allCheckbox = Ext.get('${filterContentId}_selectall');
                if (allCheckbox) {
                    allCheckbox.dom.checked = allChecked;
                }
            }
        
//]]>
</script>        
        <table class="x-cmp-holder">
            <colgroup>
                <col />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td>
                        <input id="${filterContentId}_selectall" type="checkbox" name="selectall" value="" <c:if test="${allSelected}">checked</c:if>/>
                        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady(function() {
                                Ext.get('${filterContentId}_selectall').on('click', function() {
                                    Ext.get('${filterContentId}').select('input').each(function(input) {
                                        input.dom.checked = (this.dom.checked ? true : false);
                                    }, this);                                    
                                    var okbutton = Ext.getCmp('<c:out value="${filterId}"/>_ok_button');
                                    if (okbutton) {
                                        if (this.dom.checked) {
                                            okbutton.enable();
                                        } else {
                                            okbutton.disable();
                                        }
                                    }
                                });
                            });
                        
//]]>
</script>
                    </td>
                    <td>
                        <label for="${filterContentId}_selectall"><fmt:message key="SelectAll" bundle="${uisccomponents_Message}"/></label>
                    </td>
                </tr>
                <c:forEach var="value" items="${this.availableValues}" varStatus="status">
                    <tr>
                        <td>
                            <syswf:selectOne name="filterValue${status.index}" mode="checkbox" optionValues="true" optionCaptions=" "
                                value="${this.selectedValues[value]}" property="selected" dataType="boolean" id="${filterContentId}_${status.index}"/>
                            <script type="text/javascript">
//<![CDATA[

                                Ext.onReady(function() {
                                    Ext.get('${filterContentId}_${status.index}_0').on('click', ${prefix}_validate);
                                });
                            
//]]>
</script>
                        </td>
                        <td>
                            <label for="${filterContentId}_${status.index}_0"><c:out value="${this.availableValueCaptions[value]}"/></label>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <syswf:control mode="script" action="applyFilter" caption="${applyFilterControlName}" affects="."/>

</div>
</div>