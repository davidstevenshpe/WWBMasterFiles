<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<syswf:control mode="ajax" action="removeKeyReferences" caption="${prefix}removeKeyReferences"/>

<syswf:input id="uddiKeyHolder" name="uddiKeyHolder" value="" mode="hidden"/>
<syswf:input id="uddiTypeHolder" name="uddiTypeHolder" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

    function storeEditingProperties(uddiKey, uddiType) {
        Ext.get('uddiKeyHolder').dom.value = uddiKey;
        Ext.get('uddiTypeHolder').dom.value = uddiType;
    }
    function getParams() {
        return {
            'uddiKeyHolder' : Ext.get('uddiKeyHolder').dom.value,
            'uddiTypeHolder': Ext.get('uddiTypeHolder').dom.value
        }
    }
    function ${openRemoveKeyedReferencesDialog}(uddiKey, uddiType) {
    	storeEditingProperties(uddiKey,uddiType);
    	${prefix}openRemoveKeyedReferences();
    }
    

//]]>
</script>


<syswf:component name="/core/window" prefix="removeKeyReferences">
    <syswf:param name="winTitle" value="${winTitle}" />
    <syswf:param name="winComponent" value="/widgets/removeKeyedReferencesWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openRemoveKeyedReferences" />
    <syswf:param name="winWidth" value="500" />
    <syswf:param name="winOkAction" value="${prefix}removeKeyReferences" />
    <syswf:param name="winOkLabel" value="Ok" />
   
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="winGetParamsFunctionName" value="getParams" />
    <syswf:param name="registryBean" value="${registryBean}" />
    <syswf:param name="uddiHolder" value="${uddiHolder}" />
</syswf:component>