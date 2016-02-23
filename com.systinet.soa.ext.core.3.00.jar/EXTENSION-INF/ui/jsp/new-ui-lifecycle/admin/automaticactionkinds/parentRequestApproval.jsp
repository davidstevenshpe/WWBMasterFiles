<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="parentRequestApproval.artifactLabel" var="artifactLabel" bundle="${messages}" />
<fmt:message key="parentRequestApproval.stageLabel" var="stageLabel" bundle="${messages}" />

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="artifactCaptions" type="java.util.List"--%>
<%--@elvariable id="artifactValues" type="java.util.List"--%>
<%--@elvariable id="stageCaptions" type="java.util.List"--%>
<%--@elvariable id="stageValues" type="java.util.List"--%>
<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.admin.automaticactionkinds.ParentRequestApproval.Bean"--%>

<table class="UI Table Properties">
    <colgroup>
        <col class="MidLabelCol"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <th class="first">
                <label class="UI Label Inline"><c:out value="${artifactLabel}"/></label>
            </th>
            <td>
                <syswf:selectOne id="${prefix}_artifactId" name="${prefix}_artifactSelect" mode="menu"
                                 optionValues="${artifactValues}"
                                 optionCaptions="${artifactCaptions}"
                                 value="${bean}" property="selectedArtifact"/>
                <script type="text/javascript">
                    //<![CDATA[

                    Ext.onReady(function() {
                        var var_${prefix}_artifactId = new Ext.HP.ComboBox({
                            id: '${prefix}_artifactId',
                            transform: '${prefix}_artifactId',
                            forceSelection: true,
                            typeAhead: false,
                            disableKeyFilter: false,
                            editable: true,
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
                <label class="UI Label Inline"><c:out value="${stageLabel}"/></label>
            </th>
            <td>
                <syswf:selectOne id="${prefix}_stageId" name="${prefix}_stageSelect" mode="menu"
                                 optionValues="${stageValues}"
                                 optionCaptions="${stageCaptions}"
                                 value="${bean}" property="selectedStage"/>
                <script type="text/javascript">
                    //<![CDATA[

                    Ext.onReady(function() {
                        var var_${prefix}_stageId = new Ext.HP.ComboBox({
                            id: '${prefix}_stageId',
                            transform: '${prefix}_stageId',
                            forceSelection: true,
                            typeAhead: false,
                            disableKeyFilter: false,
                            editable: true,
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

<syswf:control mode="script" caption="parentRequestApprovalPost" action="save" loadingMask="true"/>
<script type="text/javascript">
//<![CDATA[

    function customAutomaticActionFn() {
        parentRequestApprovalPost();
        reloadAASection();
    }
    //]]>
</script>

