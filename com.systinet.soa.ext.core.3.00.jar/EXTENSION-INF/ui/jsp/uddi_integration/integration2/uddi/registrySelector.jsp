<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>

<fmt:message var="error_title" key="uddi.registrySelector.import_error_title" bundle="${l10n}"/>

<c:if test="${not empty uddiRegistries}">
<li>	
	<a class="dir" href="javascript:void(0);">UDDI</a>
	
	<ul class="systinet-horizontal-menu-arifacts">
		<c:forEach items="${uddiRegistries}" var="registryBean">
		    <li>
			    <a id="import_${registryBean.uuid}" href="javascript:void(0)">
			        <span>
			        	<syswf:out value="${registryBean.name}" context="HtmlBody"/>
		        	</span>
			    </a>
		    </li>
		</c:forEach>
	</ul>
	
	<syswf:input id="registryUuid" name="registryUuid" value="" mode="hidden"/>
	
	<div id="${prefix}importWindowWrapper">
		<syswf:component name="/integration2/uddi/import/registryImport" prefix="${prefix}_importWindow">
		    <syswf:param name="jsOpenWindow" value="${prefix}openPopWindow"/>
		    <syswf:param name="winGetParamsFunctionName" value="importDialog_getParams" />
		</syswf:component>            
	</div>
	
	<script type="text/javascript">
	//<![CDATA[
	
	    Ext.onReady(function(){
			moveWindow('${prefix}importWindowWrapper','popupWindows');
		});
		
	//]]>
	</script>
	
	<script type="text/javascript">
	//<![CDATA[
	
	    function storeRegistryUuid(uuid) {
	        Ext.get('registryUuid').dom.value = uuid;
	    }
	    function importDialog_getParams() {
	        return {
	            'registryUuid' : Ext.get('registryUuid').dom.value
	        };
	    }
	    function showimportDialog(uuid) {
	        storeRegistryUuid(uuid);
	        ${prefix}openPopWindow();
	    }
		
	//]]>
	</script>
	
	<script type="text/javascript">
	//<![CDATA[
	
	Ext.onReady(function(){
	    <c:forEach items="${uddiRegistries}" var="registryBean">
	           attachOn('import_${registryBean.uuid}','click',function(){ 
	            	showimportDialog('${registryBean.uuid}');              
               });        
	     </c:forEach> 
	});
		
	//]]>
	</script>
</li>	
</c:if>
