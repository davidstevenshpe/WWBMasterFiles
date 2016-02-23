<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.history.messages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="uimessages"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
    <syswf:param name="subtitle" value="${caption}" />
    <syswf:param name="subtitleClass" value="Artifact" />
    <syswf:param name="iconType" value="${artifactFirstRev._artifactSdmName}" />
    <syswf:param name="iconFormat" value="small" />
    <syswf:param name="showRating" value="false" />
    <syswf:param name="showBackButton" value="true" />
    <syswf:param name="artifactUuid" value="${artifactFirstRev._uuid}" />
</syswf:component>

<syswf:block className="UI Block Simple">
    <div class="Content">

        <syswf:control mode="script" action="change" caption="${prefix}changeView"/>
        
        <div class="TabPanel Plain CompareRevisions">        
            <div id="${prefix}diffs" class="CompareRevisionProperties">                
                <syswf:component name="/core/layout/tabs" prefix="visualDiffTabs" wrap="false">
                    <syswf:param name="customizationId" value="${customizationId}" />
                    <syswf:param name="parentPrefix" value="${prefix}"/>
                    <syswf:param name="propertyDatasource" value="${propertyDatasource}" />
                    <syswf:param name="relationDatasource" value="${relationDatasource}" />
                    <syswf:param name="firstRev" value="${firstRev}" />
                    <syswf:param name="secondRev" value="${secondRev}" />
                    <syswf:param name="artifactFirstRev" value="${artifactFirstRev}" />
                    <syswf:param name="artifactSecondRev" value="${artifactSecondRev}" />
                    <syswf:param name="model" value="${model}" />
                    <syswf:param name="diffMode" value="${diffMode}" />
                    <syswf:param name="firstRevCaption" value="${firstRevCaption}" />
                    <syswf:param name="secondRevCaption" value="${secondRevCaption}" />
                </syswf:component>
            </div>            
        </div>
    </div>
</syswf:block>