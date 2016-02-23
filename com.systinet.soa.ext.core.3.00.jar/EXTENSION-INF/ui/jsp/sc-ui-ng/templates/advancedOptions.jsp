<%--

Usage:

<syswf:wrap template="../sc-ui-ng/templates/advancedOptions.jsp">
 your content
</syswf:wrap>

to store opener status, add parameter advancedOptionsOpenerHolder, which has to be a bean
with property advancedOptionsClosed:

<syswf:wrap template="../sc-ui-ng/templates/advancedOptions.jsp">
<syswf:param name="advancedOptionsOpenerHolder" value="${bean}" />
 your content
</syswf:wrap>

--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="wrapMessages" />

<c:set var="wrapContent" value="${wrapContent}" scope="page" />
<%  // trimming prepares wrapped content for the "not empty" check
    String wrapContent = (String) pageContext.getAttribute("wrapContent");
    if (wrapContent != null) wrapContent = wrapContent.trim();
    pageContext.setAttribute("wrapContentTrimmed", wrapContent);
%>

<c:if test="${not empty wrapContentTrimmed}">
<c:if test="${not empty advancedOptionsOpenerHolder}">
    <div class="x-hidden">
        <syswf:selectOne mode="checkbox" id="${prefix}advancedOptionsHolder" value="${advancedOptionsOpenerHolder}" property="advancedOptionsClosed" optionValues="true" optionCaptions=" " displayAsRow="true" dataType="boolean" name="advancedOptionsHolder" />
    </div>
</c:if>

    <div class="UI AdvancedOptions Labeled<c:choose><c:when test="${empty advancedOptionsOpenerHolder || advancedOptionsOpenerHolder.advancedOptionsClosed}"> Closed</c:when><c:otherwise> Open</c:otherwise></c:choose>">
        <div class="OptionsOpener">
            <a href="javascript:void(0);" onclick="advancedOptionsSwitch();" id="${prefix}opener"><span><fmt:message bundle="${wrapMessages}" key="AdvancedOptions" /></span></a>
        </div>
        <script type="text/javascript">
//<![CDATA[

            function advancedOptionsSwitch(){
                AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
                <c:if test="${not empty advancedOptionsOpenerHolder}">
                var chb = Ext.get('${prefix}advancedOptionsHolder_0').dom;
                chb.checked = !chb.checked;
                </c:if>
            }

        
//]]>
</script>
        <div class="Content"<c:if test="${not empty advancedOptionsOpenerHolder && not advancedOptionsOpenerHolder.advancedOptionsClosed}"> style="display: block"</c:if>>
            <c:out value="${wrapContent}" escapeXml="false"/>
        </div>
    </div>
</c:if>