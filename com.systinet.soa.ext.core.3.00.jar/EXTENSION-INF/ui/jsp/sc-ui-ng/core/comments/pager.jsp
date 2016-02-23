<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--
totalCount: ${pagerInfo.totalCount} <br/>
pageSize: ${pagerInfo.pageSize} <br/>
activePage: ${pagerInfo.activePage} <br/>
totalPages: ${pagerInfo.totalPages} <br/>
 -->

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsMessages"/>
<c:if test="${pagerInfo.totalCount > pagerInfo.pageSize}">

<fmt:message var="firstCaption" key="pager.firstCaption" bundle="${commentsMessages}" />
<fmt:message var="firstHint" key="pager.firstHint" bundle="${commentsMessages}" />
<fmt:message var="nextCaption" key="pager.nextCaption" bundle="${commentsMessages}" />
<fmt:message var="nextHint" key="pager.nextHint" bundle="${commentsMessages}" />
<fmt:message var="prevCaption" key="pager.prevCaption" bundle="${commentsMessages}" />
<fmt:message var="prevHint" key="pager.prevHint" bundle="${commentsMessages}" />
<fmt:message var="lastCaption" key="pager.lastCaption" bundle="${commentsMessages}" />
<fmt:message var="lastHint" key="pager.lastHint" bundle="${commentsMessages}" />

<!-- BEGIN: PAGER -->
<div class="MessageboardPagination">
    <div class="NavigationMeta">Page: <span class="ActivePage">${pagerInfo.activePage}</span> of ${pagerInfo.totalPages}</div>
    <div class="Buttons">
        <c:if test="${pagerInfo.activePage > 1}">
            <syswf:control mode="postAnchor" caption="${firstCaption}" hint="${firstHint}" action="page" id="pagerFirstPage">
                <syswf:attribute name="class">First</syswf:attribute>
                <syswf:param name="page" value="${1}" />
            </syswf:control>
            <syswf:control mode="postAnchor" caption="${prevCaption}" hint="${prevHint}" action="page" id="pagerPrevPage">
                <syswf:attribute name="class">Previous</syswf:attribute>
                <syswf:param name="page" value="${pagerInfo.activePage - 1}" />
            </syswf:control>
        </c:if>
        
        <c:if test="${pagerInfo.activePage - 3 > 1}">
            <a href="javascript:void(0);" class="Dots"><span>...</span></a>
        </c:if>
        
        <c:forEach begin="1" end="3" var="j">
            <c:set var="i" value="${4-j}" />
            <c:if test="${(pagerInfo.activePage - i) >= 1}">
                <syswf:control mode="postAnchor" caption="${pagerInfo.activePage - i}" action="page" id="pagerPage${pagerInfo.activePage - i}">
                    <syswf:attribute name="class">Page</syswf:attribute>
                    <syswf:param name="page" value="${pagerInfo.activePage - i}" />
                </syswf:control>
            </c:if>
        </c:forEach>
        
        <a href="javascript:void(0);" class="Page ActivePage"><span>${pagerInfo.activePage}</span></a>
        
        <c:forEach begin="1" end="3" var="i">
            <c:if test="${(pagerInfo.activePage + i) <= pagerInfo.totalPages}">
                <syswf:control mode="postAnchor" caption="${pagerInfo.activePage + i}" action="page" id="pagerPage${pagerInfo.activePage + i}">
                    <syswf:param name="page" value="${pagerInfo.activePage + i}" />
                </syswf:control>
            </c:if>
        </c:forEach>
        
        <c:if test="${pagerInfo.activePage + 3 < pagerInfo.totalPages}">
            <a href="javascript:void(0);" class="Dots"><span>...</span></a>
        </c:if>
        
        <c:if test="${pagerInfo.activePage < pagerInfo.totalPages}">
            <syswf:control mode="postAnchor" caption="${nextCaption}" hint="${nextHint}" action="page" id="pagerNextPage">
                <syswf:attribute name="class">Next</syswf:attribute>
                <syswf:param name="page" value="${pagerInfo.activePage + 1}" />
            </syswf:control>
            <syswf:control mode="postAnchor" caption="${lastCaption}" hint="${lastHint}" action="page" id="pagerLastPage">
                <syswf:attribute name="class">Last</syswf:attribute>
                <syswf:param name="page" value="${pagerInfo.totalPages}" />
            </syswf:control>
        </c:if>
        <div class="x-clear"></div>
    </div>
</div>
<!-- END: PAGER -->

</c:if>
