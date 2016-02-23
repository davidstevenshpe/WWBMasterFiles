<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<%-- It aims to display all Deliverable/plateau artifacts that realized by current artifact. --%>
<%-- Just display this section only if there are such Deliverable/Plateur   --%>
<c:if test="${allowDisplay}">
<fmt:message var="baseline" bundle="${relationshipmessages}" key="lifecycleplan.baseline"/>
<fmt:message var="approved" bundle="${relationshipmessages}" key="lifecycleplan.stage.approved"/>
<br>
<syswf:block className="LifeCyclePlan UI Block">
	<div class="Title">
        <h3><span><fmt:message bundle="${relationshipmessages}" key="lifecycleplan.title"/></span></h3>
    </div>
    <i>Track the plans for planned lifecycle transitions of this artifact. The current lifecycle status and when it was reached is referenced as 'Baseline'. You can add a plan
        for lifecycle transition by linking this artifact from a
        <syswf:control id="gov0" mode="anchor" caption="plateau" targetTask="/common/browseArtifact">
            <syswf:param name="artifactType" value="plateauArtifact"/>
        </syswf:control><c:choose>
            <c:when test="${not(artifact._artifactSdmName eq 'projectArtifact' or artifact._artifactSdmName eq 'programArtifact')}">
                or <syswf:control id="gov1" mode="anchor" caption="deliverable." targetTask="/common/browseArtifact">
                <syswf:param name="artifactType" value="deliverableArtifact"/>
            </syswf:control> The date for the transition is derived from the plateau/deliverable end date property.
            </c:when>
            <c:otherwise>.</c:otherwise>
        </c:choose>
    </i>
</syswf:block>

<div id="LifeCyclePlanGridContainer"></div>
<script type="text/javascript">
//<![CDATA[

    var textBlueColor = "#0096D6";

    Ext4.onReady(function(){
        Ext4.Loader.setPath('Ext4.app', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.portal', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.model', '${webResourcePath}/../../components/ui-ea/model');
        Ext4.Loader.setPath('EA.portlets', '${webResourcePath}/../../components/ui-ea/portlets');

	   var myProxy = Ext4.create('EA.model.table.PagingMemoryProxy', {
		   enablePaging: true,
           reader: {
               type: 'json',
               root: '${rows}',
               totalProperty: '${totalRows}'
           }
	   });

       var store = new Ext4.data.Store ({
        	fields:[
        	    <c:forEach var="col" items="${tableData.columnsDefinitions}" varStatus="status">
        	    	'${col.stage}'<c:if test="${not status.last}">,</c:if>
                </c:forEach>
        	],
        	data: ${tableData.jsonData},
            proxy: myProxy,
            pageSize: ${pageSize}
        });
        Ext4.create('Ext4.grid.Panel', {
        	store: store,
            pageSize: ${pageSize},
            start:0, limit: ${pageSize},
            viewConfig: {
                loadMask: false,
                enableTextSelection: true
            },
            columns: [
                <c:forEach var="col" items="${tableData.columnsDefinitions}" varStatus="status">
                  {
                	  id:'${col.stage}',
                	  header:'<div class="LifeCyclePlan-color-circle-border"><div class="LifeCyclePlan-color-circle" style="background-color: ${col.backgroundColor};"><div class="LifeCyclePlan-header">${col.stage}</div></div></div>',
                      dataIndex:'${col.stage}',
                      renderer: function (v, m, record) {
                    	  if (!v) {
                    		  return;
                    	  }
                    	  v = v.trim();
                    	  if (v.length == 0) {
                    		  return;
                    	  }
                    	  // set background color of this cell as stage color.
                    	  // m.style = "background-color: ${col.backgroundColor};";

                    	  var separator = '${separator}';
                    	  var values = v.split(separator);

                    	  var uuid = values[0];
                    	  var dateValue = values[1];
                    	  var name = values[2];

                    	  var result = '';
						  
						  if (uuid != 'null'){
							  result = '<a href=\"' + SERVER_URI + '/../../service-catalog/artifact/' + uuid + '\"';

							  result += "<span style='color: ${col.color};'>" + dateValue + " </span>";
							  if (dateValue.trim().length > 0) {
								result += " - ";
							  }
							  result += "<span style='color: " + textBlueColor + ";'>" + name + " </span>";

							  result += "</a>";
						  }else{
							if (dateValue.trim().length > 0) {
								result = dateValue + ' - ';
							}
							result += '${baseline}';
							if (${isStageApproved}){
								result += ' (${approved})';
							}
						  }	

                    	  return result;
                      },
                      width:250,
                      sortable:false
                  }<c:if test="${not status.last}">,</c:if>
                </c:forEach>
            ],

            <c:if test="${tableData.totalRows > pageSize}">
	            dockedItems: [{
	                xtype: 'pagingtoolbar',
	                store: store,
	                dock: 'bottom',
	                displayInfo: true,
	                plugins: Ext4.create("EA.model.table.SlidingPager")
	            }],
            </c:if>
            renderTo: 'LifeCyclePlanGridContainer'
        });
    });
//]]>
</script>
</c:if>