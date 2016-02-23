<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />
<fmt:message var="optionalLabel" key="addParameter.optional" bundle="${tpMessages}" />

<fmt:message var="selectCategoryWindowTitle" key="addParameter.selectCategory.windowTitle" bundle="${tpMessages}" />
<fmt:message var="okButtonLabel" key="addParameter.okButtonLabel" bundle="${tpMessages}" />
<fmt:message var="cancelButtonLabel" key="addParameter.cancelButtonLabel" bundle="${tpMessages}" />

<script type="text/javascript">
//<![CDATA[

    var ${prefix}Mask;
    var lastIndex;

//]]>
</script>

<table class="UI Table SavedSearchesManager">
	<colgroup>
        <col class="SavedSearchesListCol"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <td class="SavedSearchesList" width="200">
                <div id="${prefix}ListContainer"></div>
                <syswf:control caption="${prefix}Select" mode="script" action="selectRow" affects="." />
                <script type="text/javascript">
//<![CDATA[

					
                    Ext.onReady(function() {
                        var store = new Ext.data.SimpleStore({
                            fields: [
                                {name: 'savedSearch'}
                            ],
                            listeners: {
                                load: function(ds, recs, options) {
                                    Ext.getCmp('${prefix}List').select(${assertionIndex});
									lastIndex = ${assertionIndex};
                                }
                            }
                        });

                        var list = new Ext.list.ListView({
                            store: store,
                            id: '${prefix}List',                                                                                
                            emptyText: '',
                            height: 200,
                            renderTo: '${prefix}ListContainer',
                            hideHeaders: true,
                            autoScroll: true,
                            singleSelect: true,
                            reserveScrollOffset: true,
                            columns: [{
                                header: 'Name',
                                dataIndex: 'savedSearch'
                            }]
                        });
						
						store.loadData([
                            <c:forEach var="assertion" items="${assertionBeanList}" varStatus="status">
								<c:set var="error" value="${assertion.errorParams}" scope="page"  />
								<c:if test="${not empty error}">
									['<em class="x-form-invalid-msg UI Invalid"><c:out value="${assertion.assertionName}"/></em>']<c:if test="${not status.last}">,</c:if>
								</c:if>
								<c:if test="${empty error}">
									['<label class="UI Label Inline"><c:out value="${assertion.assertionName}"/></label>']<c:if test="${not status.last}">,</c:if>
								</c:if>
                            </c:forEach>
                        ]);

                        list.on('selectionchange', function(view, nodes){
							if(lastIndex != list.getSelectedIndexes()[0]) {
                                ${prefix}Select({selectedIndex: list.getSelectedIndexes()[0]});
                                ${prefix}Mask = new Ext.LoadMask(Ext.get('${prefix}Desc'));
                                ${prefix}Mask.show();
                            }
                            lastIndex = list.getSelectedIndexes()[0];
                        });

                        if(${prefix}Mask != null) {
                            ${prefix}Mask.hide();
                        }
                    });
                
//]]>
</script>
            </td>


            <td class="SavedSearchesItem">
				<c:if test="${not empty assertionBeanList[assertionIndex]}" >				
					<div class="SavedSearchesItemContent" id="${prefix}Desc">
                        <syswf:component name="/admin/policy/technical/assertionContentWindow" prefix="assertionContent" ajax="true">
                            <syswf:param name="assertion" value="${assertionBeanList[assertionIndex]}" />
							<syswf:param name="severityValues" value="${severityValues}" />
							<syswf:param name="severityCaptions" value="${severityCaptions}" />
							<syswf:param name="errors" value="${assertionBeanList[assertionIndex].errorParams}" />
                        </syswf:component>
                    </div>
				</c:if>
    		</td>
        </tr>
    </tbody>
</table>