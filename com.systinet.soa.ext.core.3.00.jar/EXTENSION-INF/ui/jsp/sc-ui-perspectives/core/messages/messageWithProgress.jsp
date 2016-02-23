<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<div class="UI SystemMessage Info">
    <div class="MessageContainer">
        <syswf:component prefix="progressBar" name="/core/impl/widgets/progressBar" wrap="false">
            <syswf:param name="onCompleteCallback" value="${onCompleteCallback}"/>
        </syswf:component>
        <%-- TODO REVIEW (Svata, Sep 7, 2010): The message does not change when the progress bar is completed --%>
        <div class="Text">
            <c:out value="${message}" escapeXml="false"/>
        </div>
        <div class="x-clear"></div>
    </div>
</div>