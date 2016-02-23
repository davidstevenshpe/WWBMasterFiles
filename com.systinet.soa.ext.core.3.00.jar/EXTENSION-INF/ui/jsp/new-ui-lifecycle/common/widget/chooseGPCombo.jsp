<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<c:choose>
    <c:when test="${empty processes}">
    	<span class="IconAlign">
		<c:choose>
		<c:when test="${noMatchingProcess}">
			<fmt:message key="no_matching_processes" bundle="${messages}"/>
		</c:when>
		<c:otherwise>		
        	<fmt:message key="no_governance_processes" bundle="${messages}"/>
		</c:otherwise>
		</c:choose>
    	</span>
    </c:when>	
    <c:otherwise>
        <syswf:input name="newProcessId" value="${selectedProcessId}" mode="hidden" dataType="long"/>
        <syswf:input name="selectedProcess" value=""/>

        <c:set var="selectedIndex" value="-1" />
        <c:set var="selectedValue" value="Select a process..." />
        <syswf:jsonValue type="array" var="governanceProcesses">
            <c:forEach var="process" items="${processes}" varStatus="i">
                <c:if test="${process.id eq selectedProcessId}">
                    <c:set var="selectedIndex" value="${i.index}" />
                    <c:set var="selectedValue" value="${process.name}" />
                </c:if>
                <syswf:jsonValue type="array">
                    <syswf:jsonValue value="${process.id}" />
                    <syswf:jsonValue value="${process.name}"/>
                    <c:if test="${not empty process.description}">
                        <syswf:jsonValue value="${process.description}"/>
                    </c:if>
                </syswf:jsonValue>
            </c:forEach>
        </syswf:jsonValue>

        <script type="text/javascript">
        //<![CDATA[

            Ext.onReady(function(){
            	moveWindow('startGovernancePopup_win','popupWindows');
                var ${prefix}_ds = new Ext.data.SimpleStore({
                    fields: ['id', 'name', 'description'],
                    data: ${governanceProcesses}
                });

                // Custom rendering Template
                var ${prefix}_resultTpl = new Ext.XTemplate(
                    '<tpl for="."><div class="UI Offset InteractiveSearch"><div class="search-item">',
                        '<span class="SearchField Name"><span class="Value">{name:htmlEncode}</span></span>',
                        '<span class="SearchField Description"><span class="Value">{description}</span></span>',
                    '</div></div><hr/></tpl>'
                );
                            
                var ${prefix}_combo = new Ext.form.ComboBox({
                    store: ${prefix}_ds,
                    editable: false,
                    displayField: 'name',
                    typeAhead: true,
                    mode: 'local',
                    width: 250,
                    triggerAction: 'all',
                    emptyText: 'Select a process...',
                    // selectOnFocus: true,
                    itemSelector: 'div.search-item',
                    tpl: ${prefix}_resultTpl,
                    applyTo: '${prefix}_selectedProcess'
                    <c:if test="${not empty selectedValue}">
                    , value: <syswf:jsonValue value="${selectedValue}" /></c:if>
                });

                ${prefix}_combo.on('beforeSelect', function(combo, record, index) {
                    Ext.get('${prefix}_newProcessId').dom.value = record.data.id;
                    <c:if test="${not empty onChangeAction}">
                        ${onChangeAction}
                    </c:if>
                });
            });
        
        //]]>
        </script>        
    </c:otherwise>
</c:choose>

<script type="text/javascript">
//<![CDATA[

	function StartGovernance_enableOk() {
	    <c:if test="${not empty selectedProcessId and not empty onChangeAction}">
	        Ext.onReady(function() { ${onChangeAction} });
	    </c:if>
	}				

//]]>
</script>
