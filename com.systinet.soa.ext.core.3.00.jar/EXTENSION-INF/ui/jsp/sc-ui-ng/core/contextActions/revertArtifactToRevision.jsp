<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contextactions.messages" var="messages" />
<fmt:message bundle="${messages}" key="revert" var="label" />

<c:if test="${allowRevert}">

    <script type="text/javascript">
//<![CDATA[

        function ${prefix}confirm(e) {
            Ext4.MessageBox.confirm("<fmt:message bundle="${messages}" key="revert" />", "<fmt:message bundle="${messages}" key="revert.confirm" />", function(answer) {
                if(answer == LANG.Yes.toLowerCase()) {
                    ${prefix}revert();
                }
            });
        }
    
//]]>
</script>
    
    <syswf:control mode="script" caption="${prefix}revert" action="revert">
        <syswf:attribute name="class">action-button RevertToRevision</syswf:attribute>
    </syswf:control>
    
    <a href="javascript:void(0)" id="${prefix}restoreAnchor" class="context-button VersionRevert" title="${label}"></a>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}restoreAnchor','click',${prefix}confirm);
        });
    
//]]>
</script>

</c:if>