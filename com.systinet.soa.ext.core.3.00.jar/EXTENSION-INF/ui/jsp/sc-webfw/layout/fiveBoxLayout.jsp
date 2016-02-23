<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<div class="GUILayout">

  <div class="GUICustomizeOptions<c:if test="${((layoutEditingParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true'))}">Open</c:if>">
      <syswf:component prefix="${panel.activeLayout.name}" name="/layout/layoutControls" wrap="false">
        <syswf:param name="panel" value="${panel}"/>
        <syswf:param name="layout" value="${layout}"/>
        <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
      </syswf:component>
  </div>
  <c:if test="${((layoutEditingParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true'))}">
    <div class="Customize">
  </c:if>

  <div class="">
  <table class="GUIFiveBoxes" border="0" cellspacing="0" width="100%">

    <tr class="GUIAboveStripe">

      <td class="GUIBox GUIBox1" valign="top">
        <div class="GUIBoxBody" id="box1">
        <syswf:component prefix="upperLeft" name="/layout/box">
          <syswf:param name="panel" value="${panel}"/>
          <syswf:param name="box" value="${panel.activeLayout.boxes['upperLeft']}"/>
          <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
        </syswf:component>
                        
        <div class="GUIArea GUILastArea" id="box1Last"></div>
        </div>
        
        <div class="GUIBoxBody" id="box6">
          <syswf:component prefix="metaBox" name="/layout/box">
            <syswf:param name="panel" value="${panel}"/>
            <syswf:param name="box" value="${panel.activeLayout.boxes['meta']}"/>
            <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
          </syswf:component>
        </div>
      
        <div class="GUIArea GUILastArea" id="box6Last"></div>
        </div>
      </td>

      <td class="GUIBox GUIBox2" valign="top">
        <div class="GUIBoxBody" id="box2">
        <syswf:component prefix="upperRight" name="/layout/box">
          <syswf:param name="panel" value="${panel}"/>
          <syswf:param name="box" value="${panel.activeLayout.boxes['upperRight']}"/>
          <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
        </syswf:component>
        <div class="GUIArea GUILastArea" id="box2Last"></div>
        </div>
      </td>

    </tr>
    <tr class="GUIStripe">
      <td class="GUIBox GUIBox3" colspan="2" valign="top">
        <div class="GUIBoxBody" id="box3">
        <div class="GUIArea">
        <div class="GUIAreaBody">

          <div class="GUIStripeButtons">
            <span class="RightOnes">
              <syswf:component prefix="rightButtons" name="/layout/box">
                <syswf:param name="panel" value="${panel}"/>
                <syswf:param name="box" value="${panel.activeLayout.boxes['rightButtons']}"/>
                <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
              </syswf:component>
            </span>
            <span class="LeftOnes">
              <syswf:component prefix="leftButtons" name="/layout/box">
                <syswf:param name="panel" value="${panel}"/>
                <syswf:param name="box" value="${panel.activeLayout.boxes['leftButtons']}"/>
                <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
              </syswf:component>
            </span>
          </div>
          <div class="GUIStripeMessage">
             <c:out value="${panel.areas['message'].code}" escapeXml="no"/>
<%--            <p><strong class="NoticeTitle">Important:</strong> If you made any changes, click "Save changes" button to apply</p>--%>
          </div>
        </div>
        </div>
        <div class="GUIArea GUILastArea" id="box3Last"></div>
        </div>
      </td>
    </tr>
    <tr class="GUIBelowStripe">
      <td class="GUIBox GUIBox4" valign="top">
        <div class="GUIBoxBody" id="box4">
        <syswf:component prefix="downLeft" name="/layout/box">
          <syswf:param name="panel" value="${panel}"/>
          <syswf:param name="box" value="${panel.activeLayout.boxes['downLeft']}"/>
          <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
        </syswf:component>
        
        <c:if test="${not empty panel.activeLayout.boxes['deprecated'].assignedAreas}">
          <div class="GUIBoxBody" id="box7">
            <div style="background:lightgrey; padding:20px;">
              <syswf:component prefix="deprecatedBox" name="/layout/box">
                <syswf:param name="panel" value="${panel}"/>
                <syswf:param name="box" value="${panel.activeLayout.boxes['deprecated']}"/>
                <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
              </syswf:component>
            </div>
          </div>
        </c:if>
        
        <div class="GUIArea GUILastArea" id="box4Last"></div>
        </div>
      </td>

      <td class="GUIBox GUIBox5" valign="top">
        <div class="GUIBoxBody" id="box5">
        <syswf:component prefix="downRight" name="/layout/box">
          <syswf:param name="panel" value="${panel}"/>
          <syswf:param name="box" value="${panel.activeLayout.boxes['downRight']}"/>
          <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
        </syswf:component>
        <%--
        <ul class="LinksList PageControls">
          <li class="PermissionsLink"><a href="..." class="Control Control"><span></span></a></li>
          <li class="PoliciesLink"><a href="..." class="Control Control"><span></span></a></li>
          <li class="RESTLink"><a href="..." class="Control Control"><span></span></a></li>
          <li class="DeleteLink"><a href="..." class="Control Control"><span></span></a></li>
        </ul>
        <div class="ContextPart">
          <ul class="LinksList PageControls">
            <li class="SynchronizeLink"><a href="..." class="Control Control"><span></span></a></li>
            <li class="ValidateLink"><a href="..." class="Control Control"><span></span></a></li>
          </ul>
        </div> --%>
        <div class="GUIArea GUILastArea" id="box5Last"></div>
        </div>
      </td>

    </tr>
  </table>
  </div>

  <c:if test="${((layoutEditingParameters.displayMode eq 'customize') or (customizeLayoutSwitch eq 'true'))}">
    </div>
  </c:if>

</div>

