<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>


<syswf:control mode="script" caption="${prefix}_csvExport" targetTask="/common/csvExport" action="export">
    <syswf:param  name="datasource" value="${datasource}"/>
    <syswf:param  name="tableColumns" value="${tableColumns}" />
    <syswf:param  name="tableGroupColumns" value="${tableGroupColumns}" />
    <syswf:param  name="rowPreview" value="${rowPreview}" />
    <syswf:param  name="hiddenColumnsWrapper" value="${this.hiddenColumnsWrapper}" />
    <syswf:param  name="sdmNames" value="${sdmNames}" />
    <syswf:param  name="selectionBag" value="${selectionBag}" />
</syswf:control>

<syswf:input id="${prefix}_hiddenColumns" name="hiddenColumns" value="${this.hiddenColumnsWrapper}" property="hiddenColumns" mode="hidden"/> 

<script type="text/javascript">
//<![CDATA[

    function ${controlName}() {
        var config = ${tableId}Columns;
        var s = "";
        for(i=0;i<config.length; i++) {
            if(config[i].hidden) {
                s = s + config[i].id + ";"
            }
        }
        document.getElementById('${prefix}_hiddenColumns').value=s;
      	${prefix}_csvExport(s);
    }

//]]>
</script>
