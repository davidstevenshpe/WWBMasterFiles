<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div style="margin: 10px 0 0 20px;font-style:italic;">
 Managed scripts can be used to customize the system. You can use them to customize UI, write custom lifecycle actions, create event handlers for artifact related operations and more.
 Scripts can be treated in the following modes:
 <br/>
 <br/>

   <table>
        <tr style="line-height: 18px"><td><span style="color:red">DISABLED&nbsp;&nbsp;</span></td><td>Scripts that might cause serious failures, e.g. scripts executed on server startup, artifact event handlers are not executed at all</td></tr>
        <tr style="line-height: 18px"><td><span style="color:blue">CHECKED</span></td><td>Scripts that might cause serious failures are executed in a safe mode, when a compilation failure occurs or an exception is raised from a script it is ignored. This mode should be used for script debugging only.</td></tr>
        <tr style="line-height: 18px"><td><span style="color:green">UNCHECKED&nbsp;&nbsp;</span></td><td>Scripts are executed with no limitations</td></tr>
   </table>
  <br/>
  Script processing can be also disabled by setting the "platform.disable.scripting" configuration property to "true" within the top level domain, or by passing the same property as a java system property during the server startup.

</div>

<br/>



<table>
<tbody><tr>
<th><label class="UI Label Inline" title="Defines how scripts are treated"> <span style="margin-left:20px;">Script Processing Mode:</span></label>
</th>
<td>
<span class="IconAlign">

<c:choose>
  <c:when test="${!this.scriptingAvailable}">
     <span style="font-size:14px; color:red">DISABLED </span>
  </c:when>
  <c:when test="${this.scriptingEnabled}">
    <c:choose>
      <c:when test="${this.scriptingDebug}">
       <span style="font-size:14px; color:blue"> CHECKED </span>(<syswf:control id="add1" mode="anchor" caption="Unchecked..," hint="Switch to script unchecked mode" action="production"/>
       <syswf:control id="add3" mode="anchor" caption="Disable.." hint="Disable embedded script execution" action="disable"/>)
      </c:when>
      <c:otherwise>
        <span style="font-size:14px; color:green">UNCHECKED </span> (<syswf:control id="add2" mode="anchor" caption="Checked..," hint="Switch to script checked mode" action="debug"/>
                    <syswf:control id="add4" mode="anchor" caption="Disable.." hint="Disable embedded script execution" action="disable"/>)
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <span style="font-size:14px; color:red">DISABLED </span> (<syswf:control id="add5" mode="anchor" caption="Enable.." hint="Enable embedded script execution" action="enable"/>)
  </c:otherwise>
</c:choose>

</span>
</td>
</tr>
</tr>
</tbody>
</table>


<br/>
<br/>
