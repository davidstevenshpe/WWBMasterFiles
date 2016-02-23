<%--
Parameters:
    jsLoadFunction = name of a function that loads content of the window
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<fmt:message var="saveButtonLabel" key="Save" bundle="${messages}"/>
<fmt:message var="loadButtonLabel" key="Load" bundle="${messages}"/>
<fmt:message var="deleteButtonLabel" key="Delete" bundle="${messages}"/>

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
            <td class="SavedSearchesList">
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
                                    Ext.getCmp('${prefix}List').select(${definitionHolder.selectedIndex});
                                }
                            }
                        });

                        var list = new Ext.list.ListView({
                            store: store,
                            id: '${prefix}List',
                            emptyText: '',
                            height: 250,
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
                        
                        list.on('selectionchange', function(view, nodes){
                            if (list.getSelectedIndexes()[0] != null) {
                                if(lastIndex != list.getSelectedIndexes()[0]) {
                                    ${prefix}Select({selectedIndex: list.getSelectedIndexes()[0]});
                                    ${prefix}Mask = new Ext.LoadMask(Ext.get('${prefix}Desc'));
                                    ${prefix}Mask.show();
                                }
                                lastIndex = list.getSelectedIndexes()[0];
                            }
                        });

                        store.loadData([
                            <c:forEach var="name" items="${definitionHolder.names}" varStatus="status">
                                ['<c:out value="${name}" />']<c:if test="${not status.last}">,</c:if>
                            </c:forEach>
                        ]);

                        if(${prefix}Mask != null) {
                            ${prefix}Mask.hide();
                        }
                    });
                  
//]]>
</script>
            </td>

            <td class="SavedSearchesItem">
                <c:if test="${not empty definitionHolder.selectedDefinition}" >  
                    <div class="SavedSearchesItemContent" id="${prefix}Desc">
                        <syswf:component name="/core/search/searchCriteriaDescription" prefix="seachDescription" ajax="true" wrap="false">
                            <syswf:param name="savedSearchDefinition" value="${definitionHolder.selectedDefinition}" />
                            <syswf:param name="showUrl" value="${true}" />
                            <syswf:param name="showAtomFeed" value="${true}" />
                            <syswf:param name="savedSearchDefinitionBaseUrl" value="${savedSearchDefinitionBaseUrl}" />
                            <syswf:param name="filterLabelResolver" value="${filterLabelResolver}" />
                            <syswf:param name="nameMustNotBeEmpty" value="${nameMustNotBeEmpty}" />
                        </syswf:component>
                    </div>

                    <div class="SavedSearchesControlButtons">
						<c:set var="disableSaveButtonClass" value="btn btn-gray disabled" />
						<c:if test="${definitionHolder.selectedDefinition.owner eq currentUser or empty definitionHolder.selectedDefinition.owner}">
							<c:set var="disableSaveButtonClass" value="btn btn-gray" />
						</c:if>

                        <a id="${prefix}SaveLink"href="javascript:void(0);" class="${disableSaveButtonClass}">${saveButtonLabel}</a>
						<c:if test="${definitionHolder.selectedDefinition.owner eq currentUser or empty definitionHolder.selectedDefinition.owner}">
	                        <syswf:control id="${prefix}ExecuteSave" caption="${prefix}ExecuteSave" mode="script" action="saveSearch" affects="." />
	                        <script type="text/javascript">
//<![CDATA[

	                            Ext.onReady(function() {
	                                Ext.get('${prefix}SaveLink').on('click', function() {
	                                    ${prefix}ExecuteSave();
	                                });
	                            });
	                        
//]]>
</script>
						</c:if>
                                                
                        <a href="${savedSearchDefinitionBaseUrl}${definitionHolder.selectedDefinition.uuid}" class="btn btn-primary">${loadButtonLabel}</a>
                        
						<c:set var="disableDeleteButtonClass" value="btn btn-gray disabled" />
						<c:if test="${definitionHolder.selectedDefinition.owner eq currentUser or empty definitionHolder.selectedDefinition.owner or isAdmin}">
							<c:set var="disableDeleteButtonClass" value="btn btn-gray" />
						</c:if>

                        <a id="${prefix}DeleteLink" href="javascript:void(0);" class="${disableDeleteButtonClass}">${deleteButtonLabel}</a>
						<c:if test="${definitionHolder.selectedDefinition.owner eq currentUser or empty definitionHolder.selectedDefinition.owner or isAdmin}">
	                        <syswf:control id="${prefix}ExecuteDelete" caption="${prefix}ExecuteDelete" mode="script" action="deleteSearch" affects="." />
	                        <script type="text/javascript">
//<![CDATA[

	                            Ext.onReady(function() {
	                                Ext.get('${prefix}DeleteLink').on('click', function() {
	                                	${prefix}ExecuteDelete();
	                                });
	                            });
	                        
//]]>
</script>
						</c:if>
                    </div>
                </c:if>	
            </td>
        </tr>
    </tbody>
</table>

<syswf:control caption="${jsLoadFunction}" mode="script" action="loadContent" affects="."></syswf:control>