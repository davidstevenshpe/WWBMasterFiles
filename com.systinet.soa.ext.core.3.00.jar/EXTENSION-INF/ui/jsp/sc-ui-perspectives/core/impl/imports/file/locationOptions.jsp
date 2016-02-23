<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
    beforeLocationContent - if not empty, value from this variable is inserted before line with location.
    afterLocationContent - if not empty, value from this variable is inserted after line with location.
 -->

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="localTab_fileLabel" key="localTab.fileLabel" bundle="${importsMessages}"/>
<fmt:message var="localTab_browseFileButton" key="localTab.browseFileButton" bundle="${importsMessages}"/>
<fmt:message var="remoteTab_urlLabel" key="remoteTab.urlLabel" bundle="${importsMessages}"/>
<fmt:message var="locationAfterUploadLabel" key="locationAfterUploadLabel" bundle="${importsMessages}"/>


<syswf:control id="${prefix}forceLocationUpdate" caption="${prefix}forceLocationUpdate" action="${prefix}_locationAfterUpload$recalculateLocation" mode="script" affects="${prefix}_locationAfterUpload">
    <syswf:param name="importType" value="${importType}"/>
</syswf:control>

<table class="UI Table Properties">
    <colgroup>
        <col class="MidLabelCol"/>
        <col/>
    </colgroup>
    <tbody>
        <c:if test="${not empty beforeLocationContent}">
            ${beforeLocationContent}
        </c:if>
    
        <tr>
            <c:choose>
                <c:when test="${importType eq 'local'}">
                    <th>
                    </th>
                    <td>                        
                        <syswf:input id="${prefix}publishLocalFile_file" name="publishLocalFile_file" mode="text" value="${importFileBean}" property="sourceFile" hint=""/>                        
                        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady(function() {
                                var publishLocalFile_file = new Ext.ux.form.FileUploadField({
                                    id: '${prefix}publishLocalFile_file',
                                    applyTo: '${prefix}publishLocalFile_file',
                                    width: 600,
                                    buttonText: '${localTab_browseFileButton}'
                                });
                            });
                        
//]]>
</script>
                       
                    </td>
                </c:when>
                <c:when test="${importType eq 'remote'}">
                    <th></th>
                    <td>
                        <syswf:input id="${prefix}publishRemoteFile_file" name="publishRemoteFile_file" value="${importFileBean}" property="sourceUrl" hint=""/>
                        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady(function() {
                                var publishRemoteFile_file = new Ext.form.TextField({
                                    id: '${prefix}publishRemoteFile_file',
                                    applyTo: '${prefix}publishRemoteFile_file',
                                    width: 600
                                });
                            });
                        
//]]>
</script>
                    </td>
                </c:when>
            </c:choose>
        </tr>

        <c:if test="${not empty afterLocationContent}">
            ${afterLocationContent}
        </c:if>

        <syswf:component name="/core/impl/imports/file/selectServerFolder" prefix="serverFolder" wrap="false">
            <syswf:param name="importFileBean" value="${importFileBean}"/>
            <syswf:param name="locationsBrowserUrl" value="${locationsBrowserUrl}"/>
            <syswf:param name="recalculateLocationFunction" value="${prefix}forceLocationUpdate"/>
            <syswf:param name="locationsComboID" value="locationsCombo"/>
            <syswf:param name="locationTextID" value="locationText"/>
            <syswf:param name="parentPrefix" value="${prefix}"/>
            <syswf:param name="importType" value="${importType}"/>
            <syswf:param name="inputWidth" value="${importType eq 'local' ? 600 : 584}"/>
        </syswf:component>

        <tr>
            <th>
                <label class="UI Label">${locationAfterUploadLabel}</label>
            </th>
            <td>
                <syswf:component name="/core/impl/imports/file/locationAfterUpload" prefix="locationAfterUpload">
                    <syswf:param name="importFileBean" value="${importFileBean}"/>
                    <syswf:param name="importType" value="${importType}"/>
                    <syswf:param name="locationsComboID" value="locationsCombo"/>
                    <syswf:param name="locationTextID" value="locationText"/>
                </syswf:component>
            </td>
        </tr>
    </tbody>
</table>

<c:if test="${importType eq 'local'}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.getCmp('${prefix}publishLocalFile_file').on('fileselected', function() { 
                Ext.get('${prefix}_locationAfterUploadlocationText').dom.value = "";
                ${prefix}forceLocationUpdate({ sourceFileName : Ext.get('${prefix}publishLocalFile_file').dom.value, isWindows: Ext.isWindows, isIE: (Ext.isIE || Ext.isChrome)});
            });
        });
    
//]]>
</script>
</c:if>

<c:if test="${importType eq 'remote'}">
    <script type="text/javascript">
//<![CDATA[

    	Ext.onReady(function() {
	        Ext.get('${prefix}publishRemoteFile_file').on('blur', function() {
                Ext.get('${prefix}_locationAfterUpload$locationsCombo').dom.value = "";
    	        ${prefix}forceLocationUpdate({ sourceUrl : Ext.get('${prefix}publishRemoteFile_file').dom.value });
        	});
       	});
    
//]]>
</script>
</c:if>
