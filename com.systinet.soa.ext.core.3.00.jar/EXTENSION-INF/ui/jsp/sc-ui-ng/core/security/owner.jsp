<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.security.securitymessages" var="securitymessages"/>
<fmt:message var="owner_componentTitle" key="owner.componentTitle" bundle="${securitymessages}"/>
<fmt:message var="owner_changeLink" key="owner.changeLink" bundle="${securitymessages}"/>

<div class="EA-right-panel">
    
   	<h3>${owner_componentTitle}</h3>        
       <div>
           <syswf:component prefix="owner" name="/core/impl/util/principalLinkRenderer">
               <syswf:param name="principal" value="${principal}"/>
               <syswf:param name="showIcon" value="${true}"/>
           </syswf:component>
       </div>
    
    <c:if test="${isActionPermitted}"> 
        <div class="Footer">
            <c:set var="controlName" value="${prefix}_changeOwner_popup" />
                                                                
            <syswf:component name="/core/impl/bulk/security/owner" prefix="changeOwner" wrap="false" >
                <syswf:param name="selectionBag" value="${selectionBag}"/>
                <syswf:param name="controlName" value="${controlName}"/>
            </syswf:component>                        
            
            <a class="UI PageAction ChangeOwner" href="javascript:${controlName}();" style="font-size: 12px;">${owner_changeLink}</a>

        </div>
    </c:if>
</div>    
