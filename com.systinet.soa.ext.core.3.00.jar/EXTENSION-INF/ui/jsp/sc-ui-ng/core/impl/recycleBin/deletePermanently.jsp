<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.contextactions.messages" var="contextmessages"/>
<fmt:message bundle="${messages}" key="recycleBin.deletePernamently" var="label"/>

<syswf:control mode="script" caption="${prefix}DeletePermanently" action="${controlAction}">
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

<c:choose>
    <c:when test="${not empty emptyRecycleBin}"><fmt:message bundle="${messages}" key="recycleBin.emptyBinConfirm" var="confirm" /></c:when>
    <c:otherwise><fmt:message bundle="${messages}" key="recycleBin.deletePernamentlyConfirm" var="confirm" /></c:otherwise>
</c:choose>

<script type="text/javascript">
//<![CDATA[

    function ${controlName}(e) {
        Ext.MessageBox.confirm("<fmt:message bundle="${messages}" key="recycleBin.deletePernamently" />", "${confirm}", function(answer) {
            if(answer == LANG.Yes.toLowerCase()) {
            	${prefix}DeletePermanently();
            }
        });
    }

//]]>
</script>

<c:if test="${not empty uuid}">
    <a href="javascript:void(0)" id="${prefix}anch" class="context-button Remove" title="${label}"></a>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}anch','click',${controlName});
        });
    
//]]>
</script>
</c:if>
