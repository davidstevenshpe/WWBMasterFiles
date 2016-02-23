<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<syswf:control mode="script" caption="setProcessRefreshPopup" action="change" affects="." />

<c:set var="onChangeAction">Ext.getCmp('bulkSetGovernanceProcess_okButton').enable(); setProcessRefreshPopup();</c:set>

<div class="Content" id="setProcessContent">
<table class="UI Table Properties">
  <col class="LabelCol" />   
  <col />   
  <tbody>
    <tr>
        <td>
            <label class="UI Label Inline"><fmt:message bundle="${messages}" key="bulk.setGovernanceProcess.process" />:</label> 
        </td>
        <td>
			<span class="IconAlign">
	            <syswf:component name="/newUi/lc/common/widget/chooseGPCombo" prefix="${prefix}processCombo">                
	                <syswf:param name="selectedProcessId" value="${selectorBean}" property="selectedProcessId" />
	                <syswf:param name="onChangeAction" value="${onChangeAction}" />
	            </syswf:component>
			</span>
        </td>    
    </tr>
    <c:if test="${this.admin and not empty processes}">
        <tr>
            <td>
                <label class="UI Label Inline"><fmt:message bundle="${messages}" key="bulk.setGovernanceProcess.stage" />:</label> 
            </td>
            <td>
                <span class="IconAlign">
                    <syswf:selectOne mode="menu" value="${selectorBean}" property="stageName" optionValues="${selectorBean.stages}" name="stage" />
                    
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function(){
                            var cmb = new Ext.form.ComboBox({
                            id : 'stage',
                            editable : false,
                            transform : '${prefix}_stage',
                            listWidth : 250,
                            width : 250,        
                            disableKeyFilter : true,
                            mode : 'local',
                            autoHeight : true,
                            resizable : true,
                            triggerAction : 'all'
                          });
                        });
                
                    
//]]>
</script>
                               
                </span>
            </td>    
        </tr>    
        <tr>
            <td>
                <label class="UI Label Inline" for="${prefix}approved_0"><fmt:message bundle="${messages}" 
                  key="bulk.setGovernanceProcess.approved" />:</label>
            </td>
            <td>
                <span class="IconAlign">
                    <syswf:selectOne id="${prefix}approved" name="approved" selectClass="UI Form Checkbox Inline" value="${selectorBean}" 
                     property="approved" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " displayAsRow="true" />            
                </span>
            </td>    
        </tr>
    </c:if>
  </tbody>        
</table>
</div>

<c:if test="${not empty processes}">
<div class="UI AdvancedOptions Labeled Closed">
    <div class="OptionsOpener">
        <a href="javascript:void(0);" id="${prefix}opener">
        <span>
            <fmt:message bundle="${messages}" key="bulk.setGovernanceProcess.advancedOptions" />
        </span></a>
    </div>
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        attachOn('${prefix}opener','click',function() {
            AdvancedOptions.Switch(Ext.get('${prefix}opener').dom);
        });
    });
    
//]]>
</script>
    <div class="Content">
        <syswf:selectOne id="${prefix}ignoreGovernedArtifacts" name="ignoreGovernedArtifacts" selectClass="UI Form Checkbox Inline" 
            value="${selectorBean}" property="ignoreGovernedArtifacts" mode="checkbox" optionValues="true" dataType="boolean" optionCaptions=" " 
            displayAsRow="true" />
        <label class="UI Label Inline" for="${prefix}ignoreGovernedArtifacts_0"><fmt:message bundle="${messages}" 
            key="bulk.setGovernanceProcess.ignoreGovernedArtifacts" /></label>
    </div>
</div>
</c:if>