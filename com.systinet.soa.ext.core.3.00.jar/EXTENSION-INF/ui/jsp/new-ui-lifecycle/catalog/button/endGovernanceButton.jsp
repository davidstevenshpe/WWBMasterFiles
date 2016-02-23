<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="this" type="com.hp.systinet.lifecycle.ui.catalog.button.EndGovernanceButton"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="endGovernanceButton_buttonLabel" var="endGovernanceButton_buttonLabel" bundle="${messages}"/>
<fmt:message key="endGovernanceButton_popupHeader" var="msgConfirmTitle" bundle="${messages}"/>
<fmt:message key="endGovernanceButton_popupBody" var="msgConfirmMessage" bundle="${messages}"/>

<c:if test="${this.canEndGovernance}">
	<div class="EA-right-panel">
	    <a id="${prefix}ungovernLink" href="javascript:void(0);" class="UI PageAction Delete">
	       <span><c:out value="${endGovernanceButton_buttonLabel}"/></span>
	    </a>
    </div>
    <syswf:control mode="script" caption="${prefix}endGovernance" action="endGovernanceAction"/>

    <syswf:component prefix="ungovernConfirmDialog" name="/core/impl/util/dialog">
        <syswf:param name="controlName" value="${prefix}ungovernControl" />
        <syswf:param name="handler" value="${prefix}endGovernance" />
        <syswf:param name="heading">${msgConfirmTitle}</syswf:param>
        <syswf:param name="content">${msgConfirmMessage}</syswf:param>
        <syswf:param name="actionCaption">${endGovernanceButton_buttonLabel}</syswf:param>
        <syswf:param name="noUndo" value="no" />
    </syswf:component>
    
    <script type="text/javascript">
//<![CDATA[
                    Ext.onReady(function() {
                        attachOn('${prefix}ungovernLink','click',function() {
                            ${prefix}ungovernControl();
                        });
                        moveWindow('${prefix}_ungovernConfirmDialog_window','popupWindows');
                    }); 
//]]>
</script>
</c:if>
