<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="lifecycleCategories" type="java.util.List"--%>

<c:if test="${not edit}">
<script>
//<![CDATA[
 Ext.get('${prefix}undeplEnvId').dom.value='';
 Ext.get('${prefix}deplEnvId').dom.value='';

//]]>
</script>
</c:if>


<div style="display:none">
<div id="tab2">

    <br/>
    <div style="margin:0 5px 0 5px">You can specify an additional filter for the devices affected by this action. Specify subset of the devices where the proxy will be deployed using a regexp for the device name:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                    <label class="UI Label Inline">Deploy To Device(s):</label>
                </th>
                <td>
                    <syswf:input id="${prefix}_deplId" name="${prefix}_deployTo" value="${createProxyBean}" property="deployToRegExp"/>
                </td>
            </tr>
        </tbody>
    </table>

    <br/>
    <div style="margin:0 5px 0 5px">You can filter list of devices where the device should not be deployed to anymore using a regexp expression:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                    <label class="UI Label Inline">Undeploy From Device(s):</label>
                </th>
                <td>
                    <syswf:input id="${prefix}_undeplId" name="${prefix}_undeployFrom" value="${createProxyBean}" property="undeployFromRegExp"/>
                </td>
            </tr>
        </tbody>
    </table>
<div style="height:12px">&nbsp;</div>
</div>
<div id='tab1'>
    <br/>
    <div style="margin:0 5px 0 5px">This action is used to deploy/undeploy a contract. Deploy action also updates an existing proxy if available.</div>
    <br/>
    <div style="margin:0 5px 0 5px">Select the target environment(s) of the newly created proxy/proxies for the endpoints referenced by the governed artifact:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                    <label class="UI Label Inline">Deploy to environment(s):</label>
                </th>
                <td>
                    <div id="deployTo"/>
                    <script>
                    //<![CDATA[
                          var envs = new Ext.form.CheckboxGroup({
                              renderTo:'deployTo',
                              xtype: 'checkboxgroup',
                              fieldLabel: 'Deploy to Environments:',
                              columns: 1,
                              items: [
                                  <c:forEach varStatus="status" var="env" items="${environmentCategories}">
                                        {boxLabel: '${env.name}', name: '${env.val}',  checked : ${createProxyBean.deployToEnvironmentsMap[env.val]==true}  }<c:if test="${not status.last}">,</c:if>
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
    <div style="margin:0 5px 0 5px">Select the environment(s) where proxies of endpoints referenced by the governed artifact should be destroyed:</div>
    <br/>

    <table class="UI Table Properties">
        <colgroup>
            <col class="MidLabelCol"/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th class="first">
                    <label class="UI Label Inline">Undeploy from:</label>
                </th>
                <td>
                    <div id="undeployFrom"/>
                    <script>
                    //<![CDATA[
                          var envs = new Ext.form.CheckboxGroup({
                              renderTo:'undeployFrom',
                              xtype: 'checkboxgroup',
                              fieldLabel: 'Deploy to Environments:',
                              columns: 1,
                              items: [
                                  <c:forEach varStatus="status" var="env" items="${environmentCategories}">
                                        {boxLabel: '${env.name}', name: '${env.val}',  checked : ${createProxyBean.undeployFromEnvironmentsMap[env.val]==true}  }<c:if test="${not status.last}">,</c:if>
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
                            Ext.get('${prefix}undeplEnvId').dom.value=result;
                          });
                    
//]]>
</script>
                </td>
            </tr>
        </tbody>
    </table>
    <div style="height:12px">&nbsp;</div>
</div>
</div>

<div style="display:none">
  <syswf:input id="${prefix}deplEnvId" name="${prefix}_deployToEnv" value="${createProxyBean}" property="deployToEnvironments" mode="hiddden"/>
  <syswf:input id="${prefix}undeplEnvId" name="${prefix}_undeployToEnv" value="${createProxyBean}" property="undeployFromEnvironments" mode="hiddden"/>
</div>

<div id='my-tabs'/>
<%-- IE7 workaroud first tab is improperly sized--%>
<div id='ie7'/>

<script>
//<![CDATA[
  var tabs = new Ext.TabPanel({
      renderTo: 'my-tabs',
      activeTab: 0,
      items:[
          {contentEl:'ie7', title:''},
          {contentEl:'tab1', title:'General'},
          {contentEl:'tab2', title:'Advanced'}
      ]
  });
  tabs.remove(0);
  tabs.doLayout();

//]]>
</script>


<syswf:control mode="script" caption="createProxyPost" action="save" loadingMask="true"/>
<script type="text/javascript">
//<![CDATA[

    function customAutomaticActionFn() {
        createProxyPost();
        reloadAASection();
    }

//]]>
</script>
