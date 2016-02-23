<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:selectOne id="${prefix}_time" name="time" mode="menu" value="${this}" property="time" 
        optionValues="${this.timeValues}" optionCaptions="${this.timeCaptions}" />
<script type="text/javascript">
//<![CDATA[

    var cmb_${prefix}_time = new Ext.HP.ComboBox({
        id : '${prefix}_time',
        transform : '${prefix}_time',
        disableKeyFilter : true,
        mode : 'local',
        autoHeight : true,
        resizable : true,
        listWidth : 150,
        width : 150,
        triggerAction : 'all'
    <c:if test="${notEditableTime}">            
        ,editable: false    
    </c:if>
    });    

//]]>
</script>
