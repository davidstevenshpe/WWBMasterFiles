<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--
input parameters:
   * list - list of items; items implements =com.hp.systinet.sc.ui.util.ItemSelectorComponent.ItemSelectorSelectable=
   * itemSelectorListener - selection listener; =com.hp.systinet.sc.ui.util.ItemSelectorComponent.ItemSelectorListener=
   * affects - affects parameter; enables AJAX behaviour (affects parameter set to affected component prefix)
--%>

<c:choose>
    <c:when test="${not empty affects}">
        <syswf:control mode="script" action="select" affects="." caption="${prefix}_select" loadingMask="true"/>
    </c:when>
    <c:otherwise>
        <syswf:control mode="script" action="select" caption="${prefix}_select" />
    </c:otherwise>
</c:choose>

<syswf:input id="${prefix}_select_id" name="selectedId" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

function ${prefix}_handle_select(id) {
    var element = Ext.get('${prefix}_select_id');
    element.dom.value = id;
    ${prefix}_select();        
}

//]]>
</script>

<table class="UI Table ExpressionBuilder Plain">
    <tr>
        <td class="EditorCell">
            <div id="${prefix}_itemSelector" class="UI Border Text Links">
                <c:forEach items="${list}" var="item">
            
                    <c:choose>
                        <c:when test="${itemSelectorWrapper.selectedId eq item.id}">
                            <c:set var="class">LinkArea Active</c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="class">LinkArea</c:set>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:set var="caption" >
                        <strong>${item.label}</strong><br />
                        <span class="Comment">${item.description}</span>
                    </c:set>
                    
                    <a href="javascript:${prefix}_handle_select('${item.id}')" class="${class}" title="${item.description}">${caption}</a>
                    
                </c:forEach>
            </div>
        </td>
    </tr>
</table>
