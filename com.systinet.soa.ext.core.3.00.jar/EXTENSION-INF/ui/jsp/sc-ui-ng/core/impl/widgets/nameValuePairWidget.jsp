<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />
<fmt:message key="namePairValue.name" bundle="${widgetMessages}" var="nameLabel" />
<fmt:message key="namePairValue.value" bundle="${widgetMessages}" var="valueLabel" />

<c:set var="optional" value="${mode ne 'view' and not this.widgetModel.required}" />

<c:choose>
    <c:when test="${this.single}">
        <c:if test="${mode eq 'view'}">
            <c:out value="${this.value.val}" />
        </c:if>    
    </c:when>
    <c:otherwise>
    
    
        <syswf:block className="UI Block Common">
            <div class="Title">
                <h3><span><c:out value="${this.widgetModel.label}" /></span></h3>
            </div>
            <div class="Content">
                <table class="UI Table Properties">
                    <col class="LabelCol" />
                    <col />
                    
                    <c:forEach var="value" items="${this.values}" varStatus="status">
                        <tr>
                            <th>
                                <label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>">${nameLabel}</label>
                                <c:if test="${mode ne 'view'}">
					                <c:if test="${not optional}">
					                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
					                </c:if>
					            </c:if>
                            </th>
                            <td>
                                <c:if test="${mode eq 'edit'}">
                                    <syswf:input id="${prefix}${status.index}Name" name="${prefix}${status.index}Name" value="${value}" property="name" >
                                        <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
                                    </syswf:input>
                                    <script type="text/javascript">
//<![CDATA[

                                        Ext.onReady(function() {
                                            new Ext.HP.Input({
                                                applyTo : '<c:out value="${prefix}${status.index}Name" />'
                                            });
                                        });
                                    
//]]>
</script>
                                </c:if>
                                <c:if test="${mode eq 'view'}">
                                    <span class="IconAlign"><c:out value="${value.name}" /></span>
                                </c:if>
                            </td>
                        </tr>
                        
                        <tr>
                            <th>
                                <label class="UI Label <c:choose><c:when test="${not optional}">Required Full</c:when><c:otherwise>Inline</c:otherwise></c:choose>">${valueLabel}</label>
                                <c:if test="${mode ne 'view'}">
					                <c:if test="${not optional}">
					                    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
					                </c:if>
					            </c:if>
                            </th>
                            <td>
                                <c:if test="${mode eq 'edit'}">
                                    <div class="width-100-percent">
                                        <syswf:input id="${prefix}${status.index}Value" name="${prefix}${status.index}Value" value="${value}" property="val" >
                                            <syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
                                        </syswf:input>
                                    </div>
                                    <div>
                                        <syswf:control id="remove${status.index}" mode="postanchor" caption="${removeMsg}" affects="." action="remove" wrapper="span">
                                            <syswf:param name="index" value="${status.index}" />
                                            <syswf:attribute name="class" value="UI Icon Delete Context"/>
                                        </syswf:control>
                                    </div>
                                    <script type="text/javascript">
//<![CDATA[

                                        Ext.onReady(function() {
                                            new Ext.HP.Input({
                                                applyTo : '<c:out value="${prefix}${status.index}Value" />'
                                            });
                                        });
                                    
//]]>
</script>
                                </c:if>
                                <c:if test="${mode eq 'view'}">
                                    <span class="IconAlign"><c:out value="${value.val}" /></span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${mode eq 'edit'}">
                        <tr>
                            <th></th>
                            <td>
                                <syswf:control mode="postanchor" affects="." action="add" caption="Add" />
                            </td>
                        </tr>
                    </c:if>
                </table>
            </div>
        </syswf:block>
                        
    </c:otherwise>
</c:choose>



