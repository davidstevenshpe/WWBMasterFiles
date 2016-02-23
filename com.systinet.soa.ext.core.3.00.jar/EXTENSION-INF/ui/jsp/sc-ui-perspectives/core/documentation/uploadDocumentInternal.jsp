<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.documentation.documentationmessages" var="documentationmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message var="filePropertyLabel" key="filePropertyLabel" bundle="${documentationmessages}"/>
<fmt:message var="typePropertyLabel" key="typePropertyLabel" bundle="${documentationmessages}"/>
<fmt:message var="keywordsPropertyLabel" key="keywordsPropertyLabel" bundle="${documentationmessages}"/>
<fmt:message var="typeComboHint" key="typeComboHint" bundle="${documentationmessages}"/>
<fmt:message var="typePropertySubText" key="typePropertySubText" bundle="${documentationmessages}"/>
<fmt:message var="optionalPropertyLabel" key="optionalPropertyLabel" bundle="${documentationmessages}"/>
<fmt:message var="sourceLabel" key="sourceLabel" bundle="${documentationmessages}"/>


<syswf:control mode="ajax" id="${prefix}Change" action="tabChange" caption="${prefix}Change"/>

<c:set var="beforeLocationContent">
    <tr>
        <th>
            <label for="${prefix}ChangeTab" class="UI Label">${sourceLabel}</label>
        </th>
        <td>                        
            <syswf:selectOne id="${prefix}ChangeTab" name="${prefix}ChangeTab" value="${tabHolder}" property="selectedTab" mode="radio" optionValues="${sourceValues}" optionCaptions="${sourceCaptions}"  displayAsRow="true">
                <syswf:attribute name="onClick">
                    ${prefix}Change();
                </syswf:attribute>
            </syswf:selectOne>
        </td>
    </tr>
</c:set>

<c:set var="afterLocationContent">
    <tr>
        <th>
            <label class="UI Label">${typePropertyLabel}</label>
            <sup>${optionalPropertyLabel}</sup>
        </th>
        <td>
            <syswf:selectOne id="${prefix}uploadDocumentType" name="uploadDocumentType" mode="menu"
                value="${documentBean}" property="documentType" optionValues="${typeValues}" optionCaptions="${typeCaptions}" />                         
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
                        listWidth :600,
                        width :600,
                        triggerAction :'all'
                    });
                });
            
//]]>
</script>
        </td>
    </tr>
</c:set>

<syswf:component name="/core/impl/imports/file/locationOptions" prefix="localOptions">
    <syswf:param name="importFileBean" value="${documentBean}"/>
    <syswf:param name="importType" value="${tabHolder.selectedTab}"/>
    <syswf:param name="beforeLocationContent" value="${beforeLocationContent}"/>
    <syswf:param name="afterLocationContent" value="${afterLocationContent}"/>
</syswf:component>

<c:set var="beforeContent">
    <th>
        <label class="UI Label Inline" for="uploadDocumentKeywords">${keywordsPropertyLabel}</label>
        <sup>${optionalPropertyLabel}</sup>
    </th>
    <td>
        <syswf:component name="/core/search/keywordsSuggestedSearch" prefix="${prefix}keywordsSearch">
            <syswf:param name="keywordsCustomizationId" value="shared.keywords.suggestedSearch"/>
            <syswf:param name="keywordsValueHolder" value="${documentBean.searchExpressionWrapper}" />
            <syswf:param name="keywordsShowHint" value="${true}" />
        </syswf:component>
    </td>
</c:set>


<syswf:component name="/core/impl/imports/file/advancedOptions" prefix="advancedOptionsRemote">
    <syswf:param name="importFileBean" value="${documentBean}"/>
    <syswf:param name="importType" value="${tabHolder.selectedTab}"/>
    <syswf:param name="hideOverwriteLocalChanges" value="${true}"/>
    <syswf:param name="hideProcessArchive" value="${true}"/>
    <syswf:param name="beforeContent" value="${beforeContent}"/>
</syswf:component>

