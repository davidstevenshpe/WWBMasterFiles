<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.composite.compositeMessages" var="compositeMessages"/>

<fmt:message var="searchLabel" key="searchLabel" bundle="${compositeMessages}"/>
<fmt:message var="searchHint" key="searchHint" bundle="${compositeMessages}"/>
<fmt:message var="searchButtonCaption" key="searchButtonCaption" bundle="${compositeMessages}"/>
    <div class="flex-container">
        <syswf:block className="UI Block Common Middle">
            <div class="Content">
                <div class="CompositeBrowser">
                    <div class="TopBar">
                                                
                        <syswf:component name="/core/impl/composite/parentPath" prefix="parentPath">
                            <syswf:param name="compositeBrowser.parentPathArray" value="${this.parentPathArray}"/>
                            <syswf:param name="rootArtifactUuid" value="${this.rootArtifactUuid}"/>                                
                            <syswf:param name="sliceTime" value="${this.sliceTime}"/>                                
                            <syswf:param name="inverseTraversalRuleSet" value="${this.usedRuleSets.parentPathRuleSet}"/>                                
                            <syswf:param name="inverted" value="${this.usedRuleSets.inverted}"/>                                
                            <%-- display only the artifact name when in impact mode 
                            <c:if test="${this.usedRuleSets.treeRuleSet ne 'aggregation'}">
                                <syswf:param name="hideParentPath" value="${false}"/>    
                            </c:if>
                            --%>
                            <c:if test="${this.usedRuleSets.governanceTreeMode}">
                                <syswf:param name="governanceTreeMode" value="${true}"/>
                            </c:if>
                        </syswf:component>
                        
                        <!-- 
                        **** Align the Filter component horizontal with the show action message in Tree View tab,
                        **** Although it is not a best solution but at this time we temporary accept to use it
                        **** because if doesn't impact other features
                        -->
                        <br><br><br><br>
                        
                        <c:if test="${not this.usedRuleSets.governanceTreeMode}">
                            <div class="FilterByName">
                                <label for="treeview_filterbyname">${searchLabel}</label>
                                <syswf:input id="treeview_filterbyname" name="searchExpression" property="searchExpression" value="${this.searchExpressionWrapper}">
                                    <syswf:attribute name="type" value="text"/>
                                </syswf:input>
                                <syswf:control id="executeSearch" mode="anchor" action="treeDisplay$executeSearch" caption="${searchButtonCaption}" wrapper="span" affects="." loadingMask="true">
                                    <syswf:attribute name="class" value="Button"/>
                                </syswf:control>
                                
                                <syswf:control mode="script" affects="." caption="submitSearch" action="treeDisplay$executeSearch" loadingMask="true"/>
                                <script type="text/javascript">
//<![CDATA[

                                        var treeview_filterbyname = new Ext.form.TextField({
                                            applyTo: 'treeview_filterbyname',
                                            width: 130,
                                            listeners: {
                                                specialkey: function(tf, e) {
                                                    if (e.getKey() == Ext.EventObject.ENTER) {
                                                        submitSearch();
                                                    }
                                                }
                                            },
                                            emptyText: '${searchHint}'
                                        });
                                    
//]]>
</script>
                                </div>
                            </c:if>

                        <div class="x-clear"></div>

                    </div>

                    <hr/>
                   
                    <c:choose>
                        <c:when test="${not this.usedRuleSets.governanceTreeMode}">
                            <syswf:component name="/core/composite/compositeTreeDisplay" prefix="treeDisplay">
                                <syswf:param name="paramDecorator" value="${linkDecorator}"/>
                                <syswf:param name="rootArtifactUuid" value="${this.rootArtifactUuid}"/>
                                <syswf:param name="sliceTime" value="${this.sliceTime}"/>
                                <syswf:param name="traversalRuleSet" value="${this.usedRuleSets.treeRuleSet}"/>
                                <syswf:param name="initialExpansionDepth" value="${this.initialExpansionDepth}"/>
                                <syswf:param name="removeDuplicateSubTrees" value="${this.removeDuplicateSubTrees}"/>
                                <syswf:param name="searchExpressionWrapper" value="${this.searchExpressionWrapper}"/>
                            </syswf:component>
                        </c:when>
                        <c:otherwise>
                            <syswf:component name="/core/composite/governanceTreeDisplay" prefix="governanceTreeDisplay">
                                <syswf:param name="paramDecorator" value="${linkDecorator}"/>
                                <syswf:param name="rootArtifactUuid" value="${this.rootArtifactUuid}"/>
                                <syswf:param name="sliceTime" value="${this.sliceTime}"/>
                                <syswf:param name="traversalRuleSet" value="governance"/>
                                <syswf:param name="initialExpansionDepth" value="${this.initialExpansionDepth}"/>
                                <syswf:param name="removeDuplicateSubTrees" value="${this.removeDuplicateSubTrees}"/>
                                <syswf:param name="searchExpressionWrapper" value="${this.searchExpressionWrapper}"/>                                    
                            </syswf:component>
                        </c:otherwise>                         
                    </c:choose>

                </div>
            </div>
        </syswf:block>
    <div class="UI Right">
        <c:if test="${not artifactDeleted}">
        <syswf:block className="UI Block TreeView">
            <syswf:component name="/core/impl/composite/ruleSetSwitcher" prefix="ruleSetSwitcher">
                <syswf:param name="usedRuleSets" value="${this.usedRuleSets}"/>
                <syswf:param name="artifact" value="${artifact}"/>
            </syswf:component>
            <div class="EA-right-panel">
             <syswf:control id="navigator" caption="Navigator" mode="anchor" targetTask="/common/navigator">
                 <syswf:param name="uuid" value="${artifact._uuid}"/>
                 <syswf:attribute name="class" value="UI PageAction Navigator"/>
             </syswf:control>
            </div>
        </syswf:block>
        </c:if>
    </div>
</div>