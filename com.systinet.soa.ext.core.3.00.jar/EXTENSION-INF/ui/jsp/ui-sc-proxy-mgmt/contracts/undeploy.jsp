// GLOBAL variables

// function afterUndeployAndProxyRemoval
// function afterUndeploy

var confirmDestroyCompletion=function(result)
{
        Ext.Msg.show({
          title:'Info..',
          msg: 'Proxy removal complete',
          minWidth:800,
          multiline: true,
          value:result.results.join('\n'),
          buttons: Ext.Msg.OK,
          icon: Ext.MessageBox.INFO,
          fn:afterUndeployAndProxyRemoval
        });
}


var destroyProxiesHandler=function(taskKey)
{
    monitorProgress(taskKey,confirmDestroyCompletion,'Removing proxies ..');
};

var undeployProgressWindow;

var undeployResultsHandler=function(result)
{
    undeployProgressWindow.hide();
    if (result.proxiesToDestroy.length==0)
    {
        Ext.Msg.show({
          title:'Info..',
          msg: 'Contract has been successfuly undeployed',
          buttons: Ext.Msg.OK,
          icon: Ext.MessageBox.INFO,
          fn: afterUndeploy
        });
    }
    else
    {
        var proxyNameList=new Array();
        var proxyRemovalList=new Array();

        for(i=0;i<result.proxiesToDestroy.length;i++)
        {
           var proxy=result.proxiesToDestroy[i];
           proxyNameList[i]=proxy.name;
           proxyRemovalList[i]={ name: proxy.name, uuid: proxy.uuid };
        }

        Ext.Msg.show({
          title:'Confirmation..',
          msg: 'Proxies '+proxyNameList.join(',')+' are left in the repository and are not associated with any contract.'+
               ' Should I remove those from the repository and the device as well ?',
          buttons: Ext.Msg.YESNO,
          fn: function(buttonId) {
                if (buttonId=='yes')
                {
                    deleteProxies(Ext.encode(proxyRemovalList),destroyProxiesHandler);
                }
                else
                {
                    afterUndeploy();
                }
              },
          icon: Ext.MessageBox.QUESTION
        });

    }
}


undeployContract=function(uuid,name)
{
    Ext.Msg.show({
      title:'Confirmation..',
      msg: 'Are you sure you want to undeploy contract \''+name+'\' in all environments ?',
      buttons: Ext.Msg.YESNO,
      fn: function(buttonId) {
             if (buttonId=='yes')
             {
                 undeployProgressWindow=Ext.MessageBox.progress('Please wait..','Contract being undeployed..','');
                 undeployContractOnServer(uuid,undeployResultsHandler);
             }
          },
      icon: Ext.MessageBox.QUESTION
    });
}