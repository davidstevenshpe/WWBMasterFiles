<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="componentsmessages"/>

<fmt:message bundle="${relationshipmessages}" key="Target" var="targetLabel" />
<fmt:message bundle="${relationshipmessages}" key="Relationship" var="relationshipLabel" />
<fmt:message bundle="${componentsmessages}" key="Change" var="changeLabel" />

<c:choose>
    <c:when test="${holder.selectedTab == 0}">
    
        <c:if test="${not empty errorLabel}">
            <div class="UI SystemMessage Error">
                <div class="MessageContainer">
                    <div class="Text"><strong>${errorLabel}:</strong> ${errorBody}</div>
                    <div class="x-clear"></div>
                </div>
            </div>
        </c:if>
    
        <syswf:component name="/core/impl/relations/addRelationWindow" prefix="addRelation" ajax="true">
            <syswf:param name="addMode" value="search"/>
            <syswf:param name="relation" value="${relation}"/>
            <syswf:param name="useType" value="${useType}"/>
            <syswf:param name="selectionBag" value="${holder.selectionBag}"/>
            <syswf:param name="resultTableId" value="${prefix}Table"/>
            <syswf:param name="popupWindowId" value="${modalWinId}"/>
        </syswf:component>
        
         <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.getCmp('${selectButtonId}').setDisabled(false);
                Ext.getCmp('${selectButtonId}').show();
            	Ext.getCmp('${addButtonId}').hide();
            });
        
//]]>
</script>
        
    </c:when>
    
    
    <c:when test="${holder.selectedTab == 1}">
        <table class="UI Table Properties">
            <colgroup>
                <col class="LabelCol"/>
                <col/>
            </colgroup>
            <tr>
                <td>
                    <c:set var="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${holdersItem.value[0].sdmName}&amp;format=small)"/>
                    <label class="UI Label Inline" for="">${targetLabel}:</label>
                </td>
                <td>
                	<c:forEach var="artifact" items="${holder.artifacts}" varStatus="status">
                		<c:choose>
                			<c:when test="${status.index < 3}">
			                     <c:set var="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=${artifact._artifactSdmName}&amp;format=small)"/>
			                     <label class="UI Icon"  style="${style}">
			                         <syswf:component prefix="more${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
			                            <syswf:param name="uuid" value="${artifact._uuid}"/>
			                            <syswf:param name="caption" value="${artifact.name}"/>
			                            <syswf:param name="sdmName" value="${artifact._artifactSdmName}"/>
			                        </syswf:component>
			                    </label>
			                    <br/>
			                 </c:when>
			                 <c:when test="${status.index == 3}">
			                 	...<br/>
			                 </c:when>
			              </c:choose>
	                </c:forEach>
                    (<a id="${prefix}Change" href="javascript:void(0);">${changeLabel}</a>)
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            Ext.get('${prefix}Change').on('click', function() {
                                ${prefix}Tab0();
                            });
                        });
                    
//]]>
</script>
                </td>
                <td>
            </tr>
            <tr>
                <td>
                    <label class="UI Label Inline" for="">${relationshipLabel}:</label>
                </td>
                <td>
                    <syswf:selectOne name="${prefix}Combo" displayAsRow="true" mode="menu" 
                        value="${holder}" optionValues="${availableTypes}" optionCaptions="${availableTypesCaptions}" property="type"
                        id="${prefix}Combo" />
                    
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                            var search_artifact_type = new Ext.HP.ComboBox({
                                id: '${prefix}Combo',
                                transform: '${prefix}Combo',
                                forceSelection: true,
                                typeAhead: false,
                                disableKeyFilter: false,
                                editable: true,
                                width: 200
                            });
                        });
                    
//]]>
</script>
                </td>
                <td>
            </tr>
        </table>
        
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
            	Ext.getCmp('${selectButtonId}').hide();
            	Ext.getCmp('${addButtonId}').setDisabled(false);
            	Ext.getCmp('${addButtonId}').show();
            });
        
//]]>
</script>
    </c:when>
</c:choose>

<script type="text/javascript">
//<![CDATA[


        var ${selectAction} = function() {
            Ext.getCmp('${selectButtonId}').setDisabled(true);
            ${prefix}Select();
        }

        var ${prefix}Tab0 = function() {
            Ext.getCmp('${addButtonId}').setDisabled(true);
            ${prefix}GoToTab0();
        }

//]]>
</script>

<syswf:control mode="script" caption="${prefix}Select" action="select" affects="."/>

<syswf:control mode="script" caption="${cancelAction}" action="cancel" affects="."/>

<syswf:control mode="script" caption="${prefix}GoToTab0" action="goToTab0" affects="."/>

