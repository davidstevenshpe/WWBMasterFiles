<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.history.messages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uimessages"/>

<fmt:message bundle="${messages}" key="ui.options" var="optionCaptions" />

<div id="${prefix}relationDiff">
    
    <div class="CompareControls">
        <div class="FilterContainer">
        <span><fmt:message bundle="${messages}" key="ui.filterLabel" /></span>

        <div class="Filter" id="${prefix}compare-filter"></div>
        <div class="webfw-Window">
            <syswf:component name="/core/impl/history/relationFilter" prefix="filter">
                <syswf:param name="artifact" value="${artifactFirstRev}" />
                <syswf:param name="artifact2" value="${artifactSecondRev}" />
                <syswf:param name="applyFilterControlName" value="${prefix}ApplyFilter" />
                <syswf:param name="filterContentId" value="${prefix}RelFilter" />
                <syswf:param name="datasource" value="${propertyDatasource}" />
                <syswf:param name="dataComponentPrefix" value="${prefix}_relationDiffTable" />
                <syswf:param name="model" value="${model}" />
            </syswf:component>
        </div>
        
        <script type="text/javascript">
//<![CDATA[

            var filterbutton = new Ext.HP.DropdownButton({
                id: '${prefix}RelFilterDrop',
                renderTo: '${prefix}compare-filter',
                text: '',
                iconCls: 'x-btn-filter-default',
                content: '${prefix}RelFilter',
                buttons: [{
                    text: '<fmt:message bundle="${uimessages}" key="OK" />',
                    handler: function() {
                        ${prefix}relShowLoading();
                        ${prefix}ApplyFilter();
                        var filterbutton = Ext.getCmp('${prefix}RelFilterDrop');
                        filterbutton.setIconClass('x-btn-filter-applied');
                        filterbutton.toggleMenu();
                    }
                }, {
                    text: '<fmt:message bundle="${uimessages}" key="Cancel" />'
                }]
            });
        
//]]>
</script>
        </div>
        <div class="Show">
            <span><fmt:message bundle="${messages}" key="ui.modeLabel" /></span>
            <syswf:selectOne mode="radio" value="${diffMode}" property="differenceMode" 
                    displayAsRow="true" optionValues="1,2" name="differenceMode1"
                    optionCaptions="${optionCaptions}" dataType="int" />
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    <c:if test="${diffMode.differenceMode == 2}">
                    attachOn('${prefix}_differenceMode1_0','click',function() {
                        ${prefix}relShowLoading();
                        ${parentPrefix}changeView();
                    });
                    </c:if>
                    <c:if test="${diffMode.differenceMode == 1}">
                    attachOn('${prefix}_differenceMode1_1','click',function() {
                        ${prefix}relShowLoading();
                        ${parentPrefix}changeView();
                    });
                    </c:if>
                });
            
//]]>
</script>
        </div>
        <div class="clear"></div>
    </div>
    
    <div class="CompareTable">
        <syswf:component name="/core/table" prefix="relationDiffTable">
            <syswf:param name="customizationId" value="shared.history.relationDiffTable" />
            <syswf:param name="datasource" value="${relationDatasource}" />
            <syswf:param name="firstRevision" value="${firstRev}" />
            <syswf:param name="secondRevision" value="${secondRev}" />                    
            <syswf:param name="useHPGridView" value="true" />
            <syswf:param name="useExtColumnModel" value="true" />
            <syswf:param name="tableId" value="${prefix}rel" />
        </syswf:component>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Ext.getCmp('${prefix}rel').getView().on('refresh',function(view) {
            // fix IE's inner table height issue
            if (Ext.isIE) {
                view = Ext.getCmp('${prefix}rel').getView();
                for (var row = 0; row < view.ds.data.length; row++) {
                    for (var col = 0, len = view.cm.columns.length; col < len; col++) {
                        var cell = view.getCellAsObject(row, col);
                        var revtable = cell.select('table.RevisionDetails');
                        revtable.setHeight(cell.getHeight());
                    }
                }
            }
        });
        Ext.getCmp('${prefix}rel').getView().refresh();
        var dg = Ext.getCmp('${prefix}relationDiff');
        refreshView(dg);
    });

    function refreshView(dg) {
        if (dg) {
            dg.getView().refresh();
            bt = dg.getBottomToolbar();
            if (bt) { bt.container.setWidth('auto'); }
        }
    }

//]]>
</script>