<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="aasBean" type="java.util.List<com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean>"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="OK" var="OK" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

<syswf:block className="UI Block Plain">
    <div class="Title"><h4><span><fmt:message key="automaticActionsSection.title" bundle="${bundle}"/></span></h4></div>
    <div class="Content">
    <div class="Offset">
    <syswf:input id="automaticActionId" name="automaticActionId" value="" mode="hidden"/>

    <%-- Call refreshAASection() to reload AA section. --%>
    <syswf:control mode="script" caption="reloadAASection" action="reloadAASection" loadingMask="true"/>

    <%-- Call editAutomaticActionPost(); function from action editor OK button. --%>
    <syswf:control mode="script" caption="editAutomaticActionPost" action="editAutomaticAction" loadingMask="true"/>
    <script type="text/javascript">
        //<![CDATA[

        function editAutomaticAction(actionId){
            Ext.get('automaticActionId').dom.value = actionId;
            editAutomaticActionPost();
        }
        //]]>
    </script>

    <%-- Call editAutomaticActionWithRedirectPost(); function from action editor OK button. --%>
    <syswf:control mode="script" caption="editAutomaticActionWithRedirectPost" action="editAutomaticActionWithRedirect" loadingMask="true"/>
    <script type="text/javascript">
        //<![CDATA[
        function editAutomaticActionWithRedirect(actionId){
            Ext.get('automaticActionId').dom.value = actionId;
            editAutomaticActionWithRedirectPost();
        }
        //]]>
    </script>

    <c:if test="${not empty aasBean and not empty aasBean.automaticActions}">
        <syswf:control mode="script" caption="deleteAutomaticActionPost" action="deleteAutomaticAction" affects="." loadingMask="true"/>
        <script type="text/javascript">
            //<![CDATA[
            function deleteAutomaticAction(actionId){
                Ext.get('automaticActionId').dom.value = actionId;
                deleteAutomaticActionPost();
            }
            //]]>
        </script>

        <c:forEach items="${aasBean.automaticActions}" var="action">
            <%--@elvariable id="action" type="com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean.ConfigData"--%>
            <c:if test="${not empty action.rowRenderer and action.showInUi}">
                <syswf:component prefix="automaticActionRenderer_${action.id}" name="${action.rowRenderer}">
                    <syswf:param name="configData" value="${action}"/>
                    <syswf:param name="metadata" value="${action.metadata}"/>
                    <syswf:param name="automaticActionsBean" value="${aasBean}"/>
                </syswf:component>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${not empty aasBean and not empty aasBean.availableActions}">
        <syswf:control mode="script" caption="addAutomaticActionPost" action="addAutomaticAction" affects="." loadingMask="true"/>

        <c:forEach items="${aasBean.availableActions}" var="action" varStatus="status">
            <%--@elvariable id="action" type="com.hp.systinet.platform.lifecycle.automaticaction.AutomaticActionMetadata"--%>
            <c:set var="showInPopup" value="${aasBean.showInPopupMap[action.id]}"/>

            <c:if test="${not empty action.editRendered and showInPopup}">
                <syswf:component name="/core/window" prefix="aasAddPopup_${status.index}">
                    <syswf:param name="winId" value="aaction_${status.index}_Popup_win" />
                    <syswf:param name="winTitle"><fmt:message key="automaticActionSection.label" bundle="${bundle}"/></syswf:param>
                    <syswf:param name="winComponent" value="${action.editRendered}"/>
                    <syswf:param name="winOpenFunctionName" value="EditAaction_${status.index}_open" />
                    <syswf:param name="winOkAction" value="customAutomaticActionFn" />
                    <syswf:param name="metadata" value="${action}"/>
                    <syswf:param name="aasBean" value="${aasBean}"/>
                    <syswf:param name="winRenderAlways" value="true" />
                    <c:if test="${not empty action.windowWrapperClass}">
                       <syswf:param name="winWrapperClass" value="${action.windowWrapperClass}" />
                    </c:if>
                </syswf:component>
            </c:if>
        </c:forEach>

        <div id="btn_addcriteria_ct" class="MenuButton"/>
        <script type="text/javascript">
            //<![CDATA[

            function addAutomaticAction(actionId){
                Ext.get('automaticActionId').dom.value = actionId;
                addAutomaticActionPost();
            }
            
            Ext.layout.HPMenuLayout = Ext.extend(Ext.layout.MenuLayout, { monitorResize: true, type: "hplayoutmenu",
    			doAutoSize: function () {
    				// do nothing
    			}
   			});
   			Ext.Container.LAYOUTS.hplayoutmenu = Ext.layout.HPMenuLayout;

   			Ext.menu.HPMenu = Ext.extend(Ext.menu.Menu, {layout: 'hplayoutmenu'});
   			Ext.reg("hpmenu", Ext.menu.HPMenu);

   			Ext.HPButton = Ext.extend(Ext.Button, {
   				 initComponent: function () {
   					if (this.menu) {
   						if (Ext.isArray(this.menu)) {
   							this.menu = { items: this.menu }
   						} 
   						this.menu = Ext.create(this.menu, "hpmenu");
   					}
   					Ext.HPButton.superclass.initComponent.call(this);		
   				}
   			 });
   			 Ext.reg("hpbutton", Ext.HPButton);
            
            new Ext.HPButton({
                renderTo: 'btn_addcriteria_ct',
                arrowAlign: 'right',
                menu: [
                    <c:forEach items="${aasBean.availableActions}" var="action" varStatus="status">
                        <c:set var="showInPopup" value="${aasBean.showInPopupMap[action.id]}"/>
                        {
                        text: '${action.name}',
                        iconCls: 'hp-add-criteria-item',
                        handler: function() {
                            <c:if test="${not empty action.editRendered}">
                                <c:if test="${showInPopup}">
                                    EditAaction_${status.index}_open();
                                </c:if>
                                <c:if test="${not showInPopup}">
                                    editAutomaticActionWithRedirect('${action.id}');
                                </c:if>
                            </c:if>
                            <c:if test="${empty action.editRendered}">
                                addAutomaticAction('${action.id}');
                            </c:if>
                        }
                        }<c:if test="${not status.last}">,</c:if>
                    </c:forEach>
                      ],
                split: true,
                text: '<fmt:message key="automaticActionsSection.addAction" bundle="${bundle}"/>'
            });
            //]]>
        </script>
    </c:if>
    </div>
    </div>
</syswf:block>