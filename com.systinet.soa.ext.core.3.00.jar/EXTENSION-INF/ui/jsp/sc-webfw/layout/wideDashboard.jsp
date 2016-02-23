<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component prefix="layoutControls" name="/layout/dashboard/layoutControls">
    <syswf:param name="panel" value="${panel}"/>
    <syswf:param name="layout" value="${layout}"/>
    <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
</syswf:component>

<syswf:component prefix="uiMessages" name="/util/uiMessageRenderer" wrap="false" />

<div id="wideDashboard" class="sortableBlocks">
    <c:forEach var="box" items="${panel.activeLayout.boxList}">
        <syswf:component prefix="${box.name}" name="/layout/wideDashboard/box" wrap="false">
            <syswf:param name="panel" value="${panel}"/>
            <syswf:param name="box" value="${box}"/>
            <syswf:param name="layoutParameters" value="${layoutEditingParameters}"/>
        </syswf:component>
    </c:forEach>
</div>

<script type="text/javascript">
//<![CDATA[

	init_section_sorting('wideDashboard', null);

//]]>
</script>