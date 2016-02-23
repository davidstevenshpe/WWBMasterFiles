<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contextactions.messages" var="messages"/>
<fmt:message bundle="${messages}" key="purge" var="label" />

<div class="x-hidden flyout-menu UI Dropdown" id="feeds_list_content">
    <div class="DropdownContent">
        <syswf:component name="/core/feeds/restLink" prefix="restLink">
            <syswf:param name="artifact" value="${artifact}"/>
        </syswf:component>
        <syswf:component name="/core/comments/contextActions/commentFeedLink" prefix="discussionFeed">
            <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
            <syswf:param name="common" value="false"/>
        </syswf:component>
    </div>
</div>

<a href="javascript:void(0);" onclick="return false;" class="context-button Dropdown Left" id="feeds_list" title="${lable}"></a>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){ Dropdown.init('feeds_list','feeds_list_content',{align:'tl-bl',forceRefresh:true,shadow:'none'}); });

//]]>
</script>