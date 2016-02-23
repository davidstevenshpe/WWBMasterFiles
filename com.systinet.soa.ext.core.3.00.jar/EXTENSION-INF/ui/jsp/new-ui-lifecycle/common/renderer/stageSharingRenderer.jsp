<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="${prefix}">

<syswf:control mode="script" action="onSharingChange" caption="${prefix}changeSharing" affects="." />

<syswf:selectOne id="${prefix}_sharing" mode="menu" optionCaptions="${stageSharingRendererBean.sharingCaptions}" 
value="${stageSharingRendererBean}" size="1" optionValues="${stageSharingRendererBean.sharingValues}" property="sharing" name="${prefix}stageSharing" />

<script type="text/javascript">
//<![CDATA[

    Ext.get('${prefix}_sharing').on('change',function(){
    	${prefix}changeSharing();
    });

    var ${prefix}cmb;
        
    Ext.onReady(function(){
    	${prefix}cmb = new Ext.form.ComboBox({
        id : '${prefix}_sharing',
        transform : '${prefix}_sharing',
        listWidth : 140,
        width : 140,        
        disableKeyFilter : true,
        mode : 'local',
        autoHeight : true,
        resizable : true,
        triggerAction : 'all'
      });

    	${prefix}cmb.on('select',function(){
            ${prefix}changeSharing();
        });
        
    });     
    

//]]>
</script>
</div>