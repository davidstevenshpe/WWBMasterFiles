<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>

<fmt:message var="status_completed" bundle="${relationshipmessages}" key="completion.status.table.completed"/>
<fmt:message var="status_notCompleted" bundle="${relationshipmessages}" key="completion.status.table.notCompleted"/>
<fmt:message var="proposalPrerequisiteDesc" bundle="${uisccomponentsmessages}" key="proposal.prerequisite.description"/>

<div class="proposalDeliverableDescp">${proposalPrerequisiteDesc}</div>
<div>&nbsp;</div>
<div id="${prefix}-prerequisiteComponent">
</div>
<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
    Ext4.Loader.setPath('EA.model', '${webResourcePath}/../../components/ui-ea/model');
    var artifactTable = Ext4.create('EA.model.table.proposal.ArtifactListingDatasourceTable', {
        renderTo: '${prefix}-prerequisiteComponent',
        width: '100%',
        remoteSort: false,
        dataSourceLocation: '${datasourceLocation}',
        extraParamsDataSource: {
            proposalUuid: '${artifact._uuid}',
            coreSdmList: '' + toString(getSdmNames(${coreArtifactSdmList}, []))
        },
        pageResults: true,
        pageSize: 10,
        remoteSort: true,
        sorters:[{"property":"sdmName","direction":"DESC"}],
        
        getNotCompletedStatusText: function() {
            return '${status_notCompleted}';
        },
        
        getCompletedStatusText: function() {
            return '${status_completed}';
        },
        
        columns:[
                 {
                     id:'name',
                     flex:1,
                     header:'Name',
                     dataIndex:'coreName',
                     renderer:function (v,m,record) {
                         return artifactTable.getArtifactLinkRender(record.data.uuid, record.data.coreName, record.data.type);
                     },
                     width:150,
                     sortable:true,
                     doSort: function(state) {
                    	 artifactTable.sortColumn(this, state, '');
                     }
                 }, {
                     header:'Type',
                     dataIndex:'sdmName',
                     width:120,
                     sortable:true
                 }, {
                     header:'Version',
                     dataIndex:'coreVersion',
                     hidden:true,
                     renderer:function (v) {
                         if (v == null || v == '') return 'N/A'; else return v;
                     },
                     width:50,
                     sortable:true
                 }, {
                     header:'Owner',
                     dataIndex:'owner',
                     width:50,
                     sortable:true
                 }, {
                     header:'Plateau',
                     dataIndex:'plateauName',
                     renderer:function (v, m, record) {
                         return artifactTable.getArtifactLinkRender(record.data.plateauUuid, record.data.plateauName, 'plateauArtifact');
                     },
                     width:150,
                     sortable:true
                 }, {
                     header:'Realized by',
                     dataIndex:'realizedBy',
                     renderer:function (v, m, record) {
                    	 var render = "";
                    	 var values = record.raw['realizedBy'];
                    	 for (var idx = 0; idx < values.length; idx++) {
                    		 render += artifactTable.getArtifactLinkRender(values[idx].uuid, values[idx].name, values[idx].type);
                    		 if (idx < values.length - 1) {
                    		     render +=  " , ";
                    		 }
                    	 }
                         return render;
                     },
                     width:200,
                     sortable:false
                 }, {
                     header:'Last Approved',
                     dataIndex:'lastApprovedStage',
                     renderer:function (v) {
                         if (v == null || v == '') return 'Not assigned'; else return v;
                     },
                     width:100,
                     sortable:true
                 }, {
                     header:'Target Stage',
                     dataIndex:'targetStage',
                     width:100,
                     sortable:true
                 }, {
                     header:'Completion Status',
                     dataIndex:'completionStatus',
                     renderer: function(v, m, record) {
                         return artifactTable.getCompletionStatusRender(v, m, record);
                     },
                     width:150,
                     sortable:false
                 }
            ]
    });
    
    function toString(sdmNames) {
        var result = "";
        for (idx = 0; idx < sdmNames.length ; idx++) {
            result += sdmNames[idx] + ",";
        }
        return result;
    }
    
    function getSdmNames(subTypes, sdmNames){
        for (var i=0; i< subTypes.length; i++){
            var subType = subTypes[i];
            if (subType.subs.length > 0){
                getSdmNames(subType.subs, sdmNames);
            }
            if (!subType.abstractType){
                sdmNames.push(subType.type);
            }
        }
        return sdmNames;
    }
});

//]]>
</script>