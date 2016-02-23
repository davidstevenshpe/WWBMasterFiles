<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.documentation.documentationmessages" var="documentationmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>

<fmt:message var="addDocumentReferenceUrlLabel" key="addDocumentReferenceUrlLabel" bundle="${documentationmessages}"/>
<fmt:message var="addDocumentReferenceLinkTextLabel" key="addDocumentReferenceLinkTextLabel" bundle="${documentationmessages}"/>
<fmt:message var="typeComboHint" key="typeComboHint" bundle="${documentationmessages}"/>
<fmt:message var="optionalPropertyLabel" key="optionalPropertyLabel" bundle="${documentationmessages}"/>
<fmt:message var="typePropertyLabel" key="typePropertyLabel" bundle="${documentationmessages}"/>
<fmt:message var="advancedOptionsSectionLabel" key="advancedOptionsSectionLabel" bundle="${importsMessages}"/>
<fmt:message var="advancedOptionsToggleMessage" key="advancedOptionsToggleMessage" bundle="${importsMessages}"/>
<fmt:message var="keywordsPropertyLabel" key="keywordsPropertyLabel" bundle="${documentationmessages}"/>

<table class="UI Table Properties">
    <colgroup>
        <col class="MidLabelCol"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <th>
                <label for="${prefix}Url" class="UI Label">${addDocumentReferenceUrlLabel}</label>
            </th>
            <td>                        
                <syswf:input id="${prefix}Url" name="${prefix}Url" value="${holder}" property="documentUrl" />
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        var publishRemoteFile_file = new Ext.form.TextField({
                            id: '${prefix}Url',
                            applyTo: '${prefix}Url',
                            width: 600
                        });
                    });
                
//]]>
</script>
            </td>
        </tr>
		<tr>
            <th>
                <label class="UI Label">${typePropertyLabel}</label>
                <sup>${optionalPropertyLabel}</sup>
            </th>
            <td>
                <syswf:selectOne id="${prefix}uploadDocumentType" name="uploadDocumentType" mode="menu"
                    value="${holder}" property="documentType" optionValues="${holder.typeValues}" optionCaptions="${holder.typeCaptions}" />                         
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady( function() {
                        var cmb = new Ext.form.ComboBox( {
                            id :'${prefix}uploadDocumentType',
                            emptyText :'${typeComboHint}',
                            transform :'${prefix}uploadDocumentType',
                            disableKeyFilter :true,
                            mode :'local',
                            autoHeight :true,
                            resizable :true,
                            listWidth :590,
                            width : 590,
                            triggerAction :'all'
                        });
                    });
                
//]]>
</script>
            </td>
        </tr>                    
        <tr>
            <th>
                <label for="${prefix}LinkText" class="UI Label">${addDocumentReferenceLinkTextLabel}</label>
            </th>
            <td>                        
                <syswf:input id="${prefix}LinkText" name="${prefix}LinkText" value="${holder}" property="linkText" />
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        var publishRemoteFile_file = new Ext.form.TextField({
                            id: '${prefix}LinkText',
                            applyTo: '${prefix}LinkText',
                            width: 600
                        });
                    });
                
//]]>
</script>                
            </td>
        </tr>
    </tbody>
</table>

<syswf:wrap template="../sc-ui-ng/templates/advancedOptions.jsp">
    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol" />
            <col />
        </colgroup>
        <tbody>
        	<tr>
        		<th>
			        <label class="UI Label Inline" for="uploadDocumentKeywords">${keywordsPropertyLabel}</label>
			        <sup>${optionalPropertyLabel}</sup>
			    </th>
			    <td>
			        <syswf:component name="/core/search/keywordsSuggestedSearch" prefix="${prefix}keywordsSearch">
			            <syswf:param name="keywordsCustomizationId" value="shared.keywords.suggestedSearch"/>
			            <syswf:param name="keywordsValueHolder" value="${holder.searchExpressionWrapper}" />
			            <syswf:param name="keywordsShowHint" value="${true}" />
			        </syswf:component>
			    </td>
        	</tr>
    </table>
</syswf:wrap>

