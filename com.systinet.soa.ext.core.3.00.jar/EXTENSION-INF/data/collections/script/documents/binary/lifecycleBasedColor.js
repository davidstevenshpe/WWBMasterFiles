function getConfig(){
  var config = {'default':{background: '#eee', text: '#666'}};
	var colors = com.hp.systinet.sc.ui.layout.LifeCyclePlanOverviewHelper.loadLifeCycleStageColor(false);
  	var colorsArray = colors.keySet().toArray();
	
	for (var i = 0; i< colorsArray.length; i++){
		var stageName = colorsArray[i];
		var stageColor = colors.get(stageName);
                config[stageName] = {
                  	'background': stageColor.getSecond(),
            		'text':stageColor.getFirst()
          	}
	}
	return config;
}