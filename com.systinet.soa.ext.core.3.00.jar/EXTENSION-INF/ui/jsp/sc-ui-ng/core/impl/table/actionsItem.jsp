<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:choose>
    <c:when test="${not empty item.label and renderingChilds}">
        <c:set var="itemLabel" value="${item.label}"/>
    </c:when>
    <%-- <c:otherwise>
        A default fallback as the label is optional.
        <c:set var="itemLabel" value="${item.id}"/>
    </c:otherwise> --%>
</c:choose>
<c:choose>
    <c:when test="${item.type == 'group'}">
        <c:if test="${not empty item.childs}">
        
            <c:set var="content" >
                <c:set var="previousContent" value=""/>
                <c:forEach items="${item.childs}" var="child" varStatus="status">
                    <c:if test="${child.visible}">
                        <c:if test="${not empty previousContent}">,</c:if>
                        <c:set var="itemContent">                        
                            <syswf:component name="/core/impl/table/actionsItem" prefix="item${status.index}" wrap="false">
                               <syswf:param name="item" value="${child}" />
                               <syswf:param name="href" value="javascript:void(0);" />
                               <syswf:param name="renderingChilds" value="true" />
                            </syswf:component>
                        </c:set>
                        <c:set var="previousContent" >
                            ${previousContent}
                            ${itemContent}
                        </c:set>
                        ${itemContent}
                     </c:if>
                </c:forEach>                
            </c:set>
            
            <c:if test="${not empty content}">
                {
                	xtype: 'hpabutton', 
                	text: '${itemLabel}'
                    <c:if test="${not empty item.description}">,tooltip: '${item.description}'</c:if>,
                    <c:if test="${not renderingChilds}">iconCls: 'action-button<c:if test="${not empty item.styleClass}"> ${item.styleClass}</c:if>',</c:if>
                    <c:choose><c:when test="${not item.disablable}">enableDisability: true,</c:when><c:when test="${empty renderingChilds}">disabled: true,</c:when></c:choose>
                    menu: new Ext.HP.ActionMenu({
                        id: '${item.controlName}Menu',
                        items: [
                            ${content}
                        ]
                    })
                }
             </c:if>
        </c:if>
    </c:when>
	<c:when test="${item.type == 'subgroup'}">
        <c:if test="${not empty item.childs}">
        
            <c:set var="content" >
                <c:set var="previousContent" value=""/>
                <c:forEach items="${item.childs}" var="child" varStatus="status">
                    <c:if test="${child.visible}">
                        <c:if test="${not empty previousContent}">,</c:if>
                        <c:set var="itemContent">                        
                            <syswf:component name="/core/impl/table/actionsItem" prefix="item${status.index}" wrap="false">
                               <syswf:param name="item" value="${child}" />
                               <syswf:param name="href" value="javascript:void(0);" />
                               <syswf:param name="renderingChilds" value="true" />
                            </syswf:component>
                        </c:set>
                        <c:set var="previousContent" >
                            ${previousContent}
                            ${itemContent}
                        </c:set>
                        ${itemContent}
                     </c:if>
                </c:forEach>                
            </c:set>
            
            <c:if test="${not empty content}">
                {
                	xtype: 'hpamitem', 
                	text: '${itemLabel}'
                    <c:if test="${not empty item.description}">,tooltip: '${item.description}'</c:if>,
                    <c:if test="${not renderingChilds}">iconCls: 'action-button<c:if test="${not empty item.styleClass}"> ${item.styleClass}</c:if>',</c:if>
                    <c:choose><c:when test="${not item.disablable}">enableDisability: true,</c:when><c:when test="${empty renderingChilds}">disabled: true,</c:when></c:choose>
					cls: 'UI Icon ${item.styleClass}',
                    menu: new Ext.HP.ActionMenu({
                        id: '${item.controlName}Menu',
                        items: [
                            ${content}
                        ]
                    })
                }
             </c:if>
        </c:if>
    </c:when>
    <c:when test="${item.visible}">
       	{	
       		id: '${item.controlName}',
       		<c:choose>
				<c:when test="${fn:contains(item.styleClass, 'with-text')}">
					text: '<span>${item.label}</span>',	
				</c:when>
				<c:otherwise>
					text: '${itemLabel}',
				</c:otherwise>
			</c:choose> 
	        <c:if test="${not empty href}">href: '<c:out value="${href}"/>',</c:if>
	        <c:if test="${not empty item.description}">tooltip: '${item.description}',</c:if>
			<c:if test="${not item.disablable}">enableDisability: true,</c:if>
		            
	 		<c:if test="${(empty renderingChilds) or (not renderingChilds)}">
	       		xtype: 'hpabutton',
	            iconCls: 'action-button<c:if test="${not empty item.styleClass}"> ${item.styleClass}</c:if>',
	            <c:choose>
					<c:when test="${item.disable}">
						disabled: true,	
					</c:when>
					<c:otherwise>
						disabled: false,					
					</c:otherwise>
				</c:choose>
	        </c:if>
			
			<c:if test="${(empty subgroup)}">
				<c:if test="${not empty item.styleClass}">
					cls: 'UI Icon ${item.styleClass}',
				</c:if>
	        </c:if>
	        	        
          	handler: function() { ${item.controlName}(); }        
        }
    </c:when>
</c:choose>