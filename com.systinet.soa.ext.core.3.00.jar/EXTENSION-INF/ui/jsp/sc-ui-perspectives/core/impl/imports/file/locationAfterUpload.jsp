<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
    <c:when test="${importType eq 'local'}">
        <div class="OneLine"><syswf:out context="HtmlBody" value="${importFileBean.localLocation}"/></div>
        <syswf:input id="${prefix}${locationTextID}" name="${prefix}${locationTextID}" value="${importFileBean}" property="localLocation" mode="hidden"/>        
    </c:when>
    <c:when test="${importType eq 'remote'}">
        <syswf:selectOne id="${locationsComboID}" name="${locationsComboID}" value="${importFileBean}" 
                         property="remoteLocation" optionValues="${possibleLocations}" optionCaptions="${possibleLocations}" mode="menu" hint=""/>
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                var publishLocalFile_serverFolder_Preview = new Ext.HP.ComboBox({
                    transform: '${locationsComboID}',
                    forceSelection: true,
                    typeAhead: true,
                    disableKeyFilter: false,
                    width: 600,
                    listWidth: 600, // IE compatibility
                    listClass: 'x-combo-list-locations',
                    editable: false,
                    hiddenId: '${prefix}$${locationsComboID}'
                });
            });
        
//]]>
</script>
    </c:when>
</c:choose>