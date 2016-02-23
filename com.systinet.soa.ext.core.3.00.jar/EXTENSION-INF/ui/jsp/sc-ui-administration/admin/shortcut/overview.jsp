<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="UI Block">
<p>
 <label class="UI Icon Info" style="font-style:italic;">Shortcuts are used to simplify the data model - you can create a shortcut relationship that will link entities directly instead of a whole chain of relationships declared in the SDM model. Read more in the documentation on this topic.</label>
</p>
<table>
    <tbody><tr>
        <th><label class="UI Label Inline" title="Defines how the shortcut calculation are treated"> <span style="margin-left:20px;">Shortcut calculation:</span></label>
        </th>
        <td>
            <span class="IconAlign">
                <c:choose>
                    <c:when test="${this.shortcutCalculationEnabled}">
                        <span style="font-size:14px; color:green"> ENABLED </span>(<syswf:control id="disable" mode="anchor" caption="Disable..." hint="Switch shortcut calculation to disable mode" action="disable"/>)
                    </c:when>
                    <c:otherwise>
                        <span style="font-size:14px; color:red"> DISABLED </span> (<syswf:control id="enable" mode="anchor" caption="Enable..." hint="Switch shortcut calculation to enable mode" action="enable"/>)
                    </c:otherwise>
                </c:choose>
            </span>
        </td>
    </tbody>
</table>
<br/>
<br/>
<syswf:component prefix="shortcutsConfiguration" name="/admin/shortcut/shortcutsConfigurationTable"/>
</div>