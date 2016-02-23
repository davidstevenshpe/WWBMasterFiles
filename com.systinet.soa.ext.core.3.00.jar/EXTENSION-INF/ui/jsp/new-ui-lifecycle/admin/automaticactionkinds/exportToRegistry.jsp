<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="lifecycleCategories" type="java.util.List"--%>
<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="environment.label" var="environmentLabel" bundle="${messages}" />
<fmt:message key="applyWhen.label" var="applyWhenLabel" bundle="${messages}" />

<table class="UI Table Properties">
    <colgroup>
        <col class="MidLabelCol"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <th class="first">
                <label class="UI Label Inline">${applyWhenLabel}:</label>
            </th>
            <td>
                <syswf:selectOne id="${prefix}_applyWhenId" name="${prefix}_exportToRegistries_actionEvent" value="${autoExportToRegistriesBean}" property="selectedEvent" mode="menu"
                                   optionValues="${autoExportToRegistriesBean.events}" dataType="enum"
                                   optionCaptions="${autoExportToRegistriesBean.eventLabels}"/>
                <script type="text/javascript">
                    //<![CDATA[

                    Ext.onReady(function() {
                        var var_${prefix}_eventId = new Ext.HP.ComboBox({
                            id: '${prefix}_applyWhenId',
                            transform: '${prefix}_applyWhenId',
                            forceSelection: true,
                            typeAhead: true,
                            disableKeyFilter: false,
                            editable: false,
                            listWidth : 300,
                            width : 300
                        });
                    });
                    //]]>
                </script>
            </td>            
        </tr>
        <tr>
            <th class="first">
                <label class="UI Label Inline">${environmentLabel}:</label>
            </th>
            <td>
                <syswf:selectOne id="${prefix}_envId" name="${prefix}_exportToRegistries_actionEnv" value="${autoExportToRegistriesBean}" property="selectedEnvironment" mode="menu"
                                   optionValues="${autoExportToRegistriesBean.environments}" optionValuesProperty="val" 
                                   optionCaptions="${autoExportToRegistriesBean.environments}" optionCaptionsProperty="name"/>
                <script type="text/javascript">
                    //<![CDATA[

                    Ext.onReady(function() {
                        var var_${prefix}_envId = new Ext.HP.ComboBox({
                            id: '${prefix}_envId',
                            transform: '${prefix}_envId',
                            forceSelection: true,
                            typeAhead: true,
                            disableKeyFilter: false,
                            editable: false,
                            listWidth : 300,
                            width : 300
                        });
                    });
                    //]]>
                </script>
            </td>
        </tr>
    </tbody>
</table>

<syswf:control mode="script" caption="autoExportToRegistriesPost" action="save" loadingMask="true"/>
<script type="text/javascript">
    //<![CDATA[

    function customAutomaticActionFn() {
    	autoExportToRegistriesPost();
        reloadAASection();
    }
    //]]>
</script>