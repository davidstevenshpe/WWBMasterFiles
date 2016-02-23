<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<!--
Parameters:  
jsOpenFunction = name of a function that opens the window, has to be bound to an element onClick method
windowTitle = title of the opened window
roleVisibility - to show Role field whether or not.
 -->

<fmt:setBundle basename="com.hp.systinet.sc.ui.domain.domainmessages" var="domainMessages"/>

<fmt:message var="defaultDomainDescription" key="defaultDomainDescription" bundle="${domainMessages}"/>
<fmt:message var="roleLabel" key="roleLabel" bundle="${domainMessages}"/>
<fmt:message var="descriptionLabel" key="descriptionLabel" bundle="${domainMessages}"/>

<table class="UI Table Properties">
    <col class="MidLabelCol"/>
    <col/>
    <tbody>
        <tr>
            <td>
                <%-- <select size="10" id="selectDomain_selectedDomain" name="selectDomain_selectedDomain" class="UI Form Select Primary Full" onchange="onSelectChange()">
                    <c:forEach items="${domains}" var="domain">
                    	<c:choose>
                    		<c:when test="${_defaultDomain eq domain.domainId}">
                        		<c:set value="${domain.name} (Default)" var="domainName"></c:set>
                        	</c:when>
                        	<c:otherwise>
                        		<c:set value="${domain.name}" var="domainName"></c:set>
                        	</c:otherwise>
                    	</c:choose>
                        <c:choose>
                            <c:when test="${(not empty selectedDomain) and (domain.domainId eq selectedDomain.domainId)}">
                                <option selected="selected" id="${domain.domainId}" value="${domain.domainId}"><syswf:out value="${domainName}" context="HtmlBody"/></option>
                            </c:when>
                            <c:otherwise>
                                <option id="${domain.domainId}" value="${domain.domainId}"><syswf:out value="${domainName}" context="HtmlBody"/></option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select> --%>
                <div id="listDomainContainer" class="list-group bord-no em-domain-selector" style="border:#cfd8f0 solid 1px !important;">
                	<c:forEach items="${domains}" var="domain">
                    	<c:choose>
                    		<c:when test="${_defaultDomain eq domain.domainId}">
                        		<c:set value="${domain.name} (Default)" var="domainName"></c:set>
                        	</c:when>
                        	<c:otherwise>
                        		<c:set value="${domain.name}" var="domainName"></c:set>
                        	</c:otherwise>
                    	</c:choose>
                        <c:choose>
                            <c:when test="${(not empty selectedDomain) and (domain.domainId eq selectedDomain.domainId)}">
                                <a class="list-group-item  list-item-sm active" href="javascript:void(0)" data-value="${domain.domainId}" onclick="onSelectDomain(this);">
                                	<syswf:out value="${domainName}" context="HtmlBody"/>
								</a>
                            </c:when>
                            <c:otherwise>
                                <a class="list-group-item  list-item-sm" href="javascript:void(0)" data-value="${domain.domainId}" onclick="onSelectDomain(this);">
                                	<syswf:out value="${domainName}" context="HtmlBody"/>
								</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
            	</div>
            </td>
            <td>
            	<c:choose>
            		<c:when test="${_defaultDomain eq selectedDomain.domainId}">
            		<div class="UI SystemMessage Info">
                    <div class="MessageContainer">
                        <div class="Text"> <c:out value="${defaultDomainDescription}"></c:out> </div>
                        <div class="x-clear"></div>
                    </div>
                </div>
            		</c:when>
            	</c:choose>
            	
                <div id="selectDomain_info">
                	<c:choose>
                		<c:when test="${roleVisibility}">
                		<h4><c:out value="${roleLabel}"></c:out></h4>
                    <ul>
                        <li style="color:black;margin-left:5px;padding-left:5px;">
                            <c:choose>
                                <c:when test="${empty roles}">
                                    <span class="Comment"><c:out value="none"/></span>
                                </c:when>
                                <c:otherwise>
		                            <c:forEach items="${roles}" var="role" varStatus="status">
		                                <c:choose>
		                                    <c:when test="${status.last}">
		                                        <c:out value="${role}"/>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <c:out value="${role},"/>
		                                    </c:otherwise>
		                                </c:choose>
		                            </c:forEach>        
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ul>
                		</c:when>
                	</c:choose>
                	 
                    <h4><c:out value="${descriptionLabel}"></c:out></h4>
                    <div class="UI Text Description" style="color:black;"><syswf:out context="HtmlBody" value="${selectedDomain.description}"/></div>
                </div>
            </td>
        </tr>
    </tbody>
</table>

<syswf:control mode="script" action="changeDomain" caption="${prefix}selectionChangeDomain" affects="."/>
<syswf:control mode="script" action="setUserDefaultDomain" caption="${parentPrefix}changeDomain" affects="."/>

<script type="text/javascript">
//<![CDATA[
	
	function updateButtonStatus(comboboxObject) {
		if(comboboxObject != undefined){
			var defaultBtnObj = Ext.getCmp('${defaultBtnId}');
		    if ('${_defaultDomain}' === comboboxObject.value) {
		    	defaultBtnObj.disable();
		    } else {
		    	defaultBtnObj.enable();
		    }
	    }
	}
	
	function changeDomainWndOpen() {
		var selectedDomain = $('#listDomainContainer a.active');
		selectedDomain.value = selectedDomain.attr("data-value");
		
	    updateButtonStatus(selectedDomain);
	}
	
	function onSelectDomain(item){		
		
		var clazz = $(item).attr("class");
		item.value = $(item).attr("data-value");
		
		updateButtonStatus(item);
		
		if(clazz.indexOf("active") < 0){
			$('#listDomainContainer a.active').removeClass("active");
			$(item).addClass("active");
					
			${prefix}selectionChangeDomain({
				domainId: item.value
			});
		}
	}

//]]>
</script>

