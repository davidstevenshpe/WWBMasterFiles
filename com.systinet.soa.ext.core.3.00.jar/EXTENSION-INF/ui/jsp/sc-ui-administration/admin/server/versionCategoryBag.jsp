<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<table class="UI Table Properties">
    <col class="LabelCol">
    <col/>
    <tbody>
    <tr>
        <th>
            <label class="UI Label Inline">
                <fmt:message key="server.version.label" bundle="${messages}"/>:
            </label>
        </th>
        <td>
            <div class="AJAXContainer">
                <%--@elvariable id="selectedBean" type="com.hp.systinet.sc.ui.admin.server.VersionBean"--%>
                <c:choose>
                    <%--@elvariable id="mode" type="java.lang.String"--%>
                    <c:when test="${mode eq 'VIEW'}">
                        <%--@elvariable id="selectedLabel" type="java.lang.String"--%>
                        <c:out value="${selectedLabel}"/>
                    </c:when>
                    <c:otherwise>
                        <%--@elvariable id="optionValues" type="java.lang.String[]"--%>
                        <%--@elvariable id="optionCaptions" type="java.lang.String[]"--%>
                        <%--@elvariable id="prefix" type="java.lang.String"--%>
                        <syswf:selectOne name="serverVersion" id="${prefix}_serverVersion"
                                         value="${selectedBean}" property="selectedValue" mode="menu"
                                         optionValues="${optionValues}" optionCaptions="${optionCaptions}"/>
                        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady( function() {
                                var cmb = new Ext.form.ComboBox({
                                    id : '<c:out value="${prefix}_serverVersion" />',
                                    transform : '<c:out value="${prefix}_serverVersion" />',
                                    disableKeyFilter : true,
                                    mode : 'local',
                                    autoHeight : true,
                                    resizable : true,
                                    listWidth : 300,
                                    width : 300,
                                    triggerAction : 'all',
                                    editable : false
                                });
                            });
                        
//]]>
</script>
                    </c:otherwise>
                </c:choose>
            </div>
        </td>
    </tr>
    </tbody>
</table>
