<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="${prefix}Local" class="TabPanel Simple">
    <div id="${prefix}LocalTabs">
    <syswf:control mode="ajax" caption="${prefix}toTabPersons" action="tabChange" id="${prefix}toTabPersons">
        <syswf:param name="tab" value="localPersons" />
    </syswf:control>
    <syswf:control mode="ajax" caption="${prefix}toTabOrgUnits" action="tabChange" id="${prefix}toTabOrgUnits">
        <syswf:param name="tab" value="localOrgUnits" />
    </syswf:control>

    <div id="${prefix}TabPersons">
    <c:if test="${userSelectorHolder.tab eq 'localPersons'}" >
        <syswf:component name="/core/table" prefix="persons">
           <syswf:param name="customizationId" value="shared.userSelector.persons"/>
           <syswf:param name="datasource" value="${personsDatasource}"/>
           <syswf:param name="selectionBag" value="${userSelectorHolder.localPersonsSelectionBag}" />
        </syswf:component>
    </c:if>
    </div>

    <div id="${prefix}TabOrgUnits">
    <c:if test="${userSelectorHolder.tab eq 'localOrgUnits'}" >
        <syswf:component name="/core/table" prefix="orgUnits">
           <syswf:param name="customizationId" value="shared.userSelector.orgUnits"/>
           <syswf:param name="datasource" value="${orgUnitsDatasource}"/>
           <syswf:param name="selectionBag" value="${userSelectorHolder.localOrgUnitsSelectionBag}" />
        </syswf:component>
    </c:if>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            var ${prefix}LocalTabs = new Ext.TabPanel({
                id: '${prefix}tabs',
                renderTo: '${prefix}LocalTabs',
                activeTab: '${prefix}${userSelectorHolder.tab}',
                deferredRender: false,
                width: 472,
                autoHeight: true,
                items: [
                        { contentEl: '${prefix}TabPersons', autoHeight: true, title: '${personsTabLabel}', id: '${prefix}localPersons', callback: ${prefix}toTabPersons}
                        ,
                        { contentEl: '${prefix}TabOrgUnits', autoHeight: true, title: '${orgUnitsTabLabel}', id: '${prefix}localOrgUnits', callback: ${prefix}toTabOrgUnits}
                    ]
            });

            ${prefix}LocalTabs.on('tabchange', function(self, tab, ${prefix}LocalTabs) {
                this.getActiveTab().callback();
            });
        });
    
//]]>
</script>

</div>