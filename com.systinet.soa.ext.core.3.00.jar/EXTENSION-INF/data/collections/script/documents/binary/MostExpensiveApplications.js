Ext4.define('EA.scripts.MostExpensiveApplications', {
	extend: 'EA.portal.PrintablePortlet',
    requires: [
        'EA.model.tools.DataSourceStore',
        'Ext.data.JsonStore',
	    'Ext4.chart.Chart',
        'Ext4.chart.theme.Base',
        'Ext4.chart.series.Series',
        'Ext4.chart.series.Line',
        'Ext4.chart.axis.Numeric'
    ],
    config: {
	    name: 'Most Expensive Applications',
        id: 'mostExpensiveApplications',
        dataSource: '/scripts/MostExpensiveApplicationComponents.xml'
    },
    transform: function(item) {
      	return item;
    },
    pageSize: 50,
    chart: {},
    loadDS: function (filter) {    	
		var self = this;
		self.dqlStore.on('load', function(dqlStore){
			if (dqlStore == null) return;
			
			var store = dqlStore.data.items; 
			for (var i =0; i <store.length; i++){
				store[i].data = self.transform(store[i].data);
			}
			
			self.chart.store = self.dqlStore;
			self.chart.refresh();
		});		
		self.dqlStore.load();
    },
	buildMenu: function () {
		var self = this;
		var pageSize = this.pageSize;
	        var menu = {
                xtype: 'toolbar',
                dock: 'top',
				cls: 'print-preview-hide',
                items: [
                  { 
                    xtype: 'label', text: 'Cost: '
                  },{ 
                    xtype: 'combo', queryMode: 'local', editable: false,
                    valueField: 'value', displayField: 'name',
                    value: '0', width: 80,
					name: 'comboCost',
                    store:  Ext4.create('Ext.data.Store', {
                       fields: ['name', 'value'],
                       data : [
                           {'value':'0', 'name':'ANY'},
                           {'value':'1', 'name':'>=$1M'},
                           {'value':'2', 'name':'>=$2M'}
                       ]
                    })
                  },{ 
                    xtype: 'tbseparator'
                  },{ 
                    xtype: 'label', text: 'NPV: '
                  },{ 
                    xtype: 'combo', queryMode: 'local', editable: false,
                    valueField: 'value', displayField: 'name',
                    value: '0', width: 80,
					name: 'comboNPV',
                    store:  Ext4.create('Ext.data.Store', {
                       fields: ['name', 'value'],
                       data : [
                           {'value':'0', 'name':'ANY'},
                           {'value':'1', 'name':'>=$1M'},
                           {'value':'2', 'name':'>=$2M'}
                       ]
                    })
                  },{ 
                    xtype: 'tbseparator'
                  },{ 
                    xtype: 'label', text: 'ROI: '
                  },{ 
                    xtype: 'combo', queryMode: 'local', editable: false,
                    valueField: 'value', displayField: 'name',
                    value: '0', width: 80,
					name: 'comboROI',
                    store:  Ext4.create('Ext.data.Store', {
                       fields: ['name', 'value'],
                       data : [
                           {'value':'0', 'name':'ANY'},
                           {'value':'1', 'name':'>=0'},
                           {'value':'2', 'name':'<=0'}
                       ]
                    })
                  },{ 
                    xtype: 'tbseparator'
                  },{ 
                    xtype: 'label', text: 'Order by: '
                  },{ 
                    xtype: 'combo', queryMode: 'local', editable: false,
                    valueField: 'value', displayField: 'name',
                    value: 'annualCostTotalVal DESC', width: 150,
                    store:  Ext4.create('Ext.data.Store', {
                       fields: ['name', 'value'],
                       data : [
                           {'value':'annualCostTotalVal DESC', 'name':'\u2193 Total Cost'},
                           {'value':'annualCostLaborIntVal DESC', 'name':'\u2193 Labor Cost Internal'},
                           {'value':'annualCostLaborExtVal DESC', 'name':'\u2193 Labor Cost External'},
      					   {'value':'transformationCostVal DESC', 'name':'\u2193 Transformation Cost'},
                           {'value':'annualCostHwVal DESC', 'name':'\u2193 Hardware Cost'},
                           {'value':'annualCostSwVal DESC', 'name':'\u2193 Software Cost'},
                           {'value':'annualCostOtherVal DESC', 'name':'\u2193 Other Cost'},
                           {'value':'netPresentValueVal DESC', 'name':'\u2193 NPV'},
                           {'value':'returnOnInvestmentVal DESC', 'name':'\u2193 ROI'}
                       ]
                    }),
                    /* custom field */
                    dqlType: 'orderBy'
                  },{ 
                    xtype: 'tbseparator'
                  },{ 
                    xtype: 'label', text: 'Items: '
                  },{
                    xtype: 'numberfield',
                    name: 'pagesSize',
                    value: pageSize,
                    maxValue: 90,
                    minValue: 10,
                    editable: false,
                    step: 10,
                    width: 50,
                    listeners: {
                       "change": function(){
                          pageSize = this.value;
                          filterChanged.select();
                       }
                    }
                  }
                  /* Save chart available since Ext 4.1 
                  ,{ 
                    xtype: 'tbseparator'
                  },{
                    xtype: 'button',
                    text: 'Save Chart',
                    handler: function() {
                      Ext.MessageBox.confirm('Confirm Download', 'Do you want to download the chart as an image?', function(choice){
                          if(choice == 'yes'){
                              chart.save({
                                  type: 'image/png'
                              });
                          }
                      });
                    }  
                  }
                  */ 
                ]
              };
		var filterChanged = {
           filters: [],
           orderBy: [],
           pageSize: null,
           addListener: function(item,orderBy){
              item.addListener("select",this.select,this);
              if(orderBy) {this.orderBy.push(item);} else {this.filters.push(item);}
           },
           select: function(){
			  self.dqlStore = self.buildStore(this.getParams());
			  self.loadDS(false);
           },
           getParams: function(){
              var i;
			  var roiValue;
			  var costValue;
			  var npvValue;
              for(i=0; i<this.filters.length; i++){
                 if (this.filters[i].name=='comboNPV'){
                    npvValue = parseInt("" + this.filters[i].value);
                 } else if (this.filters[i].name=='comboROI'){
                    roiValue = parseInt("" + this.filters[i].value);
                 } else if (this.filters[i].name=='comboCost'){
                    costValue = parseInt("" + this.filters[i].value);
                 }
              } 
              var orderByCount = 0;
			  var sortColums = '';
              for(i=0; i<this.orderBy.length; i++){
                 if (this.orderBy[i].value!==''){
                    if (orderByCount === 0) {sortColums+="  ";}
                    if (orderByCount >0) {sortColums+=", ";}
                    sortColums+= this.orderBy[i].value;
                    orderByCount++;
                 }
              }
			  var extraParams = {
				start: 0,
				limit: pageSize,
				roi: roiValue,
				cost: costValue,
				npv: npvValue,
				sort: sortColums,
			  };
              return extraParams;
           }
        };
        for(var i=0; i!== menu.items.length; i++){
           var item = menu.items[i];
           if (item.xtype === 'combo'){
              menu.items[i] = Ext4.create("Ext.form.ComboBox",item); 
              filterChanged.addListener(menu.items[i], item.dqlType === 'orderBy');
           }
        }
		return menu;
	},
	buildStore: function(extraParams) {
		if (!extraParams || extraParams == null) {
			extraParams = {};
        }
        extraParams.domainFilterType = 'report';
        
		var self = this;
		var dqlStore = Ext4.create('EA.model.tools.DataSourceStore', {
				dataSource: self.config.dataSource,
				extraParams: extraParams,
				fields: [
						{ name: 'uuid', type: 'string' },
						{ name: 'name', type: 'string' },
						{ name: 'annualCostTotalVal', type: 'float' },
						{ name: 'annualCostLaborIntVal', type: 'float' },
						{ name: 'annualCostLaborExtVal', type: 'float'},
						{ name: 'transformationCostVal', type: 'float'},
						{ name: 'annualCostSwVal', type: 'float'},
						{ name: 'annualCostHwVal', type: 'float'},
						{ name: 'annualCostOtherVal', type: 'float'},
						{ name: 'returnOnInvestmentVal', type: 'float'},
						{ name: 'netPresentValueVal', type: 'float'}
					],
				});
		return dqlStore;
	},
    buildChart: function(self) {
        var currencySymbol = self.config.currencySymbol;
		var currentYear = new Date().getFullYear();
        var pageSize = self.pageSize;
        var onClick={
                itemmousedown:function(v) { showArtifact(v.storeItem.data['uuid']); }
            };
            var toolTipGridStore =  Ext4.create('Ext.data.JsonStore', {
               fields: ['name', 'value']
            });
            var toolTipGrid = Ext4.create('Ext.grid.Panel', {
                store: toolTipGridStore,
                columns: [
                   { 
                	   text : 'Name', 
                	   dataIndex: 'name', 
                	   width: 150
            	   },
                   { 
            		   text : 'Value', 
            		   dataIndex: 'value', 
            		   width: 130, 
            		   align: 'right', 
            		   renderer: function(val,m,record) {
            			   if(val == null) return 'N/A';
            			   return record.data.name == 'ROI' ? Ext4.util.Format.numberRenderer('0,0')(val) : layoutManager.formatCurrency(val);
            		   }
        		   }
                ]
            });
            self.chart = Ext4.create('Ext.chart.Chart', {
                    animate: true,
                    style: 'background:#fff',
                    shadow: false,
                    store: self.dqlStore,
                    legend: {position: 'bottom'},
                    axes: [{
                        type: 'Category',
                        label: {
                            font:'HPSimplified',
                            rotate: {degrees: 270}
                        },
                        position: 'bottom',
                        /* title: 'some title', */
                        fields: ['name']
                    },{
                        type: 'Numeric',
                        position: 'left',
                        fields: ['annualCostLaborIntVal','annualCostLaborExtVal', 'transformationCostVal', 'annualCostSwVal','annualCostHwVal','annualCostOtherVal'],
                        title: 'Cost',
                        grid: true,
                        label: {
                            renderer: Ext4.util.Format.numberRenderer('0,0'),
                            font:'HPSimplified'
                        }
                    },{
                        type: 'Numeric', minimum: 0,
                        position: 'right',
                        fields: ['returnOnInvestmentVal','netPresentValueVal'],
                        title: 'ROI/NPV',
                        grid: false,
                        label: {
                            font:'HPSimplified'
                        }
                    }],
                    series: [
                    {
                        type: 'column',
                        axis: 'left',
                        /* highlight: true, */
                        tips: {
                          trackMouse: true,
						  width: 300,
                          height: 300,
                          layout: 'fit',
                          items: {
                             xtype: 'container',
                             layout: 'hbox',
                             items: [toolTipGrid]
                          },
                          renderer: function(storeItem) {
                            this.setTitle(storeItem.get('name'));
                            toolTipGridStore.loadData([
                               {name:'Cost Labor Internal', value: storeItem.get('annualCostLaborIntVal')},
                               {name:'Cost Labor External', value: storeItem.get('annualCostLaborExtVal')},
    						   {name:'Transformation Cost', value: storeItem.get('transformationCostVal')},
                               {name:'Cost Software', value: storeItem.get('annualCostSwVal')},
                               {name:'Cost Hardware', value: storeItem.get('annualCostHwVal')},
                               {name:'Cost Other', value: storeItem.get('annualCostOtherVal')},
                               {name:'NPV', value: storeItem.get('netPresentValueVal')},
                               {name:'ROI', value: storeItem.get('returnOnInvestmentVal')}
                            ]);
                            toolTipGrid.setSize(285, 270);
                          }
                        },
                        xField: 'name',
                        yField: ['annualCostLaborIntVal','annualCostLaborExtVal','transformationCostVal', 'annualCostSwVal','annualCostHwVal','annualCostOtherVal'],
                        stacked: true,
                        title: ['Cost Labor Internal','Cost Labor External','Transformation Cost', 'Cost Software','Cost Hardware','Cost Other'],
                        listeners: onClick
                    },/*{
                        type: 'column',
                        axis: 'left',
                        xField: 'name',
                        yField: ['annualCostTotal'],
                        stacked: false,
                        title: ['Cost Total']
                    },*/{
                        type: 'line',
                        axis: 'right',
                        smooth: false,
                        showMarkers: true,
                        fill: true,
                        fillOpacity: 0.5,
                        xField: 'name',
                        yField: 'returnOnInvestmentVal',
                        title: 'ROI'
                    },{
                        type: 'line',
                        axis: 'right',
                        smooth: false,
                        showMarkers: true,
                        fill: false,
                        fillOpacity: 0.5,
                        xField: 'name',
                        yField: 'netPresentValueVal',
                        title: 'NPV'
                    }]
                });
    },    
    initComponent: function(){
        var self = this;
		var extraParams = {
			start: 0,
			limit: self.pageSize,
			roi: 0,
			cost: 0,
			npv: 0,
			sort: 'annualCostTotalVal desc'
		};
        self.initConfig();
		self.config.currencySymbol = layoutManager.currencySymbol;
        self.dqlStore = self.buildStore(extraParams);
		self.buildChart(self);
		var menu = self.buildMenu();
		    menu.region = 'north';
            menu.height = 35;
            self.chart.region = 'center';
            Ext4.apply(self, {
                layout: 'border',
                height: 500,
                items: [menu, self.chart]
            });
		self.callParent(arguments);
    },
	loadDataSource: function() {
		this.loadDS(false);
	}
})