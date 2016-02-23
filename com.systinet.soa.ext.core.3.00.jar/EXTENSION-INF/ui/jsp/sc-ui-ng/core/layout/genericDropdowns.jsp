<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="scComponents"/>

<c:if test="${empty style}">
	<c:choose>
		<c:when test="${fn:contains(customizationId,'importFile')}">
			<c:set var="style" value="margin: 10px 0 -27px 10px"/>
		</c:when>
		<c:otherwise>
			<c:set var="style" value="margin: 10px 0 10px 10px"/>
		</c:otherwise>
	</c:choose>
</c:if>

<c:if test="${fn:length(availableOptions) > 1}">
	<div class="UI Block Common" style="${style}">
		<table>
			<tr>
				<c:if test="${not empty isAddPrefixText and isAddPrefixText eq 'true'}">
					<td class="PaddingRight" style="padding-top: 2px;">
						<fmt:message key="addressBook.selectFrom" bundle="${scComponents}"/>
					</td>
				</c:if>
				<td>
					<select id="${prefix}dropdownCombobox">
						<c:forEach var="availableOption" items="${availableOptions}" varStatus="status">
							<option value="caption${prefix}_${availableOption.id}" <c:if test="${selectedOptionId eq availableOption.id}">selected</c:if>>
								<c:out value="${availableOption.label}"/>
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<c:forEach var="availableOption" items="${availableOptions}" varStatus="status">
			<syswf:control id="id${prefix}_${availableOption.id}" mode="script" action="changeOption" caption="caption${prefix}_${availableOption.id}">
			    <syswf:param name="optionId" value="${availableOption.id}"/>
			</syswf:control>
		</c:forEach>
		
		<script type="text/javascript">
	//<![CDATA[
            Ext.onReady(function() {
                var ${prefix}dropDown = new Ext.form.ComboBox({
                    id: '${prefix}cbbox',
                    transform: '${prefix}dropdownCombobox',
                    forceSelection: true,
                    typeAhead: true,
                    disableKeyFilter: false,
                    editable: false,
                    triggerAction: 'all',
                    onSelect: function(record){
                    	if(record.id != this.getValue()){
	                    	this.setValue(record.id);		                        
	                    	window[record.id]();
                    	}
                    	this.collapse();
                    }
                });
                <c:choose>
                	<c:when test="${not empty widthDropdown}">
                		${prefix}dropDown.setWidth(${widthDropdown});
                	</c:when>
                	<c:otherwise>
	                	function keepSize(){
   	                        //Get the window's width: (NOT including toolbars/scrollbars)
                            var winWidth = window.innerWidth;
                            if(typeof(winWidth)=='undefined'){
                                winWidth = $(window).width();
                            }
	                        ${prefix}dropDown.setWidth(Math.round(winWidth/3));
	                    }
	                    keepSize();
	                    Ext.EventManager.onWindowResize(keepSize);
                	</c:otherwise>
                </c:choose>
            });
	//]]>
	</script>
	</div>
</c:if>

<c:if test="${not empty selectedOption}">
    <syswf:component prefix="${selectedOption.id}" name="${selectedOption.componentName}">
        <syswf:param name="tabId" value="${selectedOption.id}"/>
        <syswf:paramSet value="${selectedOption.paramsMap}"/>
    </syswf:component>
</c:if>