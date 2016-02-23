<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />

<syswf:control mode="ajax" action="changeMyEntities" caption="${prefix}changeMyEntities"  loadingMask="true" affects="."/>

<h4>
	<div class="UI Align">
		<div class="Left">
			<fmt:message key="uddi.bulk.export.destinationBusinessEntity" bundle="${l10n}"/>
		</div>		
		<div class="Right">
			<fmt:message key="uddi.bulk.export.show" bundle="${l10n}"/>
			<syswf:selectOne id="${prefix}myEntities" name="myEntities" value="${showEntity}" 
								property="myEntities" mode="radio" optionValues="${showValues}" optionCaptions="${showCaptions}" 
								displayAsRow="true" />
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    attachOn('${prefix}myEntities_0','click',function() {
                    	${prefix}changeMyEntities();
                    });
                    attachOn('${prefix}myEntities_1','click',function() {
                    	${prefix}changeMyEntities();
                    });
                });
            
//]]>
</script>
		</div>		
		<div class="x-clear"></div>	
	</div>
</h4>

<c:if test="${(empty errorMessage)}" >
	<syswf:component name="/core/table" prefix="bulkExport" >
		<syswf:param name="customizationId" value="integration.uddiexport.bulkExportAction"/>
		<syswf:param name="datasource" value="${BEDataSource}"/>
		<syswf:param name="selectionBag" value="${selectionBag}" />               
	</syswf:component>
</c:if>

<c:if test="${not empty errorMessage}" >
	<p class="Warning"><c:out value="${errorMessage}"/></p>
</c:if>
