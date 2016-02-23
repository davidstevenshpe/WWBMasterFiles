<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>

<fmt:message bundle="${msg}" var="saveContract" key="NewRequest_ButtonSaveContract"/>
<fmt:message bundle="${msg}" var="saveRequest" key="NewRequest_ButtonSaveRequest"/>

<c:set var="pp" value="${parentPrefixes[0]}"/>

<syswf:block className="UI Block Green">
    <div class="Content">
        <div class="UI Form Controls">
            <c:choose>
                <c:when test="${model.importContract}">
                    <syswf:control mode="button" action="${pp}$saveContract" caption="${saveContract}" disabled="${not model.valid}">
                        <syswf:attribute name="class" value="btn btn-primary" />
                    </syswf:control>
                </c:when>
                <c:otherwise>
                    <syswf:control mode="button" action="${pp}$save" caption="${saveRequest}" disabled="${not model.valid}">
                        <syswf:attribute name="class" value="btn btn-primary" />
                        </syswf:control>
                </c:otherwise>
            </c:choose>
            <syswf:control mode="button" action="${pp}$cancel" caption="Cancel" targetDepth="${sessionStack.currentDepth-1}"/>
        </div>
    </div>
</syswf:block>
