<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />
<c:set var="optional" value="${not this.widgetModel.required}" />

<syswf:block className="UI Block Common">
<div class="Title">
    <h3><span><c:out value="${this.widgetModel.label}" /></span></h3>
</div>
<div class="Content">
<table class="UI Table Properties">
    <col class="LabelCol" />
    <col />
    <c:forEach var="line" items="${this.address.addressLines}" varStatus="stat">
        <c:if test="${mode ne 'view' or not empty line.value}">
        <tr>
            <th><label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>">
                <c:choose>
                    <c:when test="${line.useType eq 'Recipient'}">
                        <fmt:message key="address.recipient" bundle="${widgetMessages}"/>:
                    </c:when>
                    <c:when test="${line.useType eq 'Street'}">
                        <fmt:message key="address.street" bundle="${widgetMessages}"/>:
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="address.other" bundle="${widgetMessages}"/>:
                    </c:otherwise>
                </c:choose>
                </label>
                <c:if test="${mode ne 'view'}">
                    <c:if test="${not optional}">
                        <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                    </c:if>
                </c:if>
            </th>
            <td>
                <c:if test="${mode eq 'edit'}">
                    <syswf:input id="addressWidget${stat.index}" name="addressWidget${stat.index}" value="${line}" property="value">
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
                                applyTo : 'addressWidget${stat.index}'
                            });
                        });
                    
//]]>
</script>
                </c:if>
                <c:if test="${mode eq 'view'}">
                    <span class="IconAlign"><c:out value="${line.value}" /></span>
                </c:if>
            </td>
        </tr>
        </c:if>
    </c:forEach>

    <c:if test="${mode ne 'view' or not empty this.address.city}">
    <tr>
        <th>
            <label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>"><fmt:message key="address.city" bundle="${widgetMessages}"/>:</label>
            <c:if test="${mode ne 'view'}">
                <c:if test="${not optional}">
                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                </c:if>
            </c:if>
        </th>
        <td>
            <c:if test="${mode eq 'edit'}">
                <syswf:input id="addressWidgetCity" name="addressWidgetCity" value="${this.address}" property="city">
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
                            applyTo : 'addressWidgetCity'
                        });
                    });
                
//]]>
</script>
            </c:if>
            <c:if test="${mode eq 'view'}">
                <span class="IconAlign"><c:out value="${this.address.city}" /></span>
            </c:if>
        </td>
    </tr>
    </c:if>

    <c:if test="${mode ne 'view' or not empty this.address.stateProvince}">
    <tr>
        <th>
            <label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>"><fmt:message key="address.stateProvince" bundle="${widgetMessages}"/>:</label>
            <c:if test="${mode ne 'view'}">
                <c:if test="${not optional}">
                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                </c:if>
            </c:if>
        </th>
        <td>
            <c:if test="${mode eq 'edit'}">
                <syswf:input id="addressWidgetState" name="addressWidgetState" value="${this.address}" property="stateProvince">
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
                            applyTo : 'addressWidgetState'
                        });
                    });
                
//]]>
</script>
            </c:if>
            <c:if test="${mode eq 'view'}">
                <span class="IconAlign"><c:out value="${this.address.stateProvince}" /></span>
            </c:if>
        </td>
    </tr>
    </c:if>

    <c:if test="${mode ne 'view' or not empty this.address.postalCode}">
    <tr>
        <th>
            <label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>"><fmt:message key="address.postalCode" bundle="${widgetMessages}"/>:</label>
            <c:if test="${mode ne 'view'}">
                <c:if test="${not optional}">
                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                </c:if>
            </c:if>
        </th>
        <td>
            <c:if test="${mode eq 'edit'}">
                <syswf:input id="addressWidgetPostalCode" name="addressWidgetPostalCode" value="${this.address}" property="postalCode">
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
                            applyTo : 'addressWidgetPostalCode'
                        });
                    });
                
//]]>
</script>
            </c:if>
            <c:if test="${mode eq 'view'}">
                <span class="IconAlign"><c:out value="${this.address.postalCode}" /></span>
            </c:if>
        </td>
    </tr>
    </c:if>

    <c:if test="${mode ne 'view' or not empty this.address.country}">
    <tr>
        <th>
            <label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>"><fmt:message key="address.country" bundle="${widgetMessages}"/>:</label>
            <c:if test="${mode ne 'view'}">
                <c:if test="${not optional}">
                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
                </c:if>
            </c:if>
        </th>
        <td>
            <c:if test="${mode eq 'edit'}">
                <syswf:input id="addressWidgetCountry" name="addressWidgetCountry" value="${this.address}" property="country">
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
                            applyTo : 'addressWidgetCountry'
                        });
                    });
                
//]]>
</script>
            </c:if>
            <c:if test="${mode eq 'view'}">
                <span class="IconAlign"><c:out value="${this.address.country}" /></span>
            </c:if>
        </td>
    </tr>
    </c:if>
</table>
</div>
</syswf:block>