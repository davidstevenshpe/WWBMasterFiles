calculateWindowHeight=function(optimal_h)
{
       var max_h=document.documentElement.clientHeight-50;
       return optimal_h>max_h?max_h:optimal_h;
}

showArtifact=function(uuid)
{
       window.location.href=SERVER_URI+'/../../service-catalog/artifact/'+uuid;
}

showArtifactInNewWindow=function(uuid)
{
       window.open(SERVER_URI+'/../../service-catalog/artifact/'+uuid);
}
