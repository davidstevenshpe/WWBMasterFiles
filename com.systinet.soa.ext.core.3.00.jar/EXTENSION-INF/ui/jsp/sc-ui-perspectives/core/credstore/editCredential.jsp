<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:control mode="script" action="saveCredential" caption="${prefix}saveCredential"/>

<syswf:input id="editingUrlPattern" name="editingUrlPattern" value="" mode="hidden"/>
<syswf:input id="mode" name="mode" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

    function storeEditingProperties(urlPattern) {
        Ext.get('editingUrlPattern').dom.value = urlPattern;
    }
    function storeEditingMode(mode) {
        Ext.get('mode').dom.value = mode;
    }
    function editDialog_getParams() {
        return {
            'editingUrlPattern' : Ext.get('editingUrlPattern').dom.value,
            'mode' : Ext.get('mode').dom.value
        };
    }
    
    function ${openDialogFunction}(urlPattern) {
        storeEditingProperties(urlPattern);
        storeEditingMode('edit');
        ${prefix}openCredential();
    }
    

//]]>
</script>


<syswf:component name="/core/window" prefix="addResourceCredential">
    <syswf:param name="winTitle" value="${winTitle}" />
    <syswf:param name="winComponent" value="/core/credstore/editCredentialWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openCredential" />
    <syswf:param name="winWidth" value="350" />
    <syswf:param name="winOkAction" value="${prefix}saveCredential" />
    <syswf:param name="winOkLabel" value="Save" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="winGetParamsFunctionName" value="editDialog_getParams" />
    <syswf:param name="resourceCredential" value="${resourceCredential}"/>
    <syswf:param name="validationResult" value="${validationResult}"/>
    
</syswf:component>

<c:if test="${not empty validationResult}">
	<script type="text/javascript">
//<![CDATA[

	  Ext.onReady(function(){
		  storeEditingMode('error');
		  ${prefix}openCredential();
	  });
	
//]]>
</script>
</c:if>