<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--
input parameters:
   * list - list of items; items implements =com.hp.systinet.sc.ui.util.ItemSelectorHorizComponent.ItemSelectorHorizSelectable=
   * itemSelectorHorizListener- selection listener; =com.hp.systinet.sc.ui.util.ItemSelectorHorizComponent.ItemSelectorHorizListener=
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

<c:set var="imgLocation" value="${webResourcePath}/skin/img/default" />

<table class="UI Table ExpressionBuilder Plain">
    <tr>
        <td class="EditorCell">
            <div id="${prefix}_itemSelectorHorizontal" class="UI Border Text Links">
                <c:forEach items="${list}" var="item">					
                    <c:choose>
                        <c:when test="${itemSelectorHorizWrapper.selectedId eq item.id}">
                            <c:set var="class">LinkArea Square Active</c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="class">LinkArea Square</c:set>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:set var="caption" >
                        <img src="${imgLocation}/${item.icon}" alt="${item.iconAlt}" width="${item.iconWidth}" height="${item.iconHeight}" /><br />
                        <span><syswf:out context="HtmlBody" value="${item.label}"/></span>
                    </c:set>
                    
                    <a href="javascript:${prefix}_handle_select('${item.id}')" class="${class}" title="<syswf:out context='HtmlAttributeOther' value='${item.label}'/>">${caption}</a>
                    
                </c:forEach>
            </div>
        </td>
    </tr>
</table>