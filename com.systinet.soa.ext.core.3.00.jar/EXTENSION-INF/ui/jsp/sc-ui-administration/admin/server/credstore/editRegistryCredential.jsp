<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<a href ="javascript:void(0);" class ="${styleClass}" id ="prefix_${actionMode}">${label}</a>
<syswf:control mode="script" action="edit" caption="${prefix}edit" affects=".." loadingMask="true">
    <syswf:param name="artifact" value="${artifact}"/>
</syswf:control>

<syswf:control mode="script" action="cancel" caption="${prefix}cancel" affects=".."/>

<syswf:component name="/core/window" prefix="addResourceCredential">
    <syswf:param name="winTitle" value="${winTitle}" />
    <syswf:param name="winComponent" value="/admin/server/editRegistryCredentialWindow"/>
    <syswf:param name="winOpenFunctionName" value="${prefix}openRegistryCredential" />
    <syswf:param name="winWidth" value="450" />
    <syswf:param name="winOkAction" value="${prefix}edit" />
    <syswf:param name="winCancelAction" value="${prefix}cancel" />
    <syswf:param name="winOkLabel" value="Save" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="regCredentialBean" value="${regCredentialBean}"/>
    <syswf:param name="validationResult" value="${validationResult}"/>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        attachOn('prefix_${actionMode}','click',function() {
            ${prefix}openRegistryCredential();
        });
    });

//]]>
</script>

<c:if test="${not empty validationResult}">
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        ${prefix}openRegistryCredential();
    });

//]]>
</script>
</c:if>