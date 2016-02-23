<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="nextStages" type="java.util.List<com.hp.systinet.repository.sdm.propertytypes.Category>"--%>
<%--@elvariable id="canMoveTo" type="java.lang.Boolean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:if test="${canMoveTo && not empty nextStages}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
    
    <fmt:message key="cancelButton" var="cancelButton" bundle="${messages}"/>
    <fmt:message key="moveToButton_dialogTitle" var="dialogTitle" bundle="${messages}"/>

    <syswf:component prefix="confirmDialog" name="/core/impl/util/dialog">
        <syswf:param name="noUndo" value="false"/>
        <syswf:param name="heading" value="${dialogTitle}"/>
    </syswf:component>

    <syswf:input id="moveToTaxonomyVal" name="moveToTaxonomyVal" value="" mode="hidden"/>

    <syswf:control mode="script" caption="moveToFunction" action="moveToAction"/>
	<div class="EA-right-panel">
	    <a href="javascript:void(0);" id="moveToButton" class="UI PageAction Dropdown Left" style="padding-top:4px">
	        <span><fmt:message key="moveToButton_buttonLabel" bundle="${messages}"/></span>
	    </a>
    </div>
    <%--DROPDOWN MENU --%>
    <div class="x-hidden flyout-menu UI Dropdown" id="moveToMenu_content">

        <div class="DropdownContent">
            <c:forEach items="${nextStages}" var="stage" varStatus="stageStatus">
            <div class="EA-left-panel">
                <a id="${prefix}_${stageStatus.index}" href="javascript:void(0)" class="IconAlign">
                    <span><c:out value="${stage.name}"/></span>
                </a>
                <script type="text/javascript">
                //<![CDATA[
			    <c:set var="stageNameEscaped"><syswf:out value="${stage.name}" context="HtmlBody"/></c:set>
			    
                    Ext.onReady(function() {
                        var handler = function(){ Ext.get('moveToTaxonomyVal').dom.value = '${stage.val}'; moveToFunction(); };
                        var element = Ext.get('${prefix}_${stageStatus.index}');
                        element.on('click', function() {
                           ${prefix}_confirmDialog_showDialog(element,
                                   null,
                                   '<fmt:message key="moveToButton_popupBody" bundle="${messages}"><fmt:param value="${stageNameEscaped}"/></fmt:message>',
                                   null, handler, false);
                       	});
                    });
                
                //]]>
                </script>
            </div>
            </c:forEach>

        </div>

    </div>
    <%-- DROPDOWN INIT --%>
    <script type="text/javascript">
    //<![CDATA[

        Ext.onReady(function() {
            Dropdown.init('moveToButton', 'moveToMenu_content', {
                align: 'tr-tl?'
            });
        });
    
    //]]>
    </script>


</c:if>
