<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>

<fmt:message var="status_completed" bundle="${relationshipmessages}" key="completion.status.table.completed"/>
<fmt:message var="status_notCompleted" bundle="${relationshipmessages}" key="completion.status.table.notCompleted"/>
<fmt:message var="proposalDeliverableDesc" bundle="${uisccomponentsmessages}" key="proposal.deliverable.description"/>

<div class="proposalDeliverableDescp">${proposalDeliverableDesc}</div>
<div>&nbsp;</div>
<div id="${prefix}-deliverableComponent">
</div>
<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
    var artifactTable = Ext4.create('EA.model.table.proposal.ProposalDeliverableTable', {
        renderTo: '${prefix}-deliverableComponent',
        width: '100%',
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
        columns:[{
                     id:'name',
                     flex:1,
                     header:'Name',
                     dataIndex:'coreName',
                     renderer:function (v,m,record) {
                    	 return artifactTable.getArtifactLinkRender(record.data.uuid, record.data.coreName, record.data.type);
                     },
                     width:150,
                    // sortable:true,
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
                     renderer:function (v) {
                         if (v == null || v == '') return 'N/A'; else return v;
                     },
                     width:50,
                     //sortable:true
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
                     header:'Internal Effort',
                     dataIndex:'internalEffort',
                     width:100,
                     sortable:true
                 }, {
                     header:'Ext. Effort',
                     dataIndex:'externalEffort',
                     width:100,
                     sortable:true
                 }, {
                     header:'Cost',
                     dataIndex:'cost',
                     width:100,
                     sortable:true
                 }, {
                	 header:'Compliance',
                	 align:'right',
                	 dataIndex: 'complianceErrorCount',
                	 sortable:false,
                	 width:100
                 },{
                     header:'Completion Status',
                     dataIndex:'completionStatus',
                     renderer: function(v, m, record) {
                    	 return artifactTable.getCompletionStatusRender(v, m, record);
                     },
                     width:150,
                     sortable:false
                 }]
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