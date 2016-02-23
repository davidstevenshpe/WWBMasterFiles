<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="com.hp.systinet.sync.ui.L10nUIMessages" var="messages"/>

<fmt:message var="requiredCaption" key="required" bundle="${messages}" />
<fmt:message var="requiredTitle" key="required.title" bundle="${messages}" />

<table class="UI Table Properties">
    <col class="LabelCol">
    <col/>
    <tbody>
      <c:forEach items="${propertyDescriptors}" var="descriptor">
         <c:if test="${ (mode eq 'EDIT') or (not empty integrationProperties[descriptor.name]) }">
             <tr>
                <td>
                    <label class="UI Label Inline"><syswf:out value="${descriptor.displayName}" context="HtmlBody"/>:</label>
                    <c:if test="${mode eq 'EDIT'}">
                        <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                    </c:if>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${mode eq 'EDIT'}">
                            <div class="Text">
                                <syswf:input name="${descriptor.name}" value="${integrationProperties}" property="${descriptor.name}" mode="text" >
                                    <syswf:attribute name="style" value="width:98%"></syswf:attribute>
                                    <syswf:attribute name="class" value="x-form-text UI Input x-form-field"></syswf:attribute>
                                </syswf:input>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="AJAXContainer">
                                <syswf:out value="${integrationProperties[descriptor.name]}" context="HtmlBody"/>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </td>
             </tr>
         </c:if>
      </c:forEach>
    </tbody>
</table>