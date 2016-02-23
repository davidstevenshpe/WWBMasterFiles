
progressMonitor={};

var showStack;
var onResultsReturned=function(results)
{
   if (results.success)
   {
       progressMonitor.resultHandler(results.result);
   }
   else
   {
       progressMonitor.progressWindow.hide();
       if (results.message.length < 300){
		   Ext.Msg.show({
			  title:'Critical failure',
			  msg: results.message,
			  buttons: Ext.Msg.OK,
			  icon: Ext.MessageBox.ERROR
		   });
	   }else{
			showStack = function (){
				Ext.Msg.show({title:'Stacktrace',
					width:800, 
					multiline: 300,
					value:results.message,
					buttons: Ext.Msg.OK});
			};
   
		   Ext.Msg.show({
			  title:'Critical failure',
			  msg: 'Provision operation failed. <a onclick=\"javascript: eval(\'showStack()\');\" style=\"cursor: pointer;\"> (Details..)</a>',
			  buttons: Ext.Msg.OK,
			  icon: Ext.MessageBox.ERROR
		   });
	   }
   }
}

var onProgressReturned=function(progress)
{
   progressMonitor.progressWindow.updateProgress(progress.progress/100,progress.progress+'%',progress.comment);
   if (progress.progress==100) 
   {
      progressMonitor.resultsFetched=true;
      getTaskResults(progressMonitor.currentTaskKey,onResultsReturned);
      progressMonitor.progressWindow.hide();
   }
   progressMonitor.isCallRunning=false;
}

var onPoll=function()
{
    if (!progressMonitor.isCallRunning && !progressMonitor.resultsFetched)
    {
        progressMonitor.isCallRunning=true;
        getTaskProgress(progressMonitor.currentTaskKey,onProgressReturned);
    }
    if (!progressMonitor.resultsFetched) 
    {
        setTimeout("onPoll()",500);
    }
}

monitorProgress=function(taskKey,resultHandler,initialMessage)
{
   progressMonitor.isCallRunning=false;
   progressMonitor.resultsFetched=false;
   progressMonitor.currentTaskKey=taskKey; 
   progressMonitor.progressWindow=Ext.MessageBox.progress('Please wait..',initialMessage,'0%');
   onPoll();
   progressMonitor.resultHandler=resultHandler;
}
