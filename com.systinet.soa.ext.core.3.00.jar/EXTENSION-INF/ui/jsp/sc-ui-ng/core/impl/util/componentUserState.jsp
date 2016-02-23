<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:input name="componentState" value="${this.componentUserStateHolder}" property="componentState"
             mode="hidden" id="${this.componentUserStateHolder.componentStateId}_state"/>

<syswf:control id="update" mode="script" caption="${this.componentUserStateHolder.componentStateId}" affects="." action="foo"/>
<%-- without action onAction is not called --%> 