<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>



<div class="GUILayout">

<div class="GUICustomizeOptions<c:if test="${((layoutEditingParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true'))}">Open</c:if>">
    <syswf:component prefix="${panel.activeLayout.name}" name="/layout/layoutControls">
      <syswf:param name="panel" value="${panel}"/>
      <syswf:param name="layout" value="${layout}"/>
      <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
    </syswf:component>
</div>
<c:if test="${((layoutEditingParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true'))}">
  <div class="Customize">
</c:if>
<table class="GUIOneBox" border="0" cellspacing="0" width="100%">
  <tr class="GUIWithoutStripe">
    <td class="GUIBox GUIBox1" valign="top">

  <c:forEach var="box" items="${panel.activeLayout.boxList}">
    <syswf:component prefix="${box.name}" name="/layout/box">
      <syswf:param name="panel" value="${panel}"/>
      <syswf:param name="box" value="${box}"/>
      <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
    </syswf:component>
  </c:forEach>

    </td>
  </tr>
</table>
<c:if test="${((layoutEditingParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true'))}">
  </div>
</c:if>

</div>
