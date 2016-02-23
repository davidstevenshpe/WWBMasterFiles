<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="lifecycleCategories" type="java.util.List"--%>

<c:if test="${not edit}">
<script>
//<![CDATA[
 Ext.get('${prefix}deplEnvId').dom.value='';

//]]>
</script>
</c:if>

<div id="tab4" class="x-hide-display">
   <br/>
    <div style="margin:0 5px 0 5px">You can specify an additional filter for the devices affected by this action. Specify subset of devices using a regexp for the device name:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                    <label class="UI Label Inline">Affected Device(s):</label>
                </th>
                <td>
                    <syswf:input id="${prefix}_deplId" name="${prefix}_deployTo" value="${updateProxiesBean}" property="deployToRegExp"/>
                </td>
            </tr>
        </tbody>
    </table>

    <br/>
    <div style="height:12px">&nbsp;</div>
</div>
<div id='tab3' class="x-hide-display">
    <br/>
    <div style="margin:0 5px 0 5px">This action rebuilds PEP proxies for contracts of the approved service (contract provider).</div>
    <br/>
    <div style="margin:0 5px 0 5px">Select the environment(s) where proxy/proxies of contracts of the governed artifact will be recreated:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                    <label class="UI Label Inline">Affected environment(s):</label>
                </th>
                <td>
                    <div id="deployTo${prefix}"/>
                    <script>
                    //<![CDATA[
                          var envs = new Ext.form.CheckboxGroup({
                              renderTo:'deployTo${prefix}',
                              xtype: 'checkboxgroup',
                              fieldLabel: 'Deploy to Environments:',
                              columns: 1,
                              items: [
                                  <c:forEach varStatus="status" var="env" items="${environmentCategories}">
                                        {boxLabel: '${env.name}', name: '${env.val}',  checked : ${updateProxiesBean.deployToEnvironmentsMap[env.val]==true}  }<c:if test="${not status.last}">,</c:if>
                                  </c:forEach>
                              ]
                          });
                          envs.on('change',function(group,checked) {
                            var result='';
                            for(i=0;i<checked.length;i++)
                            {
                               result+=checked[i].getName();
                               if (i+1!=checked.length) result+=',';
                            }
                            Ext.get('${prefix}deplEnvId').dom.value=result;
                          });
                    
//]]>
</script>
                </td>
            </tr>
        </tbody>
    </table>
    <br/>
    <div style="margin:0 5px 0 5px">Check the following to create proxies for contracts that haven't been deployed previously or leave unchecked if you want just an update of existing proxy configuration:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                </th>
                <td>
                    <syswf:selectOne name="relatedDataResolverCheckboxes" value="${updateProxiesBean}" optionValues="true" dataType="boolean" optionCaptions=" "property="deployPreviouslyUndeployed"
                      displayAsRow="true" mode="checkbox" id="id_relatedDataResolverCheckboxes"/>
                    Deploy previously not deployed
                </td>
            </tr>
        </tbody>
    </table>
    <br/>

</div>



<div style="display:none">
  <syswf:input id="${prefix}deplEnvId" name="${prefix}_deployToEnv" value="${updateProxiesBean}" property="deployToEnvironments" mode="hiddden"/>
</div>

<div id='my-tabs-2'/>

<%-- IE7 workaroud first tab is improperly sized--%>
<div id='ie7'/>

<script>
//<![CDATA[
  var tabs = new Ext.TabPanel({
      renderTo: 'my-tabs-2',
      activeTab: 0,
      items:[
          {contentEl:'ie7', title:''},
          {contentEl:'tab3', title:'General'},
          {contentEl:'tab4', title:'Advanced'}
      ]
  });
  tabs.remove(0);
  tabs.doLayout();

//]]>
</script>


<syswf:control mode="script" caption="updateProxyPost" action="save" loadingMask="true"/>
<script type="text/javascript">
//<![CDATA[

    function customAutomaticActionFn() {
        updateProxyPost();
        reloadAASection();
    }

//]]>
</script>