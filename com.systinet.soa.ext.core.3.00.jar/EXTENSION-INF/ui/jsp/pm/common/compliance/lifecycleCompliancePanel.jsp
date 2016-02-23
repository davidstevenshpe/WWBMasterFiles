<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="data" type="com.hp.systinet.policy.ui.compliance.CompliancePanelData"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="bundle"/>

<c:if test="${!data.hidePanel}">
    <c:set var="complianceInPercents" value="${data.complianceInPercents}%"/>

    <div class="EA-right-panel">
    	<fmt:message key="compliancePanel_title" bundle="${bundle}"/>
      <div class="Content">
        <div>
          <table class="UI Table Properties">
          <c:if test="${not data.dataNotAvailable}">
            <col />
            <col class="SimpleGraphLabelCol" />
          </c:if>
            <tr>
    <c:choose>
    <c:when test="${data.dataNotAvailable}"> <%-- Data Not Available --%>
              <td>
                <div class="com_simplechart">
                  <div class="com_simplechart">
                    <div class="ChartTextForCompliance"><fmt:message key="compliancePanel_notavailable_label" bundle="${bundle}"/></div>
                  </div>
                </div>
              </td>
    </c:when>
    <c:when test="${data.obsolete || data.available}"> <%-- Data Available or Obsolete --%>
        <c:set var="chartClass">ChartFill</c:set>
        <%-- Set chart title, text, class --%>
        <c:choose>
            <c:when test="${data.available}">
                <fmt:message var="chartTitle" key="compliancePanel_available_title" bundle="${bundle}">
                  <fmt:param value="${data.complianceInPercents}"/>
                </fmt:message>
                <c:set var="chartText">${data.complianceInPercents}%</c:set>
            </c:when>
            <c:when test="${data.obsolete}">
                <fmt:message var="chartTitle" key="compliancePanel_obsolete_title" bundle="${bundle}">
                  <fmt:param value="${data.complianceInPercents}"/>
                </fmt:message>
                <c:set var="chartText">(${data.complianceInPercents}%)</c:set>
                <c:set var="chartClass">${chartClass} Obsolete</c:set>
            </c:when>
        </c:choose>
        <%-- Set chart color --%>
        <c:set var="chartClass">${chartClass} <c:choose>
            <c:when test="${data.complianceInPercents == 100}">Compliant</c:when>
            <c:when test="${data.complianceInPercents <= data.notCompliantThreashold}">NotCompliant</c:when>
            <c:otherwise>Warning</c:otherwise>
        </c:choose></c:set>
              <td>
                <div class="com_simplechart">
                  <div class="ChartCanvas">
                    <div style="width:${data.complianceInPercents}%;" title="${chartTitle}" class="${chartClass}"></div>
                  </div>
                </div>
              </td>
              <td>${chartText}</td>
    </c:when>
    <c:otherwise> <%-- Validation Is Running --%>
          <fmt:message var="running_title" key="compliancePanel_running_title" bundle="${bundle}"/>
          <fmt:message var="running_value" key="compliancePanel_running_value" bundle="${bundle}"/>
              <td>
                <div class="com_simplechart">
                  <div class="ChartCanvas">
                    <div style="width:100%; background-color:#390;" title="${running_title}" class="ChartFill Running"></div>
                  </div>
                </div>
              </td>
              <td>${running_value}</td>
        </c:otherwise>
    </c:choose>
            </tr>
          </table>
        </div>
      </div>
      <div class="Footer">
        <c:if test="${data.showRecalculateLink}">
            <fmt:message var="link_recalculate_text" key="compliancePanel_link_recalculate_text" bundle="${bundle}"/>
            <fmt:message var="link_recalculate_title" key="compliancePanel_link_recalculate_title" bundle="${bundle}"/>
            <syswf:control id="compliancePanelRecalculate" mode="anchor" action="recalculate" affects="." caption="${link_recalculate_text}">
                <syswf:attribute name="class">UI Icon Validation</syswf:attribute>
                <syswf:attribute name="title">${link_recalculate_title}</syswf:attribute>
            </syswf:control>
        </c:if>
        <c:if test="${data.showDetailsLink && data.showRecalculateLink}">&nbsp;|&nbsp;</c:if>
        <c:if test="${data.showDetailsLink}">
            <fmt:message var="link_details_text" key="compliancePanel_link_details_text" bundle="${bundle}"/>
            <fmt:message var="link_details_title" key="compliancePanel_link_details_title" bundle="${bundle}"/>
            <syswf:component prefix="complianceDetails" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                <syswf:param name="uuid" value="${artifact._uuid}"/>
                <syswf:param name="caption" value="${link_details_text}"/>
                <syswf:param name="artifactTabId" value="compliance"/>
                <syswf:param name="class" value="UI Icon Info"/>
                <syswf:param name="title" value="${link_details_title}"/>
            </syswf:component>
        </c:if>
      </div>
	</div>

    <c:if test="${data.running}">
        <%-- Validation is Running, setup automatic reload --%>
        <syswf:control mode="script" action="reloadSection" caption="reloadCompliancePanel" affects="."/>
        <script type="text/javascript">
//<![CDATA[

          setTimeout("callFunction('reloadCompliancePanel')", getRandomLoadingInterval());
        
//]]>
</script>
    </c:if>
</c:if>
