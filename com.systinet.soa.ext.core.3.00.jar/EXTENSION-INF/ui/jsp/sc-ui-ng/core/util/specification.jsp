<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uisccomponentsmessages"/>
<fmt:message var="SaveButton" key="Save" bundle="${uisccomponentsmessages}"/>
<fmt:message var="CancelButton" key="Cancel" bundle="${uisccomponentsmessages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="utilmessages"/>
<fmt:message var="specificationMissingInfoMessage" key="specificationMissingInfoMessage" bundle="${utilmessages}"/>
<fmt:message var="specificationEmptyInfoMessage" key="specificationEmptyInfoMessage" bundle="${utilmessages}"/>

<c:choose>
    <c:when test="${editMode}">
        <syswf:block className="UI Block Common">
            <syswf:textArea id="${prefix}_richTextAreaWidget" name="richTextAreaWidget" value="${specificationBean}" property="specification"/>                
            <syswf:component name="/core/impl/edit/richTextEditor" prefix="richText" wrap="false">
                <syswf:param name="textAreaId" value="${prefix}_richTextAreaWidget"/>
                <syswf:param name="specificationPage" value="true"/>
                <syswf:param name="height" value="500"/>
            </syswf:component>
        </syswf:block>
        <syswf:block className="UI Block Green">
            <div class="Content">
                <div class="UI Form Controls">
                    <a id="${prefix}saveLink" href="javascript:void(0);" class="btn btn-primary"><span><span><span>${SaveButton}</span></span></span></a>
                    <syswf:control caption="${prefix}save" mode="script" affects="." action="save" loadingMask="true"/>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            Ext.get('${prefix}saveLink').on('click', function() {
                                ${prefix}_richText_updateContent();
                                ${prefix}save();
                            });
                        });
                    
//]]>
</script>
                    <a id="${prefix}cancelLink" href="javascript:void(0);" class="btn btn-gray"><span><span><span>${CancelButton}</span></span></span></a>
                    <syswf:control caption="${prefix}cancel" mode="script" affects="." action="cancel"/>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            Ext.get('${prefix}cancelLink').on('click', function() {
                                ${prefix}cancel();
                            });
                        });
                    
//]]>
</script>
                </div>
            </div>
        </syswf:block>
    </c:when>
    <c:otherwise>
        <syswf:control caption="${editFunction}" mode="script" affects="." action="edit" loadingMask="true"/>
        <c:choose>
            <c:when test="${empty specificationBean.specification or specificationBean.specification eq ''}">
                <c:choose>
                    <c:when test="${permissions.write}">
                        <syswf:block className="UI Block Common Last">
                            <syswf:component name="/core/impl/layout/uiMessage" prefix="noSpecificationMessage">
                                <syswf:param name="type" value="info" />
                                <syswf:param name="text">${specificationMissingInfoMessage}</syswf:param>
                            </syswf:component>
                        </syswf:block>
                    </c:when>
                    <c:otherwise>
                        <syswf:block className="UI Block Common Last">
                            <syswf:component name="/core/impl/layout/uiMessage" prefix="noSpecificationMessage">
                                <syswf:param name="type" value="info" />
                                <syswf:param name="text">${specificationEmptyInfoMessage}</syswf:param>
                            </syswf:component>
                        </syswf:block>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>            
                <syswf:block className="UI Block Common Last">
					<c:set var="specificationValue" value="${fn:replace(specificationBean.specification, newLineChar, '')}"/>
                    <iframe src="${webContext}/service-catalog/core/util/specificationIF?uuid=${artifact._uuid}" frameborder="0" height="500px" width="100%" scrolling="auto"></iframe>
                </syswf:block>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>