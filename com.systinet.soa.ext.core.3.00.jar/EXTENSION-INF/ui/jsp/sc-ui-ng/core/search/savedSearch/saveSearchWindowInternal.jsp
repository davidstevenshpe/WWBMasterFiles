<%--
Parameters:
    saveFce - javascript function for saving method. Saving method rerenders this compoment.
    openResultWindowFce - javascript method, which opens page with results
    closeWindowFce - javascript method for closing this window
    savedSearchDefinition - instance of search to be saved
    resultUpdateIdHolder - holder with id of result window id to refresh after save
    saveButtonId - id of save button from window. Its css style has to be changed if name is empty durint save.
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<%-- Description of search is visible always --%>
<syswf:component name="/core/search/searchCriteriaDescription" prefix="seachDescription" ajax="true" wrap="false">
    <syswf:param name="savedSearchDefinition" value="${savedSearchDefinition}" />
    <syswf:param name="nameMustNotBeEmpty" value="${nameMustNotBeEmpty}" />
    <syswf:param name="filterLabelResolver" value="${filterLabelResolver}" />
</syswf:component>

<%-- If name is empty, button has to be enabled and its css style has to be changed --%>
<c:if test="${nameMustNotBeEmpty}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
        	SPopup.Window.Instance['${windowId}'].getEl().unmask();
            Ext.getCmp('${saveButtonId}').setDisabled(false); 
            Ext.getCmp('${saveButtonId}').setIconClass('');
        });
    
//]]>
</script>
</c:if>

<%--  if flag 'succesfullySaved' is true, result window is opened --%>
<c:if test="${isSuccesfullySaved}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            ${closeWindowFce}();
            ${openResultWindowFce}();
        });
    
//]]>
</script>

</c:if>

<%-- save action affects only internal part of window (this component) --%>
<syswf:control mode="script" caption="${saveFce}" action="save" affects="." />
