<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="lifecycleCategories" type="java.util.List"--%>
<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="applyWhen.label" var="applyWhenLabel" bundle="${messages}" />

<c:if test="${not edit}">
<script>
//<![CDATA[
 Ext.get('preExecutionCode').dom.value='';
 //]]>
</script>
</c:if>

<div id='tab5' class="x-hide-display">
<div style="margin:5px">This automatic action is used to invoke a custom javascript code previously defined using Administration/Customization/Manage scripts. <br/>
   In the advanced tab you can define a javascript fragment which is executed prior running the referenced script artifact.
  </div>
<table class="UI Table Properties">
    <colgroup>
        <col class="MidLabelCol"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <th class="first">
                <label class="UI Label Inline">${applyWhenLabel}:</label>
            </th>
            <td>

                <syswf:selectOne id="${prefix}_applyWhenId" name="${prefix}_executeScript_actionEvent" value="${scriptExecutionBean}" property="selectedEvent" mode="menu"
                                   optionValues="${scriptExecutionBean.events}" dataType="enum"
                                   optionCaptions="${scriptExecutionBean.eventLabels}"/>
                <script type="text/javascript">
                    //<![CDATA[

                    Ext.onReady(function() {
                        var var_${prefix}_eventId = new Ext.HP.ComboBox({
                            id: '${prefix}_applyWhenId',
                            transform: '${prefix}_applyWhenId',
                            forceSelection: true,
                            typeAhead: true,
                            disableKeyFilter: false,
                            editable: false,
                            listWidth : 300,
                            width : 300
                        });
                     });
                     //]]>
                </script>
             </td>
        </tr>
        <tr>
            <th class="first">
                <label class="UI Label Inline">Script:</label>
            </th>
            <td>
                <div id="scriptLocation"/>
                <syswf:input id="scriptUUIDField" name="scriptUUIDField" mode="hidden" property="scriptUuid" value="${scriptExecutionBean}"/>
                <script>
                    //<![CDATA[
                    Ext.onReady(function() {
                    var ScriptInstance = Ext.data.Record.create([
                              {
                                name: 'uuid',
                                type: 'string'
                              },
                              {
                                name: 'name',
                                type: 'string'
                              },
                              {
                                name: 'description',
                                type: 'string'
                              }
                    ]);

                    var scriptStore = new Ext.data.Store({
                      reader: new Ext.data.JsonReader({fields: ScriptInstance,  root: 'records'  }),
                      url: SERVER_URI+'/../../query',
                      baseParams : { dql : '<query>select d._uuid as uuid,d.name as name,d.description as description from r_scriptArtifact d where d.r_scriptExecuteOn.val=\'lifecycle\'</query>' },
                      sortInfo: {field: 'name', direction: 'ASC'}
                    });

                    var scriptTpl = new Ext.XTemplate(
                      '<tpl for="."><div class="search-item">',
                          '<h3><span>{method}</span> {name}</h3>',
                          '{description}',
                      '</div></tpl>'
                    );

                    var ScriptCombo=new Ext.form.ComboBox({
                                name: 'script',
                                renderTo: 'scriptLocation',
                                store: scriptStore,
                                width : 300,
                                fieldLabel: 'Script name',
                                displayField:'name',
                                valueField:'uuid',
                                hiddenName:'scriptUUID',
                                forceSelection:true,
                                editable:false,
                                triggerAction:'all',
                                listeners: {
                                    beforequery: function(qe){ qe.forceAll=true; },
                                    select: function(combo,value) { Ext.get('scriptUUIDField').dom.value=value.data.uuid;}
                                },
                                minChars:0,
                                typeAhead: false,
                                loadingText: 'Searching...',
                                pageSize:10,
                                tpl:scriptTpl,
                                itemSelector: 'div.search-item'
                    });
                    scriptStore.on('load',function() {<c:if test="${not empty scriptExecutionBean.scriptUuid}">ScriptCombo.setValue('${scriptExecutionBean.scriptUuid}');</c:if>});
                    });
                    //]]>
                </script>
            </td>
        </tr>
    </tbody>
</table>
<br/>
</div>

<div id='tab6' class="x-hide-display">
                <syswf:textArea id="preExecutionCode" name="preExecutionCode" value="${scriptExecutionBean}" property="environmentSetup"/>
                <script>
                    //<![CDATA[

                    var editorContent = new Ext.form.TextArea(
                        {
                            autoShow: true,
                            applyTo: 'preExecutionCode',
                            width: 475,
                            height: 300
                        }
                    );

                    //]]>
                </script>
</div>

<div id='my-tabs-3'></div>

<%-- IE7 workaroud first tab is improperly sized--%>
<div id='ie7'></div>

<script>
    //<![CDATA[
  var tabs = new Ext.TabPanel({
      renderTo: 'my-tabs-3',
      activeTab: 0,
      items:[
          {contentEl:'ie7', title:''},
          {contentEl:'tab5', title:'General'},
          {contentEl:'tab6', title:'Advanced'}
      ]
  });
  tabs.remove(0);
  tabs.doLayout();
  //]]>
</script>


<syswf:control mode="script" caption="executeScriptPost" action="save" loadingMask="true"/>
<script type="text/javascript">
    //<![CDATA[
    function customAutomaticActionFn() {
        executeScriptPost();
        reloadAASection();
    }
    //]]>
</script>