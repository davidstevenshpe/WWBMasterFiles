<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.composite.compositeMessages" var="compositeMessages"/>

<%--<fmt:message var="expandAllButtonLabel" key="expandAllButtonLabel" bundle="${compositeMessages}"/>--%>

<input name="${prefix}$expandRow" id="${prefix}$expandRow" type="hidden"/>
<syswf:control mode="script" affects="." caption="submitRowExpanded" action="expandCollapse" loadingMask="true"/>

<div id="${prefix}treeviewCt" class="UI Tree">
    <table class="TreeGrid Fixed">
        <colgroup>
            <c:if test="${this.treeDisplayState.selectionMode ne 'none'}">
                <col class="ColSelect"/>
            </c:if>
            <col class="ColTree" />
            <%--<c:if test="${not traversalRuleSet eq 'governance'}">--%>
                <col class="ColProduction" />
                <col class="ColProcess" />
                <col class="ColProcess" />
            <%--</c:if>--%>
        </colgroup>
        <c:if test="${this.displayHeadings}">
            <thead><tr>
                <c:if test="${treeDisplayState.selectionMode ne 'none'}">
                    <td>&nbsp;</td>
                </c:if>
                <c:forEach var="item" items="${this.columnDescriptors}">
                    <td>${item.label}</td>
                </c:forEach>
            </tr></thead>
        </c:if>
        <syswf:component name="/core/impl/composite/compositeTreeRow" prefix="rootNode" wrap="true">
            <syswf:param name="displayHeadings" value="${this.displayHeadings}"/>
            <syswf:param name="paramDecorator" value="${paramDecorator}"/>
            <syswf:param name="treeDisplayState" value="${this.treeDisplayState}"/>
            <syswf:param name="treeResultRow" value="${this.rootResultRow}"/>
            <syswf:param name="currentDepth" value="0"/>
            <syswf:param name="selectionInputName" value="${this.selectionInputName}"/>
            <syswf:param name="treeRowAcceptor" value="${treeRowAcceptor}"/>
            <syswf:param name="rootPrefix" value="${prefix}"/>
        </syswf:component>
        <%-- The 'expand all feature is disabled. --%>
        <%--        
        <tfoot>
            <tr>
                <td colspan="4">
                    <hr />                                        
                    <div class="ButtonsHolder">
                        <syswf:control id="expandAll" mode="postAnchor" action="expandAll" caption="${expandAllButtonLabel}" wrapper="span"/>
                    </div>
                </td>
            </tr>
        </tfoot>
        --%>
    </table>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            var toggles = Ext.select('#${prefix}treeviewCt div.Node a', true);
            toggles.each(function(el, self, index) {
                el.on('click', function() {
                    var row = el.dom.parentNode.parentNode.parentNode;
                    var rowId = row.id;
                    var inputId = 'i' + row.id;
                    // fix defect #56481 -  do not call on divs with Expandable class
                    // call only on grouping nodes
                    if (Ext.get(inputId) == null) return;                    
                    toggleRowItem(el, inputId);
                })
            });

            var expanders = Ext.select('#${prefix}treeviewCt div.Expandable', true);
            expanders.each(function(el, self, index) {
                el.on('click', function() {
                    var rowId = el.id;
                    var exp = Ext.get('${prefix}$expandRow');
                    var trNode = el.dom.parentNode.parentNode;
                    var expand = trNode.className.indexOf("col");
                    exp.dom.value = (expand >= 0 ? "1" : "0") + ":" + rowId;
                    submitRowExpanded();
                })
            });
        });
    
//]]>
</script>
</div>