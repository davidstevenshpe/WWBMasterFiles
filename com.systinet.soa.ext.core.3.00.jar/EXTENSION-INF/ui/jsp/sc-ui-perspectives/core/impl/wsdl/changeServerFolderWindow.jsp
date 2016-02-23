<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>

<div class="Message Warning">
    <div class="MessageContainer">
        <div class="Icon"><span>&nbsp;</span></div>
        <div class="Content">
            <fmt:message bundle="${messages}" key="wsdl.change.info" />
        </div>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

function doNothing() {;}

//]]>
</script>

<div class="UI Offset">
    <table class="UI Table Properties">
        <colgroup>
            <col class="LabelCol" />
            <col />
        </colgroup>
        <syswf:component name="/core/impl/imports/file/selectServerFolder" prefix="serverFolder" wrap="false">
            <syswf:param name="importFileBean" value="${changeServerFolderBean}"/>
            <syswf:param name="locationsBrowserUrl" value="${locationsBrowserUrl}"/>
            <syswf:param name="recalculateLocationFunction" value="doNothing"/>
            <syswf:param name="inputWidth" value="350" />
        </syswf:component>
        <tr>
            <th>
                <label for="${prefix}filename" class="UI Label">
                    <fmt:message bundle="${messages}" key="wsdl.change.newFilename" />
                </label>
            </th>
            <td>
                <syswf:input name="filename" value="${changeServerFolderBean}" property="fileName" id="${prefix}filename" />
                <script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
                new Ext.HP.Input({
                    width: 350,
                    applyTo : '${prefix}filename'
                });
});
                
//]]>
</script>
            </td>
        </tr>
    </table>
</div>