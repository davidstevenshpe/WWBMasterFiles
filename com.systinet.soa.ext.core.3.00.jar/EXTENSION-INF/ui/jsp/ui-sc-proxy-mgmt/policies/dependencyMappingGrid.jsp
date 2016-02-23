<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var="unresolvedCount" value="${this.grid.unresolvedDependenciesCount}"/>

<c:if test="${not empty this.grid.mappings}">
  <c:choose>
    <c:when test="${unresolvedCount>0}">
      <span>
        <a onclick="openEditor()" style="color:red" href="#">${unresolvedCount} unresolved policy <c:choose><c:when test="${unresolvedCount>1}">dependencies</c:when><c:otherwise>dependency</c:otherwise></c:choose> found. Resolve..</a>
      </span>
    </c:when>
    <c:otherwise>
      <span>
        <a onclick="openEditor()" style="color:green" href="#">Alter dependency mapping..</a>
      </span>
    </c:otherwise>
  </c:choose>
</c:if>

<div style="display:none">
  <div id="editorContainer">
<%--
  <div padding:10px>Here you can define how individual dependencies will be resolved when deployed in different environments. For example a authentication may depend on a different userstore etc.
--%>
  <table border=1 width="100%" height="100%" class="PolicyDepEditorTable">
    <tr>
      <th style="background:#EBF3FD"><div class="PolicyDepEditorHeader">Dependency Name</div></th>
      <th style="background:#EBF3FD" width="220px"><div class="PolicyDepEditorHeader">Dependency Type</div></th>

      <c:forEach var="env" items="${this.grid.environments}">
        <th style="background:#EBF3FD"><div class="PolicyDepEditorHeader">${env.name}</div></th>
      </c:forEach>
    </tr>

    <script>
    //<![CDATA[
      prefilledValues=new Object();
    
//]]>
</script>

    <c:forEach var="mapping" items="${this.grid.mappings}">
      <tr>
        <td><div class="PolicyDepEditorCell Name">
          <c:choose>
             <c:when test="${not empty mapping.dependency.name}">${mapping.dependency.name}</c:when>
             <c:otherwise><div style="color:gray">${mapping.dependency.ID}</c:otherwise>
          </c:choose>
        </div></td>
        <td><div class="PolicyDepEditorCell TypeName">${mapping.dependency.typeName}</div></td>

        <c:forEach var="env" items="${this.grid.environments}">
          <td width="160px" onclick="openCellCombo(this,'${mapping.dependency.ID}','${mapping.dependency.typeID}','${env.val}');">
             <div>
                <c:choose>
                  <c:when test="${empty mapping.mapping[env.val].name}">
                    <c:choose>
                      <c:when test="${mapping.dependency.automaticallyResolvable}">
                         <div class="PolicyDepEditorCell Environment" style="color:gray">${mapping.dependency.name}</div>
                      </c:when>
                      <c:otherwise>
                         <div class="PolicyDepEditorCell Environment" style="color:red">N/A</div>
                      </c:otherwise>
                    </c:choose>
                  </c:when>
                  <c:otherwise>
                    <div class="PolicyDepEditorCell Environment" style="color:green">${mapping.mapping[env.val].name}</div>
                    <script>
                    //<![CDATA[
                      prefilledValues['${mapping.dependency.ID}${mapping.dependency.typeID}${env.val}']='${mapping.mapping[env.val].name}';
                    
//]]>
</script>
                  </c:otherwise>
                </c:choose>
             </div>
          </td>
        </c:forEach>
      </tr>
    </c:forEach>

  </table>
  </div>
</div>

<syswf:component name="/data/js" prefix="js">
  <syswf:param name="sourceId" value="UIHandler"/>
  <syswf:param name="code">

      function getTaskProgress(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskProgressJSON(task);
      }

      function getTaskResults(task)
      {
      return Packages.com.hp.systinet.sc.ui.TaskProgressMonitor.getInstance().getTaskResult(task);
      }


      function getPolicyDependencyResolutionCandidates(type,env)
      {
      return Packages.com.hp.systinet.proxy.mgmt.ui.PolicyManagementHandler.getInstance().getPolicyDependencyResolutionCandidates(type,env);
      }

  </syswf:param>
</syswf:component>


<syswf:input mode="hidden" id="replayLog" name="replayLog" value="${this}" property="replayLog"/>

<syswf:control mode="script" caption="saveChanges" action="saveDependencyMapping" loadingMask="true"/>


<script>
//<![CDATA[
  combo=null;
  comboElement=null;

  results=new Array();
  resultPosition=0;

  function onDataLoaded(element,id,type,env,data)
  {
          loadingProgressWindow.hide();
          comboElement=element;
          backupContent=element.innerHTML;
          element.innerHTML='';
          combo = new Ext.form.ComboBox({
            typeAhead: true,
            triggerAction: 'all',
            mode: 'local',
            width: element.clientWidth,
            height: element.clientHeight,
            store: new Ext.data.ArrayStore({
                  id: 0,
                  fields: [
                      'myId',
                      'displayText'
                  ],
                  data: data.candidates
            }),
            valueField: 'myId',
            displayField: 'displayText'
          });
          combo.render(element);
          combo.on('select',
             function(combo,record,index) {
               results[resultPosition++]= { originalID: id, type: type, environment: env, newID:record.data.myId,newName:record.data.displayText  };
               element.innerHTML='<div class="PolicyDepEditorCell Environment">'+record.data.displayText+'</div>';
               combo.hide();
               combo=null;
               comboElement=null;
          });
          combo.on('specialkey', function(field, e){
              if (e.getKey() == e.ESC) {
                 element.innerHTML=backupContent;
                 combo.hide();
                 combo=null;
                 comboElement=null;
              }
          });
  }


  function onContextVariableEdit(element,id,type,env)
  {
          comboElement=element;
          backupContent=element.innerHTML;
          element.innerHTML='';
          combo = new Ext.form.TextField({
            width: element.clientWidth,
            height: element.clientHeight,
            valueField: 'myId',
            displayField: 'displayText',
            value: prefilledValues[id+type+env]
          });

          combo.render(element);
          combo.on('specialkey', function(field, e){
              if (e.getKey() == e.ESC) {
                 element.innerHTML=backupContent;
                 combo.hide();
                 combo=null;
                 comboElement=null;
                 e.stopEvent();
              }
              if (e.getKey() == e.ENTER) {
                results[resultPosition++]= { originalID: id, type: type, environment: env, newID: combo.getValue(),newName: combo.getValue() };
                prefilledValues[id+type+env]=combo.getValue();
                element.innerHTML='<div class="PolicyDepEditorCell Environment">'+combo.getValue()+'</div>';
                combo.hide();
                combo=null;
                comboElement=null;
              }
          });
          combo.focus();
  }



  function openCellCombo(element,id,type,env)
  {
      if (combo!=null && comboElement!=element)
      {
          combo.hide();
          combo.destroy();
          combo=null;
      }
      if (combo==null)
      {
         if(type=='ContextVariable')
         {
            onContextVariableEdit(element,id,type,env);
         }
         else
         {
            getPolicyDependencyResolutionCandidates(type,env,function(data) { onDataLoaded(element,id,type,env,data); } );
            loadingProgressWindow=Ext.MessageBox.progress('Please wait..','Loading candidates from proxy devices..','');
         }
      }
  }


  function openEditor()
  {
      win = new Ext.Window({
        title       : 'Edit policy depencies...',
        layout      : 'fit',
        autoScroll  : true,
        width       : 930,
        height      : 'auto',
        modal       : true,
        closable   : false,
        closeAction : 'hide',
        plain       : true,
        bodyStyle   : 'padding:0',
        html        : Ext.get('editorContainer').dom.innerHTML,
        buttons     : [ new Ext.Button({ text: 'Save', listeners: {
                             click:function() {
                                  Ext.get('replayLog').dom.value=Ext.encode(results);
                                  win.destroy();
                                  saveChanges();
                             }
                        }}),
                        new Ext.Button({ text: 'Cancel', listeners: {
                             click:function() {
                                  results=new Array();
                                  win.destroy();
                        } } }) ]

      });

      win.show();

      //win.on(Ext.EventObject.ESC,function() {alert('esc');})

  }


//]]>
</script>


