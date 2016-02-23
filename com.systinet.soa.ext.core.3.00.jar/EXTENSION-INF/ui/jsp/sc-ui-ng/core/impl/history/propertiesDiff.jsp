<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.history.messages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uimessages"/>

<fmt:message bundle="${messages}" key="ui.options" var="optionCaptions" />

<div id="${prefix}propertyDiff">
    <div class="CompareControls">
        <div class="Filter"></div>
        <div class="pad-lft form-inline">
            <span><fmt:message bundle="${messages}" key="ui.modeLabel" />&nbsp;</span>
            <syswf:selectOne mode="radio" value="${diffMode}" property="differenceMode" 
                    displayAsRow="true" optionValues="1,2" name="differenceMode2"
                    optionCaptions="${optionCaptions}" dataType="int" optionClasses="pad-rgt,pad-rgt"/>
        </div>
                    <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    <c:if test="${diffMode.differenceMode == 2}">
                    attachOn('${prefix}_differenceMode2_0','click',function() {
                        ${parentPrefix}changeView();
                    });
                    </c:if>
                    <c:if test="${diffMode.differenceMode == 1}">
                    attachOn('${prefix}_differenceMode2_1','click',function() {
                        //Ext.get('${prefix}_differenceMode1_1').dom.checked = true;
                        ${parentPrefix}changeView();
                    });
                    </c:if>
                });
            
//]]>
</script>
    </div>

    <div class="CompareTable">
        <syswf:component name="/core/table" prefix="propertyDiffTable">
            <syswf:param name="customizationId" value="shared.history.propertyDiffTable" />
            <syswf:param name="datasource" value="${propertyDatasource}" />
            <syswf:param name="firstRevision" value="${firstRev}" />
            <syswf:param name="secondRevision" value="${secondRev}" />
            <syswf:param name="tableId" value="${prefix}prop" />
        </syswf:component>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {                
        var dg = Ext.getCmp('${prefix}propertyDiff');
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