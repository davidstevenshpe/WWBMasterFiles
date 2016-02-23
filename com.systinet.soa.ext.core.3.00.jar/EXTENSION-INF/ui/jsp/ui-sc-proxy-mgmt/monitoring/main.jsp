/* Global variables
 *
 */

var setLastSecondOfTheDay=function(date)
{
    date.setHours(23);
    date.setMinutes(59);
    date.setSeconds(59);
    date.setMilliseconds(999);
}

var setFirstSecondOfTheDay=function(date)
{
    date.setHours(0);
    date.setMinutes(0);
    date.setSeconds(0);
    date.setMilliseconds(0);
}

var buildContractView=function() {


    var Contract = Ext.data.Record.create([
                {
                  name: 'uuid',
                  type: 'string'
                },
                {
                  name: 'name',
                  type: 'string'
                },
                {
                  name: 'contract_id',
                  type: 'string'
                },
                {
                  name: 'contractID',
                  convert: function(v,record) {  if (record.contract_id==null) return record.uuid; else return record.contract_id; }
                },
                {
                  name: 'provider_name',
                  type: 'string'
                },
                {
                  name: 'provider_uuid',
                  type: 'string'
                },
                {
                  name: 'consumer_name',
                  type: 'string'
                },
                {
                  name: 'consumer_uuid',
                  type: 'string'
                },
                {
                  name: 'environment',
                  convert: function(v,record) {  if (record.environment==null) return "Undefined"; else return record.environment; },
                  type: 'string'
                },
                {
                  name: 'description',
                  type: 'string'
                },
                {
                  name: 'total',
                  type: 'float'
                },
                {
                  name: 'last_day',
                  type: 'float'
                },
                {
                  name: 'last_week',
                  type: 'float'
                },
                {
                  name: 'last_month',
                  type: 'float'
                },
                {
                  name: 'last_year',
                  type: 'float'
                },
                {
                  name: 'throttled_last_day',
                  type: 'float'
                },
                {
                  name: 'throttled_last_week',
                  type: 'float'
                }
    ]);

    var expander = new Ext.ux.grid.RowExpander2({
                    tpl : new Ext.XTemplate(
                        '<div style="margin-left:4px;">',
                           '{description}',
                        '</div>',
                        '<div style="margin-left:4px;">',
                            '<table style="margin:8px" border="0">',
                                 '<tr><td style="padding:3px">Contract name:</td><td style="padding:3px">',
                                     '{name}',
                                 '</td></tr>',
                               /*  '<tr><td style="padding:3px">Consumer:</td><td style="padding:3px">',
                                     '{consumer_name}',
                                 '</td></tr>',*/
                            '</table>',
                        '</div>',
                        //'<div style="margin-left:15px;"><span id="{uuid}TotalGraph">Messages processsed total</span> | <span id="{uuid}Increments"><a onclick="dailyIncrements(\'{uuid}\')">Daily Increments</a></div>',
                        '<div style="height:300px" id="{uuid}Graph"></div>'
                    )
    });

    var onContractGraphDataLoaded=function(params)
    {
        var buildGraph=function(params,index,drawSLO)
        {
           var series=params.coords;
           var res=new Array();
           var resMax=new Array();
           drawSLO=drawSLO && typeof params.maximumMessagesPerDay!='undefined';
           for(i=0;i<series.length;i++)
           {
              res[i]=new Array();
              res[i][0]=series[i][0];
              res[i][1]=series[i][index];
              if (drawSLO)
              {
                resMax[i]=new Array();
                resMax[i][0]=series[i][0];
                resMax[i][1]=params.maximumMessagesPerDay;
              }
           }

           var processedSeries;
           if (drawSLO)
           {
              processedSeries=[{label:'Messages processed per day',data:res},{label:'SLO (Maximum allowed)',data:resMax}];
           }
           else
           {
              processedSeries=[{label:'Number of messages', data:res}];
           }


           return {

                       xtype: 'flot',
                       //layout: 'fit',
                       cls: 'x-panel-body',
                       height:250,
                       series: processedSeries,
                       legend: {
                         position: "nw",
                         show: true},
                       yaxis: {
                         min:0
                       },
                       xaxis: {
                          mode: "time",
                          timeformat: "%y/%m/%d"
                       },
                       grid: {
                          backgroundColor: { colors: ["#fff", "#eee"] }
                       },
                       selection: {
                            mode: 'xy',
                            zoomDirection: 'rl'
                       }
             };
        }


        new Ext.TabPanel({
            renderTo: Ext.get(params.root_uuid+'Graph'),
            activeTab: 0,
            //width:'auto',
            //layout: 'absolute',
            //autoHeight: true,
            //height:'auto',
            height:290,
            plain:true,
            items:[{
                    title: 'Messages&nbsp;processed&nbsp;per&nbsp;day',
                    items: buildGraph(params,2,true)
                },
                {
                    title: 'Messages&nbsp;processed&nbsp;total',
                    items: buildGraph(params,1,false)
                },
                {
                    title: 'Message delivery failures per day',
                    items: buildGraph(params,3,false)
                }
            ]
        });
    }

    var onExpand=function(expander,record)
    {
         getContractGraph(record.data.uuid,onContractGraphDataLoaded);
    }
    expander.on('expand',onExpand);


    var onProviderPieLoaded=function(params)
    {
         var slider=new Ext.Slider({
            margin:0,
            width: 200,
            align:'left',
            value: 250,
            minValue: 0,
            maxValue: 1000,
            constrainThumbs: false
         });

         var sliderPanel= { items:[
                                slider,
                                {
                                     xtype:'panel',
                                     html:'<div id="sliderText" style="padding:0;margin:0;text-align:center">Data for the last month (<a style="cursor:pointer;" onclick="chooseDate();">Pick a date..</a>)</div><div id="datePicker"></div>'
                                }
                           ],
                           xtype:'panel'
         };


         var pieFlot=new Ext.ux.PieFlot({
                        layout: 'fit',
                        style: 'background: white',
                        legend: {show: false},
                        pies: {show: true, fillOpacity: 1, labelFormatter: function(label,value,x,percent,serie) { return label+'<br/>'+percent+'%'+'<span style="font-size:9px"><br/>('+value.toFixed(0)+')</span>';} },
                        colors: ["#8ae234","#ef2929", "#729fcf", "#e9b96e","#ad7fa8","#fcaf3e"],
                        series: params.entries
         });

         var maxY=50;
         for(i=0;i<params.entries.length;i++)
         {
             if(params.entries[i].data[1]>maxY) maxY=params.entries[i].data[1];
         }

         var barFlot=new Ext.ux.Flot({
                      style: 'background: white; padding-left:5px',
                      //cls: 'x-panel-body',
                      layout: 'fit',
                      bars: {show: true, align: 'center', barWidth: 1.0 },
                      colors: ["#8ae234","#ef2929", "#729fcf", "#e9b96e","#ad7fa8","#fcaf3e"],
                      legend: {show: true},
                      xaxis: { max: 10, ticks: params.ticks },
                      yaxis: { min:1,max:maxY, tickFormatter: function(val, axis) { return val.toFixed(0); } },
                      series: params.entries,
                      grid: {     clickable: false,
                                  hoverable: false
                      }
         });

         var pieWin = new Ext.Window({
            title: 'Service load distribution among contracts',
            width: 900,
            height: 400,
            layout: 'border',
            modal       : true,
            closeAction : 'destroy',
            buttonAlign: 'left',
            fbar: [sliderPanel,'->',new Ext.Button({ text: 'Close', listeners: {click:function() {pieWin.destroy();} } })],
            items: [ {
                        region:'east',
                        width: 500,
                        split:true,
                        resizable:true,
                        collapseMode  : 'mini',
                        collapsible: true,
                        id: 'east',
                        layout: 'fit',
                        items: barFlot
                      },
                      {
                        id: 'center',
                        region: 'center',
                        xtype: 'container',
                        split:true,
                        layout: 'fit',
                        items: pieFlot
                      }
                   ]
         });
         var getDayString=function(i, onePrefix)
         {
             if (i==0) return '';
             if (i==1) return onePrefix+'day';
             return i+' days';
         }
         var getMonthString=function(i)
         {
             if (i==1) return 'month';
             return i+' months';
         }
         var calculateSliderValue=function()
         {
             var x=slider.getValue()/250.0;
             return Math.round(30*x*x*x)+1;
         }

         var changeTimeWindow=function(slider, e) {
             var result=calculateSliderValue();
             var text;
             var months=Math.floor(result/30);
             if (result<30) text=getDayString(result,'');
                    else  text=getMonthString(months)+' '+getDayString(result%30,'1 ');

             Ext.get('sliderText').dom.innerHTML="Data for the last "+text+' (<a onclick="chooseDate();">Pick a date..</a>)';
         };

         slider.on('change',changeTimeWindow);

         var refreshPieGraphs=function(params) {
             barFlot.setData(params.entries);
             pieFlot.setData(params.entries);
             barFlot.setupGrid();
             barFlot.draw();
             pieFlot.setupGrid();
             pieFlot.draw();
         }
         slider.on('dragend',function() { getProviderPie(params.provider_uuid,1000*3600*24*calculateSliderValue(), refreshPieGraphs); });

         pieWin.show();

         chooseDate=function() {
              if (typeof dateMenu=='undefined')
              {
                  dateMenu = new Ext.menu.DateMenu({
                      hideOnClick: false,
                      focusOnSelect: false
                  });
                  dateMenu.on('select', function(picker,date) {
                      var now=new Date();
                      setLastSecondOfTheDay(now);
                      setFirstSecondOfTheDay(date);
                      var interval=now.getTime()-date.getTime();
                      if (interval<1000*3600*24) interval=1000*3600*24;
                      var x=interval/1000/3600/24-1;
                      x=x/30;
                      x=Math.pow(x,1.0/3.0);
                      x*=250;
                      if(x>1000) x=1000;
                      slider.setValue(x);
                      getProviderPie(params.provider_uuid,interval, refreshPieGraphs);
                      dateMenu.hide();
                  });
                  dateMenu.show('datePicker', "tl-bl?");
              }
              else
              {
                  if (dateMenu.isVisible())
                  {
                    dateMenu.hide();
                  }
                  else
                  {
                    dateMenu.show('datePicker', "tl-bl?");
                  }
              }
         }

    }

    openProviderPieWindow=function(providerUUID)
    {
         getProviderPie(providerUUID,1000*3600*24*30,onProviderPieLoaded);
    }

    var contractSelectionModel=new Ext.grid.CheckboxSelectionModel();
    var now=(new Date()).getTime();

    contractStore = new Ext.data.GroupingStore({
       reader: new Ext.data.JsonReader({fields: Contract,  root: 'records'  }),
       url: SERVER_URI+'/../../query',
       baseParams : { preparedQuery : "monitoring-dql", native_now:now},
       groupField: 'provider_name',
       sortInfo: {field: 'consumer_name', direction: 'ASC'}
    });

    contractStore.load({params:{start:0, limit:15}});


    var contractGrid = new Ext.grid.EditorGridPanel({
        store: contractStore,
        width: 'auto',
        autoHeight:true,
        height:'auto',
        region:'center',
        emptyText: 'No results to display',
        disableSelection:true,
        autoExpandColumn: 'consumer_name',
//        selModel: contractSelectionModel,
        plugins: [expander],
        view: new Ext.grid.GroupingViewWithRowExpander({
            markDirty: true,
            emptyGroupText: 'Undefined'
        }),
        columns: [
                expander,
                {
                    id: 'name',
                    header: 'Contract Name',
                    dataIndex: 'name',
                    width: 120,
                    hidden: true,
                    sortable: true
                },{
                    header: 'Contract ID',
                    width: 210,
                    dataIndex: 'contractID',
                    hidden: true,
                    sortable: true
                },{
                    header: 'Service',
                    dataIndex: 'provider_name',
                    hidden: true,
                    width: 200,
                    sortable: true,
                    groupRenderer: function(v,unused,r,rowIndex,colIndex,ds) {
                                     var tpl=new Ext.XTemplate('{provider_name} <div style="float:right;"><a style="font-weight:normal;font-style:italic" onmousedown="event.cancelBubble=true;" onclick="event.cancelBubble=true;openProviderPieWindow(\'{provider_uuid}\');">Analyze..</a></div>' ,
                                                   {compiled:true});
                                     return tpl.applyTemplate(r.data);
                                    }

                },{
                    id: 'consumer_name',
                    header: 'Consumer',
                    width: 220,
                    dataIndex: 'consumer_name',
                    sortable: true
                },{
                    header: 'Messages Total',
                    width: 95,
                    dataIndex: 'total',
                    sortable: true
                },{
                    header: 'Last 24h',
                    width: 70,
                    dataIndex: 'last_day',
                    sortable: true
                },{
                    header: 'Last Week',
                    width: 70,
                    dataIndex: 'last_week',
                    sortable: true
                },{
                    header: 'Last Month',
                    width: 70,
                    dataIndex: 'last_month',
                    sortable: true
                },{
                    header: 'Last Year',
                    width: 70,
                    dataIndex: 'last_year',
                    sortable: true
                },{
                    header: 'Last Week Throttled',
                    width: 110,
                    hidden: true,
                    dataIndex: 'throttled_last_week',
                    sortable: true
                },{
                    header: 'Environment',
                    dataIndex: 'environment',
                    hidden: true,
                    sortable: true
                }/*,
                contractSelectionModel*/
        ],
        bbar: new Ext.PagingToolbar({
            pageSize: 15,
            store: contractStore,
            displayInfo: true,
            displayMsg: 'Displaying {0} - {1} of {2}',
            emptyMsg: "No contracts to display"
        })
    });

    var collapseAll=function()
    {
        contractGrid.getView()
        for(i=0;i<contractStore.getCount();i++) expander.collapseRow(i);
    }
    contractGrid.on('sortchange',collapseAll);
    contractGrid.on('columnmove',collapseAll);
    contractGrid.on('columnresize',collapseAll);
    contractGrid.getColumnModel().on('hiddenchange',collapseAll);
    expander.on('beforeexpand',collapseAll);

    new Ext.Panel({
       layout      : 'fit',
       renderTo    : 'reportContainer',
       modal       : true,
       plain       : true,
       maximizable : true,
       bodyStyle   : 'padding:0',
       items       : contractGrid
    });
    window.onresize = function() { collapseAll(); };

    Datagrid.Utils.KeepSize(contractGrid);

};


Ext.onReady(function() {
  buildContractView();
});


