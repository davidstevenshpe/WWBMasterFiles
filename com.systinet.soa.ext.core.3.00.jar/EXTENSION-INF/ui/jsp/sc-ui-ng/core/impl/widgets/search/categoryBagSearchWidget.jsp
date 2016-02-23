<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="removeWidget" var="removeMsg" bundle="${widgetMessages}"/>
<fmt:message key="removeWidgetHint" var="removeHint" bundle="${widgetMessages}"/>


<c:set var="wrapperDivId" value="${prefix}categoriesWrapper" />
<div class="Form Collection Address" id="${wrapperDivId}">
    <div class="Category Window">
    <table class="UI Table Properties">

        <colgroup>
            <col class="LabelCol" />
            <col />
            <col class="RemoveCol"/>

        </colgroup>

        <tbody>
            <tr>
                <th>
                    <label class="UI Label">
                        <fmt:message key="categoryBag.categoryWidgetLabel" bundle="${widgetMessages}"/>:
                    </label>
                </th>
                <td>

                    <c:forEach items="${this.perTaxonomySelection}" var="perTaxonomySelection" varStatus="status1">
                        <ul class="Categories">
                            <li>
                                <c:out value="${perTaxonomySelection.taxonomy.name}"/>
                            </li>
                            <li>
                                <ul class="Categories">
                                    <c:forEach items="${perTaxonomySelection.categories}" var="categoryHolder" varStatus="status2">
                                        <li>
                                            <syswf:out value="${categoryHolder.category.name}" context="HtmlBody"/>
                                            <%-- FIXME: link should lead to category page --%>
                                             <syswf:control id="remove${status1.index}${status2.index}" mode="anchor" 
                                                    caption="${removeMsg}" action="onRemove" wrapper="span">
                                                    <syswf:param name="categoryHolder" value="${categoryHolder}" />
                                                    <syswf:attribute name="class" value="UI Icon Delete Context"/>
                                             </syswf:control>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </c:forEach>
                    
                    <syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="button">
                        <syswf:param name="selectedCategories" value="${this.selectedCategories}" />
                        <syswf:param name="addCategoryButtonId" value="${prefix}_addCategoryBtn" />
                        <syswf:param name="openFce" value="${prefix}OpenWindow" />
                        <syswf:param name="artifactType" value="${this.artifactType}" />
                        <syswf:param name="taxonomyDSCache" value="${this.taxonomyDSCache}" />
                        <syswf:param name="categoryDSCache" value="${this.categoryDSCache}" />
                        <syswf:param name="taxonomyBrowserListener" value="${this}" />
                    </syswf:component>

                    <syswf:control id="${prefix}removeId" mode="script" caption="${prefix}removeFunction" 
                        action="onRemove" affects=".."/>
                </td>
                <td>
                    <c:if test="${this.model.firstRemovable}">
                        <a id="${prefix}removeLink"
                            class="IconButton Transparent"
                            href="javascript:void(0);"><span><span><span class="Remove"></span></span></span></a>
                            
                        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady(function() {
                                Ext.get('${prefix}removeLink').on('click', function() {
                                    ${prefix}removeFunction();
                                });
                            });
                        
//]]>
</script>
    
                    </c:if>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
</div>

<c:if test="${this.openSelector}" >
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            ${prefix}OpenWindow();
        });
    
//]]>
</script>
</c:if>
