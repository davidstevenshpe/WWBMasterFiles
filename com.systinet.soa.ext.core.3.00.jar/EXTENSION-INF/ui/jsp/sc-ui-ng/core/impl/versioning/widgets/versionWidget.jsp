<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:if test="${mode eq 'view'}">

<a id="${prefix}idVersionHistory-activator" href="javascript:void(0);" class="hp-version-history"><syswf:out value="${version}" context="HtmlBody"/></a>

<script type="text/javascript">
//<![CDATA[

function ${prefix}handle() {
    if (typeof ${prefix}compare() == 'function') {
           ${prefix}compare();
    }
}

//]]>
</script>

<syswf:component name="/core/tipWindow" prefix="vw">
    <syswf:param name="winComponent" value="/core/impl/versioning/widget/versionWidgetContents" />
    <syswf:param name="winActivator" value="${prefix}idVersionHistory-activator" />
    <syswf:param name="winTitle"><fmt:message bundle="${widgetMessages}" key="versionWidget.winTitle" /></syswf:param>
    <syswf:param name="winCustomButtons">
    [{
        text: '<fmt:message bundle="${widgetMessages}" key="versionWidget.compare" />',
        handler: ${prefix}handle
    }]
    </syswf:param>
    <syswf:param name="winDontShowMask" value="true" />
    
    <syswf:param name="version" value="${version}" />
    <syswf:param name="artifact" value="${artifact}" />
    <syswf:param name="buttonFunc" value="${prefix}compare" />
</syswf:component>

</c:if>

<c:if test="${mode eq 'edit'}">
    <syswf:input id="${prefix}_versionWidget" name="versionWidget" value="${this}" property="version">
            <c:choose>
                <c:when test="${empty error}">
                    <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
                </c:when>
                <c:otherwise>
                    <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
                </c:otherwise>
            </c:choose>        
    </syswf:input>
    
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            new Ext.HP.Input({
                applyTo : '<c:out value="${prefix}_versionWidget" />'
            });
        });
    
//]]>
</script>
</c:if>